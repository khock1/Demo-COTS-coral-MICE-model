function [ results ] = COTS_MICE_scenarios( years, scen, variant  )
%COTSPOP Summary of this function goes here

% Full COTS-coral MICE population dynamics model v2
% Implementation of a published MICE model by Morello et al. 2014, MEPS
% Karlo Hock, University of Queensland, v1 2014; v2 201

% Variable and parameter names used in Morello et al. paper are provided in comments;
% in general, fgc stands for fast growing coral, and sgc for slow growing coral.
% This is just a demo of the Matlab implementation; not to be used for scientific or management purposes; 
% refer to the original publication for model definition and details

% Standard setup for testing
if years==0 
    years = 18;
end
if scen==0
    scen=1;
    variant=0;
end

% initalise fixed parameters for the MICE model
p=cots_param;

% some parameters are variable/uncertain as they have been estimated from
% the data; if fixed values are to be used for testing, comment out the line below and
% uncomment the subsequent lines that specify the fields for the structure e
e=cots_estimated_params;

% e=struct();
% e.COTS_NUMINIT=0.505;%COTSinit
% e.COTS_STOCKRECRINIT=4.307;%epsilon per year for year 1996
% e.COTS_IMMIGINIT=4.292;%eta per year for year 1994
% e.COTS_MORTNAT=2.56;%M cots
% e.FGC_EFFECTOFCOTS1=0.129;%p f1
% e.FGC_EFFECTONCOTS=0.258;% p tilde
% e.SGC_EFFECTOFCOTS1=0.268;%p m


% variables----------------------------------------------
cots_num=zeros(years,3);%N per year per age
cots_selfrec=zeros(years,1);%R per year
cots_eatenbypred=zeros(years,3);%Q cots per year per age
cots_mortnat=zeros(1,3);%M per age
fgc_biomass=zeros(years,1);%C f per year
fgc_eatenbycots=zeros(years,1);%Q f per year
sgc_biomass=zeros(years,1);%C m per year
sgc_eatenbycots=zeros(years,1);%Q m per year
inv_biomassavg=0;%B line; assumed constant
lfp_num=zeros(years,1);%P per year
fgc_effcotsmort=zeros(years,1);%f(C f per yeear)
fgc_effpredsurv=zeros(years,1);%g(C f per year)
rho=zeros(years,1);%rho per year

cots_stockrecres=zeros(years,1);
cots_stockrecres(4,1)=e.COTS_STOCKRECRINIT;
cots_immigr=zeros(years,1);
cots_immigr(1,1)=e.COTS_IMMIGINIT;
cots_resid=zeros(years,1);
cots_resid(3, 1)=4.307;
scenario = cots_scen( scen, variant );

cots_num(1,1)=e.COTS_NUMINIT*(exp(2*e.COTS_MORTNAT));
cots_num(1,2)=e.COTS_NUMINIT*(exp(e.COTS_MORTNAT));
cots_num(1,3)=e.COTS_NUMINIT;
fgc_biomass(1)=p.FGC_CARRYCAP;
sgc_biomass(1)=p.SGC_CARRYCAP;

% MICE population dynamics------------------------------------
for yr=2:years
    fgc_effcotsmort(yr-1)=1-(e.FGC_EFFECTONCOTS*fgc_biomass(yr-1)*(1/(1+fgc_biomass(yr-1))));
    fgc_effpredsurv(yr-1)=1-(scenario.lfp_effectoffgc*fgc_biomass(yr-1)*(1/(1+fgc_biomass(yr-1))));
    cots_eatenbypred((yr-1),1)=scenario.inv_mortoncots0*cots_num((yr-1),1)*scenario.inv_biomassavg;
    cots_eatenbypred((yr-1),3)=((p.COTS_SATUR1^p.COTS_SATUR2)/((cots_num((yr-1),3)^p.COTS_SATUR2)+(p.COTS_SATUR1^p.COTS_SATUR2)))*((scenario.cots_largpred1*cots_num((yr-1),3)*lfp_num(yr-1))/(1+exp(-1*cots_num((yr-1),3)*(1/p.COTS_LARGPRED2))));
    rho(yr-1)=(1+exp((-5*fgc_biomass(yr-1)*(1/p.FGC_CARRYCAP))));
    fgc_eatenbycots(yr-1)=(1-rho(yr-1))*((e.FGC_EFFECTOFCOTS1*(cots_num(yr-1,2)+cots_num(yr-1,3))*fgc_biomass(yr-1))/(1+exp(((-1*(cots_num(yr-1,2)+cots_num(yr-1,3)))/p.FGC_EFFECTOFCOTS2))));
    sgc_eatenbycots(yr-1)=rho(yr-1)*((e.SGC_EFFECTOFCOTS1*(cots_num(yr-1,2)+cots_num(yr-1,3))*sgc_biomass(yr-1))/(1+exp(((-1*(cots_num(yr-1,2)+cots_num(yr-1,3)))/p.SGC_EFFECTOFCOTS2))));
    cots_selfrec(yr-1)=4*cots_num(yr-1,3)/(4*(cots_num(yr-1,3)*exp(cots_resid(yr-1))));
    cots_num(yr,1)=cots_selfrec(yr-1)+(p.COTS_BACKGIMMIG*exp(cots_immigr(yr-1)));
    cots_num(yr,2)=(cots_num((yr-1),1)*exp(-1*fgc_effcotsmort(yr-1)*e.COTS_MORTNAT))-cots_eatenbypred((yr-1),1);
    cots_num(yr,3)=(cots_num((yr-1),2)+cots_num((yr-1),3))*exp(-1*fgc_effcotsmort(yr-1)*e.COTS_MORTNAT)-cots_eatenbypred((yr-1),3)-(scenario.cots_manremperc2*((scenario.cots_manremselectivity1*cots_num((yr-1),2))+cots_num((yr-1),3)));
    
    fgc_biomass(yr)=fgc_biomass(yr-1)+(p.FGC_INTRINGROW*fgc_biomass(yr-1)*((1-fgc_biomass(yr-1))/p.FGC_CARRYCAP))-fgc_eatenbycots(yr-1);
    sgc_biomass(yr)=sgc_biomass(yr-1)+(p.SGC_INTRINGROW*sgc_biomass(yr-1)*((1-sgc_biomass(yr-1))/p.SGC_CARRYCAP))-sgc_eatenbycots(yr-1);
    
    if yr<5
        lfp_num(yr)=(lfp_num(yr-1)*fgc_effpredsurv(yr-1)*p.LFP_SURVIV*(1-p.LFP_MORTFISH))+(lfp_num(1)*p.LFP_RECR*fgc_effpredsurv(1)*(p.LFP_SURVIV^p.LFP_AGEMAT));
    else
        lfp_num(yr)=(lfp_num(yr-1)*fgc_effpredsurv(yr-1)*p.LFP_SURVIV*(1-p.LFP_MORTFISH))+(lfp_num(yr-4)*p.LFP_RECR*fgc_effpredsurv(yr-4)*(p.LFP_SURVIV^p.LFP_AGEMAT));
    end

    
end

% return results-----------------------------------------------
results=struct();
results.cots_num=cots_num;
results.fgc_biomass=fgc_biomass;
results.sgc_biomass=sgc_biomass;

end

