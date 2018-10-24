FROM ubuntu
COPY . .
RUN ls .
ENV DEBIAN_FRONTEND noninteractive
RUN  apt-get update \
  && apt-get install -y --no-install-recommends apt-utils \
  && apt-get install -y python3 \
  && apt-get install -y python3-pip \
  && apt-get install -y libmysqlclient-dev \
  && pip3 install pymysql \
  && pip3 install mysqlclient \
  && pip3 install python-memcached \
  && apt-get install -y libmemcached-dev \
  && apt install -y npm \
  && cd cloud_net/ \
  && pip3 install -r ../requirements.txt \
  && cd .. \
  && apt-get install -y build-essential python-dev \
  && pip3 install uwsgi \
  && apt-get install -y nginx \
  && npm install \
