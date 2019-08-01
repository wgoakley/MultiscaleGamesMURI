function Q = edgeProbDiag(P)
    [from,to,vals] = find(P);
    Q = diag(vals);
end