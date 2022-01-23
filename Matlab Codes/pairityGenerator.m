function pairity = pairityGenerator(state,input)
    G1 = [1 1 1];
    G2 = [1 0 1];
    stateTable1 = stateTable();
    p1 = mod(sum([input,stateTable1(state+1,:)].*G1),2);
    p2 = mod(sum([input,stateTable1(state+1,:)].*G2),2);
    pairity = [p1,p2];