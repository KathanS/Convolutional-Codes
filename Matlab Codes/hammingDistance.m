function distance = hammingDistance(m1,m2,flag)
    if flag == 0
        distance = sum(xor(m1,m2));
    else
        distance = 0;
    end