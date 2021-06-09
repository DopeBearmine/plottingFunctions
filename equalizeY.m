function equalizeY

% get all current axes handles
ax = findall(gcf, 'type', 'axes');

% get y axis limits
yl = get(ax, 'YLim'); yl = cat(1,yl{:});

% take the minimum and maximum values you need
newYL = [min(yl(:,1)), max(yl(:,2))];

% set the new axis limits
set(ax, 'YLim', newYL);