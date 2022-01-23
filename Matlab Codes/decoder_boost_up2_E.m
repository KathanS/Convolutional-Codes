function estimatedMessage = decoder_boost_up2_E(receivedCode)
	l_r = length(receivedCode);
    estimatedMessage = zeros(1,((l_r-4)/2))-1;
    l_e = (l_r-4)/2;
    i=1;
    pathMetric = zeros(1,4);
    pathMetric(2) = 5000; % high value
    pathMetric(3) = 5000;
    pathMetric(4) = 5000;
    parents = zeros(1,4*(l_e+3));
    pairities = [0 0; 1 1; 1 0; 0 1; 1 1; 0 0; 0 1; 1 0];
    s = 0;
    state_table = [0 0; 1 0; 0 1; 1 1];
	temp = zeros(1,2*4)-1;
    while i<l_r
        twoBits = [receivedCode(i),receivedCode(i+1)];
        if sum(twoBits)<0
            if sum(twoBits) == -10
                for k = 1:4
                    temp(2*k-1) = pathMetric(k) + 2;%sum(xor(twoBits,pairities(k,:)));
                    temp(2*k) = pathMetric(k) + 2;
                end 
            else
                for k = 1:4
                    temp(2*k-1) = pathMetric(k) + 1;%sum(xor(twoBits,pairities(k,:)));
                    temp(2*k) = pathMetric(k) + 1;
                end 
            end	
        else
            for k = 1:4
                temp(2*k-1) = pathMetric(k) + sum(mod(twoBits+pairities(2*k-1,:),2));%sum(xor(twoBits,pairities(k,:)));
                temp(2*k) = pathMetric(k) + sum(mod(twoBits+pairities(2*k,:),2));
            end 
        end
        for x = 1:4
            if temp(x)-temp(x+4)<0
				location_min = x;
			else
				location_min = x+4;
            end
            p = 4*s+ceil(location_min/2);
            parents((4*(s+1))+x) = p;
            pathMetric(x) = temp(location_min);
        end
        
        i = i+2;
        s = s+1;
    end
   
    
    location = 4*(l_e+3)-3;
    state = 0;
    parent = parents(location);
    i = l_e+2;
    while i~=l_e
        location = parent;
        parent = parents(location);
        state = mod(location-1,4);
        i = i-1;
    end
    for j = 1:l_e
        estimatedMessage(l_e-j+1) = state_table(state+1,1);
        location = parent;
        parent = parents(location);
        state = mod(location-1,4);
    end
	
    