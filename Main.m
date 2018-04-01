% A call to this file produces all the figures in paper "Identifying key 
% water resource vulnerabilities in data-scarce transboundary river basins"
% By C. Rouge, A. Tilmant, B. Zaitchik, A. Dezfuli and M. Salman

%% Which figures do you want to plot (1 plot, 0 otherwise)
fig4 = 1;
fig5 = 1;
fig6 = 1;
fig7 = 1;
fig8 = 1;
fig9 = 1;
fig10 = 1;

%% Load result structures
% baseline run A0
load A0
% same as baseline but without irrigation
if fig4
    load A0_no_irr
end
% scenarios A1 to A3
if fig8 
    load A1
    load A2
    load A3
end
% scenarios B0 to B3
if fig9 
    load B0
    load B1
    load B2
    load B3
end
if fig10
    load histA0
    load histA1
    load histA2
    load histA3
    load histB0
    load histB1
    load histB2
    load histB3
end


%% Figure 4 (two panels)
% Comparison of hydropower outputs (with and without irrigation)
% with nominal (expect) productions
if fig4
    PowerCompare(A0,A0_no_irr);
end


%% Figure 5 (one panel)
% Impacts of infrastructure development on the probability distribution of
% annual flows at the border between Turkey and Syria on the Euphrates.
if fig5
    BorderFlow(5,109,A0,1,500);
end

%% Figure 6 (four panels)
% Average natural and altered annual and monthly flows, and associated \chi
% variability quotients, at the border crossings (A to C in Figure 1). Red
% lines signal  = 1, no change in variability.
if fig6
    plotBorderFlows1(A0);
end

%% Figure 7 (three panels)
% Comparison of outlet flows with outflows from Tharthar Lake.
if fig7
    Outlet_Flow(A0);
end

%% Figure 8 (five panels)
% Euphrates flow indicators at the Turkey-Syria border, and their 
% sensitivity to increased irrigation in Turkey.
if fig8
    plotBorderFlows2(A0,A1,A2,A3);
end

%% Figure 9 (two panels)
% Exceedence probabilities of irrigation demand shortages in the whole 
% Euphrates basin, under scenarios B0 to B3 (no saline water transfers). 
% Panel a), probabilities on a given year; panel b) probabilities 
% conditional on shortage the previous year.
if fig9
    plot_deficits(B0,B1,B2,B3);
end

%% Figure 10 (seven panels)
% Results for the whole Euphrates basin, from re-optimization using the
% cuts (benefits-to-go functions) obtained from running SDDP-YPRE in each
% scenario defined in Table 1, with historical flows 1982-2011. Only 
% 1987-2011 is shown to leave out the warmup period.
if fig10
    % panel (a)
    EuphratesInflows(histA0.flows.lateral_inflow');
    % the other panels
    plot_historical(histA0,histA1,histA2,histA3,histB0,histB1,histB2,...
        histB3)
end


