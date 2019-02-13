#!/bin/bash
# following option makes sure the job will run in the current directory
#$ -cwd
# following option makes sure the job has the same environmnent variables as the submission shell
#$ -V
# following option to change shell
#$ -S /bin/bash

PROG=pi_omp
size=100000000
np_NMIN=1
np_NMAX=12
N=3

# Make sure that all binaries exist
make $PROG

HOST=$(echo $HOSTNAME | cut -f 1 -d'.')
USUARIO=`whoami`
FECHA=`date`

out=/tmp/out.$$	    # Temporal file where you save the execution results

outputpath=./executiontime-${HOST}.txt
outputpath2=./efficiency-${HOST}.txt
rm -rf $outputpath 2> /dev/null
rm -rf $outputpath2 2> /dev/null

echo Executing $PROG with one thread
min_elapsed=1000  # Minimo del elapsed time de las N ejecuciones del programa
i=0        # Variable contador de repeticiones
while (test $i -lt $N)
	do
                export OMP_NUM_THREADS=1
		echo -n Run $i... 
                /usr/bin/time -f "%e" ./$PROG $size > /dev/null 2> $out


		time=`cat $out|tail -n 1`
		echo Elapsed time = `cat $out`
			
                st=`echo "$time < $min_elapsed" | bc`
                if [ $st -eq 1 ]; then
                   min_elapsed=$time
                fi
			
		rm -f $out
		i=`expr $i + 1`
	done
echo -n ELAPSED TIME MIN OF $N EXECUTIONS =
baseline=`echo $min_elapsed`
echo $baseline
echo

echo "$PROG $size $np_NMIN $np_NMAX $N"

i=0
echo "Starting OpenMP executions..."

PARS=$np_NMIN
while (test $PARS -le $np_NMAX)
do
	echo Executing $PROG with $PARS threads 
        min_elapsed=1000  # Minimo del elapsed time de las N ejecuciones del programa
	DSIZE=`expr $DSIZE + $size`

	while (test $i -lt $N)
		do
			echo -n Run $i with size $DSIZE ... 
                        export OMP_NUM_THREADS=$PARS
                        /usr/bin/time -f "%e" ./$PROG $DSIZE > /dev/null 2> $out

			time=`cat $out|tail -n 1`
			echo Elapsed time = `cat $out`
			
                        st=`echo "$time < $min_elapsed" | bc`
                        if [ $st -eq 1 ]; then
                           min_elapsed=$time;
                        fi
			
			rm -f $out
			i=`expr $i + 1`
		done

	echo -n ELAPSED TIME Min OF $N EXECUTIONS =

        min=`echo $min_elapsed`
    	result=`echo $baseline/$min|bc -l`
    	echo $min
	echo
	i=0

    	#output PARS i elapsed time minimo en fichero elapsed time
	echo -n $PARS >> $outputpath
	echo -n "   " >> $outputpath
    	echo $min >> $outputpath

    	#output PARS i speedup en fichero efficiency
	echo -n $PARS >> $outputpath2
	echo -n "   " >> $outputpath2
    	echo $result >> $outputpath2

    	#incrementa el parametre
	PARS=`expr $PARS + 1`
done

echo "Resultat de l'experiment (tambe es troben a " $outputpath " i " $outputpath2 " )"
echo "#threads	Elapsed min"
cat $outputpath
echo
echo "#threads	Speedup"
cat $outputpath2
echo

cp .weak-omp.jgr weak-omp-${HOST}.jgr
sed -i -e "s/HHH/${HOST}/g" weak-omp-${HOST}.jgr
sed -i -e "s/UUU/${USUARIO}/g" weak-omp-${HOST}.jgr
sed -i -e "s/FFF/${FECHA}/g" weak-omp-${HOST}.jgr
jgraph -P weak-omp-${HOST}.jgr >  $PROG-$size-$np_NMIN-$np_NMAX-$N-weak-${HOST}.ps
rm weak-omp-${HOST}.jgr

