% A call to this file produces all the figures in paper "Combining land
% data assimilation and hydro-economic optimization to analyze water
% allocation in politically unstable transboundary river basins"
% By C. Rouge, A. Tilmant, B. Zaitchik, A. Dezfuli and M. Salman

%% Load result structures
load te_res
load te_no_irr

%% Which figures do you want to plot (1 plot, 0 otherwise)
fig5 = 1;
fig6 = 1;
fig7 = 1;
fig8 = 1;
fig9 = 1;
tab1 = 1;

%% Figure 5 (both panels)
% Comparison of hydropower outputs (with and without irrigation)
% with nominal (expect) productions
if fig5
    z = PowerCompare(te_res,te_no_irr);
end

%% Table 1

% Producing last year's data from te_res.mat
tab = ResultsByCountry(te_res,10);
if tab1
    Results_Table
end

%% Figure 6 (panels (a) and (b))
if fig6
   % Distance to outlet
   dist_outlet = Aux_compute_distances('Nodes_with_XYcoord.xlsx', ...
       te_res.system,1.1,60);
   % Water values for the Euphrates (1 is the upstream node)
   WaterValue(te_res,1,10) % with node names
   title('a) Euphrates')
   WaterValue(te_res,1,10,dist_outlet) % with distances
   title('a) Euphrates')
   % Water values for the Tigris (6 is the upstream node)
   WaterValue(te_res,6,10) % with node names
   title('b) Tigris')
   WaterValue(te_res,6,10,dist_outlet) % with distances
   title('b) Tigris')
end

%% Figure 7 (top and bottom panels)
if fig7
    out = ['Annual power production (TWh)'];
    % Top panel, 1-year production
    Distribution_By_Country(tab.hydropower_production/1000,tab.name,out);
    title('1-year production')
    set(gca,'Xlim',[0 70])
    % Bottom panel, 5-year annual average
    hydropower_prod_5y = (tab.hydropower_production)/5;
    for y =6:9
        tab_y = ResultsByCountry(te_res,y);
        hydropower_prod_5y = hydropower_prod_5y + tab_y.hydropower_production/5;
    end
    hydropower_prod_5y = hydropower_prod_5y / 1000; % Convert to TWh
    Distribution_By_Country(hydropower_prod_5y,tab.name,out);
    title('5-year average production')
    set(gca,'Xlim',[0 70])
end

%% Figure 8 (all 9 panels)
if fig8
    % Euphrates, Turkey-Syria border
    BorderFlow(5,109,te_res,1,500);
    % Euphrates, Syria-Iraq border
    BorderFlow(16,109,te_res,1,500*0.58);
    % Tigris, Turkey-Iraq border
    BorderFlow(9,109,te_res,1);
end

%% Figure 9 (panels (a) to (d))
if fig9
   Outlet_Flow(te_res);
end

