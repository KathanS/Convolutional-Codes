function estimatedMessage = hardDecoder2(receivedCode)   % decoder - temporary name
    estimatedMessage = zeros(1,((length(receivedCode)-4)/2))-1;
    l=length(receivedCode);
    i=1;
    pathMetric = zeros(1,((length(receivedCode)-4)/2+1)*4);
    pathMetric(1) = 0;
    pathMetric(2) = -100;
    pathMetric(3) = -100;
    pathMetric(4) = -100;
    parents = zeros(1,((length(receivedCode)-4)/2+1)*4);
    parents(1) = 0;
    parents(2) = 0;
    parents(3) = 0;
    parents(4) = 0;
    s = 0;
    
    while i<l
        twoBits = [receivedCode(i),receivedCode(i+1)];
        temp = zeros(1,2*4)-1;
        j=1;
        k=1;
        flag = setFlag(twoBits); % flag is used for BEC channel and Hamming function returns 0 whenever it gets erased bit.
        while k <= 4
           temp(j) = pathMetric(4*s+k) + hammingDistance(twoBits,pairityGenerator(k-1,0),flag) + flag;
           temp(j+1) = pathMetric(4*s+k) + hammingDistance(twoBits,pairityGenerator(k-1,1),flag) + flag;
           j=j+2;
           k=k+1;
        end
        minimum = zeros(4,2)-1; % minimum conatains 1) its location(index) in temp 2) path metric  order -> state 0-->1-->2-->3.
        for ii = 1:4
            [minimum(ii,1),minimum(ii,2)] = setMinimum(ii,temp(ii),temp(ii+4));
        end
        for x = 1:4
            p = 4*s+ceil(minimum(x,1)/2);
            parents((4*(s+1))+x) = p;
            pathMetric((4*(s+1))+x) = minimum(x,2);
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
    
    
    state_table = stateTable();
    
    for i = 1:length(estimatedMessage)
        estimatedMessage(i) = state_table(statePath(i)+1,1);
    end
    
   
    
   