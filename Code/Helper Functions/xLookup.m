% Helper function for getting values of nodes.

function nodeVals = xLookup(xVals,indices)
    nodeVals = zeros(length(indices),1);
    L = length(indices);
    for i = 1:L
        nodeVals(i) = xVals{i,indices(i)};
    end
end