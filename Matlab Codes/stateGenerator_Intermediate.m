function outState = stateGenerator_Intermediate(inputState,inputBit)
    if inputState<4
        outState = 2*inputState+inputBit;
    else
        outState = 2*(inputState-4)+inputBit;
    end
    