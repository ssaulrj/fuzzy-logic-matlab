close all;
clear all;
clc;

%--------------------------------------------------------------------------

strImagen = input('Ingresa el nombre de la imagen:');
color = imread(strcat(strImagen,'.jpg'));
figure(1);
subplot(2,2,1);
% [tcx tcy tcz] = size(color);
color = imresize(color, [120,180]);
imshow(color); % si esta en u8
title('Imagen original');
gris = rgb2gray(color); % convertir en escala de grises
subplot(2,2,2);
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
subplot(2,2,3);
plot(x,y,'.k');
grid on;
hold on;
title('Puntos de interes y centros');
xlabel('x');
ylabel('y');
%Donde estan los puntos----------------------------------------------------

%Metodo montañana----------------------------------------------------------
valorxmaximo = max(x);
valorxminimo = min(x);
valorymaximo = max(y);
valoryminimo = min(y);
%Modificar muestras grid para presicion
factor = 100;
factorx = valorxmaximo/factor;
factory = valorxmaximo/factor;
[X, Y] = meshgrid (valorxminimo:factorx:valorxmaximo, valoryminimo:factory:valorymaximo);
figure (2)
plot(x, y, 'o');
grid on; 
hold on;
plot(X,Y,'.');
hold on;
xlabel('x');
ylabel('y');
title('Valores en x,y , Rejilla metodo montaña y centros');
%Mayor alfa mayores picos
alfa = 3;
lenxy = length(x);
[lenX lenY] = size(X);
M = zeros(lenX,lenY);
for i = 1:lenxy
    for ii = 1:lenX
        for jj = 1:lenY
            dxN = sqrt( (x(i)-X(ii,jj)).^2 + (y(i)-Y(ii,jj)).^2 );
            Mx(ii,jj) = exp( -(alfa.*dxN) );
            M(ii,jj) = M(ii,jj) + Mx(ii,jj);
        end
    end
end
figure (3)
plot3(X,Y,M,'.');
grid on;
hold on;
xlabel('x');
ylabel('y');
zlabel('z');
title('Metodo montaña');
%Variable posx y posy guardan los centros 
contador = 1;
while 1 
    figure (3);
    [lenmx lenmy] = max(M(:));
    [posx(contador), posy(contador)] = ind2sub(size(M),lenmy);
    %Primer cumulo es posx,posy, mostrar en la grafica
    plot3(X(posx(contador),posy(contador)),Y(posx(contador),posy(contador)),M(posx(contador),posy(contador)),'ko');
    hold on;
    beta = 8;
    [lenXn lenYn] = size(M);
    Mn = zeros(lenXn,lenYn);
        for ii = 1:lenXn
            for jj = 1:lenYn
                dxNn = sqrt( (X(posx(contador),posy(contador))-X(ii,jj)).^2 + (Y(posx(contador),posy(contador))-Y(ii,jj)).^2 );
                Mxn(ii,jj) = exp( -(beta.*dxNn) );
                Mn(ii,jj) = Mn(ii,jj) + Mxn(ii,jj);
            end
        end
    Mn;
    % %Obtener siguientes cumulos
    Mnext = max( M - M(posx(contador),posy(contador)).*Mn , 0 );
    %Encontrar valor maximo de Mnext, posicion en x & y 
    [lenmxn lenmyn] = max(Mnext(:));
    [posxn, posyn] = ind2sub(size(Mnext),lenmyn);
    if contador == 15
        disp('Fin de logaritmo montaña - centros');
        break;
    else 
        contador = contador+1;
        M = Mnext;
    end
end
xl = length(posx);
porcent=0.6; %condicion de parada * pendiente
lcentro = 0;
vxsi(1) = 0;
vysi(1) = 0;
for ixl = 1:xl
    vxx(ixl) = X(posx(ixl),posy(ixl));
    vyy(ixl) = Y(posx(ixl),posy(ixl));
    hold on;
    if ( (numel(find( (vxsi>=(vxx(ixl)-(vxx(ixl)*porcent))) & (vxsi<=(vxx(ixl)+(vxx(ixl)*porcent))) & (vysi>=(vyy(ixl)-(vyy(ixl)*porcent))) & (vysi<=(vyy(ixl)+(vyy(ixl)*porcent))) )) == 0 ))  
        lcentro = lcentro+1; 
        vxsi(lcentro) = vxx(ixl);
        vysi(lcentro) = vyy(ixl);
    end
end
vx = vxsi;
vy = vysi;
figure (2)
plot(vx,vy, 'k*');
%Metodo montañana----------------------------------------------------------

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
figure (1);
subplot(2,2,4);
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
    h5 = figure (4);
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
