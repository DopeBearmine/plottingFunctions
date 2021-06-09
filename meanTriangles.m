function meanTriangles

fig = gcf;

% get them pesky kids
subplots = findall(fig,'type','axes');

% iterate through the axes
for subAxes = 1:numel(subplots)
    axes(subplots(subAxes))
    littlePlots = flipud(subplots(subAxes).Children); % get all plots on the axis
    ylims = get(subplots(subAxes), 'YLim');   % get original ylimits
    xlims = get(subplots(subAxes), 'XLim');   % get original xlimits
    
    % iterate through the plots on this axis
    for smolPlot = 1:numel(littlePlots)
        plotType = littlePlots(smolPlot).Type;
        switch plotType
            case 'histogram'
                % for calculating the mean
                data = littlePlots(smolPlot).Data;
                
                % for the size of the triangle (==1 binWidth)
                binWidth = littlePlots(smolPlot).BinWidth;
                
                % for knowing where to place the triangle on the y axis
                % (above the data)
                maxY = max(littlePlots(smolPlot).Values);
                triangleBottom(smolPlot) = [maxY+maxY*0.1]; % add 10% to the height of the tallest bar for the bottom of the triangle
                
                % mimic existing color pallet of plot
                cData{smolPlot} = littlePlots(smolPlot).FaceColor;
                % if set to eg 'auto'
                if ischar(cData{smolPlot})
                    clr = get(gca,'colorOrder');
                    cData{smolPlot} = clr(smolPlot,:);
                end
                xVertices(smolPlot,:) = [mean(data), mean(data)+binWidth./2, mean(data)-binWidth./2];
                
                % we want the subplots to have triangles the same size so
                % for now just store the calculated height
                triangleHeight(smolPlot) = binWidth/max(xlims).*max(ylims);
        end
    end
    % i put the fill command outside the prior for loop so that the
    % triangles would be the same size and height
    yVertices = [max(triangleBottom), max(triangleBottom)+max(triangleHeight), max(triangleBottom)+max(triangleHeight)];
    for smolPlot = 1:numel(littlePlots)
        fill(xVertices(smolPlot,:),yVertices ,cData{smolPlot}, 'HandleVisibility', 'off');
    end
end
