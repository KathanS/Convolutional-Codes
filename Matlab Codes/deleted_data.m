minIndex = find(temp == min(temp(:)));
        lenMinIndex = length(minIndex);
        if lenMinIndex>256          %  prevention for BEC big leaf - big tree when p>0.12.
            lenMinIndex = 256;
        end
        % insert them in tree.
        % 1) make new leaf set.
        % 2) then do tree = [tree,leaf]
        newLeaf(1,lenMinIndex) = Node(0);
        minValue = temp(minIndex(1));stateGenerator(tree(p).state,mod(minimum(x,1)+1,2))
         1     1     0     1     1