classdef Node
    properties
        location;
        child;
        state;
        parent;
        pathMetric;
    end
    methods
      function obj = Node(~)    % used for creating array of objects.
         if nargin > 0          % nargin --> returns number of input arguments.
            %
         end
      end
   end
end