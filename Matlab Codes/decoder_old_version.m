function estimatedMessage = decoder_old_version(receivedCode)   % decoder - temporary name
    estimatedMessage = zeros(1,((length(receivedCode)-4)/2))-1;
    l=length(receivedCode);
    i=1;
    n1 = Node;
    n1.location = 1;
    n1.child = 0;
    n1.state = 0;
    n1.parent = 0;
    n1.pathMetric = 0;
    leaf = [n1];
    tree = [];
    tree = [tree,leaf];
    
    while i<l
        twoBits = [receivedCode(i),receivedCode(i+1)];
        temp = zeros(1,2*length(leaf))-1;
        j=1;
        k=1;
        while k <= length(leaf)
           temp(j) = leaf(k).pathMetric + hammingDistance(twoBits,pairityGenerator(leaf(k).state,0));
           temp(j+1) = leaf(k).pathMetric + hammingDistance(twoBits,pairityGenerator(leaf(k).state,1));
           j=j+2;
           k=k+1;
        end
        minIndex = find(temp == min(temp(:)));
        % insert them in tree.
        % 1) make new leaf set.
        % 2) then do tree = [tree,leaf]
        newLeaf(1,length(minIndex)) = Node(0); 
        minValue = temp(minIndex(1));
        
        for x = 1:length(minIndex)
            newLeaf(x).location = length(tree)+x;
            newLeaf(x).child = 0;
            % find parent Node from minIndex(x).
            % parent in leafSet (old) is located at ceil(minIndex(x)/2)
            p = ceil(minIndex(x)/2);
            newLeaf(x).parent = leaf(p).location;
            tree(leaf(p).location).child = newLeaf(x).location;
            newLeaf(x).state = stateGenerator(leaf(p).state,mod(minIndex(x)+1,2));
            newLeaf(x).pathMetric = minValue;
        end
        leaf = newLeaf;
        tree = [tree,leaf];
        
        i = i+2;
    end
    
    % take any node from leaf to get path.
    
    statePath = zeros(1,length(estimatedMessage)+3)-1;
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
        estimatedMessage(i) = state_table(statePath(i+1)+1,1);
    end
    
    
    
    