close all; clear all; clc;
% Adquisición de datos
dat = fopen('IrisDataBase.dat');
IrisDataBase = textscan(dat, '%f %f %f %f %s');
fclose(dat);
Datos(:,1)=IrisDataBase{2};
Datos(:,2)=IrisDataBase{3};
Datos(:,3)=IrisDataBase{4};
% figure(1)
% plot3(Datos(:,1),Datos(:,2),Datos(:,3),'.')
% grid on;
DatosS=Datos(1:50,:);%Datos Iris-setosa
DatosVS=Datos(51:100,:); %Datos Iris-versicolour
DatosV=Datos(101:150,:);%Datos Iris-virginica
figure(2)
hold on;
plot(DatosS(:,1),DatosS(:,2),'xr',DatosVS(:,1),DatosVS(:,2),'xg',DatosV(:,1),DatosV(:,2),'xb');
Datosx = [DatosS(:,1).' DatosVS(:,1).' DatosV(:,1).'];
Datosy = [DatosS(:,2).' DatosVS(:,2).' DatosV(:,2).'];
figure(4)
plot(Datosx, Datosy,'xb')
hold on;
% plot(DatosVS(:,1),DatosVS(:,2),'xg')
% plot(DatosV(:,1),DatosV(:,2),'xb')
grid on;

x = Datosx;
y = Datosy;

[mx,nx]=size(x);
centros = 3;
for ix = 1:nx
    lugarx = floor(centros*rand(1,1)+1);
    if lugarx == 1
        u(1,ix) = 1;
        u(2,ix) = 0;
        u(3,ix) = 0;
    elseif lugarx == 2
        u(1,ix) = 0;
        u(2,ix) = 1;
        u(3,ix) = 0;
    elseif lugarx == 3
        u(1,ix) = 0;
        u(2,ix) = 0;
        u(3,ix) = 1;
    end
end

[m,n]=size(u);
ufinal = zeros(m,n);
fin = 0; 
Uaux=zeros(m,n);
Ufinal=zeros(m,n);
cuanto = 0;
while 1 
    for i = 1:m
        vtotal = 0;
        vijx = 0;
        vijy = 0;
        for j = 1:n
            vijx = vijx + u(i,j)*x(j);
            vijy = vijy + u(i,j)*y(j);
            vtotal = vtotal + u(i,j);
        end
        vx(:,i) = vijx/vtotal;
        vy(:,i) = vijy/vtotal;
        hold on;
    end

%Distancias entre centroides y datos
    for ii = 1:m
        for jj = 1:n
            d(ii,jj) = sqrt( (x(jj)-vx(1,ii)).^2 + (y(jj)-vy(1,ii)).^2 );
        end
    end

    uactfin = zeros(m,n);
    
   for jj = 1:n
            miu1(1,jj)=((d(1,jj)/d(1,jj))^2+(d(1,jj)/d(2,jj))^2+(d(1,jj)/d(3,jj))^2)^-1;
            miu2(2,jj)=((d(2,jj)/d(1,jj))^2+(d(2,jj)/d(2,jj))^2+(d(2,jj)/d(3,jj))^2)^-1;
            miu3(3,jj)=((d(3,jj)/d(1,jj))^2+(d(3,jj)/d(2,jj))^2+(d(3,jj)/d(3,jj))^2)^-1;
%             miu1(1,jj)=((dist1(k)/dist1(k))^2+(dist1(k)/dist2(k))^2+(dist1(k)/dist3(k))^2)^-1;
%             miu2(2,jj)=((dist2(k)/dist1(k))^2+(dist2(k)/dist2(k))^2+(dist2(k)/dist3(k))^2)^-1;
%             miu3(3,jj)=((dist3(k)/dist1(k))^2+(dist3(k)/dist2(k))^2+(dist3(k)/dist3(k))^2)^-1;
            Uaux(1,jj) = miu1(jj);
            Uaux(2,jj) = miu2(jj);
            Uaux(3,jj) = miu3(jj);
   end
    
%     ufinal = uactfin;
    
    if round(u,3) == round(Uaux,3)
    % if (sum(sum(eq(U,Uaux)))==8)
        finalx = 1;
        figure(2)
        plot(vx, vy,'ok','LineWidth', 3);
        break;
    else 
        u = Uaux
        cuanto= cuanto+1;
    end
end
