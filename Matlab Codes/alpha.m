function a = alpha(state,x)
    if x == 0
        if state == 0
            a = 1;
        else
            a = 0;
        end
    else
        if state == 0
            a = alpha(0,x-1)*gamma(0,0,x) + alpha(2,x-1)*gamma(2,0,x);
        elseif state == 1
            a = alpha(0,x-1)*gamma(0,1,x) + alpha(2,x-1)*gamma(2,1,x);
        elseif state == 2
            a = alpha(1,x-1)*gamma(1,2,x) + alpha(3,x-1)*gamma(3,2,x);
        else
            a = alpha(1,x-1)*gamma(1,3,r) + alpha(3,x-1)*gamma(3,3,r);
        end
    end
            
    
     