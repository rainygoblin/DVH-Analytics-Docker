<h3 align="center">
  <img src="https://user-images.githubusercontent.com/4778878/30754005-b7a7e808-9f86-11e7-8b0f-79d1006babdf.jpg" alt="fastlane Logo" />
</h3>

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


### Installation

The purpose of DVH Analytics Docker is to greatly simplify the installation process
of DVH Analytics.

1) If needed, download and install Docker. It's free and available [here](https://www.docker.com/community-edition).
2) Download our [docker-compose.yml](https://raw.githubusercontent.com/cutright/DVH-Analytics-Docker/master/docker-compose.yml) 
file to a location of your choosing.
3) Create a folder in your home directory 'DVH-Analytics' or replace any reference to '~/DVH-Analytics/' in 
docker-compose.yml with any other folder you like. Be sure to keep directories to right of the colon the same.
4) From a terminal or command prompt, navigate to the directory with your docker-compose.yml, type `docker-compose up`.

5) From here, there are three views: 
    * Main: http://localhost:5006
    * Admin: http://localhost:5007
    * Settings: http://localhost:5008

### Initialization

1) Ensure DVH Analytics can talk to the SQL database:
    * If you are using Windows or Linux, navigate to localhost:5008 (Settings view).
    * Under SQL settings, update the host for your OS and Docker version.
    * Click "Save."  Then click "Echo" to be sure the connection works.
2) Import data:
    * Place DICOM data in ~/DVH-Analytics/dicom/inbox
        * Be sure each patient set includes dose, structure, and plan
        * If you include any other DICOM files, they will be catalogued and organized, but not used otherwise.
    * Navigate to localhost:5007 (Admin view).
    * Click "Import all from inbox" (this may take a while).
    * After all data is imported, click on ROI Name Manager.
    * In the text field next to two sets of radio buttons, enter any physician initials/names as would be 
    found in the imported DICOM files.
    * Click "Remap all ROIs in DB."
    * Add any Institutional and Physician ROIs needed, peruse the uncategorized variations, add 
    them as variations to the appropriate Physician ROI or click ignore or delete.
    * Click "Remap all ROIs in DB" or "Remap all ROIs for Physician" as needed.
    * Go back to the Database Editor tab.
    * Click "Calc PTV Distances"
    * After PTV distances are calculated, click "Calc PTV Overlap."
3) Enjoy:
    * Navigate to localhost:5006
    * Design your query and explore.
 
### General Notes

Some installation challenges with DVH Analytics that are resolved with Docker:
* Complete DVH Analytics [docker image](https://hub.docker.com/r/cutright/dvh-analytics/) is used.
* A workaround for [this](https://github.com/bokeh/bokeh/issues/7771) Bokeh bug is applied.
* Postgres SQL is included (so no need for setting up a database and user access).
* All three servers for the main, admin, and settings views are started.

Some current challenges with DVH Analytics Docker:
* Docker links to your computer's localhost differently for different operating systems. We'll link to 
additional information about this when we start testing outside fo Mac OS. We will either generate 
new docker images per OS, or provide easy instructions to update the SQL login information.
* Linking your home folder varies with operating system. This affects the volume mounts in each 
service in the docker-compose file. In the mean time, you can update the local directories to the left of the colon 
on lines relating to volume in each service
* If you're already running services on ports 5432, 5006, 5007, or 5008, you'll need to modify lines 14, 21, 32, and 43 of 
docker-compose.yml. The port to the left of the colon is local, keep the port to the right the same. If 5432 (for postgres) is altered 
you'll need to update the port listed when launching the settings view normally on port 5008.

To ensure continuity of data, the postgres SQL database is mapped to a local directory 
(by default ~/DVH-Analytics/pgsql).  

More notes to come. And we'll look into streamlining this further, but hopefully using Docker will alleviate 
many of the headaches associated with installing a plethora of python dependencies and setting up a SQL database.
