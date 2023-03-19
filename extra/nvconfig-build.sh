#!/bin/bash
#
# This is a helper script to autocreate nvblas.conf file
# Run from anywhere:
# ./nvconfig-build.sh
#

default_path="/etc/nvblas.conf"

gpu_list="ALL"
cpulibopenblas_path=$(ldconfig -p | grep -m 1 libopenblas | cut -d'>' -f2 | cut -d' ' -f2)
libnvblas_path=$(ldconfig -p | grep -m 1 libnvblas | cut -d'>' -f2 | cut -d' ' -f2)

sudo tee $default_path > /dev/null <<EOT
NVBLAS_LOGFILE nvblas.log
NVBLAS_GPU_LIST $gpu_list
NVBLAS_TRACE_LOG_ENABLED
NVBLAS_AUTOPIN_MEM_ENABLED
NVBLAS_CPU_BLAS_LIB $cpulibopenblas_path
NVBLAS_LIB $libnvblas_path
EOT
cat $default_path
echo "File $default_path writed!"
export NVBLAS_CONFIG_FILE=$default_path
export LD_PRELOAD=$libnvblas_path