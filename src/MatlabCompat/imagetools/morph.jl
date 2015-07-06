module Morph
# Partial backwards syntax comparability for morphological operations:
#
#  - strlen
#
#       SE = strel(shape, parameters)
#       SE = strel('arbitrary', NHOOD)
#       SE = strel('arbitrary', NHOOD, HEIGHT)
#       SE = strel('ball', R, H, N)
#       SE = strel('diamond', R)
#       SE = strel('disk', R, N)
#       SE = strel('line', LEN, DEG)
#       SE = strel('octagon', R)
#       SE = strel('pair', OFFSET)
#       SE = strel('periodicline', P, V)
#       SE = strel('rectangle', MN)
#       SE = strel('square', W)
#
#  - imopen
#
#       IM2 = imopen(IM,SE)
#       IM2 = imopen(IM,NHOOD)
#
#  - imdilate
#  - imerode
#
#
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

export strel


function strel(shape::AbstractArray{Bool,2}, args...)
    # Construct a proper type for StructElement.
    return shape
end
function strel(shape::String, args...)
    if shape == "disk"
        assert(length(args) in (1,2))
        radius = args[1];
        nhood = (length(args) == 2)? args[2] : 0;
        assert(isa(radius, Number) && radius > 0)
        if radius == 1
            assert(isa(nhood, Number) && nhood in (0,2,4,8))
            return bool([0 1 0;1 1 1; 0 1 0]);
        else
            error("This case is not implemented yet!")
        end
    else
        error("This case is not implemented yet!")
    end
end

end #End of Morph
