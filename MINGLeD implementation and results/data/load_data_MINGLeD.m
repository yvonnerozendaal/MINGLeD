function d = load_data_MINGLeD(d_sel,diet)

    %% plasma volume
    if isfield(d_sel,'BW')
        % plasma_volume = 1.4872 + 0.0226 * BW [Yen, Stienmetz, Simpson, 1970]
        fn = 'V_pl';
        d.(fn).name = 'plasma volume';
        d.(fn).unit = 'mL';
        d.(fn).t    = d_sel.BW.t;
        d.(fn).d    = 0.7704 + 0.0117 * d_sel.BW.d;
        d.(fn).m    = 0.7704 + 0.0117 * d_sel.BW.mn;
        if isfield(d_sel.BW,'sd')
            d.(fn).sd   = 0.7704 + 0.0117 * d_sel.BW.sd;
        end
    else
        disp('ERROR! No BW data parsed')
    end
    
    if isfield(d_sel,'fat_mass')
        mm_TG = 853; %molar mass of TG
        
        fn = 'fat_mass_umol';
        d.(fn).name = 'fat mass';
        d.(fn).unit = '\mumol';
        d.(fn).t    = d_sel.fat_mass.t;
        d.(fn).d    = (d_sel.fat_mass.d / mm_TG) *1e6;
        d.(fn).m    = nanmean(d.(fn).d);
        if isfield(d_sel.fat_mass,'sd')
            d.(fn).sd = nanstd(d.(fn).d);
        end
    end
    
    %% plasma data
    if isfield(d_sel,'pl_G')
        fn1 = 'pl_G';
        d.(fn1) = d_sel.(fn1);
        d.(fn1).m = d.(fn1).mn; d.(fn1) = rmfield(d.(fn1),'mn');
        
        fn2 = [fn1 '_umol'];
        d.(fn2).name = fn2;
        d.(fn2).unit = '\mumol'; 
        d.(fn2).t  = d.(fn1).t;
        
        t_sel = [];
        for i_t = 1:length(d.(fn2).t)
            [~,j_t] = find(d_sel.BW.t(1,:) == d.(fn2).t(i_t));
            t_sel = [t_sel; j_t];
        end
        
        d.(fn2).d = d.(fn1).d .* d.V_pl.d(:,t_sel);
        d.(fn2).m = d.(fn1).m .* d.V_pl.m(:,t_sel); %mM = mmol/L = umol/mL * mL >> umol
        if isfield(d.(fn1),'sd')
            d.(fn2).sd = d.(fn1).sd .* d.V_pl.m(:,t_sel);
        end
    end
    
    if isfield(d_sel,'pl_TG')
        fn1 = 'pl_TG';
        d.(fn1) = d_sel.(fn1);
        d.(fn1).m = d.(fn1).mn; d.(fn1) = rmfield(d.(fn1),'mn');
        
        fn2 = [fn1 '_umol'];
        d.(fn2).name = fn2;
        d.(fn2).unit = '\mumol'; 
        d.(fn2).t  = d.(fn1).t;
        
        t_sel = [];
        for i_t = 1:length(d.(fn2).t)
            [~,j_t] = find(d_sel.BW.t(1,:) == d.(fn2).t(i_t));
            t_sel = [t_sel; j_t];
        end
        
        d.(fn2).d = d.(fn1).d .* d.V_pl.d(:,t_sel);
        d.(fn2).m = d.(fn1).m .* d.V_pl.m(:,t_sel); %mM = mmol/L = umol/mL * mL >> umol
        if isfield(d.(fn1),'sd')
            d.(fn2).sd = d.(fn1).sd .* d.V_pl.m(:,t_sel);
        end
    end
    
    if isfield(d_sel,'pl_FFA')
        fn1 = 'pl_FFA';
        d.(fn1) = d_sel.(fn1);
        d.(fn1).m = d.(fn1).mn; d.(fn1) = rmfield(d.(fn1),'mn');
        
        fn2 = [fn1 '_umol'];
        d.(fn2).name = fn2;
        d.(fn2).unit = '\mumol'; 
        d.(fn2).t  = d.(fn1).t;
        
        t_sel = [];
        for i_t = 1:length(d.(fn2).t)
            [~,j_t] = find(d_sel.BW.t(1,:) == d.(fn2).t(i_t));
            t_sel = [t_sel; j_t];
        end
        
        d.(fn2).d = d.(fn1).d .* d.V_pl.d(:,t_sel);
        d.(fn2).m = d.(fn1).m .* d.V_pl.m(:,t_sel); %mM = mmol/L = umol/mL * mL >> umol
        if isfield(d.(fn1),'sd')
            d.(fn2).sd = d.(fn1).sd .* d.V_pl.m(:,t_sel);
        end
    end
    
    if isfield(d_sel,'pl_HDLC')    
        fn1 = 'pl_HDLC';
        d.(fn1) = d_sel.(fn1);
        d.(fn1).m = d.(fn1).mn; d.(fn1) = rmfield(d.(fn1),'mn');
        
        fn2 = [fn1 '_umol'];
        d.(fn2).name = fn2;
        d.(fn2).unit = '\mumol'; 
        d.(fn2).t  = d.(fn1).t;
        
        t_sel = [];
        for i_t = 1:length(d.(fn2).t)
            [~,j_t] = find(d_sel.BW.t(1,:) == d.(fn2).t(i_t));
            t_sel = [t_sel; j_t];
        end
        
        d.(fn2).d = d.(fn1).d .* d.V_pl.d(:,t_sel);
        d.(fn2).m = d.(fn1).m .* d.V_pl.m(:,t_sel); %mM = mmol/L = umol/mL * mL >> umol
        if isfield(d.(fn1),'sd')
            d.(fn2).sd = d.(fn1).sd .* d.V_pl.m(:,t_sel);
        end
    end
    
    if isfield(d_sel,'pl_TC') && isfield(d_sel,'pl_HDLC')
        fn1 = 'pl_TC_min_pl_HDLC';
        d.(fn1).t = d_sel.pl_TC.t(1,:);
        d.(fn1).t_unit = d_sel.pl_TC.t_unit;
        d.(fn1).unit = d_sel.pl_TC.unit;
        d.(fn1).d = d_sel.pl_TC.d - d_sel.pl_HDLC.d;
        d.(fn1).m = nanmean(d.(fn1).d);
        d.(fn1).sd = nanstd(d.(fn1).d);
        
        fn2 = [fn1 '_umol'];
        d.(fn2).name = fn2;
        d.(fn2).unit = '\mumol'; 
        d.(fn2).t  = d.(fn1).t;
        
        t_sel = [];
        for i_t = 1:length(d.(fn2).t)
            [~,j_t] = find(d_sel.BW.t(1,:) == d.(fn2).t(i_t));
            t_sel = [t_sel; j_t];
        end
        
        d.(fn2).d = d.(fn1).d .* d.V_pl.d(:,t_sel);
        d.(fn2).m = d.(fn1).m .* d.V_pl.m(:,t_sel); %mM = mmol/L = umol/mL * mL >> umol
        if isfield(d.(fn1),'sd')
            d.(fn2).sd = d.(fn1).sd .* d.V_pl.m(:,t_sel);
        end
    end
    
    if isfield(d_sel,'pl_TC')
        fn = 'pl_TC';
        d.(fn).name = fn;
        d.(fn).unit = d_sel.(fn).unit; 
        d.(fn).t  = d_sel.(fn).t(1,:);
        d.(fn).d  = d_sel.(fn).d;
        d.(fn).m  = d_sel.(fn).mn;
        if isfield(d_sel.(fn),'sd')
            d.(fn).sd = d_sel.(fn).sd;
        end
    end
    
    if isfield(d,'pl_TC_min_pl_HDLC') && isfield(d,'pl_HDLC')
        fn = 'pl_VLDL_C_HDL_C_ratio';
        d.(fn).name = fn;
        d.(fn).unit = '-'; 
        d.(fn).t  = d.pl_HDLC.t;
        d.(fn).d  = d.pl_TC_min_pl_HDLC.d ./ d.pl_HDLC.d;
        d.(fn).m  = nanmean(d.(fn).d);
        d.(fn).sd = nanstd(d.(fn).d);
    end
    
    %% liver data
    if isfield(d_sel,'hep_TG')
        fn = 'hep_TG';
        d.(fn).name = fn;
        d.(fn).unit = d_sel.(fn).unit; 
        d.(fn).t  = d_sel.(fn).t(1,:);
        d.(fn).d  = d_sel.(fn).d;
        d.(fn).m  = d_sel.(fn).mn;
        if isfield(d_sel.(fn),'sd')
            d.(fn).sd = d_sel.(fn).sd;
        end
    end
    
    if isfield(d_sel,'hep_FC')
        fn = 'hep_FC';
        d.(fn).name = fn;
        d.(fn).unit = d_sel.(fn).unit; 
        d.(fn).t  = d_sel.(fn).t(1,:);
        d.(fn).d  = d_sel.(fn).d;
        d.(fn).m  = d_sel.(fn).mn;
        if isfield(d_sel.(fn),'sd')
            d.(fn).sd = d_sel.(fn).sd;
        end
    end
    
    if isfield(d_sel,'hep_TC') && isfield(d_sel,'hep_FC')
        fn = 'hep_TC_min_hep_FC';
        d.(fn).name = fn;
        d.(fn).unit = d_sel.hep_TC.unit; 
        d.(fn).t  = d_sel.hep_TC.t(1,:);
        d.(fn).d  = d_sel.hep_TC.d - d_sel.hep_FC.d;
        d.(fn).m  = d_sel.hep_TC.mn - d_sel.hep_FC.mn;
        if isfield(d_sel.hep_TC,'sd')
            d.(fn).sd = d_sel.hep_TC.sd - d_sel.hep_FC.sd;
        end
    end   
        
    %% DNL calculation
    if isfield(d_sel,'DNL_C16_0')        
        d_hep_DNL = d_sel.DNL_C16_0.d + ...
                    d_sel.DNL_C18_0.d + ...
                    d_sel.DNL_C18_1.d + ...
                    (1/9)*d_sel.CE_C18_0.d + ...
                    (1/9)*d_sel.CE_C18_1.d; %[umol / gram liver]
        
        fn = 'hep_DNL';
        d.(fn).name = fn;
            d.(fn).unit = '\mumol / ?';
            d.(fn).t  = d_sel.DNL_C16_0.t(1,:);
            d.(fn).m  = nanmean(d_hep_DNL .* d_sel.liver_weight.d);
            d.(fn).sd = nanstd(d_hep_DNL .* d_sel.liver_weight.d);
    end
    
    %% food intake
    if isfield(d_sel,'FI')
        switch diet     % gram percentage of macronutrients in different diets
            case 'LFD'
                f_G  = 0.67;
                f_TG = 0.04;
                f_C  = 0;
                f_AA = 0.19;
                
                kcal_diet = 3.8; %kcal / g diet
                kcal_G    = 0.70; %kcal percentage
                kcal_TG   = 0.10;
                kcal_C    = 0;
                kcal_AA   = 0.20;
            case 'HFD'
                f_G  = 0.26;
                f_TG = 0.35;
                f_C  = 0;
                f_AA = 0.26;
                
                kcal_diet = 5.2; %kcal / g diet
                kcal_G    = 0.20; %kcal percentage
                kcal_TG   = 0.60;
                kcal_C    = 0;
                kcal_AA   = 0.20;             
            case 'HFD_025C' 
                f_G  = 0.26;
                f_TG = 0.35;
                f_C  = 0.025;
                f_AA = 0.26;
                
                kcal_diet = 5.2; %kcal / g diet
                kcal_G    = 0.20; %kcal percentage
                kcal_TG   = 0.60;
                kcal_C    = 0;
                kcal_AA   = 0.20;
            case 'HFD_04C'
                f_G  = 0.26;
                f_TG = 0.35;
                f_C  = 0.04;
                f_AA = 0.26;
                
                kcal_diet = 5.2; %kcal / g diet
                kcal_G    = 0.20; %kcal percentage
                kcal_TG   = 0.60;
                kcal_C    = 0;
                kcal_AA   = 0.20;
            case 'HFD_1C'
                f_G  = 0.26;
                f_TG = 0.35;
                f_C  = 0.1;
                f_AA = 0.26;
                
                kcal_diet = 5.2; %kcal / g diet
                kcal_G    = 0.20; %kcal percentage
                kcal_TG   = 0.60;
                kcal_C    = 0;
                kcal_AA   = 0.20;
        end

        % molecular mass [u]
        mm_G  = 180;
        mm_TG = 853;
        mm_C  = 387;

        % daily intake of macronutrients [mol / day]
        intake_G  = (f_G * d_sel.FI.d)/mm_G;
        intake_TG = (f_TG * d_sel.FI.d)/mm_TG;
        intake_C  = (f_C * d_sel.FI.d)/mm_C;

        fn = 'dietary_G';
        d.(fn).name = fn;
        d.(fn).unit = '\mumol / day';
        d.(fn).t  = d_sel.FI.t(1,:);
        d.(fn).d  = intake_G*1e6;
        d.(fn).m  = nanmean(intake_G)*1e6;
        if isfield(d_sel.BW,'sd')
            d.(fn).sd = nanstd(intake_G)*1e6;
        end
        
        fn = 'dietary_TG';
        d.(fn).name = fn;
        d.(fn).unit = '\mumol / day';
        d.(fn).t  = d_sel.FI.t(1,:);
        d.(fn).d  = intake_TG*1e6;
        d.(fn).m  = nanmean(intake_TG)*1e6;
        if isfield(d_sel.BW,'sd')
            d.(fn).sd = nanstd(intake_TG)*1e6;
        end

        fn = 'dietary_C';
        d.(fn).name = fn;
        d.(fn).unit = '\mumol / day';
        d.(fn).t  = d_sel.FI.t(1,:);
        d.(fn).d  = intake_C*1e6;
        d.(fn).m  = nanmean(intake_C)*1e6;
        if isfield(d_sel.BW,'sd')
            d.(fn).sd = nanstd(intake_C)*1e6;
        end
        
        fn = 'dietary_AA_estimation';
        d.(fn).name = fn;
        d.(fn).unit = '\mumol gluc eq./day';
        d.(fn).t  = d_sel.FI.t(1,:);
        % derivation:
