function stateDiagram1 = stateDiagram()
fprintf("initial state     input   outState   pairity\n")
r=1;
stateDiagram1 = zeros(8,5);
for i = 1:4
    for j = 1:2
        pairity = pairityGenerator(i-1,j-1);
        stateDiagram1(r,:) = [i-1,j-1,stateGenerator(i-1,j-1),pairity(1),pairity(2)];
        fprintf("%d                  %d          %d          %d%d\n",i-1,j-1,stateGenerator(i-1,j-1),pairity(1),pairity(2));
        r = r+1;
    end
end
