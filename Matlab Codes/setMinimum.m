function [location,pathMetric] = setMinimum(ii,a,b)
    if a>=0 && b>=0
        if a<b
            location = ii;
            pathMetric = a;
        else
            location = ii+4;
            pathMetric = b;
        end
    elseif b<0
        location = ii;
        pathMetric = a;
    elseif a<0
        location = ii+4;
        pathMetric = b;
    end