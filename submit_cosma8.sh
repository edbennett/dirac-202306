#!/bin/bash
#SBATCH --job-name NAME
#SBATCH --account PROJECT
#SBATCH --partition cosma8
#SBATCH --nodes NUM_NODES
#SBATCH --ntasks NUM_TASKS
#SBATCH --cpus-per-task 8
#SBATCH --time 10:00
#SBATCH --exclusive
#SBATCH --reservation onboarding

module purge
module load ucx/1.13.0rc2 oneAPI/2022.3.0

mpirun ./my_tool
