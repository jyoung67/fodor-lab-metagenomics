#!/bin/bash
#=====OPTIONS=====
#PBS -q copperhead
#PBS -N nickname
#PBS -l procs=4
#PBS -l walltime=2:00:00
#=====END PBS OPTIONS====
module load sra-tools
fasterq-dump SRR5799796 --split-files --skip-technical -O /nobackup/afodor_research/datasets/rifaximin/jyoung/R1/






