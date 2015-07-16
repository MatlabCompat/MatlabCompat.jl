#The code generated need further corrections by you. Execute it line by line and correct the errors.
# Copyright © Vardan Andriasyan, Yauhen Yakimovich, Artur Yakimovich 2015
# MIT license.
#
# Permission is hereby granted, free of charge, to any person
# obtaining a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including without
# limitation the rights to use, copy, modify, merge, publish, distribute,
# sublicense, and/or sell copies of the Software, and to permit persons to whom
# the Software is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

using MatlabCompat

using MatlabCompat.ImageTools

using MatlabCompat.MathTools

using Images,FixedPointNumbers

numberOfIterations = 1000;
innerExecutionTimes = Float64[0];
outerExecutionTimes = Float64[0];
img = imread("C:\\Users\\Vardan\\Documents\\Julia\\matlabcompat.github.io\\img\\example.tif");

function simpleJanus()
  threshold = graythresh(img); # compute graysacale threshold using Otsu algorithm
  imgbw = im2bw(img, threshold); # create a binary image based on the graysacel image
  labeledbw = bwlabel(imgbw, 4); # lable each connected object in the image
  numberOfCells = max(reshape(labeledbw, 1,numel(labeledbw))); # count cells
  #disp(strcat("number of objects:", num2str(numberOfCells)));
end


function forSimpleJanus()
  numberOfIterations = 1000;
  for j=1:numberOfIterations
    simpleJanus();
  end
end




for i=1:numberOfIterations
  inner = @elapsed(simpleJanus());
  push!(innerExecutionTimes, inner);
end


for i=1:numberOfIterations
  outer =  @elapsed(forSimpleJanus());
  push!(outerExecutionTimes,outer);
end

println([median(innerExecutionTimes) std(innerExecutionTimes)])
print([median(outerExecutionTimes)  std(outerExecutionTimes)])

