state = [[0,0];[1,0];[0,1];[1,1]];
input = [0,1];
G1 = [1,0,1];
G2 = [1,1,1];

fprintf("initial state     input   outState   pairity\n")

for i = 1:length(state)
    for j = 1:length(input)
        p1 = mod(sum([input(j),state(i,:)].*G1),2);
        p2 = mod(sum([input(j),state(i,:)].*G2),2);
        fprintf("%d                  %d          -            %d%d\n",i-1,input(j),p1,p2)
    end
end