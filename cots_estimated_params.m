function [e] = cots_estimated_params()

% Implementation of a published MICE model by Morello et al. 2014, MEPS
% Karlo Hock, University of Queensland, v1 2014; v2 2019

% Estimated parameters for the COTS-coral MICE model from Morello et al. 2014, MEPS

e=struct();
e.COTS_NUMINIT=normrnd(0.505,0.119);%COTSinit
e.COTS_STOCKRECRINIT=normrnd(4.307,0.378);%epsilon per year for year 1996
e.COTS_IMMIGINIT=normrnd(4.307,0.352);%eta per year for year 1994
e.COTS_MORTNAT=normrnd(2.56,0.146);%M cots
e.FGC_EFFECTOFCOTS1=normrnd(0.129,0.041);%p f1
e.FGC_EFFECTONCOTS=normrnd(0.258,0.167);% p tilde
e.SGC_EFFECTOFCOTS1=normrnd(0.268,0.106);%p m

% zero the negative values to avoid weirdness
if e.COTS_NUMINIT<0 e.COTS_NUMINIT=0;end
if e.COTS_STOCKRECRINIT<0 e.COTS_STOCKRECRINIT=0;end
if e.COTS_IMMIGINIT<0 e.COTS_IMMIGINIT=0;end
if e.COTS_MORTNAT<0 e.COTS_MORTNAT=0;end
if e.FGC_EFFECTOFCOTS1<0 e.FGC_EFFECTOFCOTS1=0;end
if e.FGC_EFFECTONCOTS<0 e.FGC_EFFECTONCOTS=0;end
if e.SGC_EFFECTOFCOTS1<0 e.SGC_EFFECTOFCOTS1=0;end

end

