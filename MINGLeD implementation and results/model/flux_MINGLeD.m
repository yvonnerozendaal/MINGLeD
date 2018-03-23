function j = flux_MINGLeD(t,x,p,u,m)


% j_diet_G: dietary glucose intake
j(1) = m.c.diet_G;

% j_diet_TG: dietary triglyceride intake
j(2) = m.c.diet_TG;

% j_diet_C: dietary cholesterol intake
j(3) = m.c.diet_C;

% j_diet_AA: dietary protein intake
j(4) = m.c.diet_AA;

% j_CM_TG_remn_upt_hep: CM-TG remnant uptake_{hep}
j(5) = p(m.p.k_CM_TG_remn_upt_hep)*x(m.s.int_TG);

% j_CM_TG_remn_upt_per: CM-TG remnant uptake_{per}
j(6) = p(m.p.k_CM_TG_remn_upt_per)*x(m.s.int_TG);

% j_CM_C_remn_upt: CM-C remnant uptake_{hep}
j(7) = p(m.p.k_CM_C_remn_upt)*x(m.s.int_C);

% j_AA_hep_upt: protein uptake_{hep}
j(8) = p(m.p.k_AA_hep_upt)*j(m.j.j_diet_AA);

% j_AA_per_upt: protein uptake_{per}
j(9) = p(m.p.k_AA_per_upt)*j(m.j.j_diet_AA);

% j_AA_hep_glc: glucogenic protein uptake_{hep}
j(10) = 0.5*j(m.j.j_AA_hep_upt);

% j_AA_per_glc: glucogenic protein uptake_{per}
j(11) = 0.5*j(m.j.j_AA_per_upt);

% j_AA_hep_ket: ketogenic protein uptake_{hep}
j(12) = 0.5*j(m.j.j_AA_hep_upt);

% j_AA_per_ket: ketogenic protein uptake_{per}
j(13) = 0.5*j(m.j.j_AA_per_upt);

% j_G_hep_upt: G uptake_{hep}
j(14) = p(m.p.k_G_hep_upt)*x(m.s.pl_G);

% j_G_per_upt: G uptake_{per}
j(15) = p(m.p.k_G_per_upt)*x(m.s.pl_G);

% j_G_hep_glycolysis: glycolysis_{hep}
j(16) = p(m.p.k_hep_glycolysis)*x(m.s.hep_G6P);

% j_G_hep_GNG: GNG_{hep}
j(17) = p(m.p.k_hep_GNG)*x(m.s.hep_G6P);

% j_G_per_glycolysis: glycolysis_{per}
j(18) = p(m.p.k_per_glycolysis)*x(m.s.per_G6P);

% j_VLDL_TG_upt: VLDL-TG uptake_{per}
j(19) = p(m.p.k_VLDL_TG_upt)*x(m.s.pl_VLDL_TG);

% j_VLDL_C_upt_per: VLDL-C uptake_{per}
j(20) = p(m.p.k_VLDL_C_upt_per)*x(m.s.pl_VLDL_C);

% j_VLDL_C_hep_upt_remn: VLDL-C remnant uptake_{hep}
j(21) = p(m.p.k_VLDL_C_hep_upt_remn)*x(m.s.pl_VLDL_C);

% j_VLDL_TG_form: VLDL-TG assembly
j(22) = p(m.p.k_VLDL_TG_form)*x(m.s.hep_TG);

% j_VLDL_C_form: VLDL-C assembly
j(23) = p(m.p.k_VLDL_C_form)*x(m.s.hep_CE);

% j_HDL_C_form: HDL-C assembly
j(24) = p(m.p.k_HDL_C_form)*x(m.s.per_C);

% j_HDL_C_remn_upt: HDL-C remnant uptake
j(25) = p(m.p.k_HDL_C_remn_upt)*x(m.s.pl_HDL_C);

% j_TICE: TICE
j(26) = p(m.p.k_TICE)*x(m.s.pl_VLDL_C);

% j_CETP: CETP
j(27) = p(m.p.k_CETP)*x(m.s.pl_VLDL_TG);

% j_FA_hep_upt: esterification_{hep}
j(28) = p(m.p.k_hep_FA_upt)*x(m.s.pl_FFA);

% j_TG_hep_betaox: eta-oxidation_{hep}
j(29) = p(m.p.k_hep_betaox)*x(m.s.hep_TG);

% j_C_hep_biosynt: C biosynthesis_{hep})
j(30) = p(m.p.k_hep_biosynt)*x(m.s.hep_ACoA);

% j_TG_hep_DNL: DNL_{hep}
j(31) = p(m.p.k_hep_DNL)*x(m.s.hep_ACoA);

% j_TG_per_lipolysis: lipolysis_{per}
j(32) = p(m.p.k_LPL)*x(m.s.per_TG);

% j_TG_per_betaox: eta-oxidation_{per}
j(33) = p(m.p.k_per_betaox)*x(m.s.per_TG);

% j_C_per_biosynt: C biosynthesis_{per}
j(34) = p(m.p.k_per_biosynt)*x(m.s.per_ACoA);

% j_TG_per_DNL: DNL_{per}
j(35) = p(m.p.k_per_DNL)*x(m.s.per_ACoA);

% j_ACAT: C storage_{hep}
j(36) = p(m.p.k_ACAT)*x(m.s.hep_FC);

% j_CEH: C release_{hep}
j(37) = p(m.p.k_CEH)*x(m.s.hep_CE);

% j_BA_synt: BA synthesis
j(38) = p(m.p.k_BA_synt)*x(m.s.hep_FC);

% j_BA_bil_excr: biliary BA excretion
j(39) = p(m.p.k_BA_bil_excr)*x(m.s.hep_BA);

% j_BA_recycl: bile acid recyling
j(40) = p(m.p.k_BA_recycl)*x(m.s.int_BA);

% j_C_bil_excr: biliary C excretion
j(41) = p(m.p.k_C_bil_excr)*x(m.s.hep_FC);

% j_C_fec_excr: fecal C excretion
j(42) = p(m.p.k_C_excr)*x(m.s.int_C);

% j_BA_fec_excr: fecal BA excretion
j(43) = p(m.p.k_BA_excr)*x(m.s.int_BA);

% j_ACoA_hep_resp: ACoA respiration_{hep}
j(44) = p(m.p.k_hep_resp)*x(m.s.hep_ACoA);

% j_ACoA_per_resp: ACoA respiration_{per}
j(45) = p(m.p.k_per_resp)*x(m.s.per_ACoA);

% j_AA_total: protein uptake
j(46) = j(m.j.j_AA_hep_upt)+j(m.j.j_AA_per_upt);

% y_pl_G: plasma glucose
j(47) = x(m.s.pl_G)/m.c.Vpl;

% y_pl_FFA: plasma free fatty acids
j(48) = x(m.s.pl_FFA)/m.c.Vpl;

% y_pl_HDL_C: plasma HDL-C
j(49) = x(m.s.pl_HDL_C)/m.c.Vpl;

% y_pl_VLDL_C: plasma (V)LDL-C
j(50) = x(m.s.pl_VLDL_C)/m.c.Vpl;

% y_pl_VLDL_TG: plasma (V)LDL-TG
j(51) = x(m.s.pl_VLDL_TG)/m.c.Vpl;

% y_pl_VLDL_C_HDL_C_ratio: plasma (V)LDL-C:HDL-C ratio
j(52) = x(m.s.pl_VLDL_C)/x(m.s.pl_HDL_C);

% y_pl_TC: plasma TC
j(53) = x(m.s.pl_VLDL_C)+x(m.s.pl_HDL_C);