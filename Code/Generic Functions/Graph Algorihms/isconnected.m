function conn = isconnected(G)
    epsilon = 1e-8;
    L = laplacian(G);
    es = eigs(L,2,'smallestabs');
    conn = ~(abs(es(2))<epsilon);
end