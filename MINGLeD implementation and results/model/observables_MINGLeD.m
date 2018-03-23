function y = observables_MINGLeD(t,x,j,p,u,m)


% pl_G: plasma glucose
y(1) = x(m.s.pl_G);

% pl_FFA: plasma free fatty acids
y(2) = x(m.s.pl_FFA);

% pl_HDL_C: plasma HDL-C
y(3) = x(m.s.pl_HDL_C);

% pl_VLDL_C: plasma (V)LDL-C
y(4) = x(m.s.pl_VLDL_C);

% pl_VLDL_TG: plasma (V)LDL-TG
y(5) = x(m.s.pl_VLDL_TG);

% hep_TG: hepatic triglycerides
y(6) = x(m.s.hep_TG);

% hep_FC: hepatic free cholesterol
y(7) = x(m.s.hep_FC);

% hep_CE: hepatic cholesteryl ester
y(8) = x(m.s.hep_CE);

% j_TG_hep_DNL: DNL_{hep}
y(9) = j(m.j.j_TG_hep_DNL);

% per_TG: peripheral triglyceride
y(10) = x(m.s.per_TG);

% j_AA_total: protein uptake
y(11) = j(m.j.j_AA_total);