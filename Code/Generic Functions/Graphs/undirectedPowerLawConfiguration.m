function A = undirectedPowerLawConfiguration(n,a)
    degree_dist = randraw('zeta',a,n);
    degree_dist(degree_dist>n) = n;
    assignin('base','degree_dist',degree_dist)
    total_degree = sum(degree_dist);
    nodes = zeros(1,total_degree);
    nodes_perm = nodes;
    m = 1;
    for i = 1 : n
        for j = 1 : degree_dist(i)
            nodes(m) = i;
            m = m+1;
        end
    end
    for i = total_degree : -1 : 1
        rand_num = randi(i);
        nodes_perm(i) = nodes(rand_num);
        nodes_perm(rand_num) = nodes(i);
    end
%     start = horzcat(nodes_perm,nodes);
%     finish = horzcat(nodes,nodes_perm);
    start = nodes;
    finish = nodes_perm;
    i = 1;
    while i < length(start)
        if start(i) == finish(i)
            start(i) = [];
            finish(i) = [];
        else 
            i = i + 1;
        end
    end     
    A = sparse(start,finish,ones(1,length(start)),n,n);
    A(A>1) = 1;
end
    