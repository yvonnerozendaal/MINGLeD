function dxdt = ODE_MINGLeD(t,x,p,u,m)

j_diet_G = m.c.diet_G;
j_diet_TG = m.c.diet_TG;
j_diet_C = m.c.diet_C;
j_diet_AA = m.c.diet_AA;
j_CM_TG_remn_upt_hep = p(m.p.k_CM_TG_remn_upt_hep)*x(m.s.int_TG);
j_CM_TG_remn_upt_per = p(m.p.k_CM_TG_remn_upt_per)*x(m.s.int_TG);
j_CM_C_remn_upt = p(m.p.k_CM_C_remn_upt)*x(m.s.int_C);
j_AA_hep_upt = p(m.p.k_AA_hep_upt)*j_diet_AA;
j_AA_per_upt = p(m.p.k_AA_per_upt)*j_diet_AA;
j_AA_hep_glc = 0.5*j_AA_hep_upt;
j_AA_per_glc = 0.5*j_AA_per_upt;
j_AA_hep_ket = 0.5*j_AA_hep_upt;
j_AA_per_ket = 0.5*j_AA_per_upt;
j_G_hep_upt = p(m.p.k_G_hep_upt)*x(m.s.pl_G);
j_G_per_upt = p(m.p.k_G_per_upt)*x(m.s.pl_G);
j_G_hep_glycolysis = p(m.p.k_hep_glycolysis)*x(m.s.hep_G6P);
j_G_hep_GNG = p(m.p.k_hep_GNG)*x(m.s.hep_G6P);
j_G_per_glycolysis = p(m.p.k_per_glycolysis)*x(m.s.per_G6P);
j_VLDL_TG_upt = p(m.p.k_VLDL_TG_upt)*x(m.s.pl_VLDL_TG);
j_VLDL_C_upt_per = p(m.p.k_VLDL_C_upt_per)*x(m.s.pl_VLDL_C);
j_VLDL_C_hep_upt_remn = p(m.p.k_VLDL_C_hep_upt_remn)*x(m.s.pl_VLDL_C);
j_VLDL_TG_form = p(m.p.k_VLDL_TG_form)*x(m.s.hep_TG);
j_VLDL_C_form = p(m.p.k_VLDL_C_form)*x(m.s.hep_CE);
j_HDL_C_form = p(m.p.k_HDL_C_form)*x(m.s.per_C);
j_HDL_C_remn_upt = p(m.p.k_HDL_C_remn_upt)*x(m.s.pl_HDL_C);
j_TICE = p(m.p.k_TICE)*x(m.s.pl_VLDL_C);
j_CETP = p(m.p.k_CETP)*x(m.s.pl_VLDL_TG);
j_FA_hep_upt = p(m.p.k_hep_FA_upt)*x(m.s.pl_FFA);
j_TG_hep_betaox = p(m.p.k_hep_betaox)*x(m.s.hep_TG);
j_C_hep_biosynt = p(m.p.k_hep_biosynt)*x(m.s.hep_ACoA);
j_TG_hep_DNL = p(m.p.k_hep_DNL)*x(m.s.hep_ACoA);
j_TG_per_lipolysis = p(m.p.k_LPL)*x(m.s.per_TG);
j_TG_per_betaox = p(m.p.k_per_betaox)*x(m.s.per_TG);
j_C_per_biosynt = p(m.p.k_per_biosynt)*x(m.s.per_ACoA);
j_TG_per_DNL = p(m.p.k_per_DNL)*x(m.s.per_ACoA);
j_ACAT = p(m.p.k_ACAT)*x(m.s.hep_FC);
j_CEH = p(m.p.k_CEH)*x(m.s.hep_CE);
j_BA_synt = p(m.p.k_BA_synt)*x(m.s.hep_FC);
j_BA_bil_excr = p(m.p.k_BA_bil_excr)*x(m.s.hep_BA);
j_BA_recycl = p(m.p.k_BA_recycl)*x(m.s.int_BA);
j_C_bil_excr = p(m.p.k_C_bil_excr)*x(m.s.hep_FC);
j_C_fec_excr = p(m.p.k_C_excr)*x(m.s.int_C);
j_BA_fec_excr = p(m.p.k_BA_excr)*x(m.s.int_BA);
j_ACoA_hep_resp = p(m.p.k_hep_resp)*x(m.s.hep_ACoA);
j_ACoA_per_resp = p(m.p.k_per_resp)*x(m.s.per_ACoA);
j_AA_total = j_AA_hep_upt+j_AA_per_upt;
y_pl_G = x(m.s.pl_G)/m.c.Vpl;
y_pl_FFA = x(m.s.pl_FFA)/m.c.Vpl;
y_pl_HDL_C = x(m.s.pl_HDL_C)/m.c.Vpl;
y_pl_VLDL_C = x(m.s.pl_VLDL_C)/m.c.Vpl;
y_pl_VLDL_TG = x(m.s.pl_VLDL_TG)/m.c.Vpl;
y_pl_VLDL_C_HDL_C_ratio = x(m.s.pl_VLDL_C)/x(m.s.pl_HDL_C);
y_pl_TC = x(m.s.pl_VLDL_C)+x(m.s.pl_HDL_C);


