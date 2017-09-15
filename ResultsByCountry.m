% This routine yields a structure "ct" which aggregates outputs such as
% energy production, water use, evaporation and their associated economic
% values. Aggregation is both basin-wide and countrywise.
%
% Inputs are the SDDP output structure "out", and simulation year "y"
%
% Charles Rouge, Aug 2017

function ct = ResultsByCountry(out,y)

%% Local variables
econ = out.econ;
flows = out.flows;
system = out.system;
irrigation = out.irrigation;
J = system.no_of_nodes; % number of nodes
M = size(flows.lateral_inflow,2)/J; % number of simulations
D = irrigation.no_of_sites; % number of demand sites
tb = 1+(y-1)*12; % start date; 12 months in a year
te = tb+12-1; % end date

%% Initialize country_totals structure
ct.name{1} = system.country{1};
nbc = 1; % number of countries
for j = 2:J

    val = 0;
    i = 0;
    while val == 0  && i < nbc
        i = i+1;
        if isequal(ct.name{i},system.country{j})
            val = 1;
        end
    end
    
    if val == 0
        nbc = nbc+1;
        ct.name{nbc} = system.country{j};
    end
end
ct.name = sort(ct.name);
ct.name{nbc+1} = 'Basin-wide';

ct.hydropower_benefits = zeros(nbc+1,M);
ct.hydropower_production = zeros(nbc+1,M);
ct.dem_benefits =  zeros(nbc+1,1);
ct.dem_vol =  zeros(nbc+1,1);
ct.evap_vol = zeros(nbc+1,M);
ct.evap_cost = zeros(nbc+1,M);
ct.water_value = zeros(nbc+1,M);

%% Fill the structure

for j = 1:J
    
    i = 1;
    val = 0;
    while i < nbc+1 && val == 0
        
        if isequal(ct.name{i},system.country{j})
            val = 1;
    
            % Hydropower
            ct.hydropower_production(i,:) = ct.hydropower_production(i,:) + econ.hydropower_production(y+1,j:J:end);
            ct.hydropower_benefits(i,:) =  ct.hydropower_benefits(i,:) + econ.hydropower_benefits(y+1,j:J:end);
    
            % Demand / Irrigation
            for d=1:D
                if irrigation.site_id(d) == system.id(j)
                    ct.dem_benefits(i) = ct.dem_benefits(i) + irrigation.benefits(d);
                    ct.dem_vol(i) = ct.dem_vol(i) + irrigation.demand(d);
                end
            end

            % Evaporation
            if system.is_hydropower_reservoir(j) == 1 % It is a reservoir
                ct.evap_vol(i,:) = ct.evap_vol(i,:) + sum(flows.reservoir_evap(tb+1:te+1,j:J:end));
                ct.evap_cost(i,:) = ct.evap_cost(i,:) + econ.res_evap_opportunity_cost(y+1,j:J:end);  
            end
            
            % Water value
            ct.water_value(i,:) = ct.water_value(i,:) + econ.total_water_value(y+1,j:J:end);
                
        end
        
        i = i+1;
    
    end

end

%% Basin-wide results
ct.hydropower_production(nbc+1,:) = sum(ct.hydropower_production);
ct.hydropower_benefits(nbc+1,:) = sum(ct.hydropower_benefits);
ct.dem_benefits(nbc+1,:) =  sum(ct.dem_benefits);
ct.dem_vol(nbc+1,:) =  sum(ct.dem_vol);
ct.evap_vol(nbc+1,:) = sum(ct.evap_vol);
ct.evap_cost(nbc+1,:) = sum(ct.evap_cost);
ct.water_value(nbc+1,:) = sum(ct.water_value);

