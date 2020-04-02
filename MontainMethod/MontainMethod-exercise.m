clc;
close all;
clear all;

x = [0.36 0.65 0.62 0.50 0.35 0.90 1.00 0.99 0.83 0.88];
y = [0.85 0.89 0.55 0.75 1.00 0.35 0.24 0.55 0.36 0.43];

valorxmaximo = max(x);
valorxminimo = min(x);
valorymaximo = max(y);
valoryminimo = min(y);
%Modificar muestras grid para presicion
factor = 100;
factorx = valorxmaximo/factor;
factory = valorxmaximo/factor;
[X, Y] = meshgrid (valorxminimo:factorx:valorxmaximo, valoryminimo:factory:valorymaximo);

figure (1)
plot(x, y, 'o');
grid on; 
hold on;
plot(X,Y,'.');
hold on;

% Ni = grid point = X,Y
%Distancia eucliana
% dxN = sqrt( (x(1)-N(1)).^2 + (y(1)-vy(1)).^2 )

%Mayor alfa mayores picos
alfa = 4;

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

figure (2)
plot3(X,Y,M,'.');
grid on;
hold on;

%Encontrar valor maximo de M, posicion en x & y 
%M1* = max(M)
%Misma funcion que las 2 lineas siguientes---------
% [lenmx lenmy] = size(M);
% maxvalor = 0;
% maxvalorfin = 0;
% for i = 1:lenmx
%     for ii = 1:lenmy
%         maxvalor = M(i,ii);
%         if(maxvalor > maxvalorfin)
%             maxvalorfin = maxvalor;
%             posx = i;
%             posy = ii;
%         end
%     end
% end
%--------------------------------------------------

%Variable posx y posy guardan los centros 

contador = 1;
while 1 
    figure (2);
    [lenmx lenmy] = max(M(:));
    [posx(contador), posy(contador)] = ind2sub(size(M),lenmy);

    %Primer cumulo es posx,posy, mostrar en la grafica
    plot3(X(posx(contador),posy(contador)),Y(posx(contador),posy(contador)),M(posx(contador),posy(contador)),'ko');
    hold on;
    
    beta = 15;
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

    figure (3)
    plot3(X,Y,Mnext,'.');
    grid on;
    hold on;
    plot3(X(posxn,posyn),Y(posxn,posyn),Mnext(posxn,posyn),'ko');
    grid on;
    hold on

    paro = (M(posx(contador),posy(contador)))/(Mnext(posxn,posyn));
    
    %if paro <= 1.0500
    if contador == 3
        disp('Fin de logaritmo paro < 1');
        break;
    else 
        contador = contador+1;
        M = Mnext;
    end
end
contador;
%disp('Centros');
figure (1)
xl = length(posx);
for ixl = 1:xl
    plot(X(posx(ixl),posy(ixl)),Y(posx(ixl),posy(ixl)), 'k*');
    hold on;
end
