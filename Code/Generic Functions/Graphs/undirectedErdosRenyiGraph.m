function A = undirectedErdosRenyiGraph(n,p)
    A = zeros(n);
    for i = 1 : n
        for j = 1 : (i-1)
            if rand() < p
                A(i,j) = 1;
            end
        end
    end
    A = A + transpose(A);
end