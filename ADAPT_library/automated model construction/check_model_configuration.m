function m = check_model_configuration(m)


    raw_data = load_raw_data(m);
    m = feval(['initialize_model_' m.modelname],m,raw_data);
    m = define_default_options(m); 
    m.c.p_WT = m.p_init;
    
    
    %% test ODE files
    [t_sim1,x_sim1] = ode15s(m.info.odefile,[0 m.t_max],m.x0,m.info.ode_options,m.p_init,m.u,m);
    t_sim1 = t_sim1';
    x_sim1 = x_sim1';

    % test MEX files
    if isfield(m.info,'mexfile') && exist(func2str(m.info.mexfile),'file')
        [t_sim2,x_sim2] = feval(m.info.mexfile,[0 m.t_max],m.x0,m.p_init,m.u,[1e-6 1e-8 10]);
    end
    
    % test flux file & observables
    for i_t = 1:length(t_sim1)
        j_sim1(:,i_t) = feval(m.info.fluxfile,t_sim1(i_t),x_sim1(:,i_t),m.p_init,m.u,m)';
        y_sim1(:,i_t) = feval(m.info.observfile,t_sim1(i_t),x_sim1(:,i_t),j_sim1(:,i_t),m.p_init,m.u,m);
        if isfield(m.info,'mexfile') && exist(func2str(m.info.mexfile),'file')
            j_sim2(:,i_t) = feval(m.info.fluxfile,t_sim2(i_t),x_sim2(:,i_t),m.p_init,m.u,m)';
            y_sim2(:,i_t) = feval(m.info.observfile,t_sim2(i_t),x_sim2(:,i_t),j_sim2(:,i_t),m.p_init,m.u,m);
        end
    end
    
    
    % -- display size of simulation output components
    disp(['ODE - t: ' num2str(length(t_sim1(:,1))) ' x ' num2str(length(t_sim1(1,:)))])
    disp(['    - x: ' num2str(length(x_sim1(:,1))) ' x ' num2str(length(x_sim1(1,:)))])
    disp(['    - j: ' num2str(length(j_sim1(:,1))) ' x ' num2str(length(j_sim1(1,:)))])
    disp(['    - y: ' num2str(length(y_sim1(:,1))) ' x ' num2str(length(y_sim1(1,:)))])
    
    if isfield(m.info,'mexfile') && exist(func2str(m.info.mexfile),'file')
        disp(['MEX - t: ' num2str(length(t_sim2(:,1))) ' x ' num2str(length(t_sim2(1,:)))])
        disp(['    - x: ' num2str(length(x_sim2(:,1))) ' x ' num2str(length(x_sim2(1,:)))])
        disp(['    - j: ' num2str(length(j_sim2(:,1))) ' x ' num2str(length(j_sim2(1,:)))])
        disp(['    - y: ' num2str(length(y_sim2(:,1))) ' x ' num2str(length(y_sim2(1,:)))])
    end

    
    % -- test simulation function
    if isfield(m.info,'mexfile') && exist(func2str(m.info.mexfile),'file')
        [t_sim_MEX,x_sim_MEX,j_sim_MEX,y_sim_MEX] = simulate_model([0 m.t_max],m.x0,m.p_init,m.p_init,m.u,m); %MEX
        m2 = m; m2.info = rmfield(m2.info,'mexfile');
    else
        m2 = m; 
    end
    [t_sim_ODE,x_sim_ODE,j_sim_ODE,y_sim_ODE] = simulate_model([0 m.t_max],m2.x0,m2.p_init,m2.p_init,m2.u,m2); %ODE


    % -- test costfunction
    error = feval(m.info.costfile,m.p_init,m.p_init,m.p_init,m.u,m.x0,m.info.t_tot(2:end),raw_data,m);
    SSE = sum(error.^2);
end