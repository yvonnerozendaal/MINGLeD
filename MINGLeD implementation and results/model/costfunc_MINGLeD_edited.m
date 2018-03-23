function [error,e] = costfunc_MINGLeD_edited(p,p_prev,p_WT,u,x0,tspan,data,m)


% -- compute model simulation
[~,~,~,y_sim] = simulate_model(tspan,x0,p,p_WT,m);


% -- weighted error: difference between model prediction and experimental data
e = [];
for i_y = 1:length(m.info.y)
    fn_data = char(m.eq.y{i_y}(2));
    if isfield(data,fn_data)
        if isfield(data.(fn_data),'sd')
            e(i_y) = (y_sim(i_y,end) - data.(fn_data).m(end)) / data.(fn_data).sd(end);
        else
            e(i_y) = (y_sim(i_y,end) - data.(fn_data).m(end));
        end
    else
        e(i_y) = NaN;
    end
end
e_data = e(~isnan(e));


switch m.sim_type
    case 'snapshots'
        error = e_data;
    case 'time' % hence using ADAPT
        % regularization term
        if tspan(end)>0
            e_reg = (p - p_prev) ./ p_WT;
        else
            e_reg = [];
        end
        % compute total error
        error = [e_data m.info.lambda_r*e_reg'];
end


% append zeros such that algorithm functions (length(error) should be at least #parameters)
if length(error)<length(p)
	N = length(p)-length(error);
	error = [error'; zeros(N,1)];
end