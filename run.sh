#!/bin/bash

NUM_OPS=4
NUM_RUNS=1000000000 # 1 billion

declare -a MIN
declare -a MAX

for ((i=0; i<$NUM_OPS;i++))
do
   MIN[$i]=1000000
   MAX[$i]=0
done

declare -a OPS

OPS[0]="Copy"
OPS[1]="Scale"
OPS[2]="Add"
OPS[3]="Triad"

declare -a RESULTS
declare -a MEAN
for ((i=0; i<$NUM_OPS;i++))
do
    MEAN[$i]=0
done

for ((run=1; run<=$NUM_RUNS;run++))
do
    STREAM=`./stream`
    for ((i=0; i<$NUM_OPS;i++))
    do
        RESULTS[$i]=$(echo $STREAM | grep -Po "${OPS[$i]}:( +)\K[^ ]+")
        MEAN[$i]=$(echo "${MEAN[$i]} + (${RESULTS[$i]} - ${MEAN[$i]})/$run" | bc -l)
    done

    for ((i=0; i<$NUM_OPS;i++))
    do
        if (( $(echo "${RESULTS[$i]} < ${MIN[$i]}" | bc -l) )); then
            MIN[$i]=${RESULTS[$i]}
        fi
        if (( $(echo "${RESULTS[$i]} > ${MAX[$i]}" | bc -l) )); then
            MAX[$i]=${RESULTS[$i]}
        fi
    done

    echo "RUN: $run" 
    for ((i=0; i<$NUM_OPS;i++))
    do
        DIFF=$(echo "(${MAX[$i]} - ${MIN[$i]})" | bc -l)
        DIFF=$(echo "(100 * $DIFF) / ${MAX[$i]}" | bc -l)
        printf "${OPS[$i]}:\t%.2f    %.2f    %.2f    %.2f%s\n" ${MIN[$i]} ${MAX[$i]} ${MEAN[$i]} $DIFF '%'
    done
    echo ""

    sleep 60
done
