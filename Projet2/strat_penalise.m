% Strategie qui "penalise" de plus en plus l'adversaire s'il n'est pas
% cooperatif.
function x = strategie(numpart,tx,ty,gx,gy)
nbr_penal_y = 0;
nbr_penal_x = 0;

for i = 2:numpart-1
    if (ty(i) > 0.75)
        nbr_penal_y = nbr_penal_y + 1;
    end;
end;

% nbr_penal_y = sum(find(ty(2:numpart-1) > 0.75));
while numpart-nbr_penal_x-1>0 && (tx(numpart-nbr_penal_x-1) > 0.75)
 nbr_penal_x = nbr_penal_x + 1;
end;

% nbr_penal_x = sum(find(tx(1:numpart-1) > 0.75));

if (nbr_penal_x < nbr_penal_y)
  %x = 0.75*(3-ty(numpart-1));
  x = 2*(3-ty(numpart-1))/3;
else
  x = 0.75;
end;
