function equalizeColor

ax = findall(gcf, 'type', 'axes');

% get caxis limits
yl = get(ax, 'CLim'); yl = cat(1,yl{:});

% take the minimum and maximum values you need
newYL = [min(yl(:,1)), max(yl(:,2))];

% set the new axis limits
set(ax, 'CLim', newYL);