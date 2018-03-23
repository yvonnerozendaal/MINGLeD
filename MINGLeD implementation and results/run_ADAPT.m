clear all;close all;clc;

%% user defined options
m.study = 'Cdiets';
    diets = {'LFD' 'HFD' 'HFD_025C'};
    timepoints = 0:3;
    subgroups = {{} {} {'nonMetS' 'MetS'}};
                        %nonMetS refers to the non-dyslipidemic MetS subgroup
                        %MetS refers to the dyslipidemic MetS subgroup

m.sim_type = 'time'; use_ADAPT = 1; use_classical = 0;

m.data_type = 'avg';

m.Niter = 1000; %number of data samples
m.Ndt = 90;     %number of time samples
m.t_max = 90;

m.info.lambda_r = 0.1;

m.do_not_sample = {'V_pl' 'dietary_G.m' 'dietary_C.m' 'dietary_TG.m' 'dietary_AA_estimation.m'};

m.filename_prefix = '';

tic

%% standard functions to be executed
m.phenotypes = {'LFD'
                'HFD'
                'HFD_025C(nonMetS)'
                'HFD_025C(MetS)'};
m.modelname = 'MINGLeD';
m.info.costfile = @costfunc_MINGLeD_edited;

addpath(genpath(pwd))
addpath(genpath('..\ADAPT_library\'))

%% run optimizations using ADAPT
m.datafile = @load_data_Cdiets_time_avg;
for i_ph = 1:length(m.phenotypes)
    m.phenotype = m.phenotypes{i_ph};
    perform_ADAPT(m)
end

%%
t=toc;
fprintf('%14s %.1f min\n%14s %.1f h\n',...
        'Elapsed time: ',t/60,'= ',t/(60*60));
msgbox(sprintf('ADAPT optimization (%s) finished in\n%.1f min\n= %.1f h\n',...
        m.filename_prefix,t/60,t/(60*60)));