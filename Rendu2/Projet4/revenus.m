function [revenu] = revenus(stock, demande, s, S, v, C1, C2, C3, C4)
% Calcul du revenu pendant la periode n a n+1 si le stock a la periode n 
% vaut stock et la demande a la periode n+1 vaut demande

% On vend ce que l'on peut
if stock > demande
    ventes = demande;
    penurie = 0;
else
    ventes = stock;
    penurie = demande - stock;
end
% Calcul du gain lie aux ventes
gain_ventes = ventes * v;

% Calcul du cout de stockage
cout_stockage = stock * C1;

% Calcul du cout de penurie
cout_penurie = penurie * C2;

% Calcul du cout de commande
if (stock - demande) < s
    commande = S - (stock - ventes);
else
    commande = 0;
end
cout_commande = C3 + commande * C4;

% Revenu de la semaine
revenu = gain_ventes - cout_stockage - cout_penurie - cout_commande;
end