function [x,errors,discordanceChange,numOccurences,updates] = runOpinionSim(x0,A,lambda,maxT,k)
n = length(A);
[from,to,~] = find(A);

tot = sum(x0);
mstot = ssqr(x0);
xave = tot/n;

numEvents = poissrnd(lambda*maxT);
% eventTimes = sort(maxT*rand(1,numEvents));
eventAssignments = zeros(numEvents,k);
for i = 1:numEvents
    eventAssignments(i,:) = subgraphARS(A,k);
end

numOccurences = tabulate(reshape(eventAssignments,numel(eventAssignments),1));
x = cell(n,1);
for i = 1:n
    x{i} = cell(1,numOccurences(i,2));
    x{i,1} = x0(i);
end
numUpdates = ones(n,1);

errors = zeros(1,numEvents+1);
for i = 1:n
    errors(1) = errors(1) + (x{i,1}-xave)^2;
end
errors(1) = sqrt(errors(1)/mstot);

discordanceChange = zeros(1,numEvents);

updates = cell(numEvents,2);

for i = 1:numEvents
    subNodes = eventAssignments(i,:);
    ave = 0;
    oldVals = zeros(length(subNodes),1);
    for j = 1:length(subNodes)
        p = subNodes(j);
        oldVals(j) = x{p,numUpdates(p)};
        ave = ave + x{p,numUpdates(p)};
        numUpdates(p) = numUpdates(p)+1;
    end
    ave = ave/k;
    newVals = zeros(k,1);
    for j = 1:length(subNodes)
        p = subNodes(j);
        newVals(j) = ave;
        x{p,numUpdates(p)} = ave;
    end
        
    subNodeInEdgesInd = find(ismember(from,subNodes).*(ismember(to,subNodes)));
    subNodeInEdgesFrom = from(subNodeInEdgesInd);
    subNodeInEdgesTo = to(subNodeInEdgesInd);
    subNodeOutEdgesInd = find(ismember(from,subNodes).*(~ismember(to,subNodes)));
    subNodeOutEdgesFrom = from(subNodeOutEdgesInd);
    subNodeOutEdgesTo = to(subNodeOutEdgesInd);
    inDiscordanceChange = 0;
    outDiscordanceChange = 0;
    for j = 1:length(subNodeInEdgesFrom)
        p = subNodeInEdgesFrom(j);
        q = subNodeInEdgesTo(j);
        inDiscordanceChange = inDiscordanceChange + (x{p,numUpdates(p)}-x{q,numUpdates(q)})^2-(x{p,numUpdates(p)-1}-x{q,numUpdates(q)-1})^2;
    end
    
    for j = 1:length(subNodeOutEdgesFrom)
        p = subNodeOutEdgesFrom(j);
        q = subNodeOutEdgesTo(j);
        outDiscordanceChange = outDiscordanceChange + (x{p,numUpdates(p)}-x{q,numUpdates(q)})^2-(x{p,numUpdates(p)-1}-x{q,numUpdates(q)})^2;
    end
    
    discordanceChange(i) = inDiscordanceChange + outDiscordanceChange;
    errors(i+1) = sqrt((errors(i)^2*mstot - ssqr(oldVals-xave) + ssqr(newVals-xave))/mstot);
    if discordanceChange(i) < 0 
        updates{i,1} = 1;
        updates{i,2} = subNodes;
        errors(i+1) = sqrt((errors(i)^2*mstot - ssqr(oldVals-xave) + ssqr(newVals-xave))/mstot);
    else
        updates{i,1} = 0;
        updates{i,2} = subNodes;
        for j = 1:length(subNodes)
            p = subNodes(j);
            x{p,numUpdates(p)} = x{p,numUpdates(p)-1};
        end
        errors(i+1) = errors(i);
    end
end
end
