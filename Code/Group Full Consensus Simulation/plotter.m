% Code to produce various plots of data from simulations

% 1. Calculate and plot bounds on convergence rates for opinion dynamics
%    without conformity bias
% 

% averaging time bounds
% 
% [l2,u2] = alphaStarCalculate(G2,2);
% [l3,u3] = alphaStarCalculate(G3,3);
% [l4,u4] = alphaStarCalculate(G4,4);
% [l5,u5] = alphaStarCalculate(G5,5);
% [l6,u6] = alphaStarCalculate(G6,6);
% 
% iters = 100;
% upperBounds = ...
%     [sqrt(u2)*ones(1,iters);sqrt(u3)*ones(1,iters);sqrt(u4)*ones(1,iters);sqrt(u5)*ones(1,iters);sqrt(u6)*ones(1,iters)];
% upperBounds = cumprod(upperBounds,2);
% 
% lowerBounds = ...
%     [sqrt(l2)*ones(1,iters);sqrt(l3)*ones(1,iters);sqrt(l4)*ones(1,iters);sqrt(l5)*ones(1,iters);sqrt(l6)*ones(1,iters)];
% lowerBounds = cumprod(lowerBounds,2);
% 
% hold on;
% plotUB = plot(1:iters,upperBounds(1:maxK-minK+1,:)');
% plotLB = plot(1:iters,lowerBounds(1:maxK-minK+1,:)');
% colors = {[0, 0.4470, 0.7410],[0.8500, 0.3250, 0.0980],[0.4940, 0.1840, 0.5560],[0.4660, 0.6740, 0.1880],[0.6350, 0.0780, 0.1840]};
% 
% set(plotUB(1),'DisplayName','2-Update Upper Bound','Color',colors{1},'LineWidth',2);
% set(plotUB(2),'DisplayName','3-Update Upper Bound','Color',colors{2},'LineWidth',2);
% set(plotUB(3),'DisplayName','4-Update Upper Bound','Color',colors{3},'LineWidth',2);
% set(plotUB(4),'DisplayName','5-Update Upper Bound','Color',colors{4},'LineWidth',2);
% set(plotUB(5),'DisplayName','6-Update Upper Bound','Color',colors{5},'LineWidth',2);
% 
% set(plotLB(1),'DisplayName','2-Update Upper Bound','Color',colors{1},'LineWidth',2);
% set(plotLB(2),'DisplayName','3-Update Upper Bound','Color',colors{2},'LineWidth',2);
% set(plotLB(3),'DisplayName','4-Update Upper Bound','Color',colors{3},'LineWidth',2);
% set(plotLB(4),'DisplayName','5-Update Upper Bound','Color',colors{4},'LineWidth',2);
% set(plotLB(5),'DisplayName','6-Update Upper Bound','Color',colors{5},'LineWidth',2);
% hold off;



% % 
% hold on;
% minK=2;
% maxK=6;
% for i = 1:maxK-minK+1
%     color = rand(1,3);
%     for j=1:sims
%         plot(errors{i,j}(1:end),'color',color);
%     end
%     display(i)
% end
% hold off;
% 
% % Error bar Average Plot
% % 
% 
% % Create ylabel
% ylabel({'2-norm Relative Distance from Consenus'});
% 
% % Create xlabel
% xlabel({'Number of Updates'});
% 
% hold on;
% errorSize = size(errors);
% sims = errorSize(2);
% for i = 1:maxK-minK+1
%     minLength = Inf;
%     for j=1:sims
%         if length(errors{i,j}) < minLength
%             minLength = length(errors{i,j});
%         end
%     end
%     data = zeros(sims,minLength);
%     for j = 1:sims
%         data(j,:) = errors{i,j}(1:minLength);
%     end
%     average = mean(data);
%     SEM = std(data) / sqrt(sims);
%     CI95 = SEM * tinv(0.975, sims-1);
% 
%     color = rand(1,3);
%     errorbar(1:5:100,average(1:5:100),CI95(1:5:100),'DisplayName',strjoin({'Update size =',num2str(minK+(i-1))}),'Color',colors{i},'LineWidth',2);
% end
% ylim([0,1]);
% legend
% hold off;


% Graph with node values

% hold off;
% xEnd = xSS{3,60};
% strtmp = cell(1,n);
% for q = 1:length(xEnd)
% %     strtmp{q} = strjoin({'(',num2str(q),',',num2str(xEnd(q)),')'});
%     strtmp{q} = num2str(xEnd(q));
% end
% plot(graph(A),'NodeLabel',strtmp)
% hold off;

% Fraction of sims to converge
% 
% fracConv = zeros(maxK-minK+1,1);
% epsilon = 1e-6;
% x0ave = mean(x0);
% for i = 1:maxK-minK+1
%     for j = 1:sims
%         if (norm(xSS{i,j}-x0ave*ones(n,1))<epsilon)
%             fracConv(i) = fracConv(i) + 1;
%         end
%     end
%     fracConv(i) = fracConv(i)/sims;
% end
% bar(minK:maxK,fracConv)

% updates = updates5;
% x = x5;
% errors = errors5;
% iter = 1000;
% iterHL = 1000;
% subgraphUpdates = cell2mat(updates{1}(:,2));
% numUpdates = length(subgraphUpdates);
% updateHelper = zeros(length(subgraphUpdates)+1,n);
% for i = 2:numUpdates
%     updateHelper(i,subgraphUpdates(i-1,:)) = 1;
% end
% updateHelper = cumsum(updateHelper)+1;
% G1 = createDataLabeledGraph(A,labels,xLookup(x{1},updateHelper(iter,:)));
% createFlorentineGraph(G1,[]);
% % createFlorentineGraph(G1,subgraphUpdates(iterHL,:));
% % createFlorentineGraph(graph(A,labels),[]);
% 
% % Successful Updates in time
% % 
% successes = cell2mat(updates{1}(:,1));
% cumSuccesses = cumsum(successes);
% len = round(length(cumSuccesses));
% plot(1:len,cumSuccesses(1:len))
