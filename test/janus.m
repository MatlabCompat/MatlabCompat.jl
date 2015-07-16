% Janus is a minimalistic model image
% analysis script aimed
% to work in Julia and MATLAB without
% changing its syntax
%
% Copyright � Vardan Andriasyan, Yauhen Yakimovich, Artur Yakimovich 2015
% MIT license.
%
% Permission is hereby granted, free of charge, to any person
% obtaining a copy of this software and associated documentation files (the
% "Software"), to deal in the Software without restriction, including without
% limitation the rights to use, copy, modify, merge, publish, distribute,
% sublicense, and/or sell copies of the Software, and to permit persons to whom
% the Software is furnished to do so, subject to the following conditions:
%
% The above copyright notice and this permission notice shall be included in all
% copies or substantial portions of the Software.
%
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
% SOFTWARE.
tic()
img = imread('http://matlabcompat.github.io/img/example.tif'); % read the remote image
%img = imread('D:\github\matlabcompat.github.io\img\example.tif');
threshold = graythresh(img); % compute graysacale threshold using Otsu algorithm
imgbw = im2bw(img, threshold); % create a binary image based on the grayscale image
imshow(imgbw); % display the resulting binary image
labeledbw = bwlabel(imgbw, 4); % lable each connected object in the image
numberOfCells = max(reshape(labeledbw, 1,numel(labeledbw))); % count cells
disp(strcat('number of objects:', num2str(numberOfCells)));% display the number of objects
imshow(label2rgb(labeledbw,'jet',[0 0 0],'shuffle'));
toc()

