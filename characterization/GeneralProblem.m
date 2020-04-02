clear all;
clc; 
%--------------------------------------------------------------------------
lim1 = 359;
xx = [0:lim1];
lim2 = 2;
xx2 = [0:lim2];
lim3 = 100;
xx3 = [0:lim3];

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
