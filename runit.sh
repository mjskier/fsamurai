#!/bin/bash
# Submit fortran driver to Grid Engine

function usage {
    echo "usage: qsubit [-e|--env <queue>] [-t|--threads <num>]"
    echo "		-e: One of mpi, mpi-rr, mpi-fu. [mpi]"
    echo "		-t: Number of threads [20]"
}

while [[ $# -ge 1 ]]
do
    key="$1"
    case $key in
	-e|--env)
	    pe=$2
	    shift
	    ;;
	-t|--threads)
	    threads=$2
	    shift
	    ;;
	-h|--help)
	    usage
	    exit 0
	    ;;
	*)
	    echo "Unknown option '$key'"
	    usage
	    exit 1
	    ;;
    esac
    shift
done

pe=${pe:="mpi"}
threads=${threads:="20"}

echo "parallel environment: '$pe', threads: '$threads'"

export OMP_NUM_THREADS=$threads
qsub -b y -N fsam45 -q all.q -o  /bell-scratch/bpmelli/grid_out -e  /bell-scratch/bpmelli/grid_err -cwd -pe $pe $threads /home/bpmelli/devel/tryit/fsamurai/f90
