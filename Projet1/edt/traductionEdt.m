function [Promo] = traductionEdt(occupationCreneaux, years, teachers, days, classes)
  Promo = zeros(years, days, classes);
  
  for i = 1:years
    for j = 1:teachers
      for k = 1:days
        for l = 1:classes
          if (occupationCreneaux((i-1)*(teachers*days*classes) + (j-1)*(days*classes) + (k-1)*classes + l) == 1)
            Promo(i, k, l) = j;
          end
        end
      end
    end
  end
end