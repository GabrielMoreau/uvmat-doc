# Liminary

![](img-uvmat.png)

This free Matlab toolbox (GNU General Public License) provides a set of functions and graphic user interfaces for scanning images and data files (vectors and scalars in 2D and 3D), geometric calibrations, image processing and analysis of time series.
It is designed to favor data management, relying on the standard **NetCDF** file format and **XML** documentation files.

Tools are provided to process field series on a computer cluster with different file administration systems (SGE or OAR).

**UVMAT** contains a Matlab program for **P**article **I**maging **V**elocimetry (**PIV**, also called **C**orrelation **I**mage **V**elocimetry, **CIV**) which relies on generalized pattern matching by direct cross-correlation of pattern boxes between image pairs.
It includes iterative CIV, taking into account pattern deformation by strain and rotation.

UVMAT also contains a graphic user interface and compiled binaries of the older PIV software ​CIVx written in Fortran.

The reference website for this documentation is <https://legi.gricad-pages.univ-grenoble-alpes.fr/soft/uvmat-doc/>.


## Prerequisit

This toolbox requires Matlab, release R2009 or more recent.
It can be run with any computer system on which Matlab is installed (in particular GNU/Linux, MacOSX and Windows).
No additional toolbox from Matlab is requested.
The Matlab compiler is however useful to be able to dispatch computing processes on a computer cluster, and the image processing toolbox provides some additional features.


## Useful

- Installation - Procedure to install UVMAT under GNU/Linux, MacOSX and Windows 

- [Help](help/) - Online help and documentation 

- [Tutorials](tutorial/01-ImageDisplay/) - Guideline on howto use UVMAT 

The following documents provide general instructions for the use of PIV (Note that although the general principles remain valid, references to software are outdated, use UvmatHelp and Tutorial)

- 2013 - [Presentation for students at Hydralab workshop](bib/2013-piv-at-hydralab.pdf) (pdf)

- 2003 - [PIV at the Coriolis facility](bib/2003-civ-at-coriolis.pdf) (pdf)

- 2000 - [Presentation done at Meteo-France](bib/2000-civ-at-meteofrance.pdf) (pdf)


## Follow us

UVMAT is under active development. New features are regularly included but these are made with sake of compatibility with the existing.


## Tutorials

A set of test examples are described in these tutorials, as listed in the table of content.
Follow the links to get the instructions on-line.

The requested files are provided in set of archives [UVMAT_DEMO_FILES.zip](https://gricad-gitlab.univ-grenoble-alpes.fr/legi/soft/uvmat-doc/-/raw/master/data/UVMAT_DEMO_FILES.zip?ref_type=heads).

These DEMO files can be alternatively read and processed online from the OpenDAP server <http://servdap.legi.grenoble-inp.fr/opendap/meige/18UVMAT_DEMO_SOURCES> (accessible in the upper bar menu Open of the GUI *uvmat*).

Each folder contains both a sub-folder of raw images and processing results.
