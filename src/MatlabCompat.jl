module MatlabCompat

export ImageTools, Support, Io, StringTools, MathTools
export mat2im,
       im2mat,
       rossetta,
       load,
       disp,
       num2str,
       strcat,
       numel


# Include submodules of the package.
for file in split("imagetools support io stringtools mathtools")
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
const disp = StringTools.disp
const num2str = StringTools.num2str
const strcat = StringTools.strcat
const numel = MathTools.numel
const max = MathTools.max
# imported/included inside ImageTools
const strel = ImageTools.Morph.strel
const imread = ImageTools.imread
# imported/included inside MathTools
const max = MathTools.max
end # module
