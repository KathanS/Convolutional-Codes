function pairities = parities_1()    
    state_table = [0 0; 1 0; 0 1; 1 1];
    pairities = zeros(8,2);
	for state = 1:4
		for ii = 1:2
			input = ii-1;
			G1 = [1 1 1];
			G2 = [1 0 1];
			p1 = mod(sum([input,state_table(state,:)].*G1),2);
			p2 = mod(sum([input,state_table(state,:)].*G2),2);
			pairities(2*(state-1)+ii,:) = [p1,p2];
		end
	end
	