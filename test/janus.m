% Janus is a minimalistic model image
% analysis script aimed
% to work in Julia and MATLAB without
% changing its syntax
%
% Copyright © Vardan Andriasyan, Yauhen Yakimovich, Artur Yakimovich 2015
 
img = imread('http://matlabcompat.github.io/img/example.tif'); % read the remote image
threshold = graythresh(img);
imgbw = im2bw(img, threshold); % this is also a comment, but no quotes here
imshow(imgbw);
%sprintf('%s %s', 'Hello', 'World') % and here is a comment
