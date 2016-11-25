function [meilleurS, meilleurs] = rechercherMeilleur(maxS, alpha, C1, C2, C3, C4, v)
  meilleurRevenu = intmin;
  meilleurS = -1;
  meilleurs = -1;

  for S=1:maxS
    for s=1:S
      distributionLimite = piStar(alpha, s, S);

      stockMoyen = 0;
      for i=1:S+1
        stockMoyen = stockMoyen + (i-1) * distributionLimite(i);
      end

      demandeMoyenne = 0;
      for i=1:size(alpha, 2)
        demandeMoyenne = demandeMoyenne + (i-1) * alpha(i);
      end

      revenu = revenus(stockMoyen, demandeMoyenne, s, S, v, C1, C2, C3, C4);
      if revenu > meilleurRevenu
        meilleurRevenu = revenu;
        meilleurS = S;
        meilleurs = s;
      end
    end
  end
end