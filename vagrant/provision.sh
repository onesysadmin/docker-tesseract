#!/usr/bin/env bash
set -ev

# some libraries are installed invidually due to dependencies
apt-get -qq update
apt-get -qq -y install libpng12-dev
apt-get -qq -y install libjpeg62-dev
apt-get -qq -y install libtiff4-dev
apt-get -qq -y install automake
apt-get -qq -u install checkinstall

apt-get -qq -y install build-essential libtool

# should test this part out... might need to run after vagrant is already up
# use .tar.gz files in vendor folder as source for Leptonica and Tesseract OCR
tar -xzf /vagrant/vendor/source/leptonica-1.71.tar.gz
cd leptonica-1.71
./configure
make
checkinstall -y
ldconfig
cd ..
rm -r leptonica-1.71

tar -xzf /vagrant/vendor/source/tesseract-ocr-4da712d04db9.tar.gz
cd tesseract-ocr-4da712d04db9
./autogen.sh
./configure
make
checkinstall -y
ldconfig
cd ..
rm -r tesseract-ocr-4da712d04db9

# copy traineddata to /usr/local/share/tessdata/
cp /vagrant/vendor/tessdata/* /usr/local/share/tessdata/.

# zip and archive /usr/local/ for use in docker image
tar -czf /vagrant/vendor/build/usr-local.tar.gz /usr/local/

# auto install newest version of docker
curl -sSL https://get.docker.io/ubuntu/ | sudo sh
