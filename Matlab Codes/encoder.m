function [encodedMessage,message] = encoder(k)

    % generating message
    
    p = 0.5; % p is probability of getting one  
    message = rand(1,k);
    
    for i = 1:length(message)       % length(message) = k 
        if message(i) > 1-p         % (as p increase number of ones should increase.)
            message(i) = 1;
        else
            message(i) = 0;
        end
    end
    
    % encoding using LSI - linear shift invariant system
    
    % here doing for, K=3 generatorPolynomials G1={1,1,1} G2={1,0,1}
	% Code can also work for other values, K can be set to any value and any number of generator functions can be added.   
    
    K=3;
    m = [zeros(1,K-1),message,zeros(1,K-1)];
    number_of_generators = 2;
	encodedMessage = zeros(1,number_of_generators*(k+K-1))-1;
    j=0;
    G1=[1,1,1];
    G2=[1,0,1];
    G = zeros(number_of_generators,K);
	G(1,:) = G1;
	G(2,:) = G2;
    elements =  zeros(1,K);
    
    for i = K:length(m)
		for ii = 1:K
			elements(ii) = m(i-ii+1); 
		end
		for ii = 1:number_of_generators
			j=j+1;
			encodedMessage(j) = mod(sum(elements.*G(ii,:)),2);
		end
    end
   