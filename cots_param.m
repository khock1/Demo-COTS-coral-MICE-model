classdef cots_param

% Implementation of a published MICE model by Morello et al. 2014, MEPS
% Karlo Hock, University of Queensland, v1 2014; v2 2019

% Fixed parameters for the COTS-coral MICE model from Morello et al. 2014, MEPS
    
    properties (Constant = true)
       
        COTS_BACKGIMMIG=1;%I
        COTS_STOCKRECRSTEEP=1;%h
        COTS_UNFISHEDREC=1;%R 0
        COTS_CARRYCAP=0;%K cots
        COTS_LARGPRED1=0;%p 1
        COTS_LARGPRED2=50;%p 2
        COTS_SATUR1=0.5;%N c
        COTS_SATUR2=5;%mu
        COTS_MORTFIT=2.56;%omega
        COTS_MORTDIFF=0.2%lambda, can have other values
        
        FGC_BIOMASSINIT=2500;%C f
        FGC_INTRINGROW=0.5;%r f
        FGC_CARRYCAP=2500;%K f
        FGC_EFFECTOFCOTS2=10;%p f2
        
        SGC_BIOMASSINIT=500;%C m
        SGC_INTRINGROW=0.1;%r f
        SGC_CARRYCAP=500;%K f
        SGC_EFFECTOFCOTS2=8;%p f2
        
        INV_MORTONCOTS0=0;%F I
        INV_BIOMASSAVG=0;%B line
        
        LFP_NUMINIT=10;%P init
        LFP_SURVIV=0.8%S P
        LFP_AGEMAT=4;%T P
        LFP_RECR=0.3905;%R P
        LFP_EFFECTOFFGC=0;%p tilde tilde
        LFP_MORTFISH=0;%F P
        
        COTS_MANREMSELECTIVITY1=0;%Fi cots 1
        COTS_MANREMPERC2=0;%H cots per year
        
    end

    
end

