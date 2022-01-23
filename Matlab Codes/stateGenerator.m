function outputState = stateGenerator(state,input)
    stateTable1 = stateTable();
    stateBits = [input, stateTable1(state+1,1)];
    i=1;
    while ~isequal(stateTable1(i,:),stateBits)
        i=i+1;
    end
    outputState = i-1;