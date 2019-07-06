# using Base # not required
using FileIO
using MatlabCompat
using MatlabCompat.Io
using MatlabCompat.ImageTools
import MatlabCompat.MathTools
import MatlabCompat.MathTools: max
using Test
using Images
using FixedPointNumbers
# using Tk

const TEST_FOLDER = dirname(@__FILE__)
const JANUS_PATH = joinpath(TEST_FOLDER, "janus.m");
const TESTMAT_PATH = joinpath(TEST_FOLDER, "test.mat");

# basic test
println("foo test")
x = function ()
    return 1 == 1
end
@test x()

################################
#     ImageTools Module Tests
################################

# make a test image
array = [0.1  0.001  0  0;
         0.1  0.401  0  0;
         0.1  0.01   0  0;
         0.1  0.901  0  0.6]; # should be Float : Float32, Float64, etc

# Any array can be treated as an Image. However, in graphical environments, only arrays with Colorant element types are automatically displayed as images.
#  Coloran typest=(Gray, RGB, ARGB, etc.)

# Syntax 1
img = colorview(Gray, array);
 # returns a view of the numeric array A, interpreting successive elements of A as if they were channels of Colorant C. (https://juliaimages.org/latest/function_reference/#ImageCore.colorview)
imgMet=ImageMeta(img, time="after noon"); # to add ImageMeta

# # Syntax 2
#  img=Gray.(array);
#  # calculates a grayscale representation of a color image using the Rec 601 luma. (https://juliaimages.org/latest/function_reference/#Color-conversion-1)
# imgMet=ImageMeta(img, time="after noon");
#
# # Syntax 3
# imgMet = ImageMeta(colorview(Gray, array), time="after noon")
#  # returns an ImageMeta type, which holds both data() with Colorant element type, and properties() (Dict type)
# properties(imgMet)["location"] = "university"; # to access and extract properties
# img=data(imgMet); # to access and extract data
#
# # Syntax 4
# imgMet = ImageMeta(array, time="after noon")
#  # returns an ImageMeta type, which holds both data() but array has Float type instead of Colorant, and properties() (Dict type)
# properties(imgMet)["location"] = "university"; # to access and extract properties
# array=data(imgMet); # to access and extract data

# test the fuctions
println("setting true tests results");
trueThreshold = 0.11100752480522075;
trueBWSum= 3;

# println("testing graythresh()");
# @test graythresh(img) == trueThreshold;

println("testing im2bw()");
@test sum( reinterpret( Float32, float32( im2bw(img, trueThreshold) ) )[:] ) == trueBWSum;

println("testing imread()");
img2 = MatlabCompat.imread("http://matlabcompat.github.io/img/example.tif");
expected = nothing
expected = "Images.Image{ColorTypes.Gray{FixedPointNumbers.UFixed{UInt8,8}},2,Array{ColorTypes.Gray{FixedPointNumbers.UFixed{UInt8,8}},2}}"
@test "$(typeof(img2))" == expected;

################################
#     Support Module Tests
################################

println("testing im2mat()");
mat = im2mat(img)
@test "$(typeof(mat))" == "Array{Float32,2}";

println("testing mat2im()");
expected = nothing
if (false)
    expected = "Image{Float64,2,Array{Float64,2}}"
else
    expected = "Images.Image{Float64,2,Array{Float64,2}}"
end
@test "$(typeof(mat2im(img)))" == expected;

println("testing rosetta()");
@test "$(typeof(rosetta(JANUS_PATH)))" == "Array{UTF8String,1}";



################################
#     Io Module Tests
################################

println("testing load()");
println("$(typeof(MatlabCompat.load(TESTMAT_PATH)))")
@test "$(typeof(MatlabCompat.load(TESTMAT_PATH)))" == "Dict{ASCIIString,Any}";
# "$(typeof(A))" == "Dict{Any,Any}"

################################
#     StringTools Module Tests
################################
println("testing disp()");
@test disp("test") == true;

println("testing num2str()");
@test num2str(3) == "3";

println("testing strcat()");
@test strcat("1", "2", "3") == "123";

################################
#     MathTools Module Tests
################################
matrix = [1 2 3];

println("testing numel()");
@test numel(matrix[:]) == 3;

println("testing max()");

@test max(matrix) == maximum(matrix);
