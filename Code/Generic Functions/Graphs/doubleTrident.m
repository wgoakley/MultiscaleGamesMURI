function A = doubleTrident(m,n)
    B = starGraph(m);
    C = starGraph(n);
    A = blkdiag(B,C);
    A(1,m+2)=1;
    A(m+2,1)=1;
end