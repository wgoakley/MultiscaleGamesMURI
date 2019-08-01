function [x,errors,updates] = runBetaOpinionSim(x0,A,numEvents)
n = length(A);
[from,to,~] = find(A);

tot = sum(x0);
mstot = ssqr(x0);
xave = tot/n;

% numEvents = poissrnd(lambda*maxT);
% eventTimes = sort(maxT*rand(1,numEvents));
% eventAssignments = zeros(numEvents,k);
% for i = 1:numEvents
%     eventAssignments(i,:) = subgraphARS(A,k);
% end

x = zeros(n,numEvents);
x(:,1) = x0;
numUpdates = ones(n,1);

errors = zeros(1,numEvents+1);
for i = 1:n
    errors(1) = errors(1) + (x(i,1)-xave)^2;
end
errors(1) = sqrt(errors(1)/mstot);

updates = zeros(numEvents,2);

for i = 1:numEvents
%     calculation of beta
    betas = zeros(length(from),1);
    updateDifferences = zeros(length(from),1);
    for edge = 1:length(from)
        f = from(edge);
        t = to(edge);
        if x(t,numUpdates(t)) > x(f,numUpdates(f))
%             sum t neighbors
            xt = 0;
            edgesOft = find(to==t);
            kt = length(edgesOft);
            for l = 1:kt
                nhbr = from(l);
                xt = xt + (x(nhbr,numUpdates(nhbr)) - x(t,numUpdates(t)));
            end
%             sum f neighbors
            xf = 0;
            edgesOff = find(to==f);
            kf = length(edgesOff);
            for l = 1:kf
                nhbr = from(l);
                xf = xf + (x(f,numUpdates(f)) - x(nhbr,numUpdates(nhbr)));
            end
            betas(edge) = max(0,min(1/2,2/((kt+kf+6)/2)-...
                (xt + xf)/(x(t,numUpdates(t))-x(f,numUpdates(f)))/((kt+kf+6)/2)));
            updateDifferences(edge) = x(t,numUpdates(t))-x(f,numUpdates(f));
        end
    end
    updateSizes = betas.*updateDifferences;
    [maxUpdateSize,updateEdge] = max(updateSizes);
    t = to(updateEdge);
    f = from(updateEdge);
    x(t,numUpdates(t)+1) = x(t,numUpdates(t)) - maxUpdateSize;
    x(f,numUpdates(f)+1) = x(f,numUpdates(f)) + maxUpdateSize;
    numUpdates(t) = numUpdates(t)+1;
    numUpdates(f) = numUpdates(f)+1;
    updates(i,:) = [f,t];

    oldVals = [x(t,numUpdates(t)-1);x(f,numUpdates(f)-1)];
    newVals = [x(t,numUpdates(t));x(f,numUpdates(f))];
    errors(i+1) = sqrt((errors(i)^2*mstot - ssqr(oldVals-xave) + ssqr(newVals-xave))/mstot);
end
end
