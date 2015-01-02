# Vagrant Files

This folder contains vagrant-related files to run vagrant and use it for development.

## Vagrantfile

Vagrant file for IMS installs the a generic image found at https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box (Ubuntu 14.04 LTS - Trust Tahr).  The shell script "provision.sh" is then used to provision the virtual machine.

## Development Environment Packages installed

The purpose of the Vagrantfile and provision.sh is to compile Leptonica and Tesseract OCR for use in a Docker image.  The source used to build Leptonica and Tesseract OCR can be found in the vendor folder as .tar.gz files.  If a newer version of Leptoncia and/or Tesseract OCR becomes available, these source files should be updated.

__Note__:  Updating the .tar.gz files may require updating the paths used in provision.sh, depending on how the vendor chooses to archive and compress the source files.

Vagrantfile and the provision script installs the following:

* linux-image-3.13.0-43-generic x86_64
* linux-headers-3.13.0-43-generic x86_64
* VirtualBox Guest Additions 4.3.18
* Docker (latest)
* libpng12-dev
* libjpeg62-dev
* libtiff4-dev
* automake
* build-essential
* libtool
* Leptonica 1.71
* Tesseract OCR 3.04

Once Leptonica and Tesseract OCR are compiled, the traineddata are copied from /vagrant/vendor/tessdata/ to /usr/local/share/tessdata.  /usr/local/ is then archived and compressed as a tar.gz file (/vagrant/vendor/build/usr-local.tar.gz).  This file is used to create the docker image.
