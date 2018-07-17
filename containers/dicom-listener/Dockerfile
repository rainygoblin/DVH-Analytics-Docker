FROM ubuntu

RUN apt-get update \
    && apt-get -y install dcmtk \
    && mkdir /dicom \
    && mkdir /dicom/inbox

CMD ["storescp", "2000", "-od", "/dicom/inbox", "-sp"]