function flag = setFlag(m1)
    if m1(1)~=-5 && m1(2)~=-5
        flag = 0;
    elseif m1(1)==-5 && m1(2)~=-5
        flag = 1;
    elseif m1(1)~=-5 && m1(2)==-5
        flag = 1;
    else 
        flag = 2;
    end
        
        
            