function A = undirectedStarGraph(k)
    start = horzcat(ones(k),2:k+1);
    finish = horzcat(2:k+1,ones(k));
    A = sparse(start,finish,ones(2*k),k+1,k+1);
end