# Installation notes for DVH Analytics Docker

The purpose of DVH Analytics Docker is to greatly simplify the installation process
of DVH Analytics. If you haven't already, you're going to need to install 
Docker. It's free and available [here](https://www.docker.com/community-edition).

Some installation challenges with DVH Analytics that are resolved with Docker:
* Complete DVH Analytics [docker image](https://hub.docker.com/r/cutright/dvh-analytics/)
* A workaround for [this](https://github.com/bokeh/bokeh/issues/7771) Bokeh bug is applied 
the DVH Analytics docker image.
* Postgres SQL is included (so no need for setting up user and database).
* All three servers for the main, admin, and settings views are started.

Some current challenges with DVH Analytics Docker:
* Docker links to your computer's localhost differently for operating systems. We'll link to 
additional information about this when we start testing outside fo Mac OS. We will either generate 
new docker images per OS, or provide easy instructions to update the SQL login information.
* Linking your home folder varies with operating system. This affects the volume mounts in each 
service int the docker-compose file. In the mean time, you can update the local directories to the left of colon 
on lines 16, 23, 34, and 45.
* If you're running services on ports 5432, 5006, 5007, or 5008, you'll need to modify lines 14, 21, 32, and 43 of 
docker-compose.yml. The port to left of the colon is your local, keep the port to the right the same. If 5432 (for postgres) is altered 
you'll need to update the port listed when launching the settings view normally on port 5008.

Once you've installed Docker, copy docker-compose.yml to a directory of your choosing. Navigate to this directory 
in a terminal and call `$ docker-compose up`. Open a web browser and navigate to localhost:5007.  If this does not 
launch, then DVH Analytics cannot talk to SQL.  Navigate to localhost:5008 and update the SQL connection settings 
for you OS... the likely culprit is changing host from docker.for.mac.localhost to the appropriate one for your OS. 
Note that updating the import settings locations here only reflect the location within the docker container. 
If you'd like these mapped to somwhere else locally, you should update the volumes in docker-compose.yml.
Now you should be able to view a page at localhost:5007 (the admin view). You'll need your hands on some DICOM data including 
RT Plan, RT Dose, and RT Struct for each patient set; place these in ~/DVH-Analytics/dicom/inbox, then click 
Import in the admin view.  Once that's completed entirely, the main view shoudl be accessible at localhost:5006.

More notes to come. And we'll look into streaming lining this further, but hopefully using Docker will alleviate 
many of the headaches associated with installing a plethora of python dependencies and setting up a SQL database.