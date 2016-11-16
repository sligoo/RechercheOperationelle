function [ P ] = passage( alpha,s, S )
% Creation de la matrice de passage (P dans l'?nonc?)

P = zeros(S+1);

P(1:s, 1) = sum(alpha(S+1:end)); % [0:s-1, 0]

for i = 2:S+1 % [0:s-1, 1:end]
    P(1:s, i) = alpha(S-i+2);
end

for i = s+1:S+1 
    P(i, 1) = sum(alpha(i:end)); %[s:S, 0]
    for j = 1:i-1
        P(i, j+1) = alpha(i-j); %[s:S, 1:end]
    end
end
end

