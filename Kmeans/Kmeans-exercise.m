clear all;clc;close all;

x = [1 4 4 5.5];
y = [1 1 2 1];

[mx nx]=size(x);
for ix = 1:nx
    lugarx = floor(2*rand(1,1)+1);
    if lugarx == 1
        u(1,ix) = 1;
        u(2,ix) = 0;
    elseif lugarx == 2
        u(1,ix) = 0;
        u(2,ix) = 1;
    end
end
u
% u = [0 0 1 1;
%      1 1 0 0];
 
[m n]=size(u);
ufinal = zeros(m,n);
fin = 0; 

while 1 
    clf(figure(1)); %borrar para que no queden los centroides
    %Clusters
    figure(1)
    plot(x, y,'x');
    hold on;
    grid on;
    xlim([0 6])
    ylim([0 3])
    for i = 1:2
        vtotal = 0;
        vijx = 0;
        vijy = 0;
        for j = 1:n
            vijx = vijx + u(i,j)*x(j);
            vijy = vijy + u(i,j)*y(j);
            vtotal = vtotal + u(i,j);
        end
        vx(:,i) = vijx/vtotal;
        vy(:,i) = vijy/vtotal;
        plot(vx(:,i), vy(:,i),'o');
    end

    %Distancias entre centroides y datos
    for ii = 1:m
        for jj = 1:n
            d(ii,jj) = sqrt( (x(jj)-vx(1,ii)).^2 + (y(jj)-vy(1,ii)).^2 );
        end
    end

    uactfin = zeros(m,n);
    for iii = 1:n
        uact(1,iii) = min(d(1,iii),d(2,iii));
        if uact(1,iii) == d(1,iii)
            uactfin(1,iii) = 1;
            uactfin(2,iii) = 0;
        elseif uact(1,iii) == d(2,iii)
            uactfin(1,iii) = 0;
            uactfin(2,iii) = 1;
        end
    end
    ufinal = uactfin;

    if u == ufinal
        fin = 1;
        break;
    else 
        u = uactfin;
        fin = 0; 
    end
end

%Ufinal, conjuntos discretos
vx
vy
ufinal
