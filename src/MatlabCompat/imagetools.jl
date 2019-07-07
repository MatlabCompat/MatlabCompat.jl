module ImageTools
# Copyright © 2014-2015 Vardan Andriasyan, Yauhen Yakimovich, Artur Yakimovich.
#
#  MIT license.
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

export Morph
export graythresh,
im2bw,
imshow,
imread,
bwlabel,
jet,
hsv,
label2rgb

include("imagetools/morph.jl")

# import Tk
import FileIO
import Images
import Images: Gray, properties, data, label_components
# import FixedPointNumbers
import ImageView # view images for users of the Julia command-line interface (non Juno or IJulia) https://juliaimages.org/latest/install/#Displaying-images-1
import Colors
import BinDeps


################################################################
function graythresh(img)
  # graythresh - Based on the original Paper: N. Otsu, "A Threshold Selection
  # Method from Gray-Level Histograms" 1979. Calculates a threshold of a grayscale
  # image, which can be used downstream to convert a grayscale image to binary
  # image. One input argument is required - image (expected image format obtained
  # by Images.imread, see Images package  for more information). E.g. to convert
  # an array to image use grayim(array) or colorim(array).

  #Check whether the input image is empty
  if isempty(img)
    error("Image is empty");
  end
  #Check whether the input image is gray

  if !(eltype(img) <: Gray)
    error("Input Image should be grayscale")
  end

  # raw --> rawview in Images # https://github.com/JuliaImages/ImageCore.jl/issues/83

  if isa(Images.rawview(img),Array{UInt16,2})
    # Convert image to 8bit and return it's raw values to compute the histogram
    # https://juliaimages.org/latest/conversions_views/#Views-for-%22converting%22-between-fixed-point-and-raw-representations-1
    image_array = map(Images.BitShift(Uint8,8),Images.rawview(img));
  elseif isa(Images.rawview(img),Array{Uint8,2})
    image_array = Images.rawview(img);
  else
    @warn("Input Image is neither Uint8 or Uint16");
    image_array = Images.rawview(img);
  end
  #image_array = rawview(img)

  expected_number_of_bins = 2^8;

  (range, counts) = hist(reshape(image_array,length(image_array)),expected_number_of_bins);

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
################################################################
function im2bw(img, threshold)
  # im2bw - converts image into a binary image. Input: image (expected image
  # format obtained by Images.imread,  see Images package  for more information)
  # and threshold (floating point number). E.g. to convert an array to image use
  # grayim(array) or colorim(array).

  if !(eltype(img) <: Gray)
    error("Input Image should be grayscale")
  end

  if typeof(threshold) != Float64 && typeof(threshold) != Float32 && typeof(threshold) != Float16
    error("Threshold must be of types Float64, Float32 or Float16");
  end
  if threshold > 1 || threshold < 0
    error("Threshold must be between 0 and 1");
  end

  m,n = size(img);
  blacknWhite = falses(n,m)
  imageData = data(img);

  for i = 1:n
    for j = 1:m
      if imageData[j,i] > threshold
        blacknWhite[i,j] = true;
      end
    end
  end

  return Images.Image(blacknWhite, colorspace = "Binary")
end
################################################################
function imshow(image)
  # wrapper for ImageView.view, need to add convertion of image to array and back
  ImageView.view(image)
end
################################################################
function imread(path)
  # wrapper for FileIO.load with added image retrieval from url functionality
  if (occursin(r"http://.*", path) || occursin(r"https://.*", path) || occursin(r"ftp://.*", path)|| occursin(r"smb://.*", path))
    imageContainer = nothing
    # By default, do silent download.
    url = path
    path = tempname()
    cmd = BinDeps.download_cmd(url, path)
    run(pipe(cmd, devnull, devnull));
    imageContainer = path
  else
    imageContainer = path;
  end
  image = FileIO.load(imageContainer);
  return image
end
################################################################
function bwlabel(inputImage,connectivity)
  # wrapper for Images.label_components

  #define pixel connectivity matrices for appropriate inputs
  if connectivity == 4
    connectivityMatrix = bool([0 1 0;1 1 1; 0 1 0])
  elseif connectivity == 8
    connectivityMatrix = bool([1 1 1;1 1 1; 1 1 1]);
  else
    error("Invalid pixel connectivity. Pixel connectivity can be either 4 or 8");
  end

  labeledImage = label_components(inputImage,connectivityMatrix);


  return labeledImage;
end

################################################################
function jet(numberOfColors::Int64)
  #Generate matlab-like jet colormap with specified amount of colors
  return jetColorMap = Colors.RGB{Float64}[
  Colors.RGB(
  clamp(min(4*ellement - 1.5, -4*ellement + 4.5) ,0.0,1.0),
  clamp(min(4*ellement - 0.5, -4*ellement + 3.5) ,0.0,1.0),
  clamp(min(4*ellement + 0.5, -4*ellement + 2.5) ,0.0,1.0))
  for ellement in range(0.0, stop=1.0, length=numberOfColors)];

  end

  ################################################################
  function hsv(numberOfColors::Int64)
    #Generate matlab-like hsv colormap with specified amount of colors
    return hsvColorMap = range(Colors.HSV(0,1,1), stop=Colors.HSV(330,1,1), length=numberOfColors);

  end
  ################################################################
  function label2rgb(labeledMatrix, inputColorMap = "jet",backgroundColor = [1 1 1], isShuffled = "noshuffle")


    #check if the labeledMatrix contains only integers
    if !isinteger(labeledMatrix)
      error("labeledMatrix is not an Integer matrix");
    end

    #change indexing of the labeled Matrix to start from 1
    labeledMatrix = labeledMatrix +1;
    numberOfEllements =  maximum(labeledMatrix); # number of connected ellements in the Matrix

    if inputColorMap == "jet"
      currentColormap =  jet(numberOfEllements);
    elseif inputColorMap == "hsv"
      currentColormap =  hsv(numberOfEllements);
      #check if custom colormap is loaded
    elseif is(typeof(inputColorMap),Array{Colors.RGB,1})

      if length(inputColorMap) == maximum(labeledMatrix)
        currentColormap = inputColorMap;
      else
        error("Input Colormap size is inconsistent with the Labeled Image");
      end
    else
      error("Invalid Input Colormap");
    end

    #convert input backgroundColor to RGB type
    backgroundColor = Colors.RGB(backgroundColor[1],backgroundColor[2],backgroundColor[3]);

    if  isShuffled == "shuffle"
      #shuffle the colormap
      currentColormap  = shuffle(currentColormap);
    elseif isShuffled == "noshuffle"
      #do nothing
    else
      error("isShuffled can be either shuffle or noshuffle ");
    end

    if (currentColormap[1] != backgroundColor)
      currentColormap = [backgroundColor,currentColormap[1:end-1]];
    end

    indexedImage = Images.ImageCmap(labeledMatrix, currentColormap);
    outputRGB = convert(Images.Image, indexedImage);


    return outputRGB;

  end

  ################################################################
end #End of ImageTools
