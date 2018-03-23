m.eq.x = {'j_diet_G - j_G_hep_upt - j_G_per_upt + j_G_hep_GNG' %pl G
          '3*j_TG_per_lipolysis - j_FA_hep_upt' %pl FFA
          'j_HDL_C_form - j_CETP - j_HDL_C_remn_upt' %pl HDL C
          'j_VLDL_C_form - j_VLDL_C_hep_upt_remn - j_VLDL_C_upt_per - j_TICE + j_CETP' %pl VLDL C
          'j_VLDL_TG_form - j_VLDL_TG_upt' %pl VLDL TG
          
          'j_CM_TG_remn_upt_hep + j_FA_hep_upt/3 + j_TG_hep_DNL/21.4 - j_TG_hep_betaox - j_VLDL_TG_form' %hep TG
          'j_CM_C_remn_upt + j_C_hep_biosynt/13.5 + j_CEH - j_ACAT - j_BA_synt - j_C_bil_excr' %hep FC
          'j_VLDL_C_hep_upt_remn + j_HDL_C_remn_upt + j_ACAT - j_VLDL_C_form - j_CEH' %hep CE
          'j_G_hep_upt + j_AA_hep_glc - j_G_hep_glycolysis - j_G_hep_GNG' %hep G6P
          'j_AA_hep_ket + 2*j_G_hep_glycolysis + 21.4*j_TG_hep_betaox - j_TG_hep_DNL - j_C_hep_biosynt - j_ACoA_hep_resp' %hep ACoA
          'j_BA_synt - j_BA_bil_excr + j_BA_recycl' %hep BA
          
          'j_CM_TG_remn_upt_per - j_TG_per_lipolysis + j_VLDL_TG_upt + j_TG_per_DNL/21.4 - j_TG_per_betaox' %per TG
          'j_VLDL_C_upt_per + j_C_per_biosynt/13.5 - j_HDL_C_form' %per C
          'j_G_per_upt + j_AA_per_glc - j_G_per_glycolysis' %per G6P
          'j_AA_per_ket + 2*j_G_per_glycolysis + 21.4*j_TG_per_betaox - j_TG_per_DNL - j_C_per_biosynt - j_ACoA_per_resp' %per ACoA
          
          'j_diet_TG - j_CM_TG_remn_upt_hep - j_CM_TG_remn_upt_per' %int TG
          'j_diet_C + j_C_bil_excr + j_TICE - j_CM_C_remn_upt - j_C_fec_excr' %int C
          'j_BA_bil_excr - j_BA_fec_excr - j_BA_recycl' %int BA
          };

      
              %state name   state description               state unit  state abbreviaton
m.info.x{1} = {'pl_G'       'plasma glucose'                 '\mumol'  'G_{pl}'};
m.info.x{2} = {'pl_FFA'     'plasma free fatty acids'        '\mumol'  'FFA_{pl}'};
m.info.x{3} = {'pl_HDL_C'	'plasma HDL-C'                   '\mumol'  'HDL-C_{pl}'};
m.info.x{4} = {'pl_VLDL_C'	'plasma (V)LDL-C'                '\mumol'  '(V)LDL-C_{pl}'};
m.info.x{5} = {'pl_VLDL_TG'	'plasma (V)LDL-TG'               '\mumol'  '(V)LDL-TG_{pl}'};

m.info.x{6} = {'hep_TG'     'hepatic triglycerides'          '\mumol'  'TG_{hep}'};
m.info.x{7} = {'hep_FC'     'hepatic free cholesterol'       '\mumol'  'FC_{hep}'};
m.info.x{8} = {'hep_CE'     'hepatic cholesteryl ester'      '\mumol'  'CE_{hep}'};
m.info.x{9} = {'hep_G6P'	'hepatic glucose-6-phosphate'    '\mumol'  'G6P_{hep}'};
m.info.x{10} = {'hep_ACoA'  'hepatic Acetyl CoA'             '\mumol'  'ACoA_{hep}'};
m.info.x{11} = {'hep_BA'    'hepatic bile acids'             '\mumol'  'BA_{hep}'};

