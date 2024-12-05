# UVMAT

![](img-uvmat.png)

This free Matlab toolbox (GNU General Public License) provides a set of functions and graphic user interfaces for scanning images and data files (vectors and scalars in 2D and 3D), geometric calibrations, image processing and analysis of time series.
It is designed to favor data management, relying on the standard **NetCDF** file format and **XML** documentation files.

Tools are provided to process field series on a computer cluster with different file administration systems (SGE or OAR).

**UVMAT** contains a Matlab program for **P**article **I**maging **V**elocimetry (**PIV**, also called **C**orrelation **I**mage **V**elocimetry, **CIV**) which relies on generalized pattern matching by direct cross-correlation of pattern boxes between image pairs.
It includes iterative CIV, taking into account pattern deformation by strain and rotation.

UVMAT also contains a graphic user interface and compiled binaries of the older PIV software ​CIVx written in Fortran.

## Prerequisit

This toolbox requires Matlab, release R2009 or more recent.
It can be run with any computer system on which Matlab is installed (in particular GNU/Linux, MacOSX and Windows).
No additional toolbox from Matlab is requested.
The Matlab compiler is however useful to be able to dispatch computing processes on a computer cluster, and the image processing toolbox provides some additional features.

## Useful

- Installation - Procedure to install UVMAT under GNU/Linux, MacOSX and Windows 

- UvmatHelp - Online help and documentation 

- Tutorial - Guideline on howto use UVMAT 

The following documents provide general instructions for the use of PIV (Note that although the general principles remain valid, references to software are outdated, use UvmatHelp and Tutorial)

- 2008 - Presentation for students at Hydralab workshop: hydralab_YP_joel.pdf​ 

- 2003 - PIV at the Coriolis facility: CIV_doc_lim.pdf​ 

- 2000 - Presentation done at Meteo-France: MeteoFranceDecembre2000.pdf​ 

## Follow us

UVMAT is under active development. New features are regularly included but these are made with sake of compatibility with the existing.
