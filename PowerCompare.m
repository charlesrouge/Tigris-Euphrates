% Compare simulated and theoretical annual power productions (GWh)
%
% Charles Rougé, Aug 2017

function x = PowerCompare(TE,TE0)

[y,t]=xlsread('Nominal.xlsx');
nbres = size(y,1);
z = repmat(y(:,3),1,3);

J = length(TE.system.id);
for i = 1:nbres
    [m,I] = max((TE.system.id==y(i,1)));
    z(i,2) = mean(mean(TE0.econ.hydropower_production(end,I:J:end)));
    z(i,3) = mean(mean(TE.econ.hydropower_production(end,I:J:end)));
end

% For Mosul, add the regulation dam (nominal productions are main dam +
% regulation dam)
z(12,2) = z(12,2) + mean(mean(TE0.econ.hydropower_production(end,30:J:end)));
z(12,3) = z(12,3) + mean(mean(TE.econ.hydropower_production(end,30:J:end)));

% Re-ordering power plants by expected production
tt = t(2:end,2);
[a,i] = sort(-z(:,1));
x = z(i,:);
names = tt(i);

figure('Name','Validation, panel 1')
colormap summer
bar(x(1:9,:))
ylabel('Annual power production (GWh)')
legend('Expected','Simulated (no irrigation)', ...
    'Simulated (with irrigation)')
set(gca,'Ylim',[0 10000])

% Reduce the size of the axis so that all the labels fit in the figure.
pos = get(gca,'Position');
set(gca,'Position',[pos(1), .2, pos(3) .65])

Xt = 1:9;
set(gca,'XTick',Xt,'XTickLabel','');

ax = axis;    % Current axis limits
axis(axis);    % Set the axis limit modes (e.g. XLimMode) to manual
Yl = ax(3:4);  % Y-axis limits

% Place the text labels
t = text(Xt,Yl(1)*ones(1,length(Xt)),names(1:9,:));
set(t,'HorizontalAlignment','Center','VerticalAlignment','top');

figure('Name','Validation, panel 2')
colormap summer
bar(x(10:18,:))
ylabel('Annual power production (GWh)')


% Reduce the size of the axis so that all the labels fit in the figure.
pos = get(gca,'Position');
set(gca,'Position',[pos(1), .2, pos(3) .65])
Xt = 1:9;
set(gca,'XTick',Xt,'XTickLabel','');

ax = axis;    % Current axis limits
axis(axis);    % Set the axis limit modes (e.g. XLimMode) to manual
Yl = ax(3:4);  % Y-axis limits

% Place the text labels
t = text(Xt,Yl(1)*ones(1,length(Xt)),names(10:18,:));
set(t,'HorizontalAlignment','Center','VerticalAlignment','top');


