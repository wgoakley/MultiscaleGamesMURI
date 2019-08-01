function [lowerTime,upperTime] = epsilonAveragingTime(P,k,epsilon)
    M = incidenceMatrix(P);
    Q = sqrt(edgeProbDiag(P));
    diag(Q)
    [~,n] = size(M);
    W = eye(n) - 1/k*(Q*M)'*(Q*M);
    lower = eigs(W,1,'smallestreal');
    upperTmp = eigs(W,2,'largestreal');
    upper = upperTmp(2);
    upperTime = 3*log(epsilon)/log(upper);
    eigs(W,n)
    lowerTime = log(epsilon)/log(lower);
end