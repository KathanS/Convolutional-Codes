function fourNodes = initialNodes()
    n1 = Node;
    n1.location = 1;
    n1.child = [];
    n1.state = 0;
    n1.parent = 0;
    n1.pathMetric = 0;
    
    n2 = Node;
    n2.location = 2;
    n2.child = [];
    n2.state = 1;
    n2.parent = 0;
    n2.pathMetric = -100;
    
    n3 = Node;
    n3.location = 3;
    n3.child = [];
    n3.state = 2;
    n3.parent = 0;
    n3.pathMetric = -100;
    
    n4 = Node;
    n4.location = 4;
    n4.child = [];
    n4.state = 3;
    n4.parent = 0;
    n4.pathMetric = -100;
    
    fourNodes = [n1,n2,n3,n4];