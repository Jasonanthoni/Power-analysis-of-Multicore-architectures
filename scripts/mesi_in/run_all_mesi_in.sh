#!/bin/bash

GEM5=~/gem5/build/X86_MESI_IN/gem5.opt
CONFIG=~/gem5/configs/deprecated/example/gem5_library/x86-parsec-benchmarks_MESI_IN.py
RESULTS=~/gem5/MESI_IN_results

BENCHMARKS=(
    blackscholes
    bodytrack
    canneal
    dedup
    facesim
    ferret
    fluidanimate
    freqmine
    raytrace
    streamcluster
    swaptions
    vips
    x264
)

mkdir -p "$RESULTS"

for BENCH in "${BENCHMARKS[@]}"; do

    echo "===================================================="
    echo "Starting MESI-IN: $BENCH"
    echo "===================================================="

    OUTDIR="$RESULTS/$BENCH"
    mkdir -p "$OUTDIR"

    rm -rf ~/gem5/m5out

    START=$(date +%s)

    "$GEM5" \
        -d "$OUTDIR" \
        "$CONFIG" \
        --benchmark "$BENCH" \
        --size simsmall \
        > "$OUTDIR/console.log" 2>&1

    STATUS=$?

    END=$(date +%s)
    ELAPSED=$((END-START))

    if [ $STATUS -eq 0 ]; then
        echo "$BENCH : SUCCESS (${ELAPSED}s)" | tee "$OUTDIR/status.txt"
    else
        echo "$BENCH : FAILED (exit code $STATUS, ${ELAPSED}s)" | tee "$OUTDIR/status.txt"
    fi

    echo
done

echo "===================================================="
echo "ALL MESI-IN BENCHMARKS FINISHED"
echo "===================================================="
