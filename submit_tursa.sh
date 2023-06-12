#!/bin/bash

#SBATCH --job-name NAME
#SBATCH --qos standard
#SBATCH --time 10:00
#SBATCH --account PROJECT
#SBATCH --nodes NUM_NODES
#SBATCH --ntasks NUM_TASKS
#SBATCH --ntasks-per-node 4
#SBATCH --cpus-per-task 8
#SBATCH --partition gpu
#SBATCH --gres gpu:4
#SBATCH --output %x.%j.out
#SBATCH --error %x.%j.err
#SBATCH --reservation workshop
umask 0002

module purge
module load cuda/11.4.1 \
    openmpi/4.1.1-cuda11.4.1 \
    ucx/1.12.0-cuda11.4.1

export OMP_NUM_THREADS=4
export OMPI_MCA_btl=^uct,openib
export UCX_TLS=gdr_copy,rc,rc_x,sm,cuda_copy,cuda_ipc
export UCX_RNDV_SCHEME=put_zcopy
export UCX_RNDV_THRESH=16384
export UCX_IB_GPU_DIRECT_RDMA=yes
export UCX_MEMTYPE_CACHE=n

mpirun -np ${SLURM_NTASKS} \
       --bind-to none \
       ./wrapper.sh ./my_tool
