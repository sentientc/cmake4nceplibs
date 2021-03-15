#!/bin/bash
module purge
module load rcec/cmake/3.16.3-intel19
module load rcec/ufs-ext/bbc872c-intel19-mpich
module load hwloc/2.1.0
echo $LD_LIBRARY_PATH
export MPICHLIB_CFLAGS="${CFLAGS}";      unset CFLAGS
export MPICHLIB_CXXFLAGS="${CXXFLAGS}";  unset CXXFLAGS
export MPICHLIB_CPPFLAGS="${CPPFLAGS}";  unset CPPFLAGS
export MPICHLIB_FFLAGS="${FFLAGS}";      unset FFLAGS
export MPICHLIB_FCFLAGS="${FCFLAGS}";    unset FCFLAGS
export MPICHLIB_LDFLAGS="${LDFLAGS}";    unset LDFLAGS
#export CC=mpicc
#export FC=mpif90
#export CXX=mpicxx
export FC=ifort
export CC=icc
export CXX=icpc
export CPP="icc -E"
export CXXCPP="icpc -E"
#export MPIF90=mpifort
#export MPIFC=mpifort
#export MPICC=mpicc
#export MPICXX=mpicxx
#export MPICXX=mpiicpc
#export F9X=mpifort
#export I_MPI_FABRIC=shm:ofi
#export UCX_TLS=rc,ud,sm,self
#export I_MPI_OFI_PROVIDER=mlx
#export MPICH_DIR=/opt/qct/ohpc/pub/intel/compilers_and_libraries_2020.4.304/linux/mpi/intel64
#source /opt/qct/ohpc/pub/intel/compilers_and_libraries_2020.4.304/linux/mpi/intel64/bin/mpivars.sh
#export MPI_C_COMPILER=mpiicc
#export MPI_Fortran_COMPILER=mpiifort
export MPITYPE=MPICH3
export wd=`pwd`
export td=/opt/ohpc/pkg/rcec/pkg/NCEPLIBS-external
export tv=bbc872c-intel19-mpich
export LDFLAGS=-fPIC
mkdir -p build
mkdir -p ${td}/${tv}
rm -rf build/*
cp -f config_netcdfc.sh_nopnetcdf.tmpl config_netcdfc.sh.tmpl
cp -f CMakeLists_nopnetcdf.txt CMakeLists.txt
cd build
if [ 1 -eq 2 ];then
cmake .. -DCMAKE_INSTALL_PREFIX=${td}/${tv} -DCMAKE_INSTALL_LIBDIR=lib \
 -DCMAKE_INSTALL_INCLUDEDIR=include -DBUILD_MPI=ON -DDEPLOY=ON \
 -DBUILD_NETCDF=OFF -DBUILD_JASPER=OFF -DBUILD_PNG=OFF -DBUILD_WGRIB2=OFF \
 -DBUILD_ESMF=OFF -DBUILD_HDF5=OFF -DBUILD_PNETCDF=OFF
make
fi
export CC=mpicc
export FC=mpifort
export CXX=mpicxx
export CPP="mpicc -E"
export CXXCPP="mpicxx -E"
if [ 1 -eq 2 ];then
cmake .. -DCMAKE_INSTALL_PREFIX=${td}/${tv} -DCMAKE_INSTALL_LIBDIR=lib \
 -DCMAKE_INSTALL_INCLUDEDIR=include -DBUILD_MPI=OFF -DDEPLOY=ON \
 -DBUILD_NETCDF=ON -DBUILD_JASPER=ON -DBUILD_PNG=ON -DBUILD_WGRIB2=OFF \
 -DBUILD_ESMF=OFF -DBUILD_HDF5=ON -DBUILD_PNETCDF=OFF
make
fi
if [ 1 -eq 2 ];then
cmake .. -DCMAKE_INSTALL_PREFIX=${td}/${tv} -DCMAKE_INSTALL_LIBDIR=lib \
 -DCMAKE_INSTALL_INCLUDEDIR=include -DBUILD_MPI=OFF -DDEPLOY=ON \
 -DBUILD_NETCDF=OFF -DBUILD_JASPER=OFF -DBUILD_PNG=OFF -DBUILD_WGRIB2=OFF \
 -DBUILD_ESMF=OFF -DBUILD_HDF5=OFF -DBUILD_PNETCDF=ON
make
fi
if [ 1 -eq 1 ];then
cmake .. -DCMAKE_INSTALL_PREFIX=${td}/${tv} -DCMAKE_INSTALL_LIBDIR=lib \
 -DCMAKE_INSTALL_INCLUDEDIR=include -DBUILD_MPI=OFF -DDEPLOY=ON \
 -DBUILD_NETCDF=OFF -DBUILD_JASPER=OFF -DBUILD_PNG=OFF -DBUILD_WGRIB2=ON \
 -DBUILD_ESMF=ON -DBUILD_HDF5=OFF -DBUILD_PNETCDF=OFF
make
fi
if [ 1 -eq 1 ];then
cp -f ../config_netcdfc.sh_pnetcdf.tmpl ../config_netcdfc.sh.tmpl
cmake .. -DCMAKE_INSTALL_PREFIX=${td}/${tv} -DCMAKE_INSTALL_LIBDIR=lib \
 -DCMAKE_INSTALL_INCLUDEDIR=include -DBUILD_MPI=OFF -DDEPLOY=ON \
 -DBUILD_NETCDF=ON -DBUILD_JASPER=ON -DBUILD_PNG=ON -DBUILD_WGRIB2=OFF \
 -DBUILD_ESMF=OFF -DBUILD_HDF5=OFF -DBUILD_PNETCDF=OFF
make
fi
echo $wd > ${td}/${tv}/srcpath
