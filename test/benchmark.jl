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



function graythresh2(img)


  #Check whether the input image is empty
  if isempty(img)
    error("Image is empty");
  end
  #Check whether the input image is gray

  if Images.colorspace(img) != "Gray"
    error("Input Image should be grayscale")
  end

  if isa(raw(img),Array{Uint16,2})
    #Convert image to 8bit and return it's raw values to compute the histogram
    image_array = map(Images.BitShift(Uint8,8),raw(img));
  elseif isa(raw(img),Array{Uint8,2})
    image_array = raw(img);
  else
    warn("Input Image is neither Uint8 or Uint16");
    image_array = raw(img);
  end
  #image_array = raw(img)



  expected_number_of_bins = 2^8;


 (range, counts) = hist(reshape(image_array,length(image_array)),expected_number_of_bins);
  methods(hist)

  #get real number of bins to be used below
  number_of_bins = size(counts)[1];
  #Next the algorithm implementation according to the original paper
  p = counts / sum(counts);
  ω = cumsum(p);
  μ = cumsum(p .* (1:number_of_bins));
  μ_t = μ[end];


  sigma_b_squared = (μ_t * ω - μ).^2 ./ (ω .* (1 - ω));

  # Find the location of the maximum value of sigma_b_squared.
  # The maximum may extend over several bins, so average together the
  # locations.  If maxval is NaN, meaning that sigma_b_squared is all NaN,
  # then return 0.
  maxvalue = maximum(sigma_b_squared);
  if isfinite(maxvalue)
    index = findfirst(sigma_b_squared, maxvalue);

    # Normalize the threshold to the range [0, 1].
    threshold = (index - 1) / (expected_number_of_bins - 1);
  else
    threshold = 0.0;
  end

  return threshold
end




numberOfIterations = 10000;

innerExecutionTimes = float64(zeros(1,numberOfIterations));
outerExecutionTimes = float64(zeros(1,numberOfIterations));
img = MatlabCompat.ImageTools.imread("http://matlabcompat.github.io/img/example.tif");

function simpleJanus()
  threshold = graythresh(img); # compute graysacale threshold using Otsu algorithm
  imgbw =im2bw(img, threshold); # create a binary image based on the graysacel image
  labeledbw = bwlabel(imgbw, 4); # lable each connected object in the image
#   numberOfCells = max(reshape(labeledbw, 1,numel(labeledbw))); # count cells
  #disp(strcat("number of objects:", num2str(numberOfCells)));
end


function forSimpleJanus()

  numberOfIterations = 1000;

  for j=1:numberOfIterations
    simpleJanus();
  end

end

  methods(hist)

for i=1:numberOfIterations
  inner = @elapsed(simpleJanus());
  innerExecutionTimes[i] = inner;
end


# for i=1:numberOfIterations
#   outer =  @elapsed(forSimpleJanus());
#   outerExecutionTimes[i] = outer;
# end

println([median(innerExecutionTimes) std(innerExecutionTimes)])
# print([median(outerExecutionTimes)  std(outerExecutionTimes)])

