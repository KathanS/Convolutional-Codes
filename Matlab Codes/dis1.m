function estimatedMessage = dis1(receivedCode)   % decoder - temporary name
    estimatedMessage = zeros(1,((length(receivedCode)-6)/2))-1;
    l=length(receivedCode);
    i=1;
    K = 4;
	G = [1 1 0 1; 1 1 1 1];
	l_r = length(receivedCode);
    l_e = length(estimatedMessage);
    state_table = [0 0 0; 1 0 0; 0 1 0; 1 1 0; 0 0 1; 1 0 1; 0 1 1; 1 1 1];
	pathMetric = zeros(1,2^(K-1))+100000;
    pathMetric(1) = 0;
    parents = zeros(1,2^(K-1)*(l_e+3));
    s = 0;
    pairities = [0 0; 1 1; 1 1; 0 0; 0 1; 1 0; 1 0; 0 1; 1 1; 0 0; 0 0; 1 1; 1 0; 0 1; 0 1; 1 0];
    temp = zeros(1,2*2^(K-1))-1;
    
    while i<l_r
        bits = receivedCode(1,i:i+length(G(:,1))-1);
		for k = 1:2^(K-1)
            temp(2*k-1) = pathMetric(k) + sum(mod(bits+pairities(2*k-1,:),2));
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
   
    
    
    statePath = zeros(1,length(estimatedMessage)+2)-1;
    location = length(pathMetric)-7;
    state = 0;
    parent = parents(location);
    i = length(statePath)+1;
    
    while parent~=0
        statePath(i) = state;
        location = parent;
        parent = parents(location);
        state = mod(location-1,8);
        i = i-1;
    end
    
    statePath = [0,statePath];
   
    
    for i = 1:length(estimatedMessage)
        if statePath(i)<4
            estimatedMessage(i) = statePath(i+1)-2*statePath(i);
        else
            estimatedMessage(i) = statePath(i+1)-2*statePath(i)+8;
    
        end
    end
    
    
   
    
   