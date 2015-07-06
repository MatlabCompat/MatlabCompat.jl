module Io
  # this module contains input/output functions

  # Copyright © 2014-2015 Vardan Andriasyan, Yauhen Yakimovich, Artur Yakimovich.
  #
  #  MIT license.
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
  export load

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
