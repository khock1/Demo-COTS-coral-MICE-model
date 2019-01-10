function [ scenario ] = cots_scen( scen, variant )

% Implementation of a published MICE model by Morello et al. 2014, MEPS
% Karlo Hock, University of Queensland, v1 2014; v2 2019

% Exploring some COTS predation and COTS control scenarios for COTS-coral MICE models

p=cots_param;
scenario=struct();
switch scen
    case 1%explore scenarios with varying impacts of fish predators on COTS
        scenario.inv_biomassavg=p.INV_BIOMASSAVG;%B line
        scenario.inv_mortoncots0=p.INV_MORTONCOTS0;
        scenario.cots_manremselectivity1=p.COTS_MANREMSELECTIVITY1;
        scenario.cots_manremperc2=p.COTS_MANREMPERC2;
        switch variant
            case 0
                scenario.lfp_effectoffgc=p.LFP_EFFECTOFFGC;%p tilde tilde
                scenario.cots_largpred1=p.COTS_LARGPRED1;%p 1
            case 1
                scenario.lfp_effectoffgc=0.2;%p tilde tilde
                scenario.cots_largpred1=0.01;%p 1 cots
            case 2
                scenario.lfp_effectoffgc=0.3;%p tilde tilde
                scenario.cots_largpred1=0.03;%p 1 cots
        end
    case 2%explore scenarios with varying impacts effects of invertebrate predators on COTS juveniles
        scenario.inv_biomassavg=1;%B line
        scenario.lfp_effectoffgc=p.LFP_EFFECTOFFGC;
        scenario.cots_largpred1=p.COTS_LARGPRED1;
        scenario.cots_manremselectivity1=p.COTS_MANREMSELECTIVITY1;%Fi cots 1
        scenario.cots_manremperc2=p.COTS_MANREMPERC2;%H cots per year
        switch variant
            case 0
                scenario.inv_mortoncots0=p.INV_MORTONCOTS0;%F I
            case 1
                scenario.inv_mortoncots0=0.025;%F I
            case 2
                scenario.inv_mortoncots0=0.05;%F I
            case 3
                scenario.inv_mortoncots0=0.075;%F I
            case 4
                scenario.inv_mortoncots0=0.1;%F I
            case 5
                scenario.inv_mortoncots0=0.15;%F I
        end
    case 3%explore scenarios with varying effectivenesss of control program removal on COTS adults
        scenario.inv_biomassavg=p.INV_BIOMASSAVG;%B line
        scenario.inv_mortoncots0=p.INV_MORTONCOTS0;%F I
        scenario.lfp_effectoffgc=p.LFP_EFFECTOFFGC;%p tilde tilde
        scenario.cots_largpred1=p.COTS_LARGPRED1;%p 1
        switch variant
            case 0
                 scenario.cots_manremselectivity1=p.COTS_MANREMSELECTIVITY1;%Fi cots 1
                 scenario.cots_manremperc2=p.COTS_MANREMPERC2;%H cots per year
            case 1
                scenario.cots_manremselectivity1=0.1;%fi cots 1
                scenario.cots_manremperc2=0.1;%H cots per year
            case 2
                scenario.cots_manremselectivity1=0.5;%fi cots 1
                scenario.cots_manremperc2=0.9;%H cots per year
        end
        
end


