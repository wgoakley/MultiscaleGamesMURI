function C = embeddedLattice(n)
    A = lattice(n,sqrt(2));
    B = lattice(n,sqrt(2));
    C = [A zeros(n*n) ; zeros(n*n) B ];
    for i = 1:n
        C((n-1)*n + i,n*n + i) = 1;
        C(n*n + i,(n-1)*n + i) = 1;
    end
end

    
    