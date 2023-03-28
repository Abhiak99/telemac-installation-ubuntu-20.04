#!/bin/bash


sudo apt-get update && sudo apt-get install -y gfortran libopenmpi-dev libhdf5-serial-dev libnetcdf-dev libfftw3-dev
sudo apt install python3-pip -y
sudo apt-get update && sudo apt-get install -y subversion vim cmake build-essential gfortran mpich subversion python python-numpy dialog
sudo apt install -y python3-numpy python3-scipy python3-matplotlib python3-distutils python3-dev python3-pip

sudo apt install -y git-all git-lfs

 sudo apt install -y gfortran
 sudo apt install -y cmake build-essential dialog


## From here make directory;

mkdir telemac


cd telemac/

git clone https://gitlab.pam-retd.fr/otm/telemac-mascaret.git v8p4

cd v8p4/

git checkout tags/v8p4r0


#parallelism : install MPI

sudo apt install libopenmpi-dev openmpi-bin

#Metis Installation

cd ~/telemac/v8p4/optionals/
mkdir metis-5.1.0
mkdir temp
cd temp
wget http://glaros.dtc.umn.edu/gkhome/fetch/sw/metis/metis-5.1.0.tar.gz
tar xvf metis-5.1.0.tar.gz 
cd metis-5.1.0/

##sudo nano Makefile 
##change prefix = ~/telemac/v8p4/optionals/metis-5.1.0/build/
sed -i 's/^prefix *=.*$/prefix     = ~\/telemac\/v8p4\/optionals\/metis-5.1.0\/build\//'

##       cc = gcc

sed -i 's/^cc *=.*$/cc       = gcc/' Makefile 


sudo cp -a . ~/telemac/v8p4/optionals/metis-5.1.0/

cd ~/telemac/v8p4/optionals/

cd ~/telemac/v8p4/optionals/metis-5.1.0
make config
make
make install

cd ~/telemac/v8p4/optionals/temp/
wget https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-1.8/hdf5-1.8.14/src/hdf5-1.8.14.tar.gz
tar xvf hdf5-1.8.14.tar.gz
cd hdf5-1.8.14/
./configure --prefix=/home/scorpion/telemac/v8p4/optionals/hdf5 --enable-parallel
make
make install

sudo apt install zlib1g zlib1g-dev
sudo apt install libhdf5-dev hdf5-tools

wget wget http://files.salome-platform.org/Salome/other/med-4.1.1.tar.gz

tar xvf med-4.1.1.tar.gz
cd med-4.1.1_SRC/


#./configure --prefix=/home/scorpion/telemac/v8p4/optionals/med-4.1.1 --with-hdf5=/home/scorpion/telemac/v8p4/optionals/hdf5 --disable-python


#Uncomment all

./configure --prefix=/home/scorpion/telemac/v8p4/optionals/med-4.1.1 --disable-python

make 
sudo make install

cd ../../
cd temp

wget http://www.opentelemac.org/downloads/Installation%20files/Manual%20installation%20-%20Sources/aed2_1.2.tgz

tar xvf aed2_1.2.tgz

cd aed2_1.2/

make shared

mkdir -p ~/telemac/v8p4/optionals/aed2_1.2/include
mkdir ~/telemac/v8p4/optionals/aed2_1.2/lib
cp *.mod ~/telemac/v8p4/optionals/aed2_1.2/include
cp include/* ~/telemac/v8p4/optionals/aed2_1.2/include
cp libaed2.so ~/telemac/v8p4/optionals/aed2_1.2/lib

#cd ~/telemac/v8p4/configs
#source pysource.openmpi-aed2.sh

#config.py


#https://medium.com/@hani.ramadhan/install-telemac-on-linux-ubuntu-system-worked-2022-bab5b88df0e3
