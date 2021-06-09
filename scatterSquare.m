function scatterSquare


yl = get(gca, 'YLim');
xl = get(gca, 'XLim');
limits = [min([xl(1), yl(1)]), max([xl(2) yl(2)])];

axis square
xlim(limits);
ylim(limits);
background = get(gca, 'color');
if mean(background)>0.7
    linCol = 'k';
else
    linCol = 'w';
end
line(limits, limits, 'color', linCol, 'LineStyle', '--','HandleVisibility', 'off');

