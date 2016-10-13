%%
% years : Nombre de promotions
% teachers : Nombre de professeurs
% days : Nombre de jours
% classes : Nombre de créneaux par jour
%%
function optimisation(years, teachers, days, classes)
  Aeq = []; % Contraintes d'égalité, coordonnées de la forme promo/prof/jour/créneau
  beq = []; % Vecteur des valeurs des contraintes d'égalité
  A = []; % Contraintes d'inégalité, coordonnées de la forme promo/prof/jour/créneau
  b = []; % Vecteur des valeurs des contraintes d'inégalité
  
  