m.info.x{12} = {'per_TG'    'peripheral triglyceride'        '\mumol'  'TG_{per}'};
m.info.x{13} = {'per_C'     'peripheral cholesterol'         '\mumol'  'C_{per}'};
m.info.x{14} = {'per_G6P'	'peripheral glucose-6-phosphate' '\mumol'  'G6P_{per}'};
m.info.x{15} = {'per_ACoA'  'peripheral Acetyl CoA'          '\mumol'  'ACoA_{per}'};

m.info.x{16} = {'int_TG'    'intestinal triglycerides'       '\mumol'  'TG_{int}'};
m.info.x{17} = {'int_C'     'intestinal cholesterol'         '\mumol'  'C_{int}'};
m.info.x{18} = {'int_BA'	'intestinal bile acids'          '\mumol'  'BA_{int}'};



%% parameter definition
m.info.p{1} = {'k_CM_TG_remn_upt_hep'  '' '' 'k^{CM-TG}_{upt,hep}'};
m.info.p{2} = {'k_CM_TG_remn_upt_per'  '' '' 'k^{CM-TG}_{upt,per}'};
m.info.p{3} = {'k_CM_C_remn_upt'       '' '' 'k^{CM-C}_{upt,hep}'};

m.info.p{4} = {'k_AA_hep_upt'           '' '' 'k^{AA}_{upt,hep}'};
m.info.p{5} = {'k_AA_per_upt'           '' '' 'k^{AA}_{upt,per}'};

m.info.p{6} = {'k_G_hep_upt'           '' '' 'k^{G}_{upt,hep}'};
m.info.p{7} = {'k_G_per_upt'           '' '' 'k^{G}_{upt,per}'};
m.info.p{8} = {'k_hep_glycolysis'      '' '' 'k^{G}_{glycolysis,hep}'};
m.info.p{9} = {'k_hep_GNG'             '' '' 'k^{G}_{GNG,hep}'};
m.info.p{10} = {'k_per_glycolysis'     '' '' 'k^{G}_{glycolysis,per}'};

m.info.p{11} = {'k_VLDL_TG_upt'         '' '' 'k^{(V)LDL-TG}_{upt,per}'};
m.info.p{12} = {'k_VLDL_C_upt_per'      '' '' 'k^{(V)LDL-C}_{upt,hep}'};
m.info.p{13} = {'k_VLDL_C_hep_upt_remn' '' '' 'k^{(V)LDL-C}_{remn.upt,per}'};
m.info.p{14} = {'k_VLDL_TG_form'        '' '' 'k^{(V)LDL-TG}_{form,hep}'};
m.info.p{15} = {'k_VLDL_C_form'         '' '' 'k^{(V)LDL-C}_{form,hep}'};
m.info.p{16} = {'k_HDL_C_form'          '' '' 'k^{HDL-C}_{form,per}'};
m.info.p{17} = {'k_HDL_C_remn_upt'      '' '' 'k^{HDL-C}_{upt,hep}'};
m.info.p{18} = {'k_TICE'                '' '' 'k_{TICE}'};
m.info.p{19} = {'k_CETP'                '' '' 'k_{CETP}'};

m.info.p{20} = {'k_hep_FA_upt'      '' '' 'k^{FA}_{upt,hep}'};
m.info.p{21} = {'k_hep_betaox'      '' '' 'k^{TG}_{\beta_ox,hep}'};
m.info.p{22} = {'k_hep_biosynt'     '' '' 'k^{C}_{biosyn,hep}'};
m.info.p{23} = {'k_hep_DNL'         '' '' 'k^{TG}_{DNL,hep}'};
m.info.p{24} = {'k_LPL'             '' '' 'k^{TG}_{LPL,per}'};
m.info.p{25} = {'k_per_betaox'      '' '' 'k^{TG}_{\beta_ox,per'};
m.info.p{26} = {'k_per_biosynt'     '' '' 'k^{C}_{biosyn,per}'};
m.info.p{27} = {'k_per_DNL'         '' '' 'k^{TG}_{DNL,per}'};

