# Docker file for DVH-Analytics
# http://dvh-analytics.com
# Created on Sun Jul 15 2018
# @author: Dan Cutright, PhD

# Docker file based on ubuntu with Bokeh bug fix
FROM cutright/bokeh

# install DVH Analytics requirements sans Bokeh
RUN mkdir /import_and_connection
RUN pip install dvh-analytics=='0.5.2' --no-deps
RUN mkdir /usr/local/lib/python2.7/dist-packages/dvh/backups

# Run main DVH Analytics web app accessible from user's web browser at localhost:5006
CMD ["dvh", "run", "--allow-websocket-origin=localhost:5006", "--port=5006", "--bypass-sql-test"]
