clear all;
close all;
clc; 
%--------------------------------------------------------------------------
xx = [0:43];
yy = [0:55];
zz = [-10:10];
%--------------------------------------------------------------------------
as = 0.7;
cs = 20;
sigmoide1 = 1 ./ ( 1+( exp(-as.*(xx-cs)) ) );
sigmoide11 = 1 - sigmoide1;
as2 = 0.7;
cs2 = 25;
sigmoide2 = 1 ./ ( 1+( exp(-as2.*(xx-cs2)) ) );
%--------------------------------------------------------------------------
as3 = 0.7;
cs3 = 25;
sigmoide3 = 1 ./ ( 1+( exp(-as3.*(yy-cs3)) ) );
sigmoide33 = 1 - sigmoide3;
as4 = 0.7;
cs4 = 30;
sigmoide4 = 1 ./ ( 1+( exp(-as4.*(yy-cs4)) ) );
%--------------------------------------------------------------------------
as5 = 0.7;
cs5 = -5;
sigmoide5 = 1 ./ ( 1+( exp(-as5.*(zz-cs5)) ) );
sigmoide55 = 1 - sigmoide5;
as6 = 0.7;
cs6 = 5;
sigmoide6 = 1 ./ ( 1+( exp(-as6.*(zz-cs6)) ) );
%--------------------------------------------------------------------------

figure(1)
%Input---------------------------------------------------------------------
% subplot(2,2,1);    
plot(xx, sigmoide11, xx, sigmoide2);            
title('X');   
ylabel('Grado membresia');
xlabel('º'); 
ylim([-.1 1.1]);
xlim([0 43]);
lgd = legend('A1','A2');
grid on;

figure(2)
plot(yy, sigmoide33, yy, sigmoide4);            
title('Y');   
ylabel('Grado membresia');
xlabel('º'); 
ylim([-.1 1.1]);
xlim([0 55]);
lgd = legend('B1','B2');
grid on;

%Output--------------------------------------------------------------------
% subplot(2,2,2);    
figure(3)
plot(zz, sigmoide55, zz, sigmoide6);            
title('Z');   
ylabel('Grado membresia');
xlabel('º'); 
ylim([-.1 1.1]);
lgd = legend('C1','C2');
grid on;

conta = 1;
for x = 1:43
    for y = 1:55
        xsurfx(conta) = x;
        ysurfy(conta) = y;
        valorx1 = sigmoide11(x); %uA1(x)
        valorx2 = sigmoide2(x);  %uA2(x)
        valory1 = sigmoide33(y); %uB1(y)
        valory2 = sigmoide4(y);  %uB2(y)
        %------------------------------------------------------------------
        %Reglas
        w1 = min(valorx1,valory1); %A1 Y B1 , C1
        w2 = min(valorx1,valory2); %A1 Y B2 , C2
        w3 = min(valorx2,valory1); %A2 Y B1 , C1
        w4 = min(valorx2,valory2); %A2 Y B2 , C1
       
        %tableinf = [minR1-C1 minR3-C1;
        %            minR2-C2 minR4-C1];
        %------------------------------------------------------------------
        rangox = .25;
        
        ii = 0;
        for i= 1:21
             z1 = sigmoide55(i);
             if (w1 <= z1+(z1*rangox) && w1 >= z1-(z1*rangox))
                 ii = i;
                 break;
             end
        end
        z1 = ii-11; 
        
        ii = 0;
        for i= 1:21
             z2 = sigmoide6(i);
             if (w2 <= z2+(z2*rangox) && w2 >= z2-(z2*rangox))
                 ii = i;
                 break;
             end
        end
        z2 = ii-11; 
        
        ii = 0;
        for i= 1:21
             z3 = sigmoide55(i);
             if (w3 <= z3+(z3*rangox) && w3 >= z3-(z3*rangox))
                 ii = i;
                 break;
             end
        end
        z3 = ii-11; 
        
        ii = 0;
        for i= 1:21
             z4 = sigmoide55(i);
             if (w4 <= z4+(z4*rangox) && w4 >= z4-(z4*rangox))
                 ii = i;
                 break;
             end
        end
        z4 = ii-11; 
        
        zsum = ((w1.*z1)+(w2.*z2)+(w3.*z3)+(w4.*z4))./(w1+w2+w3+w4);
        zsurfz(conta)= zsum;
        conta = conta + 1;
    end
end
%--------------------------------------------------------------------------
figure(4)
zzzx = zsurfz;
tri = delaunay(xsurfx,ysurfy); %x,y,z column vectors
trisurf(tri,xsurfx,ysurfy,zzzx);
xlabel('x');
ylabel('y');
zlabel('z');
title('Desdifusificación x y z')
%--------------------------------------------------------------------------
