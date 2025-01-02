# Tutorial 03 / Geometric Calibration

## Simple scaling

Open again a test image in 'UVMAT_DEMO01_pair' (accessible on <http://servforge.legi.grenoble-inp.fr/pub/soft-uvmat/).>

We shall use the diameter of the half cylinder visible on the upper let of the image to set the calibration.
Its physical diameter is 2cm.
The corresponding diameter in pixels can be obtained with the ruler displayed by the menu bar *[Tools/ruler]* of uvmat.

First zoom on the cylinder to optimize the precison.
Select *zoom on*, press the left mouse button and adjust the field with the directional key board arrows.
Then unselect *zoom on* to allow for other mouse actions (otherwise zoom has priority).
It is also useful to increase the contrast at the cylinder edge by setting *MaxA* to 100 in the frame *[Scalar]* (right side of *uvmat*).

Then select the menu bar *[Tools/ruler]*, press the left hand mouse button on the cylinder edge, draw a diameter keeping the mouse pressed, release it on the opposite edge.
The length in pixels, 140, is displayed, so the scaling factor is 140/2=70 pixels/cm.

Open the menu bar *[Tools/geometric calibration]*.
A new GUI *geometry_calib* appears on the right side.
Activate the upper menu bar *[!Tools/Set scale]* on this GUI and introduce the value 70 in the edit box which pops up, and validate with *[OK]*.
A set of calibration point coordinates appears in the table *[ListCoord]* of the GUI.

To see the calibration points on the image, first display the whole image by unselecting *fix* (tag *[CheckFixLimits]*) in the frame *[Axes]* of *uvmat*.
Then press *[PLOT PTS]* in *geometry_calib*.

To perform the calibration, press *[APPLY]*, first with the default option 'rescale' in *calib_type*, and confirm by pressing *[OK]* in the dialog box.
The image is now displayed in phys coordinates.
A xml file 'images.xml', containing the calibration parameters and reference point coordinates, has been created in the folder 'UVMAT_DEMO01_pair' (it should be identical with the file 'images.ref.xml' put for reference).
Note that the xml file name reproduces the name of the folder containing the images, so that images from different cameras should not be put in the same folder.

![](03-calib.jpg)

## Translating the coordinates

The origin of the phys coordinates is now arbitrary.
It is more convenient to have it for instance at the centre of the cylinder, now at (x,y)=(1.69, 4.05).

To get the precise position of the cylindre, it is useful to introduce a projection circle, using in *uvmat* the menu bar command *[Projection object/ellipse]*.
In *set_object*, select *[ProjMode]*='none', so that the line is just used as a marker, without projection operation.
Set XMax=1, YMax=1, the radius of the circle, and the coordinates (1.69, 4.05) of the centre in the table *Coord*.
Then press *[REFRESH]*.
To optimise the visualisation, zoom in and increase the image contrast to MaxA=100.

To shift the coordinates, activate in *geometry_calib* the menu bar command *[!Tools/Translate points]*, and fills (x=-1.69, y=-4.05) in the edit box which pops up.
The phys coordinates of the calibration points are then shifted, select *[APPLY]* in* 'geometry_calib' *: a new calibration put the cylindre centre at the origin (0,0).
These new calibration data are saved in an .xml file in the same folder as the image.

## *Repeating the calibration*
To repeat the calibration for several image series obtained with the same camera at the same position, different methods can be used.

- Copy the .xml file to the appropriate location, with the same name (but extension .xml) and path as the file containing the image series.
This is however not appropriate in general as the xml file contains other information, in particular about image timing.

- Open with *uvmat* one of the image of the series to calibrate, select *[Tools/geometric calibration]*, and in the GUI *geometry_calib*, the menu bar *[!Import/All]* (open the .xml field you just created), then press* [APPLY]*.
For further repetitions, the GUI *geometry_calib* can be left opened while new image series are opened, and *[APPLY]* repeated each time without importing the calibration data again.

- In case of many image series, use *[REPLICATE]* instead of *[APPLY]* in the GUI *geometry_calib*.
Then select the 'campaign' to calibrate, *i.e.* the folder containing the series of experiments.
Then in the new GUI *browse_data*, select the set of experiments and the corresponding set of data series to which the calibration must apply (this is used like *[Open campaign]* in *uvmat*).

## Calibration with reference points

The more general method of calibration consists in using a set of reference points whose physical coordinates are known.
Open with *uvmat* an image in 'UVMAT_DEMO06_PIVconvection/Dalsa1' (accessible on <http://servforge.legi.grenoble-inp.fr/pub/soft-uvmat/).>

Select in the menu bar *[Tools/geometric calibration]*.
Mark the four box corners of the box with the mouse (left hand button).
Their coordinates in pixels are displayed in the two last column of the table *[ListCoord]* in the GUI *geometry_calib*.
To clear the table for corrections push the button *[CLEAR_PTS]*, or for a single line, use the key board 'Delete' button.
To improve the position on the image, use the zoom and directional arrows.
We find the coordinates of the four calibration points in pixels:

(X,Y)=(80.3, 81.6), (982.3, 86.1), (978.9, 937.4), (71.2, 929.5).

The corresponding physical coordinates are known to be:

(x,y)=(0,0),(58.8,0),(58.8,55.1),(0,55.1), with an origin (0,0) taken at the lower left (and z=0).

Introduce those in the two first columns of the table *[ListCoord]*.
This can be conveniently done by copy-paste Matlab vector x=[0 58.8 58.8 0] in the upper line of the x column, and y=[0 0 55.1 55.1] in the y column (use carriage return to validate the input).

To perform the calibration, press *[APPLY]*, first with the default option 'rescale' in *[calib_type]*.
The image is now displayed in phys coordinates.
We observe that the rectangular frame is slightly rotated.
Furthermore the displayed precision, about 3 pixels, is not excellent.

To improve the precision we then apply the option 'linear' in *[calib_type]*, which seeks a general linear transform, including rotation.
The precision is indeed improved to about 1 pixel.
The previous xml file has been saved with a ~, ('Dalsa1.xml~') so it can be reverted in case of error.

## 3D calibration with a target grid

Most precise and general calibration relies on the use of a target grid.
As an example, open in uvmat the image img_10 in 'UVMAT_DEMO07_GeometryCalibration/multiple_planes/Dalsa1' (accessible on <http://servforge.legi.grenoble-inp.fr/pub/soft-uvmat/).> Open the menu bar *[Tools/geometric calibration]* and pick four corner points ABCD with the mouse define the periphery of the phys grid selected for calibration.
The first point A will define the phys axis origin while AB defines the x axis and AD the y axis.
AB and DC should be parallel on the phys grid (see fig).
Then select* [!Tools/Detect grid]* on the upper menu bar of* geometry_calib*: you get a new GUI *detect_grid* in which you define (in phys units) the grid mesh and the positions of the first and last points on each axis.
Enter the value 0 for the *[first]* _x_ and _y_, the distance between two points on the grid is 10 cm so enter 10 for *[mesh]* _x_ and _y_.
According to the number of meshes you selected with your 4 points ABCD enter the correct value of *[last]* _x_ and _y_.
A _z_ position can be defiend as well, do not fill it in this example.
The option white markers is selected (by default) indicating that the grid is white (the opposite option would be needed for a grid made of black crosses on a white background).
After validation by *[OK]*, the detected grid appears on *uvmat*.

![](03-detect-grid.png)

If a point is not correct, select the option *[CheckEnableMouse]* in *geometry_calib*.
Then you can adjust the point marker by selecting it with the (left button) mouse and moving it while keeping the mouse pressed (when adjustement is finished, select the option *[CheckEnableMouse]* to avoid spurious point creation with the mouse).

If the grid image is of poor quality, it is alternatively possible to mark all the points by the mouse, using the *[!Tools/Create]* grid instead of *[!Tools/Detect grid]* in geometry_calib (not convenient in general).

Once the grid has been marked, the calibration can be performed by the press button *[APPLY]*.
We observe that the simple option 'rescale' is not appropriate in this case: a perspective effect is clearly visible, together with a non-linear deformation (grid lines are curved on the image).
Therefore select the option '3D_quadr' which applies a 3D projection and quadratic correction.
The grid image now appears of good quality in phys coordinates.

This 3D calibration relies on the [pinhole camera model](3d-view-2015.pdf) (see [HELP Geometric Calibration](https://legi.gricad-pages.univ-grenoble-alpes.fr/soft/uvmat-doc/help/#8-geometric-calibration)).
It involves intrinsic parameters which characterize the optical system (camera and objective lens) and extrinsic parameters which describe the translation and rotation of the camera with respect to the physical coordinates.
The intrinsic parameters are shown in the frame *[Intrinsic Parameters]* in the GUI *geometry_calib*.
These are the focal lenghts (in pixel size on the sensor) *[fx]* and *[fy]*, the quadratic radial distortion coefficient *[kc]* and the coordinates *[Cx]* and *[Cy]* of the optical centre for this distortion (expressed in pixels on the image).
The extrinsic parameters are shown in the frame *[Extrinsic Parameters]*.
It indicates in particular the translation T_z which represents the distance from the camera to the origin of the phys coordinates.
Note that the calibration grid has been assumed by default to be at z=0, but this can be changed by selecting *[!Tools/Translate points]* in *geometry_calib* and entering a translation in _z_ for the grid point coordinates.

A last item needed to define calibration in a 3D context is the determination of the plane of the object in the phys coordinates.
It is assumed by default to be the plane z=0, but this can be changed by the menu bar option *[!Tools/Set slice]* of *uvmat*.
It is then possible to change the assumed _z_ position, keeping the same calibration.
Observe the corresponding change in the grid scale, since the same grid is then assumed to be at a different distance.

## 3D calibration improved by multiple planes:

The calibration of the previous section provides 3D information, such as the intrinsic parameters, thanks to the inclination of the calibration grid, but the precision is not optimum, and the process would not converge for a grid perpendicular to the line of view.
A more precise procedure consists in first of determining the intrinsic parameters by mutiple views of the same grid with different inclinations.

Once the grid image is correctly set, in* 'geometry_calib' *click on the *[APPEND LIST]* button in *[Point Lists]*.
This will save the grid as 'img~.xml' file.
This document is saved in the same folder as the image.
To open it select *[Import.../Calibration points]*.

Now that the calibration is made for the first image we need to do it for the other ones, you can open the different grids 'img.ref~.xml' to skip the calibration.
Once a document is open, the grid is shown in *uvmat*, to save it in the *[Point Lists]* click on *[APPEND LIST]*, it will appear below the first saved document.

*Note:* if the serie is missing some images (ie the increment from one image to another is not steady), *uvmat* will not allow you to use the arrow *[->]* to move from an image to another if the increment is set.
To avoid this delete the number in *[increment]*, you will then be able to go from an image to another.

When all the grids are selected in *[Point Lists]*, select *[APPLY]*.
The intrinsic parameters are then reevaluated according to the set of points in different planes, which provides a better estimate than with a single plane.
The extrinsic parameters are still determined by the points displayed in the table *[!ListCoord]*.

For the next calibration, to avoid any change on the intrinsic parameters, in* 'geometry_calib' *select the option *3D_extrinsic* in *[calib_type]*.
It applies a 3D projection and quadratic correction according to the already determined intrinsic parameters.

## Merging the images of several cameras

Open with *uvmat* the image 10 in 'UVMAT_DEMO07_GeometryCalibration/multiple_planes/Dalsa1'.
Create a projection plane using the menu bar tool *[Projection object/plane]*, select *[ProjMod]* =interp_lin, *[Min x]*,*[Min y]* # -100, *[Max x]*,*[Max y]* 100 and click on *[REFRESH]*.
The image will appear in a new* 'view_field' *frame.

Now that the projection plane is set, in *series* (*[Run/field series]*) open the two other images 10 from Dalsa2 and Dalsa3 by selecting in the menu bar tool *[!Open/Browse append...]*.
You can now see the three files in the *[Input Files]* table.

Select the *[Action]* function *merge_proj* and put the *[Field Transform]* as *phys*.
Select the check box *[Projection Object]*, the plane created earlier should appear below the check box.
*[RUN]* the calculation and open the result using *[STATUS]*.
You can see that the three images are merged in the same plane.

## Setting laser slices
