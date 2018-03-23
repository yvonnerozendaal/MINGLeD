clear all;close all;clc;

snapshots = {   'LFD_0M'
                'LFD_1M'
                'LFD_2M'
                'LFD_3M'
                'HFD_0M'
                'HFD_1M'
                'HFD_2M'
                'HFD_3M'
                'HFD_025C(nonMetS)_0M'
                'HFD_025C(nonMetS)_1M'
                'HFD_025C(nonMetS)_2M'
                'HFD_025C(nonMetS)_3M'
                'HFD_025C(MetS)_0M'
                'HFD_025C(MetS)_1M'
                'HFD_025C(MetS)_2M'
                'HFD_025C(MetS)_3M'};

%loading result of first snapshot:
load([pwd '\results snapshots\' results_path 'result_' snapshots{1} '.mat']);

%m: structure with all model info
%R: structure with simulation results with N=500 iterations
    %R(i).p_est   estimated parameter vector for i^th iteration
    %R(i).SSE     sum of squared errors (output of cost function)
    %R(i).x(i_x)  simulated value of state i_x
    %R(i).j(i_j)  simulated value of flux i_j
    
%m.info.x{i_x}   information of model state i_x:
%                [abbreviation    full name    unit    formatted abbreviation]
%m.info.j{i_j}   information of model flux i_j
%m.info.p{i_p}   information of model parameter i_p

%m.raw_data     structure with raw data of current snapshot (used for fitting)