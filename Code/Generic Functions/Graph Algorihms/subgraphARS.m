function subNodes = subgraphARS(A,k)
    n = length(A);
    subNodes = randperm(n,k);
    AG = graph(A);
    AGsub = subgraph(AG,subNodes);
    while ~isconnected(AGsub)
        subNodes = randperm(n,k);
        AGsub = subgraph(AG,subNodes);
    end
end