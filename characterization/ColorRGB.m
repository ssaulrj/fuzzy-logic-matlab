clear all;
clc; 
%--------------------------------------------------------------------------
xx = [0:255];
% yy = [0:255];
% zz = [0:255];
gg = [0:255];
%--------------------------------------------------------------------------
as = 0.05;
cs = 85;
ccamp = 128;
acamp = 30;
bcamp = 1.2;
as2 = 0.05;
cs2 = 171;
sigmoide1x = 1 ./ ( 1+( exp(-as.*(xx-cs)) ) );
sigmoidex = 1 - sigmoide1x;
campana1x = 1 ./ ( 1 + ( (abs( (xx - ccamp) ./ acamp )).^(2*bcamp) ) );
sigmoidex2 = 1 ./ ( 1+( exp(-as2.*(xx-cs2)) ) );
%--------------------------------------------------------------------------
sigmoide3x = 1 ./ ( 1+( exp(-as.*(xx-cs)) ) );
sigmoidex3 = 1 - sigmoide3x;
campana2x = 1 ./ ( 1 + ( (abs( (xx - ccamp) ./ acamp )).^(2*bcamp) ) );
sigmoidex4 = 1 ./ ( 1+( exp(-as2.*(xx-cs2)) ) );
%--------------------------------------------------------------------------
sigmoide5x = 1 ./ ( 1+( exp(-as.*(xx-cs)) ) );
sigmoidex5 = 1 - sigmoide5x;
campana3x = 1 ./ ( 1 + ( (abs( (xx - ccamp) ./ acamp )).^(2*bcamp) ) );
sigmoidex6 = 1 ./ ( 1+( exp(-as2.*(xx-cs2)) ) );
%--------------------------------------------------------------------------
sigmoide1g = 1 ./ ( 1+( exp(-as.*(gg-cs)) ) );
sigmoidegg = 1 - sigmoide1g;
campanagg = 1 ./ ( 1 + ( (abs( (gg - ccamp) ./ acamp )).^(2*bcamp) ) );
sigmoidegg2 = 1 ./ ( 1+( exp(-as2.*(gg-cs2)) ) );
%--------------------------------------------------------------------------
figure(1);
subplot(2,2,1); 
plot(xx, sigmoidex, xx, campana1x, xx, sigmoidex2);            
title('R');   
ylabel('Grado membresia');
xlabel('r'); 
xlim([0 255])
ylim([-.2 1.2])
% lgd = legend('Bebes/Niños','Jovenes','Adultos','Adultos mayores');
grid on;

subplot(2,2,2); 
plot(xx, sigmoidex3, xx, campana2x, xx, sigmoidex4);            
title('G');   
ylabel('Grado membresia');
xlabel('g');
xlim([0 255])
ylim([-.2 1.2])
% lgd = legend('Bebes/Niños','Jovenes','Adultos','Adultos mayores');
grid on;

subplot(2,2,3); 
plot(xx, sigmoidex5, xx, campana3x, xx, sigmoidex6);            
title('B');   
ylabel('Grado membresia');
xlabel('b'); 
xlim([0 255])
ylim([-.2 1.2])
% lgd = legend('Bebes/Niños','Jovenes','Adultos','Adultos mayores');
grid on;

subplot(2,2,4); 
plot(gg, sigmoidegg, gg, campanagg, gg, sigmoidegg2);            
title('Escala de grises');   
ylabel('Grado membresia');
xlabel('g'); 
xlim([0 255])
ylim([-.2 1.2])
% lgd = legend('Bebes/Niños','Jovenes','Adultos','Adultos mayores');
grid on;
%--------------------------------------------------------------------------
conta = 1;
for r = 1:255
    for g = 1:255
        for b = 1:255
            rsurfr(conta) = r;
            gsurfg(conta) = g;
            bsurfb(conta) = b;
            valorr1 = sigmoidex(r);  %uR1(r)
            valorr2 = campana1x(r);  %uR2(r)
            valorr3 = sigmoidex2(r); %uR3(r)
            valorg1 = sigmoidex3(g); %uG1(g)
            valorg2 = campana2x(g);  %uG2(g)
            valorg3 = sigmoidex4(g); %uG3(g)
            valorb1 = sigmoidex5(g); %uB1(b)
            valorb2 = campana3x(g);  %uB2(b)
            valorb3 = sigmoidex6(g); %uB3(b)
            %------------------------------------------------------------------
            %Reglas
            minR1 = min([valorr1,valorg1,valorb1]); 
            minR2 = min([valorr1,valorg1,valorb2]); 
            minR3 = min([valorr1,valorg1,valorb3]); 
            minR4 = min([valorr1,valorg2,valorb1]); 
            minR5 = min([valorr1,valorg2,valorb2]); 
            minR6 = min([valorr1,valorg2,valorb3]); 
            minR7 = min([valorr1,valorg3,valorb1]); 
            minR8 = min([valorr1,valorg3,valorb2]); 
            minR9 = min([valorr1,valorg3,valorb3]); 
            minR10= min([valorr2,valorg1,valorb1]); 
            minR11= min([valorr2,valorg1,valorb2]); 
            minR12= min([valorr2,valorg1,valorb3]); 
            minR13= min([valorr2,valorg2,valorb1]); 
            minR14= min([valorr2,valorg2,valorb2]); 
            minR15= min([valorr2,valorg2,valorb3]); 
            minR16= min([valorr2,valorg3,valorb1]); 
            minR17= min([valorr2,valorg3,valorb2]); 
            minR18= min([valorr2,valorg3,valorb3]); 
            minR19= min([valorr3,valorg1,valorb1]); 
            minR20= min([valorr3,valorg1,valorb2]); 
            minR21= min([valorr3,valorg1,valorb3]); 
            minR22= min([valorr3,valorg2,valorb1]); 
            minR23= min([valorr3,valorg2,valorb2]); 
            minR24= min([valorr3,valorg2,valorb3]); 
            minR25= min([valorr3,valorg3,valorb1]); 
            minR26= min([valorr3,valorg3,valorb2]); 
            minR27= min([valorr3,valorg3,valorb3]); 
            %tableinf = [minR1 minR3;
            %            minR2 minR4];
            corte_z1 = max([minR1,minR2,minR3,minR4,minR7,minR10,minR19]);
            corte_z2 = max([minR5,minR6,minR8,minR11,minR12,minR13,minR14,minR15,minR16,minR17,minR20,minR22,minR23,minR25]);
            corte_z3 = max([minR9,minR18,minR21,minR24,minR26,minR27,]);
            
            ct2 =  max(min(sigmoidegg,corte_z1),min(campanagg,corte_z2));
            corte_total = max(ct2,min(sigmoidegg2,corte_z3));
            %------------------------------------------------------------------
            z1 = 0;
            z2 = 0;
            for xw = 1:256 
                    z1 = z1 + (corte_total(xw).*(xw));
                    z2 = z2 + (corte_total(xw));
            end
            zsum = z1./z2;
            zsurfz(conta)= zsum;
            conta = conta + 1;
        end
    end
end
conta
%--------------------------------------------------------------------------
% [xsurfxx,ysurfyy] = meshgrid(xsurfx, ysurfy);
zzzx = zsurfz;
% zzzx = griddata(xsurfx, ysurfy, zsurfz, xsurfxx, ysurfyy);
% surf(xsurfxx, ysurfyy, );

tri = delaunay(rsurfr,gsurfg); %x,y,z column vectors
trisurf(tri,rsurfr,gsurfg,zzzx);
xlabel('r');
ylabel('g');
zlabel('z');
title('Desdifusificación rgb')
%--------------------------------------------------------------------------
