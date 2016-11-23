function [ pistar ] = piStar( alpha, s, S)
%PISTAR Summary of this function goes here
%   Detailed explanation goes here

P = passage(alpha, s,S);
P = eye(size(P)) - P ;
pistar = zeros(S,1);


end

