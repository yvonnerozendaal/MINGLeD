clear all;close all;clc;

Niter = 1000;
Ndt = 90;
N_lambda = 0.1;

phenotypes = {  'LFD'
                'HFD'
                'HFD_025C(nonMetS)'
                'HFD_025C(MetS)'};

%loading result of first phenotype:
load([pwd '\results ADAPT\' phenotypes{1} '_Niter=' num2str(Niter) '_Ndt=' num2str(Ndt) '_l=' num2str(N_lambda) '.mat']);

%m: structure with all model info
%R: structure with simulation results with N=1,000 iterations
    %R(i).p          estimated parameter trajectory for i^th iteration
    %R(i).SSE       vector of sum of squared errors (output of cost function) for step in time
    %R(i).x(i_x,:)  simulated trajectory of state i_x
    %R(i).j(i_j,:)  simulated trajectory of flux i_j
    %R(i).t         simulated time
    
%m.info.x{i_x}   information of model state i_x:
%                [abbreviation    full name    unit    formatted abbreviation]
%m.info.j{i_j}   information of model flux i_j
%m.info.p{i_p}   information of model parameter i_p

%m.raw_data     structure with raw data
    %R(i).data_sample   structure with sampled data (used for spline calculation)
    %R(i).spline_data   structure with spline data (used for fitting)