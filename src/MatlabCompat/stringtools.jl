module StringTools
  # this module contains string functions

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
  export disp
  export num2str
  export strcat
  # wrapper for the disp function
  function disp(string)
    println(string)
    return true
  end

  # covert number to a string in a MATLAB style
  function num2str(number)
    string = "$number"
    return string
  end

  # wrapper for the Julia function string for compatibility with MATLAB syntax
  function strcat(stringsToAdd...)
    concatenatedString = ""
    for i in 1:length(stringsToAdd)
      concatenatedString = string(concatenatedString, stringsToAdd[i])
    end
    return concatenatedString
  end


end #End of StringTools
