function estimatedMessage = softDecoder(receivedCode)   % decoder - temporary name
    estimatedMessage = zeros(1,((length(receivedCode)-4)/2))-1;
    l=length(receivedCode);
    i=1;
    leaf = initialNodes();
    tree = [];
    tree = [tree,leaf];
    
    while i<l
        twoVolts = [receivedCode(i),receivedCode(i+1)];
        temp = zeros(1,2*length(leaf))-1;
        j=1;
        k=1;
        while k <= length(leaf)
           temp(j) = leaf(k).pathMetric + euclidieanDistance(twoVolts,2*pairityGenerator(leaf(k).state,0)-1);
           temp(j+1) = leaf(k).pathMetric + euclidieanDistance(twoVolts,2*pairityGenerator(leaf(k).state,1)-1);
           j=j+2;
           k=k+1;
        end
        minimum = zeros(4,2)-1; % minimum conatains 1) its location(index) in temp 2) path metric  order -> state 0-->1-->2-->3.
        for ii = 1:4
            [minimum(ii,1),minimum(ii,2)] = setMinimum(ii,temp(ii),temp(ii+4));
        end
        newLeaf(1,length(minimum)) = Node(0);
        for x = 1:length(minimum)
            newLeaf(x).location = length(tree)+x;
            newLeaf(x).child = [];
            % find parent Node from minIndex(x).
            % parent in leafSet (old) is located at ceil(minIndex(x)/2)
            p = length(tree)-length(leaf)+ceil(minimum(x,1)/2);
            newLeaf(x).parent = tree(p).location;
            tree(p).child = [tree(p).child,newLeaf(x).location];
            newLeaf(x).state = x-1;
            newLeaf(x).pathMetric = minimum(x,2);
        end
        leaf = newLeaf;
        clear('newLeaf');
        tree = [tree,leaf];
        
        i = i+2;
    end
    
    % take any node from leaf to get path.
    
    statePath = zeros(1,length(estimatedMessage)+2)-1;
    pointerNode = Node;
    pointerNode.location = leaf(1).location;
    pointerNode.child = leaf(1).child;
    pointerNode.state = leaf(1).state;
    pointerNode.parent = leaf(1).parent;
    %pointerNode.pathMetric = leaf(1).pathMetric;
    i = length(statePath);
    
    while pointerNode.parent~=0
        statePath(i) = pointerNode.state;
        pointerNode.location = tree(pointerNode.parent).location;
        pointerNode.child = tree(pointerNode.parent).child;
        pointerNode.state = tree(pointerNode.parent).state;
        pointerNode.parent = tree(pointerNode.parent).parent;
        %pointerNode.pathMetric = tree(pointerNode.parent).pathMetric;
        
        i = i-1;
    end
    
    state_table = stateTable();
    
    for i = 1:length(estimatedMessage)
        estimatedMessage(i) = state_table(statePath(i)+1,1);
    end
    
   
    
   