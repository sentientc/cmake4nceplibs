#!/bin/tcsh

if (`hostname | cut -c1-6` == "lgn301" ) then
   echo " nchc-2020-hpc environment "
   #source ${MODULESHOME}/init/tcsh
   #setenv MODULEPATH "/opt/ohpc/pub/modulefiles:/opt/ohpc/twcc/modulefiles:/opt/ohpc/Taiwania3/modulefiles:/work/j07cyt00/scripts/modulefiles"
   #module load lapack/3.8.0-intel18
   #module load ufs-ext/1.1.0-intel18
   #module load intel/2018
   #module load rcec/ufs-ext/1.1.0-intel19
   module load rcec/lapack/3.8.0-intel19
   #module load intel/19.1.3.304
   #module load rcec/ufs-ext/bbc872c-intel19
   module load rcec/ufs-libs/1.3.0-intel19
   setenv I_MPI_FABRICS "shm:ofi"
   setenv UCX_TLS "rc,ud,sm,self"
   setenv I_MPI_OFI_PROVIDER mlx
   setenv MPICH_DIR /opt/qct/ohpc/pub/intel/compilers_and_libraries_2020.4.304/linux/mpi/intel64
   setenv NF_BLKSZ 4M
   setenv MPI_ROOT $MPICH_DIR
   setenv TEMPLATE ../../../site/intel.mk
   exit
else
   setenv NCEPLIBS_DIR /opt/pkg/NCEPLIBS/1.3.0-intel21
   setenv MPI_ROOT $I_MPI_ROOT 
   setenv TEMPLATE ../../../site/intel.mk
endif

echo " no environment available based on the hostname "
