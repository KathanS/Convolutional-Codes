function distance = euclidieanDistance(v1,v2)
    v = v1-v2;
    d = 0;
    for i = 1:length(v)
        d = d + v(i)^2;
    end
    d = sqrt(d);
    distance = d;
    