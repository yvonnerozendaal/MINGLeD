function [R,m] = perform_ADAPT(m)

% -- define output file name
save_dir = sprintf('%s%sNiter=%d_Ndt=%d_l=%s%s',pwd,'\results ADAPT\',m.Niter,m.Ndt,num2str(m.info.lambda_r),'\');
if isfield(m,'save_folder')
    save_dir = [pwd '\results ADAPT\' m.save_folder];
end
if isfield(m,'phenotype') 
    filename_output = sprintf('%s%s_Niter=%d_Ndt=%d_l=%s.mat',save_dir,m.phenotype,m.Niter,m.Ndt,num2str(m.info.lambda_r));
else
    filename_output = sprintf('%s_Niter=%d_Ndt=%d_l=%s.mat',save_dir,m.Niter,m.Ndt,num2str(m.info.lambda_r));
end
if ~exist(save_dir,'dir')
    mkdir(save_dir)
end


if ~exist(filename_output,'file')  
    % -- load original data set
    R(1).raw_data = load_raw_data(m);  
    
    % -- initialize model
    m = feval(['initialize_model_' m.modelname],m,R(1).raw_data);
    m = define_default_options(m);
    m.raw_data = R(1).raw_data; %temp
        
    % -- define data spline (sample raw data and interpolate to time span)
    [D,m] = get_spline_data(m,R(1).raw_data);
    
    % -- load initial parameters
    if ~isfield(m,'p_init_custom')
        p_init = get_sampled_init_parameters(m);
    else
        p_init = m.p_init_custom;
    end
    
    % -- iterate through total number of data spline
    for i_it = 1:m.Niter
        % -- optimize model for current data spline at each time sample
        for i_time = 1:m.Ndt
            % -- display iteration
            if exist('x','var')
                fprintf(repmat('\b',1,x))
            end
            x = fprintf('iteration [%d/%d]; time sample [%d/%d] \n',i_it,m.Niter,i_time,m.Ndt);

            % -- get data at current time point
            data_names = fieldnames(D(i_it).spline_data);
            for i = 1:length(data_names)
                data_item = char(data_names(i));
                data_curr.(data_item).t = D(i_it).spline_data.(data_item).t(i_time);
                data_curr.(data_item).m = D(i_it).spline_data.(data_item).m(i_time);
                if isfield(D(i_it).spline_data.(data_item),'sd')
                    data_curr.(data_item).sd = D(i_it).spline_data.(data_item).sd(i_time);
                end
            end            

            m.c.Vpl     = data_curr.V_pl.m;
            m.c.diet_G  = data_curr.dietary_G.m;
            m.c.diet_C  = data_curr.dietary_C.m;
            m.c.diet_TG = data_curr.dietary_TG.m;
            m.c.diet_AA = data_curr.dietary_AA_estimation.m;

            % -- perform optimization of current situation
            if i_time == 1      %estimate wild-type phenotype (t=0)
                x0_curr = m.x0;
                p_WT    = p_init(:,i_it);
                p_curr  = p_WT;
                p_prev  = p_curr;
            else                %determine full trajectory
                x0_curr = R(i_it).x(:,i_time-1);
                p_WT    = R(i_it).p(:,1);
                p_curr  = R(i_it).p(:,i_time-1);
                p_prev  = p_curr;
            end
            m.c.p_WT = p_WT;

            t_sim = [0 m.t_max];
            [p_est,SSE] = lsqnonlin((m.info.costfile),p_curr,...
                                     m.info.lb,m.info.ub,m.info.lsq_options,...
                                     p_prev,p_WT,m.u,x0_curr,t_sim,data_curr,m);

            % -- compute optimized model simulations
            [~,x_sim,j_sim,y_sim] = simulate_model(t_sim,x0_curr,p_est,p_WT,m);

            % -- save results to outpute structure
            if i_time == 1
                R(i_it).spline_func = D(i_it).spline_func;
                R(i_it).spline_data = D(i_it).spline_data;
                R(i_it).data_sample = D(i_it).data_sample;                    
            end
            
            R(i_it).p(:,i_time) = p_est;          %optimized parameters
            R(i_it).SSE(i_time) = SSE;            %corresponding SSE

            R(i_it).t(i_time) = m.info.t_tot(i_time+1);
            R(i_it).x(:,i_time) = x_sim(:,end);   %simulated model states
            R(i_it).j(:,i_time) = j_sim(:,end);   %simulated model fluxes
            R(i_it).y(:,i_time) = y_sim(:,end);   %simulated observable model outputs
        end
        
        filename_TEMP{i_it} = [save_dir m.filename_prefix '_result' num2str(i_it) '.mat'];
        save(filename_TEMP{i_it},'R','m','i_it')
    end
    save(filename_output,'R','m'); delete(filename_TEMP{:})
else
    load(filename_output)
end