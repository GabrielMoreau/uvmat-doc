# Tutorial 06 / Correlation Image Velocimetry: optimisation of parameters

To improve the results from the previous tutorial, open again in the GUI *series, *and enter the file 'frame_1.png' in 'UVMAT_DEMO01_pair/images'.
Select the *[ACTION]* function 'civ_series' which opens the new GUI *civ_input*.
You may import existing processing  parameters by pushing the button *[Import]* at the top left of the GUI *civ_input*: open the parameter file 'images.civ/0_XML/frame_1.xml' in the browser, or fill the GUI by hand as follows.


## Time interval

The first parameter to adjust is the time interval between images, which should be sufficiently long to provide a displacement of a few pixels.
The measurement precision is typically 0.2 pixel, so that a displacement of 4 pixels, as in the example, provides a relative precision of 5 %.
A larger displacement would be preferable in terms of precision but may yield to poor image correlation and ’false vectors’.
The choice of image pair is done in *[ListPairCiv1]*.

In our example we can only select 'dt=1' as we only have two images.
In order to increase the time interval and select an increment in the PIV calculation we need multiple images.


## Civ1 parameters

Once the image pair has been chosen, the next parameter is the size of the correlation box in both directions (*[num_CorrBoxSize]_1]* and *_2*), expressed in pixels.
A smaller box of course improves the spatial resolution but it involves less statistics and false vectors may result from holes in the particle seeding.
The particles are densely packed in this example, so we can significantly reduce the size from the default value [25 25] to [19 13] (in image pixels).
The use of a elongated box along _x_ allows the optimization of the resolution in the direction _y_, to deal with the transverse shear.

The next parameters are  *[num_SearchBoxSize_1]*,*_2* and *[num_SearchBoxShift_1]*,*_2*, which determine the box in which the sub-image of the first frame is allowed to move to match the second frame.
This can be adjusted from a prior estimate of the extrema of each velocity component (expressed in pixel displacement).
Select *[SEARCH RANGE]*, introduce [min, max] =[ -2; 6] for ’u’ and [-3; 3] for ’v’, and press the button *[Search Range]* again.
The optimum search ranges and shifts (for the given correlation box) are  now displayed: [33 25] and [2 0] respectively.

The PIV operation is conveniently visualised by pressing the button *[TestCiv1]* in the GUI *civ*.
Then the image appears in a new GUI *view_field*, in which the mouse motion displays the correlation function as a color map in a secondary window.
The resulting vector is shown  as a line pointing to the correlation maximum.
The corresponding  correlation and search boxes are shown in the image.

Unselect all operations except *[CIV1]* and validate the parameters by pressing *[OK]*.
Then run 'civ_series' in the GUI *series *and look at the result by pressing *[STATUS]*, and open the '.nc' result file.

To observe the influence of the search box, come back to the GUI *civ_input*, set *[CorrBoxSize]*=[19 13] and *[SearchBoxSize]*=[27 25] with *[Shift]*=0, and visualise the result with *uvmat*.
Many black vectors (F=-2) are obtained, showing that the search domain is too small, so that the correlation maximum is constrained by the limited search interval.
Using *[TestCiv1]*, it can be seen that the correlation maximum is indeed at the edge of the Search box in the main flow with u$\simeq$4 (while a gap of 2 pixels is required to properly determine the maximum without edge effect).

The parameter *[num_CorrSmooth]* is used to fit the correlation data with a Gaussian function to obtain the maximum with sub-pixel precision.
We generally keep the default value 1, while the value 2 should be more appropriate for larger particles (with wider correlation maximum).
The quality of this feature can be tested by taking the image autocorrelation, selecting the option 'displacement' instead of 'PIV' in the menu *[ListCompareMode]* of *civ_input*.
Then run the *[CIV1]* computation with *series*.
Visualise the velocity field with uvmat: it is very close to 0 as expected but the histogram of the error can be estimated with the Tool/rectangle.
The curve exported from *view_field* is shown in figure below, comparing *[CorrSmooth]*=1 and 2.
We see that the histogram is somewhat more narrow for *[CorrSmooth]*=1, corresponding to a slightly better result, but the typical error of the order of 0.1 px in both cases.

![](06-corr1vs2.png)

The parameters *[num_Dx]* and *[num_Dy]* define the mesh of the measurement grid, in pixels.
Reduce them to get more vectors, but keep in mind that the spatial resolution is anyway limited by the size of the correlation box, so that velocity vectors become redondant when the sub-images highly overlap those of the neighboring vector.
Then the choice *Dx*=*Dy*=10, about half the correlation box, provides a good optimum.

Finally select the *[Mask]* check box like in the previous tutorial.


## Fix1 parameters

Select the *[FIX1]* operation, which eliminates some false vectors using several criteria.
Use the default parameters.


## Patch1 parameters

Select the ’*PATCH1*’ operation, to interpolate the vectors and calculate spatial derivatives.
First choose the default parameters, press OK, run the caluclation and visualise with *uvmat*.
We observe that a few erratic vectors have been flagged as false (painted in magenta).

Two fields can be visualised, as selected by the menu *[VelType]* in the upper part of *uvmat*: the initial field 'civ1' and the smoothed one 'filter1', obtained by the spline interpolation/smoothing of *[PATCH1]*.
Select the option 'blank' in the menu* [TransformName]* (on the left side of *uvmat*), to observe fields as displacement in pixel units (not physical coordinates), which is the appropriate option to analyse PIV features.

