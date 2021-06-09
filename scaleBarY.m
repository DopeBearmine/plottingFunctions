function scaleBarY(startTick)
%%
% This function converts the currently selected Y axis into a scale bar of
% width equal to the difference between the first two tick marks

% startTick  (optional)
% - This indicates where on the axis the scale bar should start
% - Default: 0
% - 'off' - Removes the scalebar and turns the axis back on

% There might be a problem with the 'off' command where it may delete other
% annotation lines with Type 'lineshape'

% Author: Hayden Scott September 8 2020


%% Parameters

ax = gca;
lineWidth = 2;
font = 'Helvetica';
fontSize = ax.YAxis.FontSize;
if nargin<1
    startTick = 0;
end

% set it up so 'off' can be an input to reverse the scalebar
if ischar(startTick)
    if contains(lower(startTick), 'off')        
        % delete the propper annotations
        anns = get(findall(gcf,'Tag','scribeOverlay'), 'Children');
        % check to see which annotations should be deleted
        for u = 1:numel(anns)
            % check for the scalebar line
            if contains(anns(u).Type, 'lineshape')
                isRight(u,1) = true;
            else
                % check if it's a textbox that only contains a number
                try
                    isRight(u,1) = isnumeric(str2num(anns(u).String));
                catch
                    isRight(u,1) = false;
                end
            end
        end
        % delete them
        delete(anns(isRight))
     
        set(ax, 'YColor', 'k')
        set(ax, 'YTickLabels', strsplit(num2str(ax.YAxis.TickValues)) ) 
        return
    end
end

%%

ytik = ax.YTick;
barLen = ytik(2)-ytik(1);
figPos = plotboxpos(ax);
rang = max(ax.YLim)-min(ax.YLim);

barLenNorm = barLen/rang*figPos(4);
unitNormLength = barLenNorm/barLen;

startPos = unitNormLength*startTick+min(ax.YLim);
xLocs = [figPos(1), figPos(1)];
yLocs = [figPos(2), figPos(2)+barLenNorm]+startPos;


% The Scale Bar line
annotation('line',...
           xLocs,...
           yLocs,...
           'LineWidth', lineWidth);
       
% The Scale Bar Label
labelPosition = [xLocs(1)-0.07, yLocs(1), 0, barLenNorm];
annotation('textbox',labelPosition,'String', num2str(barLen),'FitBoxToText','on',...
           'EdgeColor', 'none',...
           'FontSize', fontSize,...
           'FontName', font,...
           'VerticalAlignment', 'middle');

%% Remove the existing axis (make it invisible)

set(ax, 'YColor', 'w')
set(ax, 'YTickLabels', [])
set(ax.YLabel, 'Color', 'k')
set(ax.YLabel, 'Units', 'normalize')
set(ax.YLabel, 'Position', get(ax.YLabel, 'Position')-[0.05 0 0])
boto