m.info.p{28} = {'k_ACAT'            '' '' 'k^{C}_{ACAT,hep}'};
m.info.p{29} = {'k_CEH'             '' '' 'k^{C}_{CEH,hep}'};
m.info.p{30} = {'k_BA_synt'         '' '' 'k^{BA}_{syn,hep}'};
m.info.p{31} = {'k_BA_bil_excr'     '' '' 'k^{BA}_{excr,bil}'};
m.info.p{32} = {'k_BA_recycl'       '' '' 'k^{BA}_{recycl}'};
m.info.p{33} = {'k_C_bil_excr'      '' '' 'k^{C}_{excr,bil}'};

m.info.p{34} = {'k_C_excr'          '' '' 'k^{C}_{excr,fec}'};
m.info.p{35} = {'k_BA_excr'         '' '' 'k^{BA}_{excr,fec}'};
m.info.p{36} = {'k_hep_resp'        '' '' 'k^{ACoA}_{resp,hep}'};
m.info.p{37} = {'k_per_resp'        '' '' 'k^{ACoA}_{resp,per}'};

%% inputs
m.u = [];

%% constants
m.c.Vpl = data.V_pl.m; %[mL]
m.c.diet_G  = data.dietary_G.m;  %[umol/day]
m.c.diet_C  = data.dietary_C.m;  %[umol/day]
m.c.diet_TG = data.dietary_TG.m; %[umol/day]
m.c.diet_AA = data.dietary_AA_estimation.m; %[umol/day]


