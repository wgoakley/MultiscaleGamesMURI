function A = erdosRenyiGraph(n,p)
    A = zeros(n);
    for i = 1 : n
        for j = 1 : (i-1)
            if rand() < p
                A(i,j) = 1;
                A(j,i) = 1;
            end
        end
    end
end