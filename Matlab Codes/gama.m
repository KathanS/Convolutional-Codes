function y = gama(s1,s2,x)
    % get r from x.
    if s1<2
        index = s2+1;
    else
        index = 5+s2;
    end
    pairities = [0 0; 1 1; 1 0; 0 1; 1 1; 0 0; 0 1; 1 0];
    dot = sum((2*pairities(index)-1).*r);
    y = exp(2*gammaLin*dot);