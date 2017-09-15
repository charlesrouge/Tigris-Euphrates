% Builds Table of annual average results by country
%
% Charles Rouge, Aug 2017

disp('Order of the columns')
disp(   tab.name)

% hydropower
ResTable.hydropower_production_TWh = mean(tab.hydropower_production/1000,2)';
ResTable.hydropower_benefits_MUSD = mean(tab.hydropower_benefits/1E6,2)';

% irrigation
ResTable.irrigation_withdrawals_km3 = tab.dem_vol'/1000;
ResTable.irrigation_benefits_MUSD = tab.dem_benefits'/1E6;

% water value
ResTable.euphrates_value_of_runoff_MUSD = zeros(1,5);
ResTable.tigris_value_of_runoff_MUSD = zeros(1,5);
ResTable.total_value_of_runoff_MUSD = mean(tab.water_value/1E6,2)';
[tur,syr] = Euphrates_Water_Value(te_res.econ.total_water_value,te_res.system.no_of_nodes);
ResTable.euphrates_value_of_runoff_MUSD = [0 0 syr tur syr+tur]/1E6;
ResTable.total_value_of_runoff_MUSD(3) = ResTable.total_value_of_runoff_MUSD(3) + syr/1E6;
ResTable.total_value_of_runoff_MUSD(4) = ResTable.total_value_of_runoff_MUSD(4) - syr/1E6;
ResTable.tigris_value_of_runoff_MUSD = ResTable.total_value_of_runoff_MUSD - ResTable.euphrates_value_of_runoff_MUSD;

% evaporation
ResTable.evaporation_volume_km3 = mean(tab.evap_vol/1E3,2)';
ResTable.evaporation_opportunity_cost_MUSD = mean(tab.evap_cost/1E6,2)';

ResTable


