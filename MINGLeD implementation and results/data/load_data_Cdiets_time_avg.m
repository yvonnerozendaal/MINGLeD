function d_ph = load_data_Cdiets_time_avg(phenotype)

load('datafile_Cdiets.mat')

y1 = strfind(phenotype,'(');
if ~isempty(y1)
    y2 = strfind(phenotype,')');
    diet = phenotype(1:y1-1);
    subgroup = phenotype(y1+1:y2-1);
else
    diet = phenotype;
    subgroup = '';
end

diets.LFD = 1;
diets.HFD = 2;
diets.HFD_025C = 3;

j_diet = diets.(diet);


fns = fieldnames(A{j_diet});
for i_fn = 1:length(fns)
    fn = char(fns{i_fn});
    if isfield(A{j_diet}.(fn),'d')
        
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
        
        switch A{j_diet}.(fn).t_unit
            case 'd'
                f = 1;
            case 'w'
                f = 7;
        end
        d_sel.(fn).t = A{j_diet}.(fn).t(1,:) * f; %[d]
        d_sel.(fn).t_unit = 'd';
        d_sel.(fn).d = A{j_diet}.(fn).d(i_ids,:);
        d_sel.(fn).mn = nanmean(A{j_diet}.(fn).d(i_ids,:));
        d_sel.(fn).sd = nanstd(A{j_diet}.(fn).d(i_ids,:));
        d_sel.(fn).unit = A{j_diet}.(fn).unit;
    end
end

% include liver lipid pool data and hepatic DNL data
fns = {'hep_TG' 'hep_FC' 'hep_TC' 'DNL_C16_0' 'DNL_C18_0' 'DNL_C18_1' 'CE_C18_0' 'CE_C18_1' 'liver_weight'};
for i_fn = 1:length(fns)
    fn = char(fns{i_fn});
    d_sel.(fn).t = [0 d_sel.(fn).t];
   
    d_sel.(fn).d = [repmat(nanmean(A{1}.(fn).d(:)),length(d_sel.(fn).d),1)  d_sel.(fn).d];
    d_sel.(fn).mn = [nanmean(A{1}.(fn).d(:)) d_sel.(fn).mn];
    d_sel.(fn).sd = [nanstd(A{1}.(fn).d(:)) d_sel.(fn).sd];
end

d_ph = load_data_MINGLeD(d_sel,diet);