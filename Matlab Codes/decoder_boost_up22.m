function estimatedMessage = decoder_boost_up2(receivedCode)
	l_r = length(receivedCode);
    estimatedMessage = zeros(1,((l_r-4)/2))-1;
    l_e = (l_r-4)/2;
    i=1;
    pathMetric = zeros(1,4);
    pathMetric(2) = 5000; % high value
    pathMetric(3) = 5000;
    pathMetric(4) = 5000;
    pairities = [0 0; 1 1; 1 0; 0 1; 1 1; 0 0; 0 1; 1 0];
    parents = zeros(1,4*(l_e+3));
    s = 0;
    state_table = [0 0; 1 0; 0 1; 1 1];
	temp = zeros(1,2*4);
    while i<l_r
        twoBits = [receivedCode(i),receivedCode(i+1)];
        for k = 1:4
            temp(k) = pathMetric(ceil(k/2)) + sum(mod(twoBits+pairities(k,:),2));%sum(xor(twoBits,pairities(k,:)));
			temp(k+4) = pathMetric(ceil((k+4)/2)) + sum(mod(twoBits+pairities(k+4,:),2));
			if temp(k)-temp(k+4)<0
				location_min = k;
			else
				location_min = k+4;
            end
            p = 4*s+ceil(location_min/2);
            parents((4*(s+1))+k) = p;
            pathMetric(k) = temp(location_min);
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
	
    