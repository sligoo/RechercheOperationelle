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

% Mme Droite : prof = 1
for i = 1:years
  AeqRow = zeros(years, teachers, days, classes);
  for j = 1:days
    for k = 1:classes
      AeqRow(i, 1, j, k) = 1;
    end
  end
  Aeq = cat(5, Aeq, AeqRow);
end
beq = [beq; 5]; % 5 cours avec la promo 1
beq = [beq; 0]; % 0 cours avec la promo 2

% M. Ellips : prof = 2
for i = 1:years
  AeqRow = zeros(years, teachers, days, classes);
  for j = 1:days
    for k = 1:classes
      AeqRow(i, 2, j, k) = 1;
    end
  end
  Aeq = cat(5, Aeq, AeqRow);
end
beq = [beq; 0]; % 0 cours avec la promo 1
beq = [beq; 4]; % 4 cours avec la promo 2

% Mme Proton : prof = 3
for i = 1:years
  AeqRow = zeros(years, teachers, days, classes);
  for j = 1:days
    for k = 1:classes
      AeqRow(i, 3, j, k) = 1;
    end
  end
  Aeq = cat(5, Aeq, AeqRow);
end
beq = [beq; 3]; % 3 cours avec la promo 1
beq = [beq; 3]; % 3 cours avec la promo 2

% M. Pascal : prof = 4
for i = 1:years
  AeqRow = zeros(years, teachers, days, classes);
  for j = 1:days
    for k = 1:classes
      AeqRow(i, 4, j, k) = 1;
    end
  end
  Aeq = cat(5, Aeq, AeqRow);
end
beq = [beq; 6]; % 6 cours avec la promo 1
beq = [beq; 0]; % 0 cours avec la promo 2

% Mme Ada : prof = 5
for i = 1:years
  AeqRow = zeros(years, teachers, days, classes);
  for j = 1:days
    for k = 1:classes
      AeqRow(i, 5, j, k) = 1;
    end
  end
  Aeq = cat(5, Aeq, AeqRow);
end
beq = [beq; 0]; % 0 cours avec la promo 1
beq = [beq; 6]; % 6 cours avec la promo 2

% M. Young : prof = 6
for i = 1:years
  AeqRow = zeros(years, teachers, days, classes);
  for j = 1:days
    for k = 1:classes
      AeqRow(i, 6, j, k) = 1;
    end
  end
  Aeq = cat(5, Aeq, AeqRow);
end
beq = [beq; 3]; % 3 cours avec la promo 1
beq = [beq; 3]; % 3 cours avec la promo 2

% Mlle Gazelle : prof = 7, jour = 4, créneau = 3
for i = 1:years
  AeqRow = zeros(years, teachers, days, classes);
  AeqRow(i, 7, 4, 3) = 1;
  Aeq = cat(5, Aeq, AeqRow);
end
beq = [beq; 1]; % 1 cours avec la promo 1
beq = [beq; 0]; % 0 cours avec la promo 2

% M. Bigceps : prof = 8, jour = 4, créneau = 3
for i = 1:years
  AeqRow = zeros(years, teachers, days, classes);
  AeqRow(i, 8, 4, 3) = 1;
  Aeq = cat(5, Aeq, AeqRow);
end
beq = [beq; 0]; % 0 cours avec la promo 1
beq = [beq; 1]; % 1 cours avec la promo 2

% Créneau réservé (partiels) : jour = 1, créneau = 1
AeqRow = zeros(years, teachers, days, classes);
for i = 1:years
  for j = 1:teachers
    AeqRow(i, j, 1, 1) = 1;
  end
end
Aeq = cat(5, Aeq, AeqRow);
beq = [beq; 0]; % 0 cours pour les promos 1 et 2

% M. Ellips indisponible le Lundi matin : prof = 2, jour = 1, créneau = 1:2
AeqRow = zeros(years, teachers, days, classes);
for i = 1:years
  for j = 1:2
    AeqRow(i, 2, 1, j) = 1;
  end
end
Aeq = cat(5, Aeq, AeqRow);
beq = [beq; 0]; % 0 cours pour les promos 1 et 2

% Mme Proton indisponible le Mercredi : prof = 3, jour = 3
AeqRow = zeros(years, teachers, days, classes);
for i = 1:years
  for j = 1:classes
    AeqRow(i, 3, 3, j) = 1;
  end
end
Aeq = cat(5, Aeq, AeqRow);
beq = [beq; 0]; % 0 cours pour les promos 1 et 2

% Chaque prof ne peut donner qu'un cours par créneau
for i = 1:teachers
  for j = 1:days
    for k = 1:classes
      ARow = zeros(years, teachers, days, classes);
      for l = 1:years
        ARow(l, i, j, k) = 1;
      end
      A = cat(5, A, ARow);
      b = [b; 1]; % max : 1 cours par prof/jour/créneau
    end
  end
end

% Chaque promo ne peut suivre qu'un cours par créneau
for i = 1:years
  for j = 1:days
    for k = 1:classes
      ARow = zeros(years, teachers, days, classes);
      for l = 1:teachers
        ARow(i, l, j, k) = 1;
      end 
      A = cat(5, A, ARow);
      b = [b; 1]; % max : 1 cours par promo/jour/créneau
    end
  end
end

% Chaque promo ne peut suivre qu'une fois un cours par jour (sauf informatique : 2 fois (prof = 4:5))
for i = 1:years
  for j = 1:teachers
    for k = 1:days
      ARow = zeros(years, teachers, days, classes);
      for l = 1:classes
        ARow(i, j, k, l) = 1;
      end
      A = cat(5, A, ARow);
      if (j == 4) || (j == 5) % Si informatique
        b = [b; 2]; % max : 2 cours par promo/prof/jour
      else % Si autre que informatique
        b = [b; 1]; % max : 1 cours par promo/prof/jour
      end
    end
  end
end