The difference between the two fields can be directly visualized by selecting *[CIV1]* in the menu *[VelType]* and 'filter1' in the menu *[VelType_1]* just below.
Adjust the scale *[num_VecScale]* (value 10 for instance) to better see the difference.
This is rather small (0.1 px) and erratic, except in the strong shear close to the cylinder, where it reaches a value about 0.3, so the smoothing properly reduces the noise without excessive perturbation of the velocity field itself.
You can also use the scalar representation, selecting the field 'U' for both 'civ1' and 'filter1'.
Projection on a line (as described in tutorial 2) is also useful to get field values on a plot.

Repeat the operations by choosing the value 100 for *[FieldSmooth]* instead of the default value 10.
Now the smoothing effect is quite clear, widening the shear region at the edge of the cylinder.

Now come back to the default value 10, and press the button *[TestPatch1]*.
This will perform patch calculations with a range of values for the smoothing parameters, and provide the rms difference between the filtered velocity field and the initial Civ1 field.
This ranges from 0.12, *[FieldSmooth]*=1, to more than 0.2 for *[FieldSmooth]*=100.
The value 0.15 for *[FieldSmooth]*=10 is less that the expected error on the PIV, about 0.2 pixel.

![](06-41.png)

This test also provides the proportion of excluded vectors (marqued as false) by the criterion of the excessive difference between the Civ1 value and the filtered one, which is attributed to false vectors.
The threshold (expressed in pixels) is given by the box *[num_MaxDiff]*.
The result obtained with the default value 1.5 is about 2 %, so that most vectors are preserved.
Repeating the test  with a higher value, for instance 10, logically reduces the number of rejected vectors, but significantly increases the rms difference: the interpolation is perturbed by a few erratic vectors.

The last parameter for *[PATCH1]* is *[num_SubDomainSize]* which corresponds to a partition in subdomains for the spline calculation, in order to avoid computer memory overflow in  the spline calculation.
In this case the default choice 100 leads to a single domain.


## Civ2, Fix2 and Patch2

The *[CIV2]* operation repeats the *[CIV1]*, but it uses the result of Patch1 as a prior estimate.
Therefore while Civ1 is purely local, Civ2 restricts the research to a correlation maximum which is close to the values obtained for neighboring vectors.

The parameter  *[num_SearchBoxShift]* therefore does not appear in the Civ2 panel, as it is given at each point by the result Patch1.
The other parameters have the same meaning as for Civ1.
The search box must be small enough to effectively reduce the research to the prior estimate.
Take *[CorrBoxSize]* +13 in each direction (providing a margin of 3 pixels on each side of the correlation box).
Since it is the final result, you can optimise the grid by taking *Dy*=5.

The parameter *[deformation]* (check box) improves the prior estimate by deforming the subimage taking into account the velocity gradients, so it can improve the processing in zones of strong shear or strong rotation, like vortex cores.
It involves an interpolation of the sub-images to perform the deformation.

*[FIX2]* and *[PATCH2]* act on the Civ2 results like *[FIX1]* and *[PATCH1]* on the Civ1 results.
Choose a smaller smoothing parameter *[FieldSmooth]*=2, to limitate systematic smoothing effects in the final result.

The final vorticity field can be observed in the following figure, in which the  vorticity roll up in the wake of the cylinder is clearly visible.
A zoom  near a vortex shows the vorticity superposed with velocity vectors.

A cut of the velocity along a transverse line x=250, y from 0 to 300 (in pixel coordinates), provides a good representation of the strong velocity shear in the wake of the cylinder.
This can be done by displaying the velocity field filter2, open a line (*[Projection object/line]*) and in *set_object* choose *[ProjMode]*=inter_tps, *Mesh*=2 to get the profile with spline interpolation from filter2.
Then select hold on on the GUI view_field and repeat the same cut with the field 'civ2', *[ProjMode]*='projection'.
We can then compare the civ2 measurement points to the interpolation, showing some fluctuations are smoothed out but without widening of the strong shear zone.
The result has been exported in figure, using the menu bar tool *[Export/extract figure]* in *view_field*.
The typical precision can be estimated from the scattering of the points as +-0.1 px, with typically 5-10 pixels in spatial resolution.

![](06-rms-patch1-civ1.png)
![](06-vort-civ3-2.jpg)
![](06-vort-vel-zoom.jpg)


## Example of an intense vortex

With the GUI *uvmat* open an image in '/UVMAT_DEMO04_PIVchallenge_2001A/images' taken from PIV challenge ([see website](http://www.pivchallenge.org/)).
A short description of the experimental conditions is given in the file 'readme.txt' in the folder of the images.
It is said that the flow seen in the image is the vortex behind a airplane.
In term of PIV features, it represents a case with poor particle seeding in the vortex core.
It is said that the field of view is 170 x140 mm, so that, since the image size is 1280x1024 px, the scale is 7.4 px/cm, but there is no information about the time interval Dt.

From *uvmat* select *[Run/PIV]* so the GUI *civ_input* pops up.
With the option *[ImportParam]*, import the parameters from the file 'Images.ref.civ/0_XML/A_1_1.xml' and *[RUN]* the civ calculation.
The result should look like the reference result 'Images.ref.civ/A_1_1-2.nc'.
As expected from the dark spot at the vortex centre, the core is not properly resolved in civ1.
The result is improved in civ2.

Let us improve again the result by a third civ iteration.
This is launched in the GUI *series*, opening  the netcdf file result of the previous Civ2 calculation instead of an image.
The source image then automatically appears in the second line of the input table of *series*.
Unselect the option *[CIV1]*, *[FIX1]* and *[PATCH1]*, and select the check box *[CIV3]* in the frame *[CIV2]*.
Then *[RUN]* the civ calculation, saving the result in a new folder 'Images.civ_1'.
The final result is shown in the figure below, with a cut across the vortex core at y=500 pixel.

![](06-vortex.png)
