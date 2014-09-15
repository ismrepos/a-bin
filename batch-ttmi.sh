#!/bin/sh

mkdir ~/ttmi/out

#PBS -q uv2k-s
#PBS -N TEST_JOB
#PBS -l select=1:ncpus=1:mem=1gb
#PBS -o ~/ttmi/out/out_file
#PBS -j oe

cd ~/ttmi
dplace ./bin/run.sh


