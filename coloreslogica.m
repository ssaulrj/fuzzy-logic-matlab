close all;
clear all;
clc;

color = imread('x8.jpg');
% color = imread('mem2.jpg');

% color = im2double(color); %op
figure(1);
subplot(3,2,1);
color = imresize(color, [240,320]);

imshow(color); % si esta en u8

gris = rgb2gray(color); % convertir en escala de grises
% imshow(gris);

subplot(3,2,2);
bin1 = gris<120;
imshow(bin1);

subplot(3,2,3);
bin2 = gris>120;
imshow(bin2);

subplot(3,2,4);
% imhist(gris);
histogram(gris);

subplot(3,2,5);
mesh(gris);

%Información de color
matrizR = color(:,:,1);
matrizG = color(:,:,2);
matrizB = color(:,:,3);

figure(2);
plot3(matrizR,matrizG,matrizB,'x');
