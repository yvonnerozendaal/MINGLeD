function m = initialize_model(m,data)

if isfield(data,'pl_G_umol')
    m.x0(1) = data.pl_G_umol.m(1);
else
    m.x0(1) = 1;
end

if isfield(data,'pl_FFA_umol')
    m.x0(2) = data.pl_FFA_umol.m(1);
else
    m.x0(2) = 1;
end

if isfield(data,'pl_HDLC_umol')
    m.x0(3) = data.pl_HDLC_umol.m(1);
else
    m.x0(3) = 1;
end

if isfield(data,'pl_TC_min_pl_HDLC_umol') % = pl VLDL C
    m.x0(4) = data.pl_TC_min_pl_HDLC_umol.m(1);
else
    m.x0(4) = 1;
end    

if isfield(data,'pl_TG_umol') % = pl VLDL TG
    m.x0(5) = data.pl_TG_umol.m(1);
else
    m.x0(5) = 1;
end

if isfield(data,'hep_TG.m')
    m.x0(6) = data.hep_TG.m(1);
else
    m.x0(6) = 1;
end

if isfield(data,'hep_FC')
    m.x0(7) = data.hep_FC.m(1);
else
    m.x0(7) = 1;
end

if isfield(data,'hep_TC_min_hep_FC') % = hep CE
    m.x0(8) = data.hep_TC_min_hep_FC.m(1);
else
    m.x0(8) = 1;
end

m.x0(9) = 1;  %hep G6P            
m.x0(10) = 1; %hep ACoA
m.x0(11) = 1; %hep BA

if isfield(data,'fat_mass') % = per TG
    m.x0(12) = data.fat_mass.m(1);
else
    m.x0(12) = 1;
end

m.x0(13) = 1; %per C
m.x0(14) = 1; %per G6P
m.x0(15) = 1; %per ACoA
m.x0(16) = 1; %int TG
m.x0(17) = 1; %int C
m.x0(18) = 1; %int BA
        

%% state variables definition
define_model;

m.p_init = ones(length(m.info.p),1);
            

%% observable pairs: {name-model-component  name-data-component}
m.eq.y{1} = {'pl_G' 'pl_G_umol'};
m.info.y{1} = m.info.x{1}; %pl_G

m.eq.y{2} = {'pl_FFA'     'pl_FFA_umol'};
m.info.y{2} = m.info.x{2}; %pl_FFA

m.eq.y{3} = {'pl_HDL_C'   'pl_HDLC_umol'};
m.info.y{3} = m.info.x{3}; %pl_HDL_C

m.eq.y{4} = {'pl_VLDL_C'  'pl_TC_min_pl_HDLC_umol'};
m.info.y{4} = m.info.x{4}; %pl_VLDL_C

m.eq.y{5} = {'pl_VLDL_TG' 'pl_TG_umol'};
m.info.y{5} = m.info.x{5}; %pl_VLDL_TG

m.eq.y{6} = {'hep_TG'     'hep_TG'};
m.info.y{6} = m.info.x{6}; %hep_TG

m.eq.y{7} = {'hep_FC'     'hep_FC'};
m.info.y{7} = m.info.x{7}; %hep_FC

m.eq.y{8} = {'hep_CE'     'hep_TC_min_hep_FC'};
m.info.y{8} = m.info.x{8}; %hep_CE

m.eq.y{9} = {'j_TG_hep_DNL'     'hep_DNL'};
m.info.y{9} = m.info.j{31}; %j_TG_hep_DNL

m.eq.y{10} = {'per_TG' 'fat_mass_umol'};
m.info.y{10} = m.info.x{12}; %per_TG

m.eq.y{11} = {'j_AA_total' 'dietary_AA_estimation'};
m.info.y{11} = m.info.j{46}; %j_AA_total

%% define data pairs (for coupling of data and model for plotting purposes)
for i = 1:length(m.info.x) %=18
    m.datapairs.x{i} = {};
end
for i = 1:length(m.info.j) %=53
    m.datapairs.j{i} = {};
end
for i = 1:length(m.info.y) %=11
    m.datapairs.y{i} = {m.eq.y{i}{2}};
end
for i = 1:length(m.info.p) %=37
    m.datapairs.p{i} = {};
end
m.datapairs.x{1} = {'pl_G_umol'};
m.datapairs.x{2} = {'pl_FFA_umol'};
m.datapairs.x{3} = {'pl_HDLC_umol'};
m.datapairs.x{4} = {'pl_TC_min_pl_HDLC_umol'};
m.datapairs.x{5} = {'pl_TG_umol'};
m.datapairs.x{6} = {'hep_TG'};
m.datapairs.x{7} = {'hep_FC'};
m.datapairs.x{8} = {'hep_CE'};
m.datapairs.x{12} = {'per_TG'};
m.datapairs.j{31} = {'hep_DNL'};
m.datapairs.j{46} = {'dietary_AA_estimation'};
m.datapairs.j{47} = {'pl_G'};
m.datapairs.j{48} = {'pl_FFA'};
m.datapairs.j{49} = {'pl_HDLC'};
m.datapairs.j{50} = {'pl_TC_min_pl_HDLC'};
m.datapairs.j{51} = {'pl_TG'};
m.datapairs.j{52} = {'pl_'};
m.datapairs.j{53} = {'pl_TC'};

%% model constants and variables
m.info.t_unit = '';
m.info.t_max = m.t_max;