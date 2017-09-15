% This plots the desired quantity's cdf, aggregated both basin-wide and
% countrywise. 
%
% Charles Rouge, Aug 2017

function Distribution_By_Country(res, names, str)

figure 
hold on 
for i = [5 1 2 3 4]
    h = cdfplot(res(i,:));
    switch i
        case 5
            set(h,'Color','g','LineWidth',2)
        case 1
            set(h,'Color','r','LineStyle','--','LineWidth',2)
        case 2
            set(h,'Color','k','LineStyle','-','LineWidth',2)
        case 3
            set(h,'Color','b','LineStyle',':','LineWidth',2)
        case 4
            set(h,'Color','k','LineStyle','--','LineWidth',2)
    end
end
xlabel(str)
ylabel('Non-exceedence probability')
title('')
legend(names{5},names{1},names{2},names{3},names{4},'Location','SouthEast')