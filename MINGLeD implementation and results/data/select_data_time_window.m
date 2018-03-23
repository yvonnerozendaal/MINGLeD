function d_sel = select_data_time_window(A,target_t,dt)

datanames = fieldnames(A);
d_sel = struct();
for i_t = 1:length(target_t)
    for i_m = 1:length(datanames)
        met = char(datanames{i_m});

        if ~isfield(d_sel,met)
            d_sel.(met).t   = [];
            d_sel.(met).d   = [];
            d_sel.(met).mn  = [];
            d_sel.(met).sd  = [];
        end
        
        dt_curr = abs( target_t(i_t) - A.(met).t_avg );
        
        t_use = [];
        d_use = [];
        for j = 1:length(dt_curr)
            if dt_curr(j) <= dt(i_t)
                t_use = [t_use; repmat(A.(met).t_avg(j),A.(met).N(j),1)];
                d_use = [d_use; A.(met).D{j}'];
            end
        end
        
        d_sel.(met).t = [d_sel.(met).t nanmean(t_use)];
        d_sel.(met).mn = [d_sel.(met).mn nanmean(d_use)];
        d_sel.(met).sd = [d_sel.(met).sd nanstd(d_use)];
        
        if i_t == 1
            d_sel.(met).desc = A.(met).desc;
            d_sel.(met).abbr = A.(met).abbr;
            d_sel.(met).unit = A.(met).unit;
            d_sel.(met).t_unit = A.(met).t_unit;
        end
    end
end