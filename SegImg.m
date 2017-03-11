
clear all;
close all;
clc;

% Get the Input Eye Image with any Format
[namefile,pathname]=uigetfile({'*.bmp;*.tif;*.tiff;*.jpg;*.jpeg;*.gif','IMAGE Files (*.bmp,*.tif,*.tiff,*.jpg,*.jpeg,*.gif)'},'Choose grayscale Image');
InImg=imread(strcat(pathname,namefile));
figure,imshow(InImg);  %Displays the eye image
title('Input Eye Image');
Si=ndims(InImg); %Find the number of dimensions

if Si>2
    InImg=rgb2gray(InImg);% rgb is converted to gray
end
load Datas.mat;

% find the iris boundary
[row, col, r] = findcircle(InImg, lirisradius, uirisradius, scaling, 2, 0.20, 0.19, 1.00, 0.00);% gives coordinates of circle

IrisOut = [row col r];
rowd = double(row);
cold = double(col);% conversion
rd = double(r);

%Iris Boundary
irl = round(rowd-rd);
iru = round(rowd+rd);
icl = round(cold-rd);
icu = round(cold+rd);
ImgIrs = InImg( irl:iru,icl:icu);
figure,imshow(uint8(ImgIrs));
title('Segmented Iris');