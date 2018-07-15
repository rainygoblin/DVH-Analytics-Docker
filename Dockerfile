FROM python:2
RUN pip install dvh-analytics==0.3.45
RUN mkdir /DVH-Analytics
CMD ["dvh", "run", "--allow-websocket-origin=localhost:5006", "--port=5106"]