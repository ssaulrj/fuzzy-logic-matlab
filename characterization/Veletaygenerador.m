clear all;
clc; 
%--------------------------------------------------------------------------
lim1 = 359;
xx = 0:lim1;
lim2 = 20;
xx2 = 0:lim2;
lim3 = 100;
xx3 = 0:lim3;

%Posveleta-----------------------------------------------------------------
xpvel0 = 1 - ( fun0(lim1,22.5,67.5) );
xpvelT = funtrap(lim1,22.5,67.5,112.5,157.5);
xpvelT2 = funtrap(lim1,112.5,157.5,202.5,247.5);
xpvelT3 = funtrap(lim1,202.5,247.5,292.5,337.5);
xpvel1 = fun0(lim1, 292.5,337.5);

%Posgenerador--------------------------------------------------------------
xgen0 = 1 - ( fun0(lim1,22.5,67.5) );
xgenT = funtrap(lim1,22.5,67.5,112.5,157.5);
xgenT2 = funtrap(lim1,112.5,157.5,202.5,247.5);
xgenT3 = funtrap(lim1,202.5,247.5,292.5,337.5);
xgen1 = fun0(lim1, 292.5,337.5);

%Sentidogirog--------------------------------------------------------------
xsen0 = 1 - ( fun0(lim2,6,9) );
xsenT = funtrap(lim2,6,9,11,14);
xsen1 = fun0(lim2, 11,14);

%Velocidadg----------------------------------------------------------------
xvel0 = 1 - ( fun0(lim3,25,37.5) );
xvelT = funtrap(lim3,25,37.5,62.5,75);
xvel1 = fun0(lim3,62.5,75);

figure(1)
%Input---------------------------------------------------------------------
subplot(2,2,1);    
plot(xx, xpvel0, xx, xpvelT, xx, xpvelT2, xx, xpvelT3, xx, xpvel1);            
title('Posveleta, funciones discretas');   
ylabel('Grado membresia');
xlabel('º'); 
ylim([-.1 1.1]);
lgd = legend('NorteE_v','Este_v','Sur_v','Oeste_v','NorteO_v');
grid on;

subplot(2,2,3);    
plot(xx, xgen0, xx, xgenT, xx, xgenT2, xx, xgenT3, xx, xgen1);            
title('Posgenerador, funciones discretas');   
ylabel('Grado membresia');
xlabel('º'); 
ylim([-.1 1.1]);
lgd = legend('NorteE_g','Este_g','Sur_g','Oeste_g','NorteO_g');
grid on;

%Output--------------------------------------------------------------------
subplot(2,2,2);     
plot(xx2, xsen0, xx2, xsenT, xx2, xsen1);            
title('Sentidogiro_g, funciones discretas');   
ylabel('Grado membresia');
xlabel('x'); 
ylim([-.1 1.1]);
lgd = legend('Horario_g','No mover_g','Antihorario_g');
grid on;

subplot(2,2,4);     
plot(xx3, xvel0, xx3, xvelT, xx3, xvel1);            
title('Velocidad_g, funciones discretas');   
ylabel('Grado membresia');
xlabel('rpm'); 
ylim([-.1 1.1]);
lgd = legend('Lenta_g','Media_g','Rapida_g');
grid on;
%--------------------------------------------------------------------------
conta = 1;
for x = 1:360
    for y = 1:360
