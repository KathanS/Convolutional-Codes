function inputBit = decodeInput(inputState,pairity)
    state_diagram = stateDiagram();
    i = 1;
    while ~isequal([state_diagram(i,1),state_diagram(i,4),state_diagram(i,5)],[inputState,pairity])
        i = i+1;
    end
    inputBit = state_diagram(i,2);