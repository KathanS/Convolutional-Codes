function estimatedMessage = decoder_boost_up(receivedCode)
	l_r = length(receivedCode);
    estimatedMessage = zeros(1,((l_r-4)/2))-1;
    i=1;
    pathMetric = zeros(1,4*(length(estimatedMessage)+3));
    pathMetric(1) = 0;
    pathMetric(2) = 5000; % high value
    pathMetric(3) = 5000;
    pathMetric(4) = 5000;
    parents = zeros(1,length(pathMetric));
    parents(1) = 0;
    parents(2) = 0;
    parents(3) = 0;
    parents(4) = 0;
    s = 0;
    state_table = [0 0; 1 0; 0 1; 1 1];
	pairities = zeros(8,2);
	for state = 1:4
		for ii = 1:2
			input = ii-1;
			G1 = [1 1 1];
			G2 = [1 0 1];
			p1 = mod(sum([input,state_table(state,:)].*G1),2);
			p2 = mod(sum([input,state_table(state,:)].*G2),2);
			pairities(2*(state-1)+ii,:) = [p1,p2];
		end
	end
	temp = zeros(1,2*4)-1;
    while i<l
        twoBits = [receivedCode(i),receivedCode(i+1)];
        if sum(twoBits)<0
			if sum(twoBits) == -10
				for k = 1:8
					temp(k) = pathMetric(4*s+ceil(k/2)) + 2;
				end
        	else
				for k = 1:8
					temp(k) = pathMetric(4*s+ceil(k/2)) + 1;
				end
			end	
        else
            for k = 1:8
                temp(k) = pathMetric(4*s+ceil(k/2)) + sum(xor(twoBits,pairities(k,:)));
            end 
        end
        for x = 1:4
			[value_min,location_min] = min([temp(x),temp(x+4)]);
			if location_min == 1
				location_min = x;
			else
				location_min = x+4;
			end
            p = 4*s+ceil(location_min/2);
            parents((4*(s+1))+x) = p;
            pathMetric((4*(s+1))+x) = value_min;
        end
        
        i = i+2;
        s = s+1;
    end
   
    
    statePath = zeros(1,length(estimatedMessage)+2)-1;
    location = length(pathMetric)-3;
    state = 0;
    parent = parents(location);
    i = length(statePath);
    
    while parent~=0
        statePath(i) = state;
        location = parent;
        parent = parents(location);
        state = mod(location-1,4);
        i = i-1;
    end
    
    for i = 1:length(estimatedMessage)
        estimatedMessage(i) = state_table(statePath(i)+1,1);
    end
	