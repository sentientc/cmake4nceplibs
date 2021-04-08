#!/bin/bash
#cannot make cmake work properly so here is some compromise
prt=${1:-1}
export MPICHLIB_CFLAGS="${CFLAGS}";      unset CFLAGS
export MPICHLIB_CXXFLAGS="${CXXFLAGS}";  unset CXXFLAGS
export MPICHLIB_CPPFLAGS="${CPPFLAGS}";  unset CPPFLAGS
export MPICHLIB_FFLAGS="${FFLAGS}";      unset FFLAGS
export MPICHLIB_FCFLAGS="${FCFLAGS}";    unset FCFLAGS
export MPICHLIB_LDFLAGS="${LDFLAGS}";    unset LDFLAGS
export CC=mpiicc
export FC=mpiifort
export CXX=mpiicpc
export CPP="mpiicc -E"
export CXXCPP="mpiicpc -E"
export MPIF90=mpiifort
export MPIFC=mpiifort
export MPICC=mpiicc
export MPICXX=mpiicpc
export F9X=mpiifort
export MPITYPE=intelmpi
export wd=`pwd`
export LDFLAGS=-fPIC
export RUNPARALLEL="mpiexec.hyrda" 
export OMPI_MCA_disable_memory_allocator=1 
export td=/opt/pkg/NCEPLIBS-external
export tv=bbc872c-intel21
export PATH=${td}/${tv}/bin:$PATH
export LD_LIBRARY_PATH=${td}/${tv}/lib:$LD_LIBRARY_PATH:/lib:/lib64
export LIBRARY_PATH=${td}/${tv}/lib:$LIBRARY_PATH:/lib:/lib64
export INCLUDE=${td}/${tv}/include:$INCLUDE:/usr/include
echo $LD_LIBRARY_PATH
mkdir -p ${td}/${tv}
mkdir -p build
rm -rf build/*
cp -f config_netcdfc.sh_nopnetcdf.tmpl config_netcdfc.sh.tmpl
cp -f CMakeLists_nopnetcdf.txt CMakeLists.txt
cd build
if [ $prt -eq 1 ];then
cmake .. -DCMAKE_INSTALL_PREFIX=${td}/${tv} -DCMAKE_INSTALL_LIBDIR=lib \
 -DCMAKE_INSTALL_INCLUDEDIR=include -DBUILD_MPI=OFF -DDEPLOY=ON \
 -DBUILD_NETCDF=ON -DBUILD_JASPER=ON -DBUILD_PNG=ON -DBUILD_WGRIB2=OFF \
 -DBUILD_ESMF=OFF -DBUILD_HDF5=ON -DBUILD_PNETCDF=ON
make
fi
if [ $prt -eq 2 ];then
cmake .. -DCMAKE_INSTALL_PREFIX=${td}/${tv} -DCMAKE_INSTALL_LIBDIR=lib \
 -DCMAKE_INSTALL_INCLUDEDIR=include -DBUILD_MPI=OFF -DDEPLOY=ON \
 -DBUILD_NETCDF=OFF -DBUILD_JASPER=OFF -DBUILD_PNG=OFF -DBUILD_WGRIB2=OFF \
 -DBUILD_ESMF=OFF -DBUILD_HDF5=OFF -DBUILD_PNETCDF=ON
make
fi
if [ $prt -eq 3 ];then
cp -f ../config_netcdfc.sh_pnetcdf.tmpl ../config_netcdfc.sh.tmpl
cmake .. -DCMAKE_INSTALL_PREFIX=${td}/${tv} -DCMAKE_INSTALL_LIBDIR=lib \
 -DCMAKE_INSTALL_INCLUDEDIR=include -DBUILD_MPI=OFF -DDEPLOY=ON \
 -DBUILD_NETCDF=ON -DBUILD_JASPER=ON -DBUILD_PNG=ON -DBUILD_WGRIB2=OFF \
 -DBUILD_ESMF=OFF -DBUILD_HDF5=OFF -DBUILD_PNETCDF=OFF
make
fi
if [ $prt -eq 4 ];then
cmake .. -DCMAKE_INSTALL_PREFIX=${td}/${tv} -DCMAKE_INSTALL_LIBDIR=lib \
 -DCMAKE_INSTALL_INCLUDEDIR=include -DBUILD_MPI=OFF -DDEPLOY=ON \
 -DBUILD_NETCDF=OFF -DBUILD_JASPER=OFF -DBUILD_PNG=OFF -DBUILD_WGRIB2=ON \
 -DBUILD_ESMF=ON -DBUILD_HDF5=OFF -DBUILD_PNETCDF=OFF
make
fi
