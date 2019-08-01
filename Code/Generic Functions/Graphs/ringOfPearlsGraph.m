function A = ringOfPearlsGraph(n,k)
    Acell = mat2cell(repmat(ones(k),1,n),k,repmat(k,1,n));
    A = blkdiag(Acell{:});
    for i=1:n-1
        A(i*k,i*k+1) = 1;
        A(i*k+1,i*k) = 1;
    end
    A(1,n*k)=1;
    A(n*k,1)=1;
    for i = 1:n*k
        A(i,i) = 0;
    end
end
        