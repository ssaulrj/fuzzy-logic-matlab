close all;
clear all;
clc;

color = imread('colores.jpg');

% color = im2double(color); %op
figure(1);
subplot(2,2,1);
color = imresize(color, [120,160]);
imshow(color); % si esta en u8
title('Imagen original');

gris = rgb2gray(color); % convertir en escala de grises
% imshow(gris);

subplot(2,2,2);
bin1 = gris<120;
imshow(bin1);
title('Imagen binarizada')

ubin1 = double(bin1);

[m n] = size(ubin1);
imn = 1;
for im = 1:m
    for in = 1:n
        if ubin1(im,in) == 1
            x(imn) = in;
            y(imn) = im;
            imn = imn + 1;
        end 
    end
end

%Donde estan los puntos
subplot(2,2,3);
plot(x,y,'.k');
grid on;
hold on;
title('Puntos de interes y centros');

%Sustractivo---------------------------------------------------------------
ra = 3.6;
[mx nx] = size(x);

D = zeros(nx,nx);

for cd = 1:nx
    for ix = 1:nx
        dist = ( sqrt( (x(cd)-x(ix)).^2 + (y(cd)-y(ix)).^2 ) );
        D(cd,ix) = D(cd,ix) + exp(- ( (dist)./( (ra/2).^2 ) ) );
    end
end

D2 = sum(D,2);
[M I] = max(D2(:));
% subplot(2,2,3);
lcentro = 1;
vx(lcentro) = x(I);
vy(lcentro) = y(I);
% plot(x(I),y(I),'xb'); %Primer centro
% hold on;

limite = 10;

rb = ra;
for z = 1:limite-1
    rb = rb + rb*0.5;
    for ixc = 1:nx
        dist2(ixc,1) = ( sqrt( (x(ixc)-x(I)).^2 + (y(ixc)-y(I)).^2 ) );
        Dnext(ixc,1) = (M*(exp(- ( (dist2(ixc,1))./( ((rb)/2).^2 ) ) ) ) );
    end
    Dx2 = D2 - Dnext;  
    [M I] = max(Dx2(:));
    %condicion de parada pendiente
    porcent=0.01;
    if ((numel(find((vx>=x(I)-(x(I)*porcent))&(vx<=x(I)+(x(I)*porcent)))) == 0) && (numel(find((vy>=y(I)-(y(I)*porcent))&(vy<=y(I)+(y(I)*porcent)))) == 0))
        lcentro = lcentro+1; 
        vx(lcentro) = x(I);
        vy(lcentro) = y(I);
    end
end
%Sustractivo---------------------------------------------------------------
%Centros 
subplot(2,2,3);
plot(vx,vy,'ob','linewidth',5);
hold on; 

%K-means-------------------------------------------------------------------
[mx nx]=size(x);
[mxv nxx]=size(vx);
centros = nxx;
u = zeros(centros,nx);
for ix = 1:nx
    lugarx = floor(centros*rand(1,1)+1);
    u(lugarx,ix) = 1;
end
[m n]=size(u);
ufinal = zeros(m,n);
fin = 0; 
while 1 
    %Distancias entre centroides y datos
    for ii = 1:m
        for jj = 1:n
            d(ii,jj) = sqrt( (x(jj)-vx(ii)).^2 + (y(jj)-vy(ii)).^2 );
        end
    end

    uactfin = zeros(m,n);
    for iii = 1:n
        [miii niii] = min(d(:,iii));
        uactfin(niii,iii) = 1;
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
%K-means-------------------------------------------------------------------
% ufinal
%--------------------------------------------------------------------------
[mx nx]=size(ufinal);
subplot(2,2,4);
grid on;
strcolores = [".r",".b",".k",".m",".c",".g",".y",".r",".b",".k",".m",".c",".g",".y"];
for imxx = 1:mx
    for inxx = 1:nx
        if ufinal(imxx,inxx) == 1
            plot(x(inxx), y(inxx),strcolores(imxx),'linewidth', 2);
            hold on;
            subplot(2,2,4);
            plot(vx(imxx),vy(imxx),strcolores(imxx),'linewidth',5);
            hold on; 
        end
    end
end
title('Clusters y centros');
%--------------------------------------------------------------------------

% bin2 = gris>120;
% imshow(bin2);

% subplot(3,2,4);
% % imhist(gris);
% histogram(gris);
% 
% subplot(3,2,5);
% mesh(gris);
% 
% %Información de color
% matrizR = color(:,:,1);
% matrizG = color(:,:,2);
% matrizB = color(:,:,3);
% 
% figure(2);
% plot3(matrizR,matrizG,matrizB,'x');
