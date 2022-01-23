function estimatedMessage = decoder_boost_up_general(receivedCode)
	K = 3;
	G = [1 1 1; 1 0 1];
	l_r = length(receivedCode);
    estimatedMessage = zeros(1,((l_r-4)/2))-1;
    l_e = (l_r-4)/2;
    i=1;
	if K=3
		state_table = [0 0; 1 0; 0 1; 1 1];
	end
	if K=4
		state_table = [0 0 0; 1 0 0; 0 1 0; 1 1 0; 0 0 1; 1 0 1; 0 1 1; 1 1 1];
	end
	pathMetric = zeros(1,2^(K-1));
    for i = 2:2^(K-1):
		pathMetric(i) = 1000000
	end
	parents = zeros(1,2^(K-1)*(l_e+3));
    pairities = zeros(2^K,length(G(:,1)));
	p = zeros(1,length(G(:,1)))
	for state = 1:2^(K-1)
		for ii = 1:2
			input = ii-1;
			for iii = 1:length(G(:,1))
				p(iii) = mod(sum([input,state_table(state,:)].*G(iii,:)),2);
			end
			pairities(2*(state-1)+ii,:) = p;
		end
	end
	s = 0;
    temp = zeros(1,2*2^(K-1))-1;
    while i<l_r
        bits = receivedCode(1,i:i+length(G(:,1)));
		for k = 1:2^(K-1)
            temp(2*k-1) = pathMetric(k) + sum(mod(bits+pairities(2*k-1,:),2));%sum(xor(twoBits,pairities(k,:)));
            temp(2*k) = pathMetric(k) + sum(mod(bits+pairities(2*k,:),2));
        end 
        
        for x = 1:2^(K-1)
            if temp(x)-temp(x+2^(K-1))<0
				location_min = x;
			else
				location_min = x+2^(K-1);
            end
            p = 2^(K-1)*s+ceil(location_min/2);
            parents((2^(K-1)*(s+1))+x) = p;
            pathMetric(x) = temp(location_min);
        end
        
        i = i+2;
        s = s+1;
    end
   
    
    location = 2^(K-1)*(l_e+3)-2^(K-1)+1;
    state = 0;
    parent = parents(location);
    i = l_e+2;
    while i~=l_e
        location = parent;
        parent = parents(location);
        state = mod(location-1,2^(K-1));
        i = i-1;
    end
    for j = 1:l_e
        estimatedMessage(l_e-j+1) = state_table(state+1,1);
        location = parent;
        parent = parents(location);
        state = mod(location-1,2^(K-1));
    end
	
    