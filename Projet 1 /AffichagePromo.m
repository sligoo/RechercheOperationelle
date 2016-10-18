occupationCreneaux = optimisation(2,8,5,4);
[Promo] = traductionEdt(occupationCreneaux);

%PROMO 1
% x est la solution optimale
% 5 jours par semaine et 4 creneaux par jour
% on represente un creneau par un rectangle de 1 sur 2
% L'emploi du temps est contenu dans le rectangle ([0;0], [0,10],
% [4,10],[4,0])
% 

%on definit la fenetre
j=0:10;
h=0:4;
grid('on');
axis([0 10 0 4]);

set(gca,'Xtick',0:2:10);  set(gca,'Ytick',0:1:5);  
title('EDT');
xlabel('jour'); ylabel('heure');

%On definit les creneaux sous forme de rectangle (blanc par defaut, en
%couleur si occup??)
%creneau = zeros(5,4);
for i= 1:5
  for j= 1:4
    creneau(i,j) = rectangle ('Position',[2*(i-1) 4-j 2 1]);
    creneau(i,j).FaceColor='white'
  end
end

for k=1:2
  for i=1:5
    for j=1:4
      if Promo(k,j,i) == 1
        creneau(i,j).FaceColor='red'
        text(2*(i-1)+0.2, 4-j+0.5, 'Droite Maths');
      end
      if Promo(k,j,i) == 2
        creneau(i,j).FaceColor='magenta';
        text(2*(i-1)+0.2, 4-j+0.5, 'Ellips Maths');
      end
      if Promo(k,j,i) ==3
        creneau(i,j).FaceColor='yellow';
        text(2*(i-1)+0.1, 4-j+0.5, 'Proton Physique');
      end
      if Promo(k,j,i) == 4
        creneau(i,j).FaceColor='green';
        text(2*(i-1)+0.2, 4-j+0.5, 'Pascal Info');
      end
      if Promo(k,j,i) ==5
        creneau(i,j).FaceColor='cyan';
        text(2*(i-1)+0.2, 4-j+0.5, 'Dell Info');
      end
      if Promo(k,j,i) ==6
        creneau(i,j).FaceColor='blue';
        text(2*(i-1)+0.2, 4-j+0.5, 'Young Anglais');
      end
      if Promo(k,j,i) ==7
        creneau(i,j).FaceColor=[0.5 0.2 0.75];
        text(2*(i-1)+0.2, 4-j+0.5, 'Gazelle Sport');
      end
      if Promo(k,j,i) ==8
        creneau(i,j).FaceColor=[1 0.7 0];
        text(2*(i-1)+0.2, 4-j+0.5, 'Bigceps Sport');
      end
    end
  end
end