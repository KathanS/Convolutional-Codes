function s = decodeState(inputState,pairity)
    state_diagram = stateDiagram();
    i = 1;
    while ~isequal([state_diagram(i,1),state_diagram(i,4),state_diagram(i,5)],[inputState,pairity])
        i = i+1;
    end
    s = state_diagram(i,3);