%% flux definition
m.eq.j = {
    'm.c.diet_G'                        % 1 j_diet_G
    'm.c.diet_TG'                       % 2 j_diet_TG
    'm.c.diet_C'                        % 3 j_diet_C
    'm.c.diet_AA'                       % 4 j_diet_AA  
    
    'k_CM_TG_remn_upt_hep * int_TG'     % 5 j_CM_TG_remn_upt_hep: int TG > hep TG
    'k_CM_TG_remn_upt_per * int_TG'     % 6 j_CM_TG_remn_upt_per: int TG > per TG
    'k_CM_C_remn_upt * int_C'           % 7 j_CM_C_remn_upt: int C > hep FC
    'k_AA_hep_upt * j_diet_AA'          % 8 j_AA_hep_upt : diet AA > hep
    'k_AA_per_upt * j_diet_AA'          % 9 j_AA_per_upt : diet AA > per
    '0.5 * j_AA_hep_upt'                % 10 j_AA_hep_glc : diet AA > hep G6P
    '0.5 * j_AA_per_upt'                % 11 j_AA_per_glc : diet AA > per G6P
    '0.5 * j_AA_hep_upt'                % 12 j_AA_hep_ket : diet AA > hep ACoA
    '0.5 * j_AA_per_upt'                % 13 j_AA_per_ket : diet AA > per ACoA
    'k_G_hep_upt * pl_G'                % 14 j_G_hep_upt :             1 pl G    > 1 hep G6P
    'k_G_per_upt * pl_G'                % 15 j_G_per_upt :             1 pl G    > 1 per G6P

    'k_hep_glycolysis * hep_G6P'        % 16 j_G_hep_glycolysis :      1 hep G6P > 2 hep ACoA
    'k_hep_GNG * hep_G6P'               % 17 j_G_hep_GNG :             1 hep G6P > 1 pl G
    'k_per_glycolysis * per_G6P'        % 18 j_G_per_glycolysis :      1 per G6P > 2 per ACoA
    
    'k_VLDL_TG_upt * pl_VLDL_TG'        % 19 j_VLDL_TG_upt :         1 pl VLDL-TG > 1 per TG
    'k_VLDL_C_upt_per * pl_VLDL_C'      % 20 j_VLDL_C_upt_per :      1 pl VLDL-C  > 1 per C
    'k_VLDL_C_hep_upt_remn * pl_VLDL_C' % 21 j_VLDL_C_hep_upt_remn : 1 pl VLDL-C  > 1 hep CE
    'k_VLDL_TG_form * hep_TG'           % 22 j_VLDL_TG_form :        1 hep TG     > 1 pl VLDL-TG
    'k_VLDL_C_form * hep_CE'            % 23 j_VLDL_C_form :         1 hep CE     > 1 pl VLDL-C
    'k_HDL_C_form * per_C'              % 24 j_HDL_C_form :          1 per C      > 1 pl HDL-C
    'k_HDL_C_remn_upt * pl_HDL_C'       % 25 j_HDL_C_remn_upt :      1 pl HDL-C   > 1 hep CE
    'k_TICE * pl_VLDL_C'                % 26 j_TICE :                1 pl VLDL-C  > 1 int C
    'k_CETP * pl_VLDL_TG'               % 27 j_CETP :                1 pl HDL-C > 1 pl VLDL-C
                                            
    'k_hep_FA_upt * pl_FFA'             % 28 j_FA_hep_upt :    3 pl FFA      > 1 hep TG
    'k_hep_betaox * hep_TG'             % 29 j_TG_hep_betaox : 1 hep TG      > 21.4 hep ACoA
    'k_hep_biosynt * hep_ACoA'          % 30 j_C_hep_biosynt : 13.5 hep ACoA > 1 hep FC
    'k_hep_DNL * hep_ACoA'              % 31 j_TG_hep_DNL :    21.4 hep ACoA > 1 hep TG
    'k_LPL * per_TG'                    % 32 j_TG_per_lipolysis :    1 per TG > 3 pl FFA
    'k_per_betaox * per_TG'             % 33 j_TG_per_betaox : 1 per TG      > 21.4 per ACoA
    'k_per_biosynt * per_ACoA'          % 34 j_C_per_biosynt : 13.5 per ACoA > 1 per FC
    'k_per_DNL * per_ACoA'              % 35 j_TG_per_DNL :    21.4 per ACoA > 1 per TG
    
    'k_ACAT * hep_FC'                   % 36 j_ACAT : 1 hep FC > 1 hep CE
    'k_CEH * hep_CE'                    % 37 j_CEH :  1 hep CE > 1 hep FC
    'k_BA_synt * hep_FC'                % 38 j_BA_synt :    1 hep FC > 1 int BA
    'k_BA_bil_excr * hep_BA'            % 39 j_BA_bil_excr :1 hep BA > 1 int BA
    'k_BA_recycl * int_BA'              % 40 j_BA_recycl :  1 int BA > 1 hep BA
    'k_C_bil_excr * hep_FC'             % 41 j_C_bil_excr : 1 hep FC > 1 int C
    
    'k_C_excr * int_C'                  % 42 j_C_fec_excr :    int C > ...
    'k_BA_excr * int_BA'                % 43 j_BA_fec_excr :   int BA > ...
    'k_hep_resp * hep_ACoA'             % 44 j_ACoA_hep_resp : hep ACoA > ...
    'k_per_resp * per_ACoA'             % 45 j_ACoA_per_resp : per ACoA > ...
    
    %helper functions
    'j_AA_hep_upt + j_AA_per_upt'       % 46 j_AA_total
    
    %for conventient plotting
    'pl_G / m.c.Vpl'                    %
    'pl_FFA / m.c.Vpl'                  %  
    'pl_HDL_C / m.c.Vpl'                % 
    'pl_VLDL_C / m.c.Vpl'               % 
    'pl_VLDL_TG / m.c.Vpl'              % 
    'pl_VLDL_C / pl_HDL_C'              % VLDL:HDL ratio
    'pl_VLDL_C + pl_HDL_C'              % total cholesterol
    };
      


               %flux name               flux description                    flux unit
%dietary fluxes
m.info.j{1} = {'j_diet_G'                  'dietary glucose intake'         '\mumol/day'    'G_{in}'};
m.info.j{2} = {'j_diet_TG'                 'dietary triglyceride intake'	'\mumol/day'    'TG_{in}'};
m.info.j{3} = {'j_diet_C'                  'dietary cholesterol intake'     '\mumol/day'    'C_{in}'};
m.info.j{4} = {'j_diet_AA'                 'dietary protein intake'         '\mumol/day'    'AA_{in}'};

