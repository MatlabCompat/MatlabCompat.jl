module Io
# this module contains input/output functions

  using MAT
  using FixedPointNumbers

  #wrapper MATLAB/Octave load function based on MAT.jl library,
  #for mat files returns the closes analogue to a struct array - Dictionary type
  function load(matFile, treatAs = "-mat", variable = "all")
    if treatAs == "-mat"
      #load all variables as a Dictionary type - the closes analogue to struct array
      allData = matread(matFile)

      if variable == "all"
        matFileDict = allData
      elseif variable != "all"
        if variable in keys(allData)
          matFileDict = allData[variable]
        else
          error("specified variable doesn't exist in the mat file")
        end
      end

    elseif treatAs == "-ascii"
      # load the ascii file and return an array of Float64 type
      fileContent = open(readlines, matFile)
      matFileDict = map(parse, fileContent)
    else
      error("unknown type specified in the second argument")
    end

    return matFileDict
  end
end #End of Io
