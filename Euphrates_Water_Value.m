% Value of runoff for the Euphrates is concentrated in Turkey and in the
% Khabur basin (split between Turkey and Syria). The model has the Khabur
% lateral inflows in the Turkish part only for simplicity, but this routine
% shares the associated value of runoff equally between the two countries.
%
% Second argument is the number of nodes in the network
%
% Charles Rouge, Aug 2017

function [tur,syr] = Euphrates_Water_Value(water_value,J)

tur = 0;

% Main branch of the Euphrates, value of runoff from Turkey
for i = 1:5
    tur = tur + mean(water_value(11,i:J:end));
end

% Kabur basin (inflow at node 15)
tur = tur + 0.5*mean(water_value(11,15:J:end));
syr = 0.5*mean(water_value(11,15:J:end));