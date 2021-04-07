#!/bin/bash
echo $LD_LIBRARY_PATH
export FC=ifort
export CC=icc
export CXX=icpc
export CPP="icc -E"
export CXXCPP="icpc -E"
export MPIF90=mpiifort
export MPIFC=mpiifort
export MPICC=mpiicc
#export MPICXX=mpicxx
export MPICXX=mpiicpc
export F9X=mpiifort
export I_MPI_FABRIC=shm:ofi
export UCX_TLS=rc,ud,sm,self
export I_MPI_OFI_PROVIDER=mlx
export CMAKE_INSTALL_LIBDIR=lib
export CMAKE_INSTALL_INCLUDEDIR=include
export wd=`pwd`
#export td=/opt/ohpc/pkg/rcec/pkg/cmake
#export td=${wd}/local
#export tv=3.16.3-intel19
#mkdir -p ${td}
mkdir -p build
rm -rf build/*
#patch -p1 -i ./cmake-cppflags.patch
cd build
../bootstrap #--prefix=${td}/${tv}
#--no-system-libs
make -j10
make install
rm -rf CMakeCache.txt CMakeFiles
#echo $wd > ${td}/${tv}/srcpath
