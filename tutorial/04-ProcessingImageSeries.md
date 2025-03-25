# Tutorial 04 / Processing Image Series

Open an image in UVMAT_DEMO03_PIVchallenge_2005C, representing a jet seeded by particles (see [UVMAT_DEMO_FILES.zip](https://gricad-gitlab.univ-grenoble-alpes.fr/legi/soft/uvmat-doc/-/raw/master/data/UVMAT_DEMO_FILES.zip?ref_type=heads)).

The series contains 99 image pairs, labelled by a number with 3 digits and a letter index a and b.
The nomenclature type *[NomType]*, given as the first image index, is therefore '001a'.
Activate the menu bar option *[Run/field series]* to open the new GUI *series*. 

This GUI is used to launch various processing programs on field series. The program name is selected in the menu *[ActionName]*.
The default option 'check_data_files' just list the set of input files and checks their existence and type. 

The lower and upper indices for the input field series are given by *first_i, last_i, and first_j, first_j* for the second index a~1 and b~2, with an increment incr_i and incr_j for each index.
The min and max indices in the series are given by the tables *[MinIndex_i], [MaxIndex_i], [MinIndex_j], [MaxIndex_j]*.
As an example, set first_i=50, last_i=100, incr_i=10, first_j=1, last_j=2, incr_j=1.
Pressing *[RUN]*, the function 'check_data_files' is activated and yields the list of file names, with the two last ones, c100a.png and c100b.png, marked as not found. 


## Aver_stat, simple field average

This function provides field average or global statistics on the whole input file series. Let us set first_i=1,last_i=99, incr_i=1.
Then run 'aver_stat'.
The average image is displayed and stored as Images.stat/c001ab.png. 


## Aver_stat, global statistics

Other statistics can be obtained by aver_stat using a projection object.
To create an object, go back to *uvmat*. Then check *Projection object* (tag = *[CheckObject]*) in series. 


## Time_series

This function provides the image intensity at a set of points versus time.
First define the set of points as a projection object, using *uvmat*.
Once you run the function, the GUI *get_field* appears (as well as the *Figure1*) where you can select the coordinates of the figure.


## Data organisation

Functions from series store results in files (except 'check_data_files'), so you need writing access on the data directory. An alternative possibility is to create a mirror directory using symbolic links so that the folders of the original images remains unperturbed.

To create such a mirror, first open the images with the menu bar option *[Open campaign/browse...]* (instead of *[Open/browse...]*).
Press the browser button *[SELECT]* when the camppaign .../UVMAT_DEMO_FILES appears in the upper window *[titlebox]* of the browser (then the list of subfolders appears in the main window *[list]*.
This opens a new GUI *browse_data*. Each example folder is then considered as an 'Experiment', and their subfolders are 'DataSeries'. 
To create a mirror, press *[create_mirror]* and set the path to the mirror folder to be created. 
Then select an *'Experiment'* and a *'DataSeries'* to open by *uvmat*. 

At the next opening you can directly open the mirror folder. 


