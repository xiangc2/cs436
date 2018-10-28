FROM ubuntu
COPY . /lab4_cloudnet/ 
RUN  apt-get update \
  && cd lab4_cloudnet \
  && apt-get install -y --no-install-recommends apt-utils \
  && apt-get install -y python3 \
  && apt-get install -y python3-pip \
  && apt-get install -y libmysqlclient-dev \
  && pip3 install pymysql \
  && pip3 install mysqlclient \
  && pip3 install python-memcached \
  && apt-get install -y libmemcached-dev \
  && apt install -y npm \
  && apt-get install -y curl \
  && npm cache clean -f \
  && npm install -g n \
  && n stable \
  && cd cloud_net \
  && pip3 install -r ../requirements.txt \
  && cd .. \
  && apt-get install -y build-essential python-dev \
  && pip3 install uwsgi \
  && apt-get install -y nginx \
  && service nginx start \
  && npm install; exit 0 \
  && cp mysite_nginx.conf /etc/nginx/sites-available/mysite_nginx.conf
ADD mysite_nginx.conf /etc/nginx/sites-available/mysite_nginx.conf
RUN ln -s /etc/nginx/sites-available/mysite_nginx.conf /etc/nginx/sites-enabled/ \
  && cd /lab4_cloudnet \
  && npm install material-ui-icons@1.0.0-beta.17 \
  && npm install material-ui@1.0.0-beta.34 \
  && npm install react-cookie \
  && npm run build \
  && python3 manage.py collectstatic
EXPOSE 8000/tcp
WORKDIR "/lab4_cloudnet"
CMD service nginx start; npm start
