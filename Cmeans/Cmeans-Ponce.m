clc;
clear all;
close all;
% conjunto de puntos
x=[1 4 4 5.5];
y=[1 1 2 1];
% matriz inicial para dos clusters
U=[0 0 1 1; 1 1 0 0];
Uaux=zeros(2,4);
Ufinal=zeros(2,4);

finalx = 0;
cuanto = 0;
while 1
    clf(figure(1));
    a=1;
    b=1;
    figure(1)
    plot(x,y,'*');
    hold on
    % calculo de centroides de cada cluster
    for x1=1:2
        clusx(:,x1)=((U(x1,a)*x(a))+(U(x1,a+1)*x(a+1))+(U(x1,a+2)*x(a+2))+(U(x1,a+3)*x(a+3)))/(U(x1,a)+U(x1,a+1)+U(x1,a+2)+U(x1,a+3));
        clusy(:,x1)=((U(x1,a)*y(a))+(U(x1,a+1)*y(a+1))+(U(x1,a+2)*y(a+2))+(U(x1,a+3)*y(a+3)))/(U(x1,a)+U(x1,a+1)+U(x1,a+2)+U(x1,a+3));
        clusterT(:,b)=clusx(x1);
        b=b+1;
        clusterT(:,b)=clusy(x1);
        b=b+1;
        plot(clusx(x1),clusy(x1),'o');
    end

    clusterT;
    % obtener distacias entre los centroides y los datos
    for d=1:4
        dist1(:,d)=sqrt((x(d)-clusterT(a))^2+(y(d)-clusterT(a+1))^2);
        dist2(:,d)=sqrt((x(d)-clusterT(a+2))^2+(y(d)-clusterT(a+3))^2);
    end
    % actualizar matriz U
    for k=1:4
        miu1(:,k)=((dist1(k)/dist1(k))^2+(dist1(k)/dist2(k))^2)^-1;
        miu2(:,k)=((dist2(k)/dist1(k))^2+(dist2(k)/dist2(k))^2)^-1;
        Uaux(1,k) = miu1(:,k);
        Uaux(2,k) = miu2(:,k);
    end
    
    Uaux 

    if round(U,3) == round(Uaux,3)
    % if (sum(sum(eq(U,Uaux)))==8)
        finalx = 1
        break;
    else 
        U = Uaux
        cuanto= cuanto+1;
    end 
end

% plot(x,y,'*');
% hold on
% plot(clusx,clusy,'o');
grid on;
xlim([0 6]);
ylim([0 4]);
