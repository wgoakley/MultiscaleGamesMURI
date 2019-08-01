function G = createDataLabeledGraph(A,nameLabels,dataLabels)

n = length(nameLabels);
strtmp = cell(1,n);
for q = 1:n
    strtmp{q} = strjoin({nameLabels{q},': ',num2str(round(dataLabels(q),2))});
end

G = graph(A,strtmp);

end