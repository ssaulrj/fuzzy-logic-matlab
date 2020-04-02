clear all;
clc; 
%--------------------------------------------------------------------------
xx = [0:43];
yy = [0:55];
zz = [-10:10];
%--------------------------------------------------------------------------
as = 0.7;
cs = 20;
sigmoide1 = 1 ./ ( 1+( exp(-as.*(xx-cs)) ) );
sigmoide2 = 1 - sigmoide1;
as2 = 0.7;
cs = 25;
sigmoide3 = 1 ./ ( 1+( exp(-as.*(xx-cs)) ) );
%--------------------------------------------------------------------------
ccamp = 10;
acamp = 11;
bcamp = 1.2;
campana1 = 1 ./ ( 1 + ( (abs( (yy - ccamp) ./ acamp )).^(2*bcamp) ) );
ccamp2 = 45;
acamp2 = 11;
bcamp2 = 1.2;
campana2 = 1 ./ ( 1 + ( (abs( (yy - ccamp2) ./ acamp2 )).^(2*bcamp2) ) );
%--------------------------------------------------------------------------
ccamp3 = -7;
acamp3= 4;
bcamp3 = 1.4;
campana3 = 1 ./ ( 1 + ( (abs( (zz - ccamp3) ./ acamp3 )).^(2*bcamp3) ) );
ccamp4 = 7;
acamp4= 4;
bcamp4 = 1.4;
campana4 = 1 ./ ( 1 + ( (abs( (zz - ccamp4) ./ acamp4 )).^(2*bcamp4) ) );
%--------------------------------------------------------------------------
conta = 1;
for x = 1:43
    for y = 1:55
        xsurfx(conta) = x;
        ysurfy(conta) = y;
        valorx1 = sigmoide2(x); %uA1(x)
        valorx2 = sigmoide3(x); %uA2(x)
        valory1 = campana1(y);  %uB1(y)
        valory2 = campana2(y);  %uB2(y)
        %------------------------------------------------------------------
        %Reglas
        minR1 = min(valorx1,valory1);
        minR2 = min(valorx1,valory2);
        minR3 = min(valorx2,valory1);
        minR4 = min(valorx2,valory2);
        %tableinf = [minR1 minR3;
        %            minR2 minR4];
        corte_c1 = max([minR1,minR3,minR4]);
        corte_c2 = max(minR2);  
        corte_total = max(min(campana3,corte_c1),min(campana4,corte_c2));
        %------------------------------------------------------------------
        z1 = 0;
        z2 = 0;
        for xw = 1:21 
                z1 = z1 + (corte_total(xw).*(xw-11));
                z2 = z2 + (corte_total(xw));
        end
        zsum = z1./z2;
        zsurfz(conta)= zsum;
        conta = conta + 1;
    end
end
%--------------------------------------------------------------------------
% [xsurfxx,ysurfyy] = meshgrid(xsurfx, ysurfy);
zzzx = zsurfz;
% zzzx = griddata(xsurfx, ysurfy, zsurfz, xsurfxx, ysurfyy);
% surf(xsurfxx, ysurfyy, );

tri = delaunay(xsurfx,ysurfy); %x,y,z column vectors
trisurf(tri,xsurfx,ysurfy,zzzx);
xlabel('x');
ylabel('y');
zlabel('z');
title('Desdifusificación x y z')
%--------------------------------------------------------------------------
