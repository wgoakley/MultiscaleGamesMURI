% Code to simulate pairwise partial consensus opinion dynamics.
% Code assumes that pair of nodes to be updated is the pair that causes
% the greatest decrease in consensus error.
% TODO: modify slightly for group updates.
% Runs a collection of simulations for a range of group update sizes
% Use with and refer to function runOpinionSim
% Return: the sequence of consensus errors for each simulation errors,
%         the sequence of opinion values for each simulation x,
%         the sequence of updates
% Input: adjacency matrix A, network-wide communication rate lambda,
%        length of time interval maxT, initial opinions x0,
%        minimum group size in simulations minK,
%        maximum group size in simulations maxK,
%        number of simulations per group size sims
% 

% n = 100;
% p = .05;

% B = erdosRenyiGraph(n,p);
% B = ringOfPearlsGraph(2,10);
% nodesB = largestcomponent(B);
% A = B(nodesB,nodesB);
data = importdata('padgett-florentine.mat');
A = data.A;
n = length(A);

% x0 = xLookup(x4{1},updateHelper4(1480,:));
% With this initial data, updates of group size up to 5 get stuck
% x0 = zeros(n,1);
% for i = 1:floor(n/2)
%     x0(i) = i;
% end
% for i = ceil(n/2):n
%     x0(i) = i;
% end
sims = 200;
N = 1000;

[eigv,~] = eigs(laplacian(graph(A)),2,'smallestreal');

% x0 = eigv(:,2);
errors = cell(1,sims);
x = cell(1,sims);
updates = cell(1,sims);
for l=1:sims
    x0 = 200*(rand(n,1)-.5);
%         [x{k-minK+1,l},errors{k-minK+1,l},~,~,updates{k-minK+1,l}] = runOpinionSim(x0,A,lambda,maxT,k);
    [x{1,l},errors{1,l},updates{1,l}] = runBetaOpinionSim(x0,A,N);
    display(l)
end
