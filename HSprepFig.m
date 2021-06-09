function HSprepFig

fig = gcf;
ax = findobj(gcf,'type','axes');

%freeze the axes limits:
set(ax,'xlimmode','manual','ylimmode','manual');

%set the figure windowstyle to normal (can't adjust figure sizes if docked)
set(fig,'windowstyle','normal');

%To do: use figure "userdata" property to override these values if
%provided:
figUnits = 'centimeters';
figWidth = 8.6; %one column in "Nature"
figHeight = figWidth; %square is usually good
font = 'Helvetica';
tickFontSize = 8;
titleFontSize = 12;
labelFontSize = 10;

%set the position
set(fig,...
    'units',figUnits, ...
    'position',[1 1 figWidth figHeight] ...
);

for u = 1:numel(ax)
    ax(u).TitleFontWeight='normal';
    ax(u).LineWidth = 1;
    % xAxis
    ax(u).XAxis.TickDirection = 'out';
    ax(u).XAxis.FontName = font;
    ax(u).XAxis.FontSize = tickFontSize;
    % yAxis
    ax(u).YAxis.TickDirection = 'out';
    ax(u).YAxis.FontName = font;
    ax(u).YAxis.FontSize = tickFontSize;
end


annotations = findall(0, 'Type', 'textbox');
if ~isempty(annotations)
    set(annotations, 'FontSize', labelFontSize)
end



