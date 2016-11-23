function [ pistar ] = piStar( alpha, s, S)
%PISTAR Summary of this function goes here
%   Detailed explanation goes here

P = passage(alpha, s, S);
% A = [I-P <colonne de 1>]
A = eye(S+1) - P;
A = [A  ones(S+1, 1)];
% B = [0, 0, 0, ... , 0, 1] (S+1 zeros)
B = [zeroes(S+1, 1); 1];
pistar = A \ B;

end

