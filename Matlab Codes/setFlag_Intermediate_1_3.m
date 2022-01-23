function flag = setFlag_Intermediate_1_3(m1)
    i = 0;
    for j = 1:length(m1)
        if m1(j) == -5
            i=i+1;
        end
    end
    flag = i;
        
            