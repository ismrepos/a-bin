#!/bin/sh

#PBS -q uv2k-m
#PBS -N TEST_JOB
#PBS -l select=1:ncpus=12:mem=12gb
#PBS -o out_file
#PBS -j oe
export OMP_NUM_THREADS=6
export KMP_AFFINITY=disalbed

cd ~/ttmi/src
dplace -X ./ttmi input_file_origin.txt > test.log
