%%
% NSUC : Vecteur du nombre de successeurs de chaque noeud
% SUC : Vecteur des successeurs de chaque noeud
% CAP : Capacité de chaque arc
% s : noeud source
% p : noeud puit
%%
function max_flow = FF_max_flow(NSUC, SUC, CAP, s, p)
%FF Summary of this function goes here
%   Detailed explanation goes here
  nbNoeuds = size(NSUC, 2); % Nombre de noeuds du graphe
  noeuds = uint16(1:nbNoeuds); % Vecteur des noeuds du graphe
  
  indiceSuccesseurs(1) = 1; % Vecteur d'indices vers les successeurs de chaque noeud
  for i=2:nbNoeuds
    indiceSuccesseurs(i) = indiceSuccesseurs(i-1) + NSUC(i-1);
  end
  
  capacites = zeros(nbNoeuds); % Matrice représentant les capacités
  for i = 1:nbNoeuds
    for j = 1:NSUC(i)
      capacites(i, SUC(indiceSuccesseurs(i) + j - 1)) = CAP(indiceSuccesseurs(i) + j - 1);
    end
  end
  flots = zeros(nbNoeuds); % Matrice représentant les flots (initialisés à 0)
  
  flotEstMaximal = false; % Vrai si on a trouvé le flot maximal
  
  max_flow = 0; % Le flot débute à 0
  while ~flotEstMaximal % Tant que le flot n'est pas maximal
    noeudsMarques = false(1, nbNoeuds); % Vecteur d'état des noeuds (marqués ou non)
    noeudsMarques(s) = true; % Marquage de la source
    grapheResiduel = zeros(nbNoeuds); % Matrice contenant le graphe résiduel
    noeudMarque = true;
    while noeudMarque % Tant qu'on marque des noeuds
      for i = 1:nbNoeuds
        if noeudsMarques(i) % Pour tout sommet marqué (i)
          noeudMarque = false; % On n'a pas encore marqué de noeud
          % On liste les noeuds suivants de i
          noeudsSuivants = SUC(indiceSuccesseurs(i):indiceSuccesseurs(i)+NSUC(i)-1);
          % On liste les noeuds précédents de i
          noeudsPrecedents = [];
          for j = 1:nbNoeuds
            if ismember(i, SUC(indiceSuccesseurs(j):indiceSuccesseurs(j)+NSUC(j)-1))
              noeudsPrecedents = [noeudsPrecedents j];
            end
          end
          for j = noeudsSuivants % Pour chaque suivant de i
            if flots(i, j) < capacites(i, j) % Si i-j non saturé, on marque j
              grapheResiduel(i, j) = 1; % On ajoute i-j au graphe résiduel
              if ~noeudsMarques(j)
                noeudsMarques(j) = true; % On marque j
                noeudMarque = true; % On continue de marquer des noeuds
              end
            end
            if flots(i, j) > 0 % Si i-j non insaturé
              grapheResiduel(j, i) = 1; % On ajoute j-i au graphe résiduel
            end
          end
          for j = noeudsPrecedents % Pour chaque précédent de i
            if flots(j, i) < capacites(j, i) % Si j-i non saturé, on marque j
              grapheResiduel(j, i) = 1; % On ajoute j-i au graphe résiduel
            end
            if flots(j, i) > 0 % Si j-i non insaturé
              grapheResiduel(i, j) = 1; % On ajoute i-j au graphe résiduel
              if ~noeudsMarques(j)
                noeudsMarques(j) = true; % On marque j
                noeudMarque = true; % On continue de marquer des noeuds
              end
            end
          end
        end
      end
    end
    if ~noeudsMarques(p) % Si on n'a pas marqué le puit (pas de liaison de s à p trouvée)
      flotEstMaximal = true; % Alors le flot est maximal
    else % Sinon on améliore le flot (recherche d'un chemin de s à p dans le graphe résiduel)
      chemin = [s]; % Chemin final
      sommet = s; % Sommet actuel
      while sommet ~= p % Recherche du chemin de s à p
        suivantTrouve = false; % Indique si on a trouvé un suivant à sommet
        for i = 1:nbNoeuds
          if grapheResiduel(sommet, i) == 1 % Si chemin de sommet à i
            grapheResiduel(sommet, i) = 0; % On l'efface (pour ne pas le reprendre)
            sommet = i; % On change sommet
            chemin = [chemin sommet]; % On l'ajoute à la chaine
            suivantTrouve = true; % On a bien trouvé un suivant
            break;
          end
        end
        if ~suivantTrouve % Si on n'a pas trouvé de suivant (bloqué)
          chemin = chemin(1:size(chemin, 2)-1); % On supprime le dernier sommet de la chaine
          sommet = chemin(size(chemin, 2)); % On repart du dernier sommet
        end
      end
      for i = 2:size(chemin, 2) % On parcourt enfin le chemin en appliquant les modifications
        if capacites(chemin(i-1), chemin(i)) ~= 0 % Si l'arc i-j existe dans le graphe de départ
          flots(chemin(i-1), chemin(i)) = flots(chemin(i-1), chemin(i)) + 1; % On augmente le flot de cet arc
        else % Sinon, c'est un retour
          flots(chemin(i), chemin(i-1)) = flots(chemin(i), chemin(i-1)) - 1; % On diminue le flot de cet arc
        end
      end
      max_flow = max_flow + 1; % On augmente le flot total de 1
    end  
  end

end

