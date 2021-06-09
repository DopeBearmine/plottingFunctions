function dat  = imagescSort(dat, conditions)

% sorts the rows or columns in "dat" by the labels in "conditions"
% sorted dimension is the one that is the same size as "conditions"

% whether the conditions refer to columns or rows
orderDim = find(size(dat)==numel(conditions));

uniqueConds = unique(conditions);
order = [];
for d = 1:numel(uniqueConds)
    if d==1
        count(d) = numel(find(conditions==uniqueConds(d)));
        newTicks(d) = floor(count(d)/2);
    else
        count(d) = count(d-1)+ numel(find(conditions==uniqueConds(d)));
        newTicks(d) = count(d)- floor((count(d)-count(d-1) )/2);
    end
    numCond(d) =numel(find(conditions==uniqueConds(d)));
    order = cat(2,order, find(conditions==uniqueConds(d)));
end

if numel(orderDim)==1
    if orderDim == 2
        dat = dat(:,order);
        tiks = 'x';
    elseif orderDim==1
        dat = dat(order,:);
        tiks = 'y';
    end
else
    dat = dat(order,:);
    dat = dat(:,order);
    tiks = 'both';
end


imagesc(dat)

newLabels = cellfun(@(x,y) [x ' (' y, ')'] , strsplit(num2str(uniqueConds)), strsplit(num2str(numCond)), 'UniformOutput', false);

switch tiks
    case 'x'
        xticks(newTicks)
        xticklabels(newLabels)
    case 'y'
        yticks(newTicks)
        yticklabels(newLabels)
    case 'both'
        xticks(newTicks)
        xticklabels(newLabels)
        yticks(newTicks)
        yticklabels(newLabels)
end



