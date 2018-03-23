function [d_ph,d_sel] = load_data_Cdiets_snapshots_avg(phenotype)

load('datafile_Cdiets.mat')
    
x = strfind(phenotype,'_');
y1 = strfind(phenotype,'(');
if ~isempty(y1)
    y2 = strfind(phenotype,')');
    diet = phenotype(1:y1-1);
    timepoint = str2double(phenotype(x(end)+1:end-1)); %[M]
    subgroup = phenotype(y1+1:y2-1);
else
    diet = phenotype(1:x(end)-1);
    timepoint = str2double(phenotype(x(end)+1:end-1)); %[M]
    subgroup = '';
end

switch timepoint
    case 0 %[M]
        t_target = 0; %[d]
    case 1 %[M]
        t_target = 31; %[d]
    case 2 %[M]
        t_target = 59; %[d]
    case 3 %[M]
        t_target = 87; %[d]
end

diets.LFD = 1;
diets.HFD = 2;
diets.HFD_025C = 3;

j_diet = diets.(diet);


fns = fieldnames(A{j_diet});
for i_fn = 1:length(fns)
    fn = char(fns{i_fn});
    if isfield(A{j_diet}.(fn),'d')        
        % select data from target time point
        dt_curr = abs( t_target - A{j_diet}.(fn).t(1,:) );
        if min(dt_curr)<5 %[d]
            [~,jt] = min(dt_curr);     
        else
            jt = [];
        end
        
        if ~isempty(subgroup)
            switch subgroup
                case 'MetS' %Metabolic Syndrome phenotypes within HFD+0.25%C group
                    IDs = [35 36 37];
                case 'nonMetS' %non-Metabolic Syndrome phenotypes within HFD+0.25%C group
                    IDs = [28 29 30 31 34];
            end
            i_ids = [];
            for i_id = 1:length(IDs)
                i_curr = find(A{j_diet}.(fn).IDs==IDs(i_id));
                i_ids = [i_ids; i_curr];
            end
        else
            i_ids = 1:length(A{j_diet}.(fn).d(:,1));
        end
        
        if ~isempty(jt)
            d_use = A{j_diet}.(fn).d(i_ids,jt);
        
            d_sel.(fn).t = t_target; %[d]
            d_sel.(fn).t_unit = 'd';
            d_sel.(fn).d = d_use;
            d_sel.(fn).mn = nanmean(d_use);
            d_sel.(fn).sd = nanstd(d_use);
            d_sel.(fn).unit = A{j_diet}.(fn).unit;
        end
    end
end

d_ph = load_data_MINGLeD(d_sel,diet);