using Base
using MatlabCompat
using MatlabCompat.Io
using MatlabCompat.ImageTools
import MatlabCompat.MathTools
import MatlabCompat.MathTools: max
using Test
using Images
using FixedPointNumbers
using Tk

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
array = [0.1 0.001 0 0; 0.1 0.401 0 0; 0.1 0.01 0 0; 0.1 0.901 0 0.6];
img = grayim(array);
properties(img)["IMcs"] = "Gray";

# test the fuctions
println("setting true tests results");
trueThreshold = 0.11100752480522075;
trueBWSum= 3;

# println("testing graythresh()");
# @test graythresh(img) == trueThreshold;

println("testing im2bw()");
@test sum(reinterpret(Float32, float32(im2bw(img, trueThreshold)))[:]) == trueBWSum;

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
