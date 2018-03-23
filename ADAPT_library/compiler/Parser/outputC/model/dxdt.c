#include "../dxdt.h"



int rhs( realtype t, N_Vector y, N_Vector ydot, void *f_data ) {

	struct mData *data = ( struct mData * ) f_data;

	realtype dxdt , j_AA_hep_glc , j_AA_hep_ket , j_AA_per_glc , j_AA_per_ket , j_AA_to_hep , j_AA_to_per , j_AA_total , j_ACAT , j_ACoA_hep_resp , j_ACoA_per_resp , j_BA_bil_excr , j_BA_fec_excr , j_BA_recycl , j_BA_synt , j_CEH , j_CETP , j_CM_C_remn_upt , j_CM_TG_remn_upt_hep , j_CM_TG_remn_upt_per , j_C_bil_excr , j_C_fec_excr , j_C_hep_biosynt , j_C_per_biosynt , j_FA_hep_upt , j_G_hep_GNG , j_G_hep_glycolysis , j_G_hep_upt , j_G_per_glycolysis , j_G_per_upt , j_HDL_C_form , j_HDL_C_remn_upt , j_TG_hep_DNL , j_TG_hep_betaox , j_TG_per_DNL , j_TG_per_betaox , j_TG_per_lipolysis , j_TICE , j_VLDL_C_form , j_VLDL_C_hep_upt_remn , j_VLDL_C_upt_per , j_VLDL_TG_form , j_VLDL_TG_upt , j_diet_AA , j_diet_C , j_diet_G , j_diet_TG , y_pl_FFA , y_pl_G , y_pl_HDL_C , y_pl_TC , y_pl_VLDL_C , y_pl_VLDL_C_HDL_C_ratio , y_pl_VLDL_TG ;

	realtype *stateVars;
	realtype *ydots;

	stateVars = NV_DATA_S(y);
	ydots = NV_DATA_S(ydot);

	
	j_diet_G =12590.4167;
	j_diet_TG =158.6166;
	j_diet_C =0;
	j_diet_AA =3416.6667;
	j_CM_TG_remn_upt_hep =data->p[0]*stateVars[15];
	j_CM_TG_remn_upt_per =data->p[1]*stateVars[15];
	j_CM_C_remn_upt =data->p[2]*stateVars[16];
	j_AA_to_hep =data->p[3]*j_diet_AA;
	j_AA_to_per =data->p[4]*j_diet_AA;
	j_AA_hep_glc =0.5*j_AA_to_hep;
	j_AA_per_glc =0.5*j_AA_to_per;
	j_AA_hep_ket =0.5*j_AA_to_hep;
	j_AA_per_ket =0.5*j_AA_to_per;
	j_G_hep_upt =data->p[5]*stateVars[0];
	j_G_per_upt =data->p[6]*stateVars[0];
	j_G_hep_glycolysis =data->p[7]*stateVars[8];
	j_G_hep_GNG =data->p[8]*stateVars[8];
	j_G_per_glycolysis =data->p[9]*stateVars[13];
	j_VLDL_TG_upt =data->p[10]*stateVars[4];
	j_VLDL_C_upt_per =data->p[11]*stateVars[3];
	j_VLDL_C_hep_upt_remn =data->p[12]*stateVars[3];
	j_VLDL_TG_form =data->p[13]*stateVars[5];
	j_VLDL_C_form =data->p[14]*stateVars[7];
	j_HDL_C_form =data->p[15]*stateVars[12];
	j_HDL_C_remn_upt =data->p[16]*stateVars[2];
	j_TICE =data->p[17]*stateVars[3];
	j_CETP =data->p[18]*stateVars[4];
	j_FA_hep_upt =data->p[19]*stateVars[1];
	j_TG_hep_betaox =data->p[20]*stateVars[5];
	j_C_hep_biosynt =data->p[21]*stateVars[9];
	j_TG_hep_DNL =data->p[22]*stateVars[9];
	j_TG_per_lipolysis =data->p[23]*stateVars[11];
	j_TG_per_betaox =data->p[24]*stateVars[11];
	j_C_per_biosynt =data->p[25]*stateVars[14];
	j_TG_per_DNL =data->p[26]*stateVars[14];
	j_ACAT =data->p[27]*stateVars[6];
	j_CEH =data->p[28]*stateVars[7];
	j_BA_synt =data->p[29]*stateVars[6];
	j_BA_bil_excr =data->p[30]*stateVars[10];
	j_BA_recycl =data->p[31]*stateVars[17];
	j_C_bil_excr =data->p[32]*stateVars[6];
	j_C_fec_excr =data->p[33]*stateVars[16];
	j_BA_fec_excr =data->p[34]*stateVars[17];
	j_ACoA_hep_resp =data->p[35]*stateVars[9];
	j_ACoA_per_resp =data->p[36]*stateVars[14];
	j_AA_total =j_AA_to_hep+j_AA_to_per;
	y_pl_G =stateVars[0]/1.0825;
	y_pl_FFA =stateVars[1]/1.0825;
	y_pl_HDL_C =stateVars[2]/1.0825;
	y_pl_VLDL_C =stateVars[3]/1.0825;
	y_pl_VLDL_TG =stateVars[4]/1.0825;
	y_pl_VLDL_C_HDL_C_ratio =stateVars[3]/stateVars[2];
	y_pl_TC =stateVars[3]+stateVars[2];
	
	
	/* [ODE] pl_G: plasma glucose*/
	ydots[0] =j_diet_G -j_G_hep_upt -j_G_per_upt +j_G_hep_GNG;
	
	/* [ODE] pl_FFA: plasma free fatty acids*/
	ydots[1] =3*j_TG_per_lipolysis -j_FA_hep_upt;
	
	/* [ODE] pl_HDL_C: plasma HDL-C*/
	ydots[2] =j_HDL_C_form -j_CETP -j_HDL_C_remn_upt;
	
	/* [ODE] pl_VLDL_C: plasma (V)LDL-C*/
	ydots[3] =j_VLDL_C_form -j_VLDL_C_hep_upt_remn -j_VLDL_C_upt_per -j_TICE +j_CETP;
	
	/* [ODE] pl_VLDL_TG: plasma (V)LDL-TG*/
	ydots[4] =j_VLDL_TG_form -j_VLDL_TG_upt;
	
	/* [ODE] hep_TG: hepatic triglycerides*/
	ydots[5] =j_CM_TG_remn_upt_hep +j_FA_hep_upt/3 +j_VLDL_TG_upt +j_TG_hep_DNL/21.4 -j_TG_hep_betaox -j_VLDL_TG_form;
	
	/* [ODE] hep_FC: hepatic free cholesterol*/
	ydots[6] =j_CM_C_remn_upt +j_C_hep_biosynt/13.5 +j_CEH -j_ACAT -j_BA_synt -j_C_bil_excr;
	
	/* [ODE] hep_CE: hepatic cholesteryl ester*/
	ydots[7] =j_VLDL_C_hep_upt_remn +j_HDL_C_remn_upt +j_ACAT -j_VLDL_C_form -j_CEH;
	
	/* [ODE] hep_G6P: hepatic glucose-6-phosphate*/
	ydots[8] =j_G_hep_upt +j_AA_hep_glc -j_G_hep_glycolysis -j_G_hep_GNG;
	
	/* [ODE] hep_ACoA: hepatic Acetyl CoA*/
	ydots[9] =j_AA_hep_ket +2*j_G_hep_glycolysis +21.4*j_TG_hep_betaox -j_TG_hep_DNL -j_C_hep_biosynt -j_ACoA_hep_resp;
	
	/* [ODE] hep_BA: hepatic bile acids*/
	ydots[10] =j_BA_synt -j_BA_bil_excr +j_BA_recycl;
	
	/* [ODE] per_TG: peripheral triglyceride*/
	ydots[11] =j_CM_TG_remn_upt_per -j_TG_per_lipolysis +j_VLDL_TG_upt +j_TG_per_DNL/21.4 -j_TG_per_betaox;
	
	/* [ODE] per_C: peripheral cholesterol*/
	ydots[12] =j_VLDL_C_upt_per +j_C_per_biosynt/13.5 -j_HDL_C_form;
	
	/* [ODE] per_G6P: peripheral glucose-6-phosphate*/
	ydots[13] =j_G_per_upt +j_AA_per_glc -j_G_per_glycolysis;
	
	/* [ODE] per_ACoA: peripheral Acetyl CoA*/
	ydots[14] =j_AA_per_ket +2*j_G_per_glycolysis +21.4*j_TG_per_betaox -j_TG_per_DNL -j_C_per_biosynt -j_ACoA_per_resp;
	
	/* [ODE] int_TG: intestinal triglycerides*/
	ydots[15] =j_diet_TG -j_CM_TG_remn_upt_hep -j_CM_TG_remn_upt_per;
	
	/* [ODE] int_C: intestinal cholesterol*/
	ydots[16] =j_diet_C +j_C_bil_excr +j_TICE -j_CM_C_remn_upt -j_C_fec_excr;
	
	/* [ODE] int_BA: intestinal bile acids*/
	ydots[17] =j_BA_bil_excr -j_BA_fec_excr -j_BA_recycl;
	
	


	#ifdef NON_NEGATIVE
		return 0;
	#else
		return 0;
	#endif

};

