using MatlabCompat
using MatlabCompat.ImageTools
using MatlabCompat.MathTools
using Base.Test
using Images
using FixedPointNumbers



# basic test
println("foo test")
x = function ()
    return 1 == 1
end
@test x()

# make a test image
array = [0.1 0.001 0 0; 0.1 0.401 0 0; 0.1 0.01 0 0; 0.1 0.901 0 0.6];
img = grayim(array);
properties(img)["IMcs"] = "Gray";

# test the fuctions
println("setting true tests results");
trueThreshold = 0.11100752480522075;
trueBWSum= 3;

println("testing graythresh()");
@test graythresh(img) == trueThreshold;

println("testing im2bw()");
@test sum(reinterpret(Float32, float32(im2bw(img, trueThreshold)))[:]) == trueBWSum;
