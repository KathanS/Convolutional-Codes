function estimatedMessage = BCJR_S(receivedCode,p)
	l_r = length(receivedCode);
    alpha = zeros(1,4*(l_r/2+1));
    bita = zeros(1,4*(l_r/2+1));
    gamma = zeros(1,4*l_r);
    s = 1;
    i=1;
    while i<l_r
        twoBits = [receivedCode(i),receivedCode(i+1)];
        pairities = [0 0; 1 1; 1 0; 0 1; 1 1; 0 0; 0 1; 1 0];
        for index = 1:8
            hd = sum(mod(twoBits+pairities(index,:),2));
            gamma(s) = ((1-p)^2)*((p/(1-p))^hd);
            s = s+1;
        end
        i = i+2; 
    end
    alpha(1) = 1;
    i = 5;
    y = 0;
    while i <= 4*(l_r/2+1)
        alpha(i) = alpha(i-4)*gamma(8*y+1) + alpha(i-4+2)*gamma(8*y+5);
        alpha(i+1) = alpha(i-4)*gamma(8*y+2) + alpha(i-4+2)*gamma(8*y+6);
        alpha(i+2) = alpha(i-4+1)*gamma(8*y+3) + alpha(i-4+3)*gamma(8*y+7);
        alpha(i+3) = alpha(i-4+1)*gamma(8*y+4) + alpha(i-4+3)*gamma(8*y+8);
        sa = alpha(i) + alpha(i+1) + alpha(i+2) + alpha(i+3);
        alpha(i) = alpha(i)/sa;
        alpha(i+1) = alpha(i+1)/sa;
        alpha(i+2) = alpha(i+2)/sa;
        alpha(i+3) = alpha(i+3)/sa;
        i = i + 4;
        y = y + 1;
    end
    bita(4*(l_r/2+1)-3) = 1;
    i = 2*l_r-3;
    y = l_r/2-1;
    while i>=1
        bita(i) = bita(i+4)*gamma(8*y+1) + bita(i+5)*gamma(8*y+2);
        bita(i+1) = bita(i+6)*gamma(8*y+3) + bita(i+7)*gamma(8*y+4);
        bita(i+2) = bita(i+4)*gamma(8*y+5) + bita(i+5)*gamma(8*y+6);
        bita(i+3) = bita(i+6)*gamma(8*y+7) + bita(i+7)*gamma(8*y+8);
        sb = bita(i) + bita(i+1) + bita(i+2) + bita(i+3);
        bita(i) = bita(i)/sb;
        bita(i+1) = bita(i+1)/sb;
        bita(i+2) = bita(i+2)/sb;
        bita(i+3) = bita(i+3)/sb;
        i = i - 4;
        y = y-1;
    end
    APP = zeros(1,l_r/2+1);
    for i = 1:l_r/2
        d = alpha(4*(i-1)+1)*gamma(8*(i-1)+1)*bita(4*i+1) + alpha(4*(i-1)+2)*gamma(8*(i-1)+3)*bita(4*i+3) + alpha(4*(i-1)+3)*gamma(8*(i-1)+5)*bita(4*i+1) + alpha(4*(i-1)+4)*gamma(8*(i-1)+7)*bita(4*i+3);
        u = alpha(4*(i-1)+1)*gamma(8*(i-1)+2)*bita(4*i+2) + alpha(4*(i-1)+2)*gamma(8*(i-1)+4)*bita(4*i+4) + alpha(4*(i-1)+3)*gamma(8*(i-1)+6)*bita(4*i+2) + alpha(4*(i-1)+4)*gamma(8*(i-1)+8)*bita(4*i+4);
        APP(i) = log(u/d);
    end
    
    estimatedMessage1 = zeros(1,length(APP));
    
    for i = 1:length(APP)
        if APP(i)>0
            estimatedMessage1(i) = 1;
        else
            estimatedMessage1(i) = 0;
        end
    end
    
    estimatedMessage = estimatedMessage1(1,1:length(APP)-3);
    