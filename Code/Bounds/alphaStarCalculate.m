function [lower,upper,lowerEigen,upperEigen] = alphaStarCalculate(P,k)
    M = incidenceMatrix(P);
    Q = sqrt(edgeProbDiag(P));
    [~,n] = size(M);
    W = eye(n) - 1/2/k*(Q*M)'*(Q*M);
%     Q*M
%     eigs(W,10,'smallestreal')
%     eigs(W,10,'largestreal')
    [lowerEigen,lower] = eigs(W,1,'smallestreal');
    [upperEigen,upperTmp] = eigs(W,2,'largestreal');
    upperEigen = upperEigen(:,2);
    upper = upperTmp(2,2);
end