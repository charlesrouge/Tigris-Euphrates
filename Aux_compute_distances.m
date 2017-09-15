% Computes distance to outlet from geographical coordinates
%
% Arguments are:
%         file_nodes contains XY coordinates of different nodes
%         system contains data about the river network
%         factor is an arbitrary number (>1) that reflects the fact that distances following a river network are longer than shortest distance on a sphere
%         to_ocean is the distance between the outlet node, and the ocean
%
% Charles Rouge, Aug 2017

function d = Aux_compute_distances(file_nodes,system,factor,to_ocean)

% Reading file
xx = xlsread(file_nodes);
x = xx(:,[1 7 8]);

% Local variable
J = size(x,1);

% Initialize output
d = zeros(J,2);
d(:,1) = x(:,1);

%% Computing distance to outlet (assuming they follow topo_r)
ad = zeros(J,1); % Keeps the list of nodes for which it is computes, ad=1 when distance from node to output is comuted

for j = 1:J
    % WARNING, not the same number of nodes in "system.id" (all
    % nodes ids) and in Lat-Lon coord file "x"  or "d"
    [m,jj]=max(x(j,1) == system.id); % jj is index of node in "system.id"
    if system.downstream_release_id(jj) == 0
        d(j,2) = to_ocean;
        ad(j) = 1;
    end
end


cc =0; % counter to stop while loop
while sum(ad) < J && cc < J % not computed for all nodes
    for j = 1:J
        
        if ad(j) == 0 
            
            % WARNING, not the same number of nodes in "system.id" (all
            % nodes ids) and in Lat-Lon coord file "x"  or "d"
            [m,jj]=max(x(j,1) == system.id); % jj is index of node in "system.id"
            [m,I] = max(system.downstream_release_id(jj)==d(:,1)); % find index of downstream node in "x" (or "d")
            
            if ad(I) == 1 % distance to outlet computed for downstream node
                
                d(j,2) = d(I,2) + lldistkm(x(j,2:3), x(I,2:3))*factor;
                ad(j) = 1;
                
            end
        end 
    end
    cc=cc+1;
end
if sum(ad) < J
    disp('   WARNING: distances to outlet NOT computed for all nodes')
end
