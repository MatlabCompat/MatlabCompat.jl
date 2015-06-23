module MatlabCompat

export ImageToolbox, Support, Io
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
for file in split("imagetoolbox support io")
    include("MatlabCompat/$file.jl")
end

# Alias some functions.
const graythresh = ImageToolbox.graythresh
const im2bw = ImageToolbox.im2bw
const imshow = ImageToolbox.imshow
const imread = ImageToolbox.imread
const bwlabel = ImageToolbox.bwlabel
const mat2im = Support.mat2im
const im2mat = Support.im2mat
const rossetta = Support.rossetta
const load = Io.load
end # module
