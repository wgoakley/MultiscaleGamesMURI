function h = edgeProbEstimator(A,k,sims)
    h = zeros(size(A));
    for l = 1:sims
        subg = subgraphARS(A,k);
        pairs = nchoosek(subg,2);
        [numPairs,~] = size(pairs);
        for m = 1:numPairs
            p = pairs(m,:);
            h(p(1),p(2)) = h(p(1),p(2))+1;
            h(p(2),p(1)) = h(p(2),p(1))+1;
        end
    end
end