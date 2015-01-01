FROM ubuntu:trusty

RUN apt-get install -qq -y libpng12-0 \
  && apt-get install -qq -y libjpeg62 \
  && apt-get install -qq -y libjpeg8 \
  && apt-get install -qq -y libtiff5

ADD vendor/build/usr-local.tar.gz /

RUN ldconfig
