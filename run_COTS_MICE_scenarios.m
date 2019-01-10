% Implementation of a published MICE model by Morello et al. 2014, MEPS
% Karlo Hock, University of Queensland, v1 2014; v2 2019

% This is just a demo of the Matlab implementation; not to be used for scientific or management purposes; 
% refer to the original publication for model definition and details

% give some example values; see cots_scen file for details on different
% scenarios for COTS predators and COTS removal
years = 18;
scenario = 1;
variant = 0;

% run COTS-coral MICE model withfor the specified scenario;
% results returns COTS abduances, and coral cover for fast- and slow-growing corals
[ results ] = COTS_MICE_scenarios( years, scenario, variant );

% plot adult COTS abundance
figure;
plot(1:years,results.cots_num(:,3));
title('Adult COTS abundance', 'FontSize', 11);
xlabel('Years');
ylabel('COTS per tow');