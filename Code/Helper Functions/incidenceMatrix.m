function [M,from,to] = incidenceMatrix(A)
    numVertices = length(A);
    [from,to] = find(A);
    directedEdges = length(from);
    fromM = 2*directedEdges;
    toM = 2*directedEdges;
    valsM = 2*directedEdges;
    for i = 1:directedEdges
        fromM(i) = i;
        toM(i) = from(i);
        valsM(i) = 1;
    end
    for i = 1:directedEdges
        fromM(directedEdges+i) = i;
        toM(directedEdges+i) = to(i);
        valsM(directedEdges+i) = -1;
    end
    M = sparse(fromM,toM,valsM,directedEdges,numVertices);
end
        