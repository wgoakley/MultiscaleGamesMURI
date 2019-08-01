function A = pathGraph(n)
    A = zeros(n,n);
    A(1,2) = 1;
    for i=2:n-1
        A(i,i+1) = 1;
        A(i,i-1) = 1;
    end
    A(n,n-1) = 1;
end