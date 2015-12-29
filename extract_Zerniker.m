% Based on http://people.tamu.edu/~amir.tahmasbi/projects.html#zernike
% Used for image retrieval based on Zernike moment
% Test database: mpeg-7 dataset
% Author: yongyuan.name

clc; clear all; close all;

nm = [0, 0; 1, 1; 2, 0; 2, 2; 3, 1; 3, 3; 4, 0; 4, 2; 4, 4; 5, 1; 5, 3; 5, 5;
    6, 0; 6, 2; 6, 4; 6, 6; 7, 1; 7, 3; 7, 5; 7, 7; 8, 0; 8, 2; 8, 4; 8, 6; 8, 8];

%% Step 1 lOADING PATHS
path_imgDB = './database/';
addpath(path_imgDB);
addpath tools;

%% Step 2 LOADING IMAGE AND EXTRACTING FEATURE
imgFiles = dir(path_imgDB);
imgNamList = {imgFiles(~[imgFiles.isdir]).name};
clear imgFiles;
imgNamList = imgNamList';

numImg = length(imgNamList);
feat = zeros(numImg, size(nm,1));
rgbImgList = {};

for i = 1:numImg
   image = imread(imgNamList{i, 1}); 
   image = logical(image);
   image = imresize(image, [250, 250]);
   for j = 1:size(nm,1)
       [~, feat(i,j), ~] = Zernikmoment(image, nm(j,1), nm(j,2)); 
   end
   fprintf('extract %d image\n\n', i);
end

feat_norm = normalize1(feat);
save('Zernike.mat','feat_norm', 'imgNamList', '-v7.3');