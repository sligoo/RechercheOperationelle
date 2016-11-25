maxS = 50;
alpha = rand(1, maxS+10);
alpha = alpha/size(alpha, 2);

C1 = 5;
C2 = 10;
C3 = 10;
C4 = 5;
v = 20;

[S, s] = rechercherMeilleur(maxS, alpha, C1, C2, C3, C4, v);

disp('S = ');
disp(S);
disp('s = ');
disp(s);