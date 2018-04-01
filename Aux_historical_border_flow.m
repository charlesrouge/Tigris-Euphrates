% Annual border flows for 1987-2011 at the Turkey-Syria border on the
% Euphrates
%
% Charles ROUGE, March 2018

function f=Aux_historical_border_flow(hist)
f=zeros(25,1);
for y =1:25
    f(y) = sum(hist.flows.release(38+12*y:49+12*y,5)+...
        hist.flows.spillage(38+12*y:49+12*y,5));
end
f = f/1000; % covnersion to km3