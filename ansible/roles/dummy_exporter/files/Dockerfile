FROM ubuntu:14.04

ADD my_dummy_exporter.py /
ADD run_my_dummy_exporter.sh /

RUN chmod +x /my_dummy_exporter.py
RUN chmod +x /run_my_dummy_exporter.sh
RUN apt-get -y update && apt-get install -y python-minimal

CMD [ "bash", "/run_my_dummy_exporter.sh", "start" ]
#CMD [ "python", "my_dummy_exporter.py" ]
