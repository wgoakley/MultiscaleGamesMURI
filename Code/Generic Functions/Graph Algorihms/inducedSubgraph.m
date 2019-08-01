function Ai = inducedSubgraph(A,v)
    [from,to,vals] = find(A);
    fromv = ismember(from,v);
    tov = ismember(to,v);
    edges = fromv.*tov;
    edgeInd = find(edges);
    szA = size(A);
    Ai = sparse(from(edgeInd),to(edgeInd),vals(edgeInd));
end