%macronutrient uptake fluxes
m.info.j{5} = {'j_CM_TG_remn_upt_hep'      'CM-TG remnant uptake_{hep}'         '\mumol/day'    'j^{CM-TG}_{upt,hep}'};
m.info.j{6} = {'j_CM_TG_remn_upt_per'      'CM-TG remnant uptake_{per}'         '\mumol/day'    'j^{CM_TG}_{upt,per}'};
m.info.j{7} = {'j_CM_C_remn_upt'           'CM-C remnant uptake_{hep}'          '\mumol/day'    'j^{CM-C}_{upt,hep}'};
m.info.j{8} = {'j_AA_hep_upt'              'protein uptake_{hep}'               '\mumol/day'    'j^{AA}_{upt,hep}'};
m.info.j{9} = {'j_AA_per_upt'              'protein uptake_{per}'               '\mumol/day'    'j^{AA}_{upt,per}'};
m.info.j{10} = {'j_AA_hep_glc'             'glucogenic protein uptake_{hep}'    '\mumol/day'    'j^{AA}_{glc.upt,hep}'};
m.info.j{11} = {'j_AA_per_glc'             'glucogenic protein uptake_{per}'    '\mumol/day'    'j^{AA}_{glc.upt,per}'};
m.info.j{12} = {'j_AA_hep_ket'             'ketogenic protein uptake_{hep}'     '\mumol/day'    'j^{AA}_{ket.upt,hep}'};
m.info.j{13} = {'j_AA_per_ket'             'ketogenic protein uptake_{per}'     '\mumol/day'    'j^{AA}_{ket.upt,per}'};
m.info.j{14} = {'j_G_hep_upt'              'G uptake_{hep}'                     '\mumol/day'    'j^{G}_{upt,hep}'};
m.info.j{15} = {'j_G_per_upt'              'G uptake_{per}'                     '\mumol/day'    'j^{G}_{upt,per}'};

%carbohydrate fluxes
m.info.j{16} = {'j_G_hep_glycolysis'       'glycolysis_{hep}'                   '\mumol/day'    'j^{G}_{glycolysis,hep}'};
m.info.j{17} = {'j_G_hep_GNG'              'GNG_{hep}'                          '\mumol/day'    'j^{G}_{GNG,hep}'};
m.info.j{18} = {'j_G_per_glycolysis'       'glycolysis_{per}'                   '\mumol/day'    'j^{G}_{glycolysis,per}'};

%lipoprotein fluxes
m.info.j{19} = {'j_VLDL_TG_upt'            'VLDL-TG uptake_{per}'               '\mumol/day'    'j^{(V)LDL-TG}_{upt,per}'};
m.info.j{20} = {'j_VLDL_C_upt_per'         'VLDL-C uptake_{per}'                '\mumol/day'    'j^{(V)LDL-C}_{upt,per}'};
m.info.j{21} = {'j_VLDL_C_hep_upt_remn'    'VLDL-C remnant uptake_{hep}'        '\mumol/day'    'j^{(V)LDL-C}_{remn.upt,hep}'};
m.info.j{22} = {'j_VLDL_TG_form'           'VLDL-TG assembly'                   '\mumol/day'    'j^{(V)LDL-TG}_{form,hep}'};
m.info.j{23} = {'j_VLDL_C_form'            'VLDL-C assembly'                    '\mumol/day'    'j^{(V)LDL-C}_{form,hep}'};
m.info.j{24} = {'j_HDL_C_form'             'HDL-C assembly'                     '\mumol/day'    'j^{HDL-C}_{form,per}'};
m.info.j{25} = {'j_HDL_C_remn_upt'         'HDL-C remnant uptake'               '\mumol/day'    'j^{HDL-C}_{upt,hep}'};
m.info.j{26} = {'j_TICE'                   'TICE'                               '\mumol/day'    'j_{TICE}'};
m.info.j{27} = {'j_CETP'                   'CETP'                               '\mumol/day'    'j_{CETP}'};

