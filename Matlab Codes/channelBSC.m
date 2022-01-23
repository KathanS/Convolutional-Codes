function output = channelBSC(input,p)
    % BSC channel flips input bit with probability p.
    output = zeros(1,length(input))-1; 
    for i = 1:length(input)
        if rand > 1-p
            % bit flips.
            output(i) = mod(input(i)+1,2);
        else
            output(i) = input(i);
        end
    end