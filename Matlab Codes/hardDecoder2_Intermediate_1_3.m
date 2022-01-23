function estimatedMessage = hardDecoder2_Intermediate_1_3(receivedCode)   % decoder - temporary name
    estimatedMessage = zeros(1,((length(receivedCode)-9)/3))-1;
    l=length(receivedCode);
    i=1;
    pathMetric = zeros(1,((length(receivedCode)-9)/3+1)*8);
    pathMetric(1) = 0;
    pathMetric(2) = -100;
    pathMetric(3) = -100;
    pathMetric(4) = -100;
    pathMetric(5) = -100;
    pathMetric(6) = -100;
    pathMetric(7) = -100;
    pathMetric(8) = -100;
    parents = zeros(1,((length(receivedCode)-9)/3+1)*8);
    s = 0;
    
    while i<l
        threeBits = [receivedCode(i),receivedCode(i+1),receivedCode(i+2)];
        temp = zeros(1,2*8)-1;
        j=1;
        k=1;
        flag = setFlag_Intermediate_1_3(threeBits); % flag is used for BEC channel and Hamming function returns 0 whenever it gets erased bit.
        while k <= 8
           temp(j) = pathMetric(8*s+k) + hammingDistance(threeBits,pairityGenerator_Intermediate_1_3(k-1,0),flag) + flag;
           temp(j+1) = pathMetric(8*s+k) + hammingDistance(threeBits,pairityGenerator_Intermediate_1_3(k-1,1),flag) + flag;
           j=j+2;
           k=k+1;
        end
        minimum = zeros(8,2)-1; % minimum conatains 1) its location(index) in temp 2) path metric  order -> state 0-->1-->2-->3.
        for ii = 1:8
            [minimum(ii,1),minimum(ii,2)] = setMinimum_Intermediate(ii,temp(ii),temp(ii+8));
        end
        
        for x = 1:8
            p = 8*s+ceil(minimum(x,1)/2);
            parents((8*(s+1))+x) = p;
            pathMetric((8*(s+1))+x) = minimum(x,2);
        end
        
        s = s+1;
        
        i = i+3;
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
    
    
   
    
   