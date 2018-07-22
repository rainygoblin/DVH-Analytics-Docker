# DVH Analytics Docker
DVH Analytics Docker uses docker-compose to run three Bokeh servers (for main, admin, and settings views) and a 
postgres SQL database. This code is currently under development, may need tweaks to work on Windows or Linux.

DVH Analytics is a software application to help radiation oncology departments build an in-house database of treatment planning data 
for the purpose of historical comparisons and statistical analysis. This code is still in development.  Please contact the developer if  you are interested in testing or collaborating.

The application builds a SQL database of DVHs and various planning parameters from DICOM files 
(i.e., Plan, Structure, Dose). Since the data is extracted directly from DICOM files, we intend
to accommodate an array of treatment planning system vendors.

In addition to viewing DVH data, this software provides methods to:

- download queried data
- view plan contours
- create time-series plots of various planning and dosimetric variables
- calculate correlations
- and generate multi-variable linear regressions.
