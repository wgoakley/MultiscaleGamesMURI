% n = number of nodes
% p = vector of prior probabilities of communities
% W = k x k symmetric metric of connectivity probabilities
function [A,commSizes] = SBM(n,p,W)
%    first assign nodes to communities
    k = length(p);
    [~,nodeC] = multinomialDistribution(n,1:k,p);
%     generate graph
    commSizes = nodeC;
    nodeIndC = cumsum(nodeC);
    nodeIndC = [0 nodeIndC];
    nodeIndC = nodeIndC + 1;
    nodeIndC = nodeIndC(1:end-1);
    edges = zeros(n*n,2);
    w = 1;
    for i = 1:k
        for j = i:k
            f = @()geornd(W(i,j))+1;
            z = 0;
            if i==j
                while true
                    z = z + f();
                    if z>(nodeC(i)*(nodeC(i)-1)/2)
                        break;
                    end
                    [a,b] = indexConvertGeneral(z,1:(nodeC(i)-1));
                    a = a+1;
                    edges(w,:) = [nodeIndC(i)-1+a nodeIndC(i)-1+b];
                    edges(w + 1,:) = [nodeIndC(i)-1+b nodeIndC(i)-1+a];
                    w = w + 2;
                end
            end
            if i~=j
                while true
                    z = z + f();
                    if z>(nodeC(i)*nodeC(j))
                        break;
                    end
                    [a,b] = indexConvert(z,nodeC(j));
                    edges(w,:) = [nodeIndC(i)-1+a nodeIndC(j)-1+b];
                    edges(w + 1,:) = [nodeIndC(j)-1+b nodeIndC(i)-1+a];
                    w = w + 2;
                end
            end
        end
    end
    A = sparse(edges(1:(w-1),1),edges(1:(w-1),2),ones((w-1),1),n,n);
end

function [x,y] = indexConvert(n,l)
    x = floor((n-1)/l) + 1;
    y = n - (x-1)*l;
end

function [x,y] = indexConvertGeneral(n,rows)
    csum = cumsum(rows);
    for i = 1:length(rows)
        if (n<=csum(i))
            x = i;
            break;
        end
    end
    csum = [0 csum];
    y = n - csum(x);
end