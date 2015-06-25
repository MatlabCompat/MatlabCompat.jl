module MatlabCompat

export ImageTools, Support, Io
export graythresh,
       im2bw,
       imshow,
       imread,
       mat2im,
       im2mat,
       rossetta,
       bwlabel,
       load


# Include submodules of the package.
for file in split("imagetools support io")
    include("MatlabCompat/$file.jl")
end

# Alias some functions.
const graythresh = ImageTools.graythresh
const im2bw = ImageTools.im2bw
const imshow = ImageTools.imshow
const imread = ImageTools.imread
const bwlabel = ImageTools.bwlabel
const mat2im = Support.mat2im
const im2mat = Support.im2mat
const rossetta = Support.rossetta
const load = Io.load
end # module
