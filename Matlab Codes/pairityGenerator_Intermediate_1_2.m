function pairity = pairityGenerator_Intermediate_1_2(state,input)
    G1=[1 1 0 1];
    G2=[1 1 1 1];
    stateTable1 = stateTable_Intermediate();
    p1 = mod(sum([input,stateTable1(state+1,:)].*G1),2);
    p2 = mod(sum([input,stateTable1(state+1,:)].*G2),2);
    pairity = [p1,p2];