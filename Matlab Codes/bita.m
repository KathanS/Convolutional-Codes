function b = bita(state,x)
    if x == endingTime
        if state == 0
            b = 1;
        else
            b = 0;
        end
    else
        if state == 0
            b = bita(0,x+1)*gamma(0,0,x) + bita(1,x+1)*gamma(0,1,x);
        elseif state == 1
            b = bita(2,x+1)*gamma(1,2,x) + bita(3,x+1)*gamma(1,3,x);
        elseif state == 2
            b = bita(0,x+1)*gamma(2,0,x) + bita(1,x+1)*gamma(2,1,x);
        else
            b = bita(2,x+1)*gamma(3,2,r) + bita(3,x+1)*gamma(3,3,r);
        end
    end
    