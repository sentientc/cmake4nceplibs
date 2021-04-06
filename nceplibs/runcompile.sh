#!/bin/bash
echo $LD_LIBRARY_PATH
export FC=mpiifort
export CC=mpiicc
export CXX=mpiicpc
export CPP="mpiicc -E"
export CXXCPP="mpiicpc -E"
export MPIF90=mpiifort
export MPIFC=mpiifort
export MPICC=mpiicc
export MPICXX=mpiicpc
#export MPICXX=mpiicpc
export F9X=mpiifort
export MPITYPE intelmpi
export wd=`pwd`
export td=/opt/pkg/NCEPLIBS
export tv=1.3.0-intel21
export LD_LIBRARY_PATH=${td}/${tv}/lib:/opt/pkg/NCEPLIBS-external/lib:$LD_LIBRARY_PATH:/lib:/lib64
export LIBRARY_PATH=${td}/${tv}/lib:/opt/pkg/NCEPLIBS-external/lib:$LIBRARY_PATH:/lib:/lib64
export INCLUDE=${td}/${tv}/include:/opt/pkg/NCEPLIBS-external/include:$INCLUDE:/usr/include
root=/opt/pkg/NCEPLIBS-external/bbc872c-intel21
export    ZDIR=$root
export    ZLIB_PATH=$root/lib
export    NCDIR=$root
export    NETCDFF=$root
export    NETCDF=$root
export    NETCDF4=1
export    NETCDF_DIR=$root
export    NetCDF_Fortran_INCLUDE_DIRS=$root/include
export    NETCDF_PATH=$root
export    PNETCDF_PATH=$root
export    PNETCDF=$root
export    H5DIR=$root
export    HDF5=$root
export    PHDF5=$root
export    HDF5_PATH=$root
export    HDF_DIR=$root
export    HDF5_ROOT=$root
export    ESMFMKFILE=$root/lib/esmf.mk
export    ZLIB_ROOT=$root
export    PNG_ROOT=$root
export    JPEG_ROOT=$root
export    Jasper_ROOT=$root
export    WGRIB2_ROOT=$root
export    JASPERLIB=$root/lib
export    JASPERINC=$root/include

mkdir -p build
mkdir -p ${td}/${tv}
rm -rf build/*
cd build
cmake .. -DCMAKE_INSTALL_PREFIX=${td}/${tv} -DOPENMP=ON -DEXTERNAL_LIBS_DIR=$NETCDF_DIR -DCMAKE_INSTALL_LIBDIR=lib -DCMAKE_INSTALL_INCLUDEDIR=include -DFLAT=ON -DTCLMOD=ON -DDEPLOY=ON
make -j2
make tcl
#make deploy
echo $wd > ${td}/${tv}/srcpath

