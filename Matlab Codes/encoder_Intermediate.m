function [encodedMessage,message] = encoder_Intermediate(k,r)

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
    
    K=4;
    m = [zeros(1,K-1),message,zeros(1,K-1)];
    encodedMessage = zeros(1,(1/r)*(k+K-1))-1;
    j=0;
    if r==1/2
        G1=[1 1 0 1];
        G2=[1 1 1 1];
    
        for i = K:length(m)
            fourElement = [m(i),m(i-1),m(i-2),m(i-3)];
            j=j+1;
            encodedMessage(j) = mod(sum(fourElement.*G1),2);
            j=j+1;
            encodedMessage(j) = mod(sum(fourElement.*G2),2);
        end
    elseif r==1/3
        G1=[1 0 1 1];
        G2=[1 1 0 1];
        G3=[1 1 1 1];
        
        for i = K:length(m)
            fourElement = [m(i),m(i-1),m(i-2),m(i-3)];
            j=j+1;
            encodedMessage(j) = mod(sum(fourElement.*G1),2);
            j=j+1;
            encodedMessage(j) = mod(sum(fourElement.*G2),2);
            j=j+1;
            encodedMessage(j) = mod(sum(fourElement.*G3),2);
        end
    end
    