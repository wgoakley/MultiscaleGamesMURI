% Code to simulate opinion dynamics process.
% Runs a collection of simulations for a range of group update sizes
% Use with and refer to function runOpinionSim
% Return: the sequence of consensus errors for each simulation errors,
%         the sequence of opinion values for each simulation x,
%         the sequence of discordance changes for each simulation
%         discordanceChange,
%         the number of times each node was updated for each simulation nodeOccurences,
%         the sequence of attempted updates and whether they succeeded of
%         failed updates
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
lambda = n;
maxT = 50;

% [~,~,~,x0] = alphaStarCalculate(A,3);
x0 = 200*(rand(n,1)-.5);
% x0 = xLookup(x4{1},updateHelper4(1480,:));
% With this initial data, updates of group size up to 5 get stuck
% x0 = zeros(n,1);
% for i = 1:floor(n/2)
%     x0(i) = i;
% end
% for i = ceil(n/2):n
%     x0(i) = i;
% end

minK = 2;
maxK = 6;
sims = 1;

errors = cell(maxK-minK+1,sims);
x = cell(maxK-minK+1,sims);
updates = cell(maxK-minK+1,sims);
for k=minK:maxK
    for l=1:sims
%         [x{k-minK+1,l},errors{k-minK+1,l},~,~,updates{k-minK+1,l}] = runOpinionSim(x0,A,lambda,maxT,k);
        [~,errors{k-minK+1,l},~,~,~] = runOpinionSim(x0,A,lambda,maxT,k);
    end
end