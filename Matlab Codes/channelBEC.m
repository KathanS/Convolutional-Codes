function output = channelBEC(input,p)
    % BEC channel erases input bit with probability p.
    output = zeros(1,length(input))-1;
    for i = 1:length(input)
        if rand > 1-p
            output(i) = -5; % -5 denotes bit is erased
        else
            output(i) = input(i);
        end
    end