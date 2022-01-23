function firstNodes = initialNodes_Intermediate()
    nodes(1,8) = Node;
    
    for i =1:8
        nodes(i).location = i;
        nodes(i).child = 0;
        nodes(i).state = i-1;
        nodes(i).parent = 0;
        nodes(i).pathMetric = -100;
    end    
    
    nodes(1).pathMetric = 0;
    
    firstNodes = nodes;