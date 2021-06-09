function equalizeX

% get all current axes handles
ax = findall(gcf, 'type', 'axes');

% get x axis limits
xl = get(ax, 'XLim'); xl = cat(1,xl{:});

% take the minimum and maximum values you need
newYL = [min(xl(:,1)), max(xl(:,2))];

% set the new axis limits
set(ax, 'XLim', newYL);