#!/bin/sh

#PBS -q uv2k-s
#PBS -N TEST_JOB
#PBS -l select=1:ncpus=1:mem=1gb
#PBS -o out_file
#PBS -j oe

cd /home1/khonda/ttmi
dplace ./bin/run.sh


