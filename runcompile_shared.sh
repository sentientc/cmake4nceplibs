#!/bin/bash
module purge
module load rcec/cmake/3.16.3-intel19
module load rcec/python/3.5.10-intel19
module load rcec/ufs-ext/bbc872c-intel19
export MPICHLIB_CFLAGS="${CFLAGS}";      unset CFLAGS
export MPICHLIB_CXXFLAGS="${CXXFLAGS}";  unset CXXFLAGS
export MPICHLIB_CPPFLAGS="${CPPFLAGS}";  unset CPPFLAGS
export MPICHLIB_FFLAGS="${FFLAGS}";      unset FFLAGS
export MPICHLIB_FCFLAGS="${FCFLAGS}";    unset FCFLAGS
export MPICHLIB_LDFLAGS="${LDFLAGS}";    unset LDFLAGS
echo $LD_LIBRARY_PATH
export CC=mpiicc
export FC=mpiifort
export CXX=mpiicpc
#export FC=ifort
#export CC=icc
#export CXX=icpc
export CPP="mpiicc -E"
export CXXCPP="mpiicpc -E"
export MPIF90=mpiifort
export MPIFC=mpiifort
export MPICC=mpiicc
export MPICXX=mpiicpc
#export MPICXX=mpiicpc
export F9X=mpiifort
#export I_MPI_FABRIC=shm:ofi
#export UCX_TLS=rc,ud,sm,self
#export I_MPI_OFI_PROVIDER=mlx
#export MPICH_DIR=/opt/qct/ohpc/pub/intel/compilers_and_libraries_2020.4.304/linux/mpi/intel64
#source /opt/qct/ohpc/pub/intel/compilers_and_libraries_2020.4.304/linux/mpi/intel64/bin/mpivars.sh
#export MPI_C_COMPILER=mpiicc
#export MPI_Fortran_COMPILER=mpiifort
export MPITYPE=intelmpi
export wd=`pwd`
export td=/opt/ohpc/pkg/rcec/pkg/NCEPLIBS-external
export tv=bbc872c-intel19
export LDFLAGS=-fPIC
export RUNPARALLEL="mpiexec.hyrda" 
export OMPI_MCA_disable_memory_allocator=1 
mkdir -p build
mkdir -p ${td}/${tv}
rm -rf build/*
cp -f config_netcdfc.sh_nopnetcdf.tmpl config_netcdfc.sh.tmpl
cp -f CMakeLists_nopnetcdf.txt CMakeLists.txt
cd build
if [ 1 -eq 2 ];then
cmake .. -DCMAKE_INSTALL_PREFIX=${td}/${tv} -DCMAKE_INSTALL_LIBDIR=lib \
 -DCMAKE_INSTALL_INCLUDEDIR=include -DBUILD_MPI=OFF -DDEPLOY=ON \
 -DBUILD_NETCDF=ON -DBUILD_JASPER=ON -DBUILD_PNG=ON -DBUILD_WGRIB2=OFF \
 -DBUILD_ESMF=OFF -DBUILD_HDF5=ON -DBUILD_PNETCDF=OFF
make
sleep 60
cmake .. -DCMAKE_INSTALL_PREFIX=${td}/${tv} -DCMAKE_INSTALL_LIBDIR=lib \
 -DCMAKE_INSTALL_INCLUDEDIR=include -DBUILD_MPI=OFF -DDEPLOY=ON \
 -DBUILD_NETCDF=OFF -DBUILD_JASPER=OFF -DBUILD_PNG=OFF -DBUILD_WGRIB2=OFF \
 -DBUILD_ESMF=OFF -DBUILD_HDF5=OFF -DBUILD_PNETCDF=ON
make
sleep 60
cmake .. -DCMAKE_INSTALL_PREFIX=${td}/${tv} -DCMAKE_INSTALL_LIBDIR=lib \
 -DCMAKE_INSTALL_INCLUDEDIR=include -DBUILD_MPI=OFF -DDEPLOY=ON \
 -DBUILD_NETCDF=OFF -DBUILD_JASPER=OFF -DBUILD_PNG=OFF -DBUILD_WGRIB2=ON \
 -DBUILD_ESMF=ON -DBUILD_HDF5=OFF -DBUILD_PNETCDF=OFF
make
sleep 60
fi
cp -f ../config_netcdfc.sh_pnetcdf.tmpl ../config_netcdfc.sh.tmpl
cmake .. -DCMAKE_INSTALL_PREFIX=${td}/${tv} -DCMAKE_INSTALL_LIBDIR=lib \
 -DCMAKE_INSTALL_INCLUDEDIR=include -DBUILD_MPI=OFF -DDEPLOY=ON \
 -DBUILD_NETCDF=ON -DBUILD_JASPER=ON -DBUILD_PNG=ON -DBUILD_WGRIB2=OFF \
 -DBUILD_ESMF=OFF -DBUILD_HDF5=OFF -DBUILD_PNETCDF=OFF
make
echo $wd > ${td}/${tv}/srcpath
