![MatlabCompat project](http://morphosphere.github.io/img/Logo_A_txt_aside.png)
[![Build Status](https://travis-ci.org/morphosphere/MorphoSphere3D.svg?branch=master)](https://travis-ci.org/morphosphere/MorphoSphere3D)

# MatlabCompat.jl
### Julia library aimed at simplifying conversion of legacy MATLAB/Octave code into Julia by providing functions similar to MATLAB/Octave



Julia is a new language with a dynamically growing community. It has a lot of syntax similarities to MATLAB/Octave with potential to build higher performance software. Because of this many developers in technical computing consider switching from MATLAB/Octave to Julia. This switch however maybe quite difficult in situations when one has a bulk amount of legacy code running on the daily basis. To simplify to transition of your legacy MATLAB/Octave code we have developed "MatlabCompat" a Julia library with a collection of functions rewritten from scratch under an open source MIT "Expat" license and some are named similarly to functions in MATLAB/Octave.



However, as a word of caution Julia is not MATLAB/Octave and was never meant to be. This library is not meant to substitute any commercial products (including those of Mathworks Inc.), nor is it meant to make Julia language closer to MATLAB/Octave. THe one and sole purpose of this library is to pave a way for enthusiast MATLB/Octave developers willing to engage with Julia open source language. For more information and help please refer to the [Julia language homepage](http://www.julialang.org/)


### Dependencies

We use following Julia packages:

julia 0.4
Tk
Images
ImageView
FixedPointNumbers
MAT
Color
BinDeps
ImageMagick

Also see REQUIRE file for details.

### Package [Help can be found here](http://matlabcompat.github.io/help.html)

### [Contribution guide can be found here](http://matlabcompat.github.io/contribute.html)

## Developer

Symlink the latest version of the package at hand. 

```bash
git clone https://github.com/MatlabCompat/MatlabCompat.jl && cd MatlabCompat.jl
julia -e 'Pkg.init(); run(`ln -s $(pwd()) $(Pkg.dir("MatlabCompat"))`); Pkg.pin("MatlabCompat"); Pkg.resolve()'
```

> On Windows you might want to use:

> mklink

If you have any troubles simply remove the folder in your home folder and try again.

Afterwards check that `Pkg.status()` contains this package (with a **master (dirty)** side note)

## Disclaimer
All the code presented in this library was written from scratch and by no means or intentions presents a complete overlap with product of Mathworks Inc., nor any intentions to violate any of materials copyrighted by Mathworks Inc. or any other respective third party copyright owner. By reading, downloading, forking or using this library you agree to do it at your own risk and there is no guarantee that you MATLAB/Octave code will work in a similar fashion as it would with products of Mathworks Inc. Code written here is based on open source Julia language and published state-of-the-art algorithms being property of the public domain. Any overlap with property of respective copyright owners is pure accidental and may be caused by using published state-of-the-art algorithms being property of the public domain.

Copyright © 2014-2015 Vardan Andriasyan, Yauhen Yakimovich, Artur Yakimovich
