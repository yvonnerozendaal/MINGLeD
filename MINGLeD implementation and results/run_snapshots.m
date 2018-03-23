clear all;close all;clc;

for i_iter = 1:1:500
    %% user defined options
    m.study = 'Cdiets';
        diets = {'LFD' 'HFD' 'HFD_025C'};
        timepoints = 0:1:3;
        subgroups = {{} {} {'nonMetS' 'MetS'}};
                            %nonMetS refers to the non-dyslipidemic MetS subgroup
                            %MetS refers to the dyslipidemic MetS subgroup

    m.sim_type = 'snapshots'; use_ADAPT = 0; use_classical = 1;

    m.data_type = 'avg';

    m.Ndt = 1;
    m.t_max = 90; %[d]


    %% standard functions to be executed
    m.phenotypes = {'LFD_0M' %initialize the different phenotype snapshots to be optimized/simulated
                    'LFD_1M'
                    'LFD_2M'
                    'LFD_3M'
                    'HFD_0M'
                    'HFD_1M'
                    'HFD_2M'
                    'HFD_3M'
                    'HFD_025C(nonMetS)_0M'
                    'HFD_025C(nonMetS)_1M'
                    'HFD_025C(nonMetS)_2M'
                    'HFD_025C(nonMetS)_3M'
                    'HFD_025C(MetS)_0M'
                    'HFD_025C(MetS)_1M'
                    'HFD_025C(MetS)_2M'
                    'HFD_025C(MetS)_3M'}; 
    phs=m.phenotypes;
    m.modelname = 'MINGLeD';

    addpath(genpath(pwd))
    addpath(genpath('..\ADAPT_library\'))


    %% perform snapshot optimization
    m.info.costfile = @costfunc_MINGLeD_edited;
    tic
    for i_ph = 1:length(m.phenotypes)
        m.phenotype = phs{i_ph};

        x = strfind(m.phenotype,'_');
        y1 = strfind(m.phenotype,'(');
        if ~isempty(y1)
            y2 = strfind(m.phenotype,')');
            m.diet = m.phenotype(1:y1-1);
            m.timepoint = str2double(m.phenotype(x(end)+1:end-1)); %[M]
            m.subgroup = m.phenotype(y1+1:y2+2);
        else
            m.diet = m.phenotype(1:x(end)-1);
            m.timepoint = str2double(m.phenotype(x(end)+1:end-1)); %[M]
            m.subgroup = '';
        end

        m.raw_data = load_raw_data(m);
        if i_ph == 1
            m = feval(['initialize_model_' m.modelname],m,m.raw_data);
            m = define_default_options(m); 
        end

        path = [pwd '\results ' m.sim_type '\'];
        filename = ['result_' m.phenotype '.mat'];

        raw_data = load_raw_data(m);
        if ~isfield(m,'p_init')
            m = feval(['initialize_model_' m.modelname],m,raw_data);
            m = define_default_options(m); 
        end

        if exist([path filename],'file')
            load([path filename])
            m.raw_data = raw_data;
            m=feval(['initialize_model_' m.modelname],m,m.raw_data);
            m.phenotypes = phs;
            i_prev = length(R);
        else
            i_prev = 0;
        end

        i_extra = i_iter - i_prev;
        for i_curr = 1:i_extra            
            if i_prev == 0
                p_start = m.p_init;
            else
                p_start = 10.^(4*rand(length(m.info.p),1)-2);
            end
            % -- running lsqnonlin optimization
            try
                [p_est,SSE] = lsqnonlin((m.info.costfile),p_start,...
                                        m.info.lb,m.info.ub,m.info.lsq_options,...
                                        p_start,p_start,m.u,m.x0,[0 m.t_max],m.raw_data,m);
                R(i_prev+i_curr).p_est = p_est;
                R(i_prev+i_curr).SSE = SSE;
                [R(i_prev+i_curr).t,R(i_prev+i_curr).x,R(i_prev+i_curr).j,R(i_prev+i_curr).y] = simulate_model([0 m.t_max],m.x0,p_est,p_est,m);
            catch
                i_curr
            end
        end

        if ~exist(path,'dir')
            mkdir(path)
        end
        save([path filename],'R','m')
    end

    if run_optimization && i_extra
        t=toc;
        msgbox(['Optimization finished [' num2str(round(t/60)) 'min]'])
    end
end