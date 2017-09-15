% Auxiliary routine
% Vector pos tells which is the position of topo(i) in the id vector
%
% Charles Rougé - Sept 2014

function pos = Aux_ConvertTopo(id,topo)

pos = zeros(size(topo));

for i = 1:length(topo)
    [m,pos(i)] =  max((id == topo(i)));
    if m == 0 % Water exits the system
        pos(i) = 0;
    end
end
