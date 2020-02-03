close all;
clear all;
clc;

%--------------------------------------------------------------------------
color = imread('x2.jpg');
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
    if contador == 10
        disp('Fin de logaritmo paro < 1');
        break;
    else 
        contador = contador+1;
        M = Mnext;
    end
end
xl = length(posx);
porcent=0.25; %condicion de parada * pendiente
lcentro = 0;
vxsi(1) = 0;
vysi(1) = 0;
for ixl = 1:xl
    vxx(ixl) = X(posx(ixl),posy(ixl));
    vyy(ixl) = Y(posx(ixl),posy(ixl));
    hold on;
    if ( (numel(find( (vxsi>=vxx(ixl)-(vxx(ixl)*porcent)) & (vxsi<=vxx(ixl)+(vxx(ixl)*porcent)) & (vysi>=vyy(ixl)-(vyy(ixl)*porcent)) & (vysi<=vyy(ixl)+(vyy(ixl)*porcent)) )) == 0 ))  
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