disp('Duopole de Cournot');
disp('Strat�gies possibles : cooperatif/noncooperatif/stackelberg');
NBJ=input('Nombre de parties: ');
nomx=input('Strat�gie du 1er joueur: ','s');
strax=[nomx,'1'];
nomy=input('Strat�gie du second joueur: ','s');
stray=[nomy,'2'];
[tx, ty, gx, gy] = jeu(NBJ,strax,stray);
fig = afficher(tx,ty,gx,gy,nomx,nomy);
