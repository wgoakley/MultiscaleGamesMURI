function A = starGraph(k)
    from = [ones(k,1);(2:k+1)'];
    to = [(2:k+1)',ones(k,1)];
    A = sparse(from,to,ones(length(from),1),k+1,k+1);
end