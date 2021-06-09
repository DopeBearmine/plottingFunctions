function scaleBarX(startTick)

%%
% This function converts the currently selected X axis into a scale bar of
% width equal to the difference between the first two tick marks

% startTick - optional
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
fontSize = ax.XAxis.FontSize;
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
     
        set(ax, 'XColor', 'k')
        set(ax, 'XTickLabels', strsplit(num2str(ax.YAxis.TickValues)) ) 
        return
    end
end


%% Create the scale Bar and Label

xtik = ax.XTick;
barLen = xtik(2)-xtik(1);
figPos = plotboxpos(ax);
rang = max(ax.XLim)-min(ax.XLim);

barLenNorm = barLen/rang*figPos(3);
unitNormLength = barLenNorm/barLen;

startPos = unitNormLength*startTick+min(ax.XLim);
xLocs = [figPos(1), figPos(1)+barLenNorm]+startPos;
yLocs = [figPos(2), figPos(2)];


% The Scale Bar line
annotation('line',...
           xLocs,...
           yLocs,...
           'LineWidth', lineWidth);
       
% The Scale Bar Label
labelPosition = [xLocs(1), yLocs(1), barLenNorm, 0];
annotation('textbox',labelPosition,'String', num2str(barLen),'FitBoxToText','on',...
           'EdgeColor', 'none',...
           'FontSize', fontSize,...
           'FontName', font,...
           'HorizontalAlignment', 'center');

%% Remove the existing axis (make it invisible)
       
set(ax, 'XColor', 'w')
set(ax, 'XTickLabels', [])
set(ax.XLabel, 'Color', 'k')
set(ax.XLabel, 'Units', 'normalize')
set(ax.XLabel, 'Position', get(ax.XLabel, 'Position')-[0 0.05 0])
boto


