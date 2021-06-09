function addMarginals

% this function takes an existing scatter plot and adds marginal
% histograms to it

% scatter(xdat,ydat, 'filled')
% scatterSquare
set(gcf, 'WindowStyle', 'normal')
plt = gca;
fig = gcf;
kids = findobj(plt, 'Type', 'scatter');

xdat = [kids.XData];
ydat = [kids.YData];

lims = [get(plt, 'YLim'), get(plt, 'XLim')];
bins = goodBins([xdat,ydat], [min(lims), max(lims)]);
%% change position of current axes to make room for the marginals

position = plt.OuterPosition; % [left bottom width height]
newPosition = [position(1:2), position(3:4).*0.7]; % 30% of the alloted space is now for marginals
set(plt, 'OuterPosition', newPosition);
inner = plt.InnerPosition; % [left bottom width height]
inset = plt.TightInset; % [left bottom right top]

%% x marginal histogram


xHistPosition = [inner(1) newPosition(2)+inner(4) inner(3) newPosition(4)*0.3];
ax2 = axes('Parent',fig, 'OuterPosition', xHistPosition);
histogram(xdat, bins, 'Normalization', 'probability')
ax2.XAxis.Visible = 'off';
ax2.YAxis.Visible = 'off';
xlim(lims(3:4))

%% y marginal histogram

yHistPosition = [inner(3)+inset(1)+inset(3), inner(2) 1-newPosition(3), inner(3)];
ax3 = axes('Parent',fig,'OuterPosition',yHistPosition);


histogram(ydat, bins,'orientation', 'horizontal', 'Normalization', 'probability')
ylim(lims(1:2))
ax3.XAxis.Visible = 'off';
ax3.YAxis.Visible = 'off';
ax3.PlotBoxAspectRatioMode = 'manual';