%         daily_energy_intake = d_sel.FI.d * kcal_diet; %[kcal/day]
%         daily_energy_intake_from_AA = daily_energy_intake * kcal_AA; %20 percent is from protein
        g_glucose_kcal = 4.18;
%         daily_AA_intake_g = daily_energy_intake_from_AA /g_glucose_kcal; %in terms of glucose equivalents [g]
%         daily_AA_intake_mol = daily_AA_intake_g/mm_G; %in terms of glucose equivalents [mol]
%         daily_AA_intake_umol = daily_AA_intake_mol * 1e6 %in terms of glucose equivalents [umol]
        d.(fn).d  = (((kcal_AA * d_sel.FI.d * kcal_diet)/g_glucose_kcal)/mm_G) *1e6;
        d.(fn).m  = nanmean(d.(fn).d);
        if isfield(d_sel.BW,'sd')
            d.(fn).sd = nanstd(d.(fn).d);
            if length(d.(fn).sd)==1
                if d.(fn).sd==0 && strcmp(diet,'HFD_025C')
                    d.(fn).sd = 25;
                end
            else
                if strcmp(diet,'HFD_025C') && d.(fn).sd(1)==0
                    d.(fn).sd(1) = d.(fn).sd(2);
                end
            end
        end
       
        
    else
        disp('ERROR!! no food intake parsed to data')
    end
    
    %% -- use steady state simulation rather than absolute time in the data
    data_names = fieldnames(d);
    for i_fn = 1:length(data_names)
        fn = char(data_names(i_fn));
    end