% [ODE] pl_G: plasma glucose
dxdt(1) = j_diet_G - j_G_hep_upt - j_G_per_upt + j_G_hep_GNG;

% [ODE] pl_FFA: plasma free fatty acids
dxdt(2) = 3*j_TG_per_lipolysis - j_FA_hep_upt;

% [ODE] pl_HDL_C: plasma HDL-C
dxdt(3) = j_HDL_C_form - j_CETP - j_HDL_C_remn_upt;

% [ODE] pl_VLDL_C: plasma (V)LDL-C
dxdt(4) = j_VLDL_C_form - j_VLDL_C_hep_upt_remn - j_VLDL_C_upt_per - j_TICE + j_CETP;

% [ODE] pl_VLDL_TG: plasma (V)LDL-TG
dxdt(5) = j_VLDL_TG_form - j_VLDL_TG_upt;

% [ODE] hep_TG: hepatic triglycerides
dxdt(6) = j_CM_TG_remn_upt_hep + j_FA_hep_upt/3 + j_TG_hep_DNL/21.4 - j_TG_hep_betaox - j_VLDL_TG_form;

% [ODE] hep_FC: hepatic free cholesterol
dxdt(7) = j_CM_C_remn_upt + j_C_hep_biosynt/13.5 + j_CEH - j_ACAT - j_BA_synt - j_C_bil_excr;

% [ODE] hep_CE: hepatic cholesteryl ester
dxdt(8) = j_VLDL_C_hep_upt_remn + j_HDL_C_remn_upt + j_ACAT - j_VLDL_C_form - j_CEH;

% [ODE] hep_G6P: hepatic glucose-6-phosphate
dxdt(9) = j_G_hep_upt + j_AA_hep_glc - j_G_hep_glycolysis - j_G_hep_GNG;

% [ODE] hep_ACoA: hepatic Acetyl CoA
dxdt(10) = j_AA_hep_ket + 2*j_G_hep_glycolysis + 21.4*j_TG_hep_betaox - j_TG_hep_DNL - j_C_hep_biosynt - j_ACoA_hep_resp;

% [ODE] hep_BA: hepatic bile acids
dxdt(11) = j_BA_synt - j_BA_bil_excr + j_BA_recycl;

% [ODE] per_TG: peripheral triglyceride
dxdt(12) = j_CM_TG_remn_upt_per - j_TG_per_lipolysis + j_VLDL_TG_upt + j_TG_per_DNL/21.4 - j_TG_per_betaox;

% [ODE] per_C: peripheral cholesterol
dxdt(13) = j_VLDL_C_upt_per + j_C_per_biosynt/13.5 - j_HDL_C_form;

% [ODE] per_G6P: peripheral glucose-6-phosphate
dxdt(14) = j_G_per_upt + j_AA_per_glc - j_G_per_glycolysis;

% [ODE] per_ACoA: peripheral Acetyl CoA
dxdt(15) = j_AA_per_ket + 2*j_G_per_glycolysis + 21.4*j_TG_per_betaox - j_TG_per_DNL - j_C_per_biosynt - j_ACoA_per_resp;

% [ODE] int_TG: intestinal triglycerides
dxdt(16) = j_diet_TG - j_CM_TG_remn_upt_hep - j_CM_TG_remn_upt_per;

% [ODE] int_C: intestinal cholesterol
dxdt(17) = j_diet_C + j_C_bil_excr + j_TICE - j_CM_C_remn_upt - j_C_fec_excr;

% [ODE] int_BA: intestinal bile acids
dxdt(18) = j_BA_bil_excr - j_BA_fec_excr - j_BA_recycl;

dxdt = dxdt(:);