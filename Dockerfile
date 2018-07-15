# Docker file for DVH-Analytics
# http://dvh-analytics.com
# Created on Sun Jul 15 2018
# @author: Dan Cutright, PhD

# ------------------------------------------------------------------------------
# This block of code installs bokeh as is.  The following block of code installs
# a modified version of bokeh removing the use of repaint() in plot_canvas.ts,
# which significantly slows down DVH Analytics since it's a very large layout
# ------------------------------------------------------------------------------
# Docker file based on python image
#FROM python:2
#RUN pip install dvh-analytics==0.3.45
#RUN mkdir /DVH-Analytics
#CMD ["dvh", "run", "--allow-websocket-origin=localhost:5006", "--port=5106"]

# Docker file based on ubuntu with modified Bokeh
FROM ubuntu
RUN apt-get update \
    && apt-get -y install python-pip \
    && apt-get -y install git-core

# install DVH Analytics requirements sans Bokeh
ADD ./requirements.txt /
RUN pip install -r requirements.txt \
    && pip install dvh-analytics==0.3.46 --no-deps

# Install node.js, needed to install custom version of BokehJS
RUN apt-get update -yq \
    && apt-get install curl gnupg -yq \
    && curl -sL https://deb.nodesource.com/setup_8.x | bash \
    && apt-get install nodejs -yq

# Download Bokeh, edit plot_canvas.ts
RUN mkdir bokeh
ADD https://github.com/bokeh/bokeh/archive/0.13.0.tar.gz /bokeh
RUN tar -C /bokeh -xvf /bokeh/0.13.0.tar.gz \
    && rm /bokeh/bokeh-0.13.0/bokehjs/src/lib/models/plots/plot_canvas.ts
ADD ./plot_canvas.ts /bokeh/bokeh-0.13.0/bokehjs/src/lib/models/plots/plot_canvas.ts

# Install custom version of BokehJS
WORKDIR /bokeh/bokeh-0.13.0/bokehjs
RUN npm install -g npm \
    && npm install --no-save

# Install Bokeh with custom version of BokehJS
WORKDIR /bokeh/bokeh-0.13.0
RUN python setup.py install --build-js

# Run main DVH Analytics web app accessible from user's web browser at localhost:5006
CMD ["dvh", "run", "--allow-websocket-origin=localhost:5006", "--port=5106"]
