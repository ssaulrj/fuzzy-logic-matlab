close all;
clear all;
clc;

%--------------------------------------------------------------------------
color = imread('x3.jpg');
figure(1);
subplot(3,2,1);
% [tcx tcy tcz] = size(color);
color = imresize(color, [120,180]);
imshow(color); % si esta en u8
title('Imagen original');
gris = rgb2gray(color); % convertir en escala de grises
subplot(3,2,2);
bin1 = gris<120; % binarizar a unos logicos la escala de grises
imshow(bin1);
title('Imagen binarizada')
ubin1 = double(bin1); % logicos a datos double
[m n] = size(ubin1); % obtener el tamaño del arreglo double
imn = 1;
for im = 1:m
    for in = 1:n
        if ubin1(im,in) == 1 % hacer una matriz para x & y
            x(imn) = in;
            y(imn) = im;
            imn = imn + 1;
        end 
    end
end
%--------------------------------------------------------------------------

%Donde estan los puntos----------------------------------------------------
subplot(3,2,3);
plot(x,y,'.k');
grid on;
hold on;
title('Puntos de interes y centros');
%Donde estan los puntos----------------------------------------------------

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
lcentro = 1; %variable posicion de guardar centros 
vx(lcentro) = x(I); %primer centro
vy(lcentro) = y(I);
limite = 100; %limite maximo de centros a crear incluyendo el primero
rb = ra;
for z = 1:limite-1
    rb = rb + rb*0.5;
    for ixc = 1:nx
        dist2(ixc,1) = ( sqrt( (x(ixc)-x(I)).^2 + (y(ixc)-y(I)).^2 ) );
        Dnext(ixc,1) = (M*(exp(- ( (dist2(ixc,1))./( ((rb)/2).^2 ) ) ) ) );
    end
    Dx2 = D2 - Dnext;  
    [M I] = max(Dx2(:));
    porcent=0.5; %condicion de parada * pendiente
    vxno(z) = x(I);
    vyno(z) = y(I);
    if ((numel(find((vx>=x(I)-(x(I)*porcent))&(vx<=x(I)+(x(I)*porcent)) & (vy>=y(I)-(y(I)*porcent)) & (vy<=y(I)+(y(I)*porcent)) )) == 0))
        lcentro = lcentro+1; 
        vx(lcentro) = x(I);
        vy(lcentro) = y(I);
    end
end
%Sustractivo---------------------------------------------------------------

%Centros-------------------------------------------------------------------
subplot(3,2,3);
plot(vx,vy,'og','linewidth',5);
hold on; 
%Centros-------------------------------------------------------------------

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
    for ii = 1:m     %Distancias entre centroides y datos
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

%Clusters------------------------------------------------------------------
[mx nx]=size(ufinal);
subplot(3,2,4);
title('Clusters y centros');
hold on;
strcolores = [".r",".b",".m",".c",".g",".y",".r",".b",".m",".c",".g",".y"];
% strcluster = ["Cluster 1"]
% strcolores = ['.r','.b','.k','.m','.c','.g','.y','.r','.b','.k','.m','.c','.g','.y'];
for imxx = 1:mx
    for inxx = 1:nx
        if ufinal(imxx,inxx) == 1
            plot(x(inxx), y(inxx),strcolores(imxx),'linewidth', 2);
            hold on;
        end
    end
    text(vx(imxx),vy(imxx),strcat('\bf Cluster ',int2str(imxx)),'Color','black','FontSize',10)
    hold on; 
end
plot(vx,vy,'ok','linewidth',5);
hold on; 
grid on;
%Clusters------------------------------------------------------------------

%Elegir Cluster------------------------------------------------------------

while 1
    h5 = subplot(3,2,5);
    disp('0 - Salir')
    disp(strcat('0 > Continuar - Hay  ',int2str(nxx),' figuras'))
    prompt = 'Qué cluster/figura deseas ver? ';
    strx = input(prompt);
    if strx == 0
        break;
    else
        for inxx = 1:nx
            if ufinal(strx,inxx) == 1
            plot(x(inxx), y(inxx),'.k','linewidth', 2);
            hold on;
            end
        end 
        title(strcat('Cluster elección',int2str(strx)));
        hold on;
        grid on;
        disp('Listo!')
    end
    disp('Enter para continuar')
    disp(' ')
    pause;
    delete(h5);
end
%Elegir Cluster------------------------------------------------------------