%         x1(xy) = input('Ingrese valor universo x: ');
%         y1(xy) = input('Ingrese valor universo y: ');
        %------------------------------------------------------------------
        xsurfx(conta) = x;
        ysurfy(conta) = y;
        valorx1 = xpvel0(x); %uX1(x)
        valorx2 = xpvelT(x); %uX2(x)
        valorx3 = xpvelT2(x);%uX3(x)
        valorx4 = xpvelT3(x);%uX4(x)
        valorx5 = xpvel1(x); %uX5(x)
        
        valory1 = xgen0(y);  %uY1(y)
        valory2 = xgenT(y);  %uY2(y)
        valory3 = xgenT2(y); %uY3(y)
        valory4 = xgenT3(y); %uY4(y)
        valory5 = xgen1(y);  %uY5(y)
        %------------------------------------------------------------------
        %Reglas
        minRx1y1 = min(valorx1,valory1);
        minRx1y2 = min(valorx1,valory2);
        minRx1y3 = min(valorx1,valory3);
        minRx1y4 = min(valorx1,valory4);
        minRx1y5 = min(valorx1,valory5);
        
        minRx2y1 = min(valorx2,valory1);
        minRx2y2 = min(valorx2,valory2);
        minRx2y3 = min(valorx2,valory3);
        minRx2y4 = min(valorx2,valory4);
        minRx2y5 = min(valorx2,valory5);
 
        minRx3y1 = min(valorx3,valory1);
        minRx3y2 = min(valorx3,valory2);
        minRx3y3 = min(valorx3,valory3);
        minRx3y4 = min(valorx3,valory4);
        minRx3y5 = min(valorx3,valory5);
        
        minRx4y1 = min(valorx4,valory1);
        minRx4y2 = min(valorx4,valory2);
        minRx4y3 = min(valorx4,valory3);
        minRx4y4 = min(valorx4,valory4);
        minRx4y5 = min(valorx4,valory5);
        
        minRx5y1 = min(valorx5,valory1);
        minRx5y2 = min(valorx5,valory2);
        minRx5y3 = min(valorx5,valory3);
        minRx5y4 = min(valorx5,valory4);
        minRx5y5 = min(valorx5,valory5);
        %tableinf = [minRx1y1 minRx2y1 minRx3y1 minRx4y1 minRx5y1;
        %            minRx1y2 minRx2y2 minRx3y2 minRx4y2 minRx5y2;
        %            minRx1y3 minRx2y3 minRx3y3 minRx4y3 minRx5y3;
        %            minRx1y4 minRx2y4 minRx3y4 minRx4y4 minRx5y4;
        %            minRx1y5 minRx2y5 minRx3y5 minRx4y5 minRx5y5];
        %------------------------------------------------------------------
        %Solution funcion max() many arguments, pasar como vector = max([])
        %Sentido giro
        %Horario
        %NM
        %Antihorario
        corte_c1 = max([minRx2y1,minRx3y1,minRx3y2,minRx4y2,minRx4y3,minRx5y3,minRx1y4,minRx5y4,minRx2y5]); 
        corte_c2 = max([minRx1y1,minRx5y1,minRx2y2,minRx3y3,minRx4y4,minRx1y5,minRx5y5]);  
        corte_c3 = max([minRx4y1,minRx1y2,minRx5y2,minRx1y3,minRx2y3,minRx2y4,minRx3y4,minRx3y5,minRx4y5]);
        
        ct1 = min(xsen0,corte_c1);
        ct2 = min(xsenT,corte_c2);
        ct3 = min(xsen1,corte_c3);
        
        ctx = max (ct1,ct2);
        corte_totalgiro = max( ctx , ct3 );
        
        %------------------------------------------------------------------
        %Velocidad
        %Lenta
        %Media
        %Rapida
        %tableinf = [minRx1y1 minRx2y1 minRx3y1 minRx4y1 minRx5y1;
        %            minRx1y2 minRx2y2 minRx3y2 minRx4y2 minRx5y2;
        %            minRx1y3 minRx2y3 minRx3y3 minRx4y3 minRx5y3;
        %            minRx1y4 minRx2y4 minRx3y4 minRx4y4 minRx5y4;
        %            minRx1y5 minRx2y5 minRx3y5 minRx4y5 minRx5y5];
        corte_c1v = max([minRx1y1,minRx5y1,minRx2y2,minRx3y3,minRx4y4,minRx1y5,minRx5y5]); 
        corte_c2v = max([minRx2y1,minRx4y1,minRx1y2,minRx3y2,minRx5y2,minRx2y3,minRx4y3,minRx1y4,minRx3y4,minRx5y4,minRx2y5,minRx4y5]);  
        corte_c3v = max([minRx3y1,minRx4y2,minRx1y3,minRx5y3,minRx2y4,minRx3y5]);
        
        ctv1 = min(xvel0,corte_c1v);
        ctv2 = min(xvelT,corte_c2v);
        ctv3 = min(xvel1,corte_c3v);
    
        ctvx = max (ctv1,ctv2);
        corte_totalvel = max( ctvx , ctv3 );
        %------------------------------------------------------------------
        z1 = 0;
        z2 = 0;
        for xw = 1:21 
                z1 = z1 + (corte_totalgiro(xw).*(xw));
                z2 = z2 + (corte_totalgiro(xw));
        end
        zsum = z1./z2;
        zsurfz(conta)= zsum;
        %------------------------------------------------------------------
        z1v = 0;
        z2v = 0;
        for xwv = 1:101 
                z1v = z1v + (corte_totalvel(xwv).*(xwv));
                z2v = z2v + (corte_totalvel(xwv));
        end
        zsumv = z1v./z2v;
        zsurfzv(conta)= zsumv;
        %------------------------------------------------------------------
        conta = conta + 1;
    end
end
%--------------------------------------------------------------------------
% [xsurfxx,ysurfyy] = meshgrid(xsurfx, ysurfy);
figure(1);
zzzx = zsurfz;
tri = delaunay(xsurfx,ysurfy); %x,y,z column vectors
trisurf(tri,xsurfx,ysurfy,zzzx);
xlabel('x');
ylabel('y');
zlabel('z');
title('Desdifusificación Sentido giro')
%--------------------------------------------------------------------------
figure(2);
zzzxv = zsurfzv;
triv = delaunay(xsurfx,ysurfy); %x,y,z column vectors
trisurf(triv,xsurfx,ysurfy,zzzxv);
xlabel('x');
ylabel('y');
zlabel('z');
title('Desdifusificación Velocidad')
%--------------------------------------------------------------------------
