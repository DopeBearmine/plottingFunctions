function scatterImages(coords,ims, imSize)

if nargin<3
    imSize = 0.5;
end

y = coords(:,2);
x = coords(:,1);


assert(size(x(:),1)==size(ims(:),1), 'scatterImages: Inputs must be same length')
xs = [];
ys=[];
scatter(x, y, [],'MarkerFaceColor',[0.9,0.9,0.9], 'MarkerEdgeColor', [1,1,1]); hold on
for p = 1:size(x,1)
    if p==1
        insert = [x(p)-imSize/2, y(p)-imSize/2];
        xs = [xs, x(p)-imSize/2, x(p)+imSize/2, x(p)+imSize/2, x(p)-imSize/2, x(p)-imSize/2];
        ys = [ys, y(p)-imSize/2, y(p)-imSize/2, y(p)+imSize/2, y(p)+imSize/2, y(p)-imSize/2];
    else
        xs = [xs, x(p)-imSize/2, x(p)+imSize/2, x(p)+imSize/2, x(p)-imSize/2, x(p)-imSize/2, insert(1)];
        ys = [ys, y(p)-imSize/2, y(p)-imSize/2, y(p)+imSize/2, y(p)+imSize/2, y(p)-imSize/2, insert(2)];
    end
    psSoFar(p,:) = [x(p)-imSize/2, x(p)+imSize/2, y(p)-imSize/2, y(p)+imSize/2];
    
    if p>1
        overlap = inpolygon(repmat(psSoFar(p,1:2),1,2),repelem(psSoFar(p,3:4),1,2),xs(1:end-6),ys(1:end-6));
    else
        overlap = false;
        on = false;
    end
    if ~any(overlap)
        image(psSoFar(p,1:2),psSoFar(p,3:4), ims{p});
    else
        xs(end-5:end)=[];
        ys(end-5:end)=[];
    end
end
hold off