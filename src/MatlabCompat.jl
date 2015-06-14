module MatlabCompat

export Image
export graythresh,
       im2bw

# Include submodules of the package.
for file in split("image")
    include("MatlabCompat/$file.jl")
end

# Alias some functions.
const graythresh = Image.graythresh
const im2bw = Image.im2bw

end # module
