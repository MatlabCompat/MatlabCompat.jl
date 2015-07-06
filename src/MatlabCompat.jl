module MatlabCompat
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
