function coolLegend

% This function modifies the aesthetic of currently existing legends on a
% figure by removing the Icons and changing the text into the color of the
% respective data

% It just looks cooler

% author: Hayden Scott September 2020

%% Properties

boxOn = false;
bold = true;
font = 'Helvetica';
fontSize = 12;
figTypes = {'line', 'histogram', 'scatter', 'BoxChart'};


%% Set parameters


if boxOn
    boxColor = [0 0 0];
else
    boxColor = 'none';
end

if bold
    fontWeight = 'bold';
else
    fontWeight = 'normal';
end

%% make the legend

leg = flipud(get(gcf,'Children'));
if sum(contains(get(leg, 'Type'),'legend'))==0
    warning('No Legends to modify')
    return
end

% in case some plots dont have legends
if sum(contains(get(leg, 'Type'),'legend'))==sum(contains(get(leg, 'Type'),'axes'))
    % a legend for every subplot
    leg = reshape(leg, 2, sum(contains(get(leg, 'Type'),'legend')));
else
    % some subplots are missing legends
    legInds = contains(get(leg, 'Type'),'legend');
    leg(diff(legInds)==0)=[];
    % those last 2 lines wont catch it if the final axis is missing a legend
    if legInds(end)==0
        leg(end)=[];
    end
    leg = reshape(leg, 2, sum(contains(get(leg, 'Type'),'legend')));
end

for u = 1:size(leg,2)
    children = flipud(leg(1,u).Children);
    types = get(children, 'type');
    if ~iscell(types)
        types = {types};
    end
    % only do this for relevant figure children
    inds = find(contains(types,figTypes));
    todo = children(inds);
    for y = 1:numel(inds)
        if ~isempty(todo(y).DisplayName)
            % variable discriptions in subfunction
            setColor(leg(2,u), todo, y, types{inds(y)})
        else
            warning('Not all Plots have available legend')
        end
    end
    
    set(leg(2,u), 'Visible', 'off')
    newString = leg(2,u).String;
    dim = get(leg(2,u), 'Position');
    annotation('textbox',dim,'String',newString','FitBoxToText','on',...
               'EdgeColor', boxColor,...
               'FontWeight', fontWeight,...
               'FontName', font,...
               'FontSize', fontSize);
end





    function setColor(leg,dat,d, type)
        % leg: the legend to modify
        % dat: the plot type that contains the proper color data
        % d: the index of the data color ID (Ie if there are multiple colors in one plot)
        % type: what type of plot is it (color property names change annoyingly)
        switch type
            case 'line'
                leg.String{d} = ['\color[rgb]{' num2str(dat(d).Color) '} ' leg.String{d}];
            case 'scatter'
                leg.String{d} = ['\color[rgb]{' num2str(dat(d).MarkerFaceColor) '} ' leg.String{d}];
            case 'histogram'
                leg.String{d} = ['\color[rgb]{' num2str(dat(d).FaceColor) '} ' leg.String{d}];
            case 'BoxChart'
                leg.String{d} = ['\color[rgb]{' num2str(dat(d).BoxFaceColor) '} ' leg.String{d}];
        end
    end



end



