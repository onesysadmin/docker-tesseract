docker-tesseract
================

Tesseract in a Docker Container.  The purpose of this project is to build the latest version of Tesseract OCR and make it available in a Docker Container.  Tesseract OCR can be installed using a package management tool (like APT) instead, but this may not be the latest version and build of Tesseract OCR, which may contain additional desired features.

To mimimize the size of the Docker image, the project is built in 2 parts.  Vagrant is used to install the dev libraries and tools needed to build Leptonica and Tesseract OCR.  The built files are then zipped and used to create a Docker image.  This eliminates the need to install the dev libraries and tools in the docker image.

##Stack

The project contains 2 parts that use the following:

* Ubuntu Trust (14.04.x)
* Virtualbox with Guest Additions (4.3.18)
* Vagrant
* Docker
* libpng12-dev
* libjepg62-dev
* libtiff4-dev
* automake
* checkinstall
* build-essential
* libtool
* libpng12-0
* libjpeg62
* libjpeg8
* libtiff5

##Build

1.  Install Virtualbox and Vagrant if needed
2.  Copy vagrant/Vagrantfile.default to ./Vagrantfile
  1.  Note that the file name changes from Vagrantfile.default to Vagrantfile
  2.  Review Vagrantfile to make sure that the configuration is valid and make changes if needed.  This is why a Vagrantfile isn't included in the project, and Vagrantfile.default is provided in a subfolder instead
  3.  To successfully build the project, the OS used for Vagrant and Docker needs to match
3.  Run 'vagrant up' in the project root
  1.  This will also run 'vagrant/provision.sh' which is used to provision the Vagrant VM
  2.  Tesseract OCR requires Leptonica.  Different versions of Tesseract require different versions of Leptonica.  For example, Tesseract OCR v3.03 requires Leptonica 1.70+.  This project currently builds Tesseract OCR v3.04 with Leptonica v1.71
  3.  To avoid errors during provisioning, the source files for Tesseract OCR and Leptioncia are stored in '.tar.gz' files in the 'vendor/source/' folder
  4.  Tesseract OCR requires traineddata files to successfully OCR images.  A default set of traineddata files can be found in the 'vendor/tessdata/' folder.  These files are copied to '/usr/local/share/tessdata/' once Tesseract OCR has been built successfully duringing provisioning
  5.  During provisioning, once Leptionica and Tesseract OCR have been successfully built and the traineddata files have been copied, 'vendor/provision.sh' will create a compressed archive file of '/usr/local' at 'vendor/build/usr-local.tar.gz'
4.  Run 'sudo docker build .'
  1.  The image libraries (libpng12-0, libjpeg62, libjpeg8, and libtiff5) need to be installed for Tesseract OCR to work (found in Dockerfile)

##Updating Leptonica and Tesseract OCR Source Files and Adding Tesseract Traineddata

To update the Leptonica and Tesseract OCR source files, download the desired '.tar.gz' file and save to 'vendr/source/'.  The 'provision.sh' file will also need to be updated, since the downloaded filenames may be different, and the folder the files are extracted to may be different.

* Leptonica - http://www.leptonica.org/
* Tesseract OCR - https://code.google.com/p/tesseract-ocr/

To add Tesseract OCR traineddata files, copy the traineddata files to 'vendor/tessdata/' and the traineddata files will be added during the build of the Docker image.

##Using the Container

1.  Run 'sudo docker run -i -t -v &lt;host absolute path&gt;:&lt;docker path&gt; &lt;image id&gt;'
2.  Run 'sudo docker pull onesysadmin/tesseract' or use a Dockerfile with 'FROM onesysadmin/tesseract'
3.  Build the image as described above if changes to the default configuration provided are needed

