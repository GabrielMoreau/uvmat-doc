# Tutorial 05 / Correlation Image Velocimetry: a simple example

Open again the first example of image pair in UVMAT_DEMO01_pair (accessible on <http://servforge.legi.grenoble-inp.fr/pub/soft-uvmat/).>

## Visual check of the image pair

The Particle Image Velocimetry (PIV) computation measures the displacement of features in a pair of images.
Visual evidence of feature displacement between the two images is a prerequisite  for the success of the computation.
To observe this motion, write the file indices 1 and 2 in the boxes *[i1]* and *[i2]* respectively, in the frame *[File Indices]* on the left.
Then push the red button *[<-->]* in the frame *[Navigate]*, see figure.
The image then alternatively switches from 1 to 2.
The speed of motion can be adjusted with the slider *[speed]*.
Press *[STOP]* to stop the motion.

![](05-movie1-2.jpg)

## Launching PIV

The PIV computation is accessed from *uvmat* by the upper bar command *[Run/PIV]*, or from *series* by selecting the function *civ_series*.
The name 'CIV' means *C*orrelation *I*maging *V*elocity to stress that the method relies on image correlation, which evaluates the displacement of image textures, not necessarily from particles.
Note that an older GUI *'civ' *is also available, but it is obsolete and not used here.

A new GUI *civ_input* now appears.
In the menu *[ListCompareMode]*, keep the default option 'PIV'.
Keep the default option 'Di=0|1' for the image pair (menu tag *[ListPairCiv1]*) and the default parameters in the frame *CIV1*.
Press *[OK]* so the GUI *civ_input* desappears.
Then change *i_last* to 2 and press *[RUN]*  in the GUI* series* to run the calculation.
The button *[RUN]* is then colored to yellow until the computation is finished.

The operation produces a  file with format netcdf, named with extension '.nc', in a folder called 'Images.civ'.
This can be viewed by pressing *[STATUS]* in the GUI *series*, which displays the result file 'frame_1-2.nc'.
The index string '_1-2' indicates that it results from images 1 and 2.
Select the file name and press *[OPEN]* to open it directly with *uvmat*, or use the browser of *uvmat*.

![](05-civ-1.jpg)

## Visualizing  the velocity fields

In *uvmat *velocity vectors are displayed in the central window, while the histograms of each component are in the lower left windows.
The arrow length is automatically set by default.
It can be adjusted by the edit box *scale* (*[num_VecScale]*) in the  frame *[Vectors]* on the right hand side.

The vector color indicates the quality of the image correlation maximum leading to each vector, blue is excellent, green average, red poor.
The thresholds for such color display can be adjusted from 0 to 1 (perfect image correlation) in the frame* [Vectors]*, using the boxes *[ColCode1]* and *[ColCode2]*,  or equivalently by the corresponding  sliders *[Slider1]* and *[Slider2]*.

The black color indicates warning in the PIV calculation process.
In this example, black vectors are indeed located on the edge, in zones outside the area of flow visualisation (this display can be desactivated by unselecting the box *hide warn* (tag *[CheckHideWarning]*) in the frame *[Vectors]*).

The position (_x,y_) and velocity components (_U,V_) can be displayed in the upper right text display window by moving the mouse over it.
The correlation 'C' and warning flag 'F' are also indicated.
The warning flag is equal to 0 for good vectors while non-zero values indicate different calculation problems.

## Histograms of velocity

The global histograms of the vector components  are available in the lower left windows.
Histograms limited to a sub-region can be extracted by the menu bar tool *[Projection object]*, selecting either* [rectangle]*, *[ellipse]* or *[polygon]* to define the sub-region (see [wiki:Tutorial/ProjectionObjects projection objects])

## Velocity profiles

The velocity profile along a line can be obtained by creating a line with the upper menu bar *[Projection object/line]*, like for image luminosity (see [wiki:Tutorial/ProjectionObjects projection objects]).
Press (and release) the left hand side mouse button, draw the line, and press it again for the end of the line.
The transverse and longitudinal velocity components along this line are then plotted in a new  figure *view_field*.

## Various vector color representations

Vector color can also  represent another quantity, as chosen in the menu *[ColorScalar]*  in the frame *[Vectors]*.
For instance the vector length 'norm(U,V)' can be used.
Then a color continuous 64 color code is appropriate, as set in the menu *[ColorCode]*.
The color code extrema are set by *[num_MinVec]*  and *[num_MaxVec]*, choose for instance 0 and 5 respectively.

## Scalar maps

Other field representations are available, selected in the menu *[Field]* at the top of the GUI.
For instance the option 'U' provides a (false) color map of the x wise velocity component.
The color code can be adjusted by the edit box *[num_MinA]*  (saturated blue color below this value) and *[num_MaxA]* (saturated red color beyond this value).
Choose for instance -1 and 5 respectively.

A contour plot can be obtained instead of a color map by selecting the option 'contour' in the menu *[ListContour]* in the frame* [Scalar]* .
Then select the contour interval, for instance 0.5.
The result is shown in the following figure.

![](05-contours.jpg)

## Spatial derivatives
To get the vorticity field, 'curl', and other spatial derivatives, you need to come back to the GUI* series* with images in *[Input Files]* and *[Action]* as 'civ_series'.
In* civ_input*, select the check boxes *[FIX1]*  and  *[PATCH1]* , validate the input with *[OK]*, then press *[RUN]* in the GUI *series*.
A question box appears to warn about the existence of the result file, answer *[OK]* to refresh it with the new data.
Otherwise the results are stored in a new subdirectory with extension '.civ1', so the previous results are not erased (you can modify this extension by editing the boxe *[OutputDirExt]* in the GUI *series*.

This will produce an interpolated velocity field and their spatial derivatives in the same netcdf file.
After this operation vorticity can be visualized in the GUI  *uvmat*, selecting the option 'curl' in the popup menu *[FieldName]*.

## Superposing image and vectors
It can be useful to visually superpose the images to the velocity field.
This is done  by selecting the option 'vec(U,V)'  in the popup menu *[FieldName]* and  'image' in the popup menu *[FieldName_1]*, located just below* * in the upper frame *[Input]*.
To remove the image, select the blank option in *[FieldName_1]*.

![](05-image-vectors.png)

Similarly, the velocity vectors can be superposed to the vorticity field, selecting 'curl' in *[FieldName_1]* instead of 'image'.

## From pixel displacement to physical velocity

So far all PIV results have been expressed as image displacement expressed in pixels.
Conversion to velocity requires timing information and geometric calibration, as described in [wiki:Tutorial/GeometricCalibration geometric calibration].
Both pieces of information must be stored in an xml file named_ 'images.xml* in the same folder as the folder *images* containing the images.*_

First introduce the time interval, Dt=0.02 s, by creating a text file with the following content, using any text editor (with output in plain text), and save it with name _ 'images.xml* (in Windows system, be carefull to avoid any additional hidden extension).*_

~~~
<ImaDoc>
  <Camera>
           <TimeUnit>s</TimeUnit>
           <BurstTiming>
                   <Time>0</Time>
                   <Dti>0.02</Dti>
                   <NbDti>1</NbDti>
           </BurstTiming>
  </Camera>
</ImaDoc>
~~~

Then open the image with uvmat.
The label 'xml' should appear in the upper right box *[TimeName]* and time value beside it in *[TimeValue]*.

Now repeat the PIV operation to include the time information in the result (in the absence of time information the file index is taken as default value).

To introduce  the geometric calibration, use the method described in [geometric calibration](https://servforge.legi.grenoble-inp.fr/projects/soft-uvmat/search?q=wiki%3ATutorial%2FGeometricCalibration), section 'Simple scaling'.
The velocity field is then displayed in terms of physical velocity.
To come back to the image coordinates, use the box* [TransformName]* on the left : select to blank instead of ’phys’.

Note that the netcdf file has not been by changed by calibration, whose rescaling is introduced after reading the file.
This means that calibration can be provided, and possibly updated, after the PIV processing.

## Masks

Spurious vectors are observed outside the fluid domain, which is particularly disturbing when spatial derivatives are calculated.

This can be avoided by using a mask, which is an image of the same size as the images used for PIV.
Grey color in the mask indicate regions excluded from measurement.

To produce the mask, first create a polygon by the menu bar command *[Projection object/mask polygon]*.
Draw the mask with the mouse by moving around regions to exclude.
Left mouse button to initiate the plot and produce new boundary points, press right hand button to finalise the polygon.
By default mask is set inside the polygon, but it can be made outside by selecting the option ’mask_outside’ in the menu *[ProjMode]* of the GUI *set_object*.

Then the mask itself is produced by the menu bar command *[!Tools/Make mask]*.
The corresponding image is then displayed and stored by default in the directory of the initial image.
Note that if several mask polygons have been initially created, as listed in *[ListObject]* (bottom right of the GUI uvmat), they will be merged as dark regions in the resulting mask (useful in case of multiple ’holes’).

The mask image can be seen as a mask by selecting *[view_mask]* at the upper left of the GUI *uvmat* next to *[REFRESH]*.
For checking purpose, it can be also opened by the browser of *uvmat* like any image.
In the GUI *civ_input*, the mask is introduced by the selecting the green check box *[Mask]*.
Vectors under the mask are not calculated in the resulting velocity data.

![](05-civ-with-mask.png)

Further improvments of the results are discussed in Tutorial/CorrelationImageVelocimetryOptimisation.
