function [D,m] = get_spline_data(m,raw_data)
    
    % -- define smoothing parameter
    if isfield(m.info,'smooth')
        smooth = m.info.smooth;
    else
        smooth = 1;
    end
    
    % -- define weight of standard deviation
    if isfield(m.info,'sd_weight')
        sd_weight = m.info.sd_weight;
    else
        sd_weight = 1;
    end


    for i_it = 1:m.Niter
        item_names = fieldnames(raw_data);

        for i_item = 1:length(item_names)
            item = char(item_names(i_item));

            %-- define roughness weight
            if isfield(m.info,'rough')
                rough = repmat(m.info.rough,length(data.(item).m),1);
            else
                if isfield(raw_data.(item),'sd')
                    if ~isempty( find(raw_data.(item).sd<1e-10) ) %if sd is extremely small or 0
                        raw_data.(item).sd( find(raw_data.(item).sd<1e-10) ) = 1;
                    end
                    rough = ( 1 ./ raw_data.(item).sd ) .^ 2;
                else
                    rough = [];
                end
            end

            if length(raw_data.(item).m) > 1                
                % -- take a random sample
                if isfield(m,'do_not_sample')
                    switch item
                        case m.do_not_sample
                            D(i_it).data_sample.(item) = raw_data.(item).m;
                        otherwise
                            D(i_it).data_sample.(item) = raw_data.(item).m + raw_data.(item).sd .* randn(size(raw_data.(item).sd)) .* sd_weight;
                    end
                end
                % -- define smooth cubic spline: piecewise polynomial spline (for computation of numerical value for m)
                if strcmp(item,'hep_DNL')
                    rough(1) = 1;
                end
                D(i_it).spline_func.(item) = csaps(raw_data.(item).t,D(i_it).data_sample.(item),smooth,[],rough);

                % -- define numeric value of data interpolant at specific time t
                D(i_it).spline_data.(item).t  = m.info.t_tot(2:end);   
                D(i_it).spline_data.(item).m  = fnval(D(i_it).spline_func.(item),D(i_it).spline_data.(item).t);
                D(i_it).spline_data.(item).sd = sqrt(interp1(raw_data.(item).t,(raw_data.(item).sd).^2,m.info.t_tot(2:end),'linear','extrap'));
                
                e_abs = fnval(D(i_it).spline_func.(item),raw_data.(item).t) - raw_data.(item).m;
                e_w = e_abs ./ raw_data.(item).sd;
                D(i_it).spline_data.(item).error.abs = sum( e_abs.^2 );
                D(i_it).spline_data.(item).error.w = sum( e_w.^2 );
            end
        end
    end
end