module MatlabCompat

export Image, Support
export graythresh,
       im2bw,
       imshow,
       imread,
       mat2im,
       im2mat,
       rossetta,
       bwlabel


# Include submodules of the package.
for file in split("image support")
    include("MatlabCompat/$file.jl")
end

# Alias some functions.
const graythresh = Image.graythresh
const im2bw = Image.im2bw
const imshow = Image.imshow
const imread = Image.imread
const bwlabel = Image.bwlabel
const mat2im = Support.mat2im
const im2mat = Support.im2mat
const rossetta = Support.rossetta
end # module
