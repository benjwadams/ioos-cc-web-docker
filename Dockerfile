FROM phusion/baseimage
MAINTAINER Ben Adams <ben.adams@rpsgroup.com>
RUN apt-get update
RUN apt-get install -y python \
                       python-pip \
                       python-virtualenv \
                       libxml2-dev \
                       python-dev \
                       nodejs \
                       npm \
                       git \
                       libhdf5-dev \
                       libnetcdf-dev \
                       libxslt1-dev \
                       libudunits2-0
RUN npm install -g bower && useradd -m nonroot
WORKDIR /home/nonroot
RUN sudo -u nonroot git clone https://github.com/ioos/compliance-checker-web
WORKDIR compliance-checker-web
RUN pip install -r requirements.txt && \
    pip install gunicorn supervisor && \
    ln -s /usr/bin/nodejs /usr/bin/node && \
    npm install -g grunt-cli
# copy supervisor configs
COPY supervisor_files/supervisord.conf supervisor_files/supervisor.d /etc/
COPY supervisor_files/supervisor.d /etc/supervisor.d
# Debian-based distros seem to have a different name for the node binary,
# which is called by programs such as bower
USER nonroot
# maximum size of the NetCDF file.  Defaults to 100MB
ENV MAXSIZE 100000000
RUN mkdir /tmp/logs && \
    cp config.yml config.local.yml && \
    npm install && \
    bower install && \
    grunt
COPY entrypoint.sh .
ENTRYPOINT ["./entrypoint.sh"]
CMD ["supervisord", "-n", "-c", "/etc/supervisord.conf"]