%lipid fluxes
m.info.j{28} = {'j_FA_hep_upt'              'esterification_{hep}'          '\mumol/day'    'j^{FA}_{upt,hep}'};
m.info.j{29} = {'j_TG_hep_betaox'           '\beta-oxidation_{hep}'         '\mumol/day'    'j^{TG}_{\beta-ox,hep}'};
m.info.j{30} = {'j_C_hep_biosynt'           'C biosynthesis_{hep})'         '\mumol/day'    'j^{C}_{biosyn,hep}'};
m.info.j{31} = {'j_TG_hep_DNL'              'DNL_{hep}'                     '\mumol/day'    'j^{TG}_{DNL,hep}'};
m.info.j{32} = {'j_TG_per_lipolysis'        'lipolysis_{per}'               '\mumol/day'    'j^{TG}_{lipolysis,per}'};
m.info.j{33} = {'j_TG_per_betaox'           '\beta-oxidation_{per}'         '\mumol/day'    'j^{TG}_{\beta-ox,per}'};
m.info.j{34} = {'j_C_per_biosynt'           'C biosynthesis_{per}'          '\mumol/day'    'j^{C}_{biosyn,per}'};
m.info.j{35} = {'j_TG_per_DNL'              'DNL_{per}'                     '\mumol/day'    'j^{TG}_{DNL,per}'};

%cholesterol fluxes
m.info.j{36} = {'j_ACAT'                    'C storage_{hep}'               '\mumol/day'    'j^{C}_{ACAT,hep}'};
m.info.j{37} = {'j_CEH'                     'C release_{hep}'               '\mumol/day'    'j^{C}_{CEH,hep}'};
m.info.j{38} = {'j_BA_synt'                 'BA synthesis'                  '\mumol/day'    'j^{BA}_{syn,hep}'};
m.info.j{39} = {'j_BA_bil_excr'             'biliary BA excretion'          '\mumol/day'    'j^{BA}_{excr,int}'};
m.info.j{40} = {'j_BA_recycl'               'bile acid recyling'            '\mumol/day'    'j^{BA}_{recycl}'};
m.info.j{41} = {'j_C_bil_excr'              'biliary C excretion'           '\mumol/day'    'j^{C}_{excr,bil}'};

%removal fluxes
m.info.j{42} = {'j_C_fec_excr'              'fecal C excretion'             '\mumol/day'    'j^{C}_{excr,fec}'};
m.info.j{43} = {'j_BA_fec_excr'             'fecal BA excretion'            '\mumol/day'    'j^{BA}_{excr,fec}'};
m.info.j{44} = {'j_ACoA_hep_resp'           'ACoA respiration_{hep}'        '\mumol/day'    'j^{ACoA}_{resp,hep}'};
m.info.j{45} = {'j_ACoA_per_resp'           'ACoA respiration_{per}'        '\mumol/day'    'j^{ACoA}_{resp,per}'};

%helper functions
m.info.j{46} = {'j_AA_total'                'protein uptake'                '\mumol/day'    'j^{AA}_{upt}'};

%helping functions for convenient plotting
m.info.j{47} = {'y_pl_G'                    'plasma glucose'                 'mM'           'G_{pl}'};
m.info.j{48} = {'y_pl_FFA'                  'plasma free fatty acids'        'mM'           'FFA_{pl}'};
m.info.j{49} = {'y_pl_HDL_C'                'plasma HDL-C'                   'mM'           'HDL-C_{pl}'};
m.info.j{50} = {'y_pl_VLDL_C'               'plasma (V)LDL-C'                'mM'           '(V)LDL-C_{pl}'};
m.info.j{51} = {'y_pl_VLDL_TG'              'plasma (V)LDL-TG'               'mM'           '(V)LDL-TG_{pl}'};
m.info.j{52} = {'y_pl_VLDL_C_HDL_C_ratio'   'plasma (V)LDL-C:HDL-C ratio'    '-'            '(V)LDL-C_{pl}:HDL-C_{pl}'};
m.info.j{53} = {'y_pl_TC'                   'plasma TC'                      'mM'           'TC_{pl}'};