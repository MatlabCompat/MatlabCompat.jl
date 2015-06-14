module Image
#
# graythresh - Based on the original Paper: N. Otsu, "A Threshold Selection
# Method from Gray-Level Histograms" 1979. Calculates a threshold of a grayscale
# image, which can be used downstream to convert a grayscale image to binary
# image. One input argument is required - image (expected image format obtained
# by Images.imread, see Images package  for more information). E.g. to convert
# an array to image use grayim(array) or colorim(array).
#
# im2bw - converts image into a binary image. Input: image (expected image
# format obtained by Images.imread,  see Images package  for more information)
# and threshold (floating point number). E.g. to convert an array to image use
# grayim(array) or colorim(array).
#
#
# Copyright © 2014 Artur Yakimovich. MIT license.   
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

using Images
using FixedPointNumbers


function graythresh(img)

    if isempty(img)
        error("Image is empty");
    end
    if properties(img)["IMcs"] != "Gray";
        error ("Image must be grayscale. If your image is grayscale consider adding properties(img)[\"IMcs\"] = \"Gray\";");
    end
    #Convert image to an array and compute it's histogram
    image_array = reinterpret(Float32, float32(img));

    expected_number_of_bins = 2^16;
    (range, counts) = hist(image_array[:],expected_number_of_bins);
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
        threshold = (index - 1) / (number_of_bins - 1);
    else
        threshold = 0.0;
    end
    
    return threshold
end

function im2bw(img, threshold)

    if properties(img)["IMcs"] != "Gray";
        error ("Image must be grayscale");
    end
    
    if typeof(threshold) != Float64 && typeof(threshold) != Float32 && typeof(threshold) != Float16
        error ("Threshold must be of types Float64, Float32 or Float16");
    end
    if threshold > 1 || threshold < 0
        error ("Threshold must be between 0 and 1");
    end
    
    m,n = size(img);   
    blacknWhite = img;
    for i = 1:m  
        for j = 1:n
            if data(img)[i,j] >= threshold
                data(blacknWhite)[i,j] = 1;
            else
                data(blacknWhite)[i,j] = 0;
            end
        end
    end
    
    return blacknWhite
end

end #End of Image
