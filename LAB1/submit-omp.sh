#!/bin/bash
# following option makes sure the job will run in the current directory
#$ -cwd
# following option makes sure the job has the same environmnent variables as the submission shell
#$ -V
# following option to change shell
#$ -S /bin/bash

USAGE="\n USAGE: submit-omp.sh PROG size n_th\n
        PROG   -> omp program name\n
        size   -> size of the problem\n
	n_th   -> number of threads\n"

if (test $# -lt 3 || test $# -gt 3)
then
	echo -e $USAGE
        exit 0
fi

make $1

HOST=$(echo $HOSTNAME | cut -f 1 -d'.')

export OMP_NUM_THREADS=$3

/usr/bin/time -o time-$1-$3-${HOST} ./$1 $2
