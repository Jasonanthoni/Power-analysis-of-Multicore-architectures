#!/bin/bash

GEM5=~/gem5/build/X86_MESI_IN/gem5.opt
CONFIG=~/gem5/configs/deprecated/example/gem5_library/x86-parsec-benchmarks_MESI_IN_16core.py
RESULTS=~/gem5/MESI_IN_results_16core

BENCHMARKS=(
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

    OUTDIR="$RESULTS/$BENCH"

    echo "===================================================="
    echo "Starting MESI-IN 16-core: $BENCH"
    echo "===================================================="

    mkdir -p "$OUTDIR"

    # Do not rerun a benchmark that already has valid statistics
    if [ -s "$OUTDIR/stats.txt" ]; then
        echo "$BENCH : VALID RESULTS ALREADY EXIST"
        echo
        continue
    fi

    rm -f "$OUTDIR/stats.txt"

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

    if [ $STATUS -eq 0 ] && [ -s "$OUTDIR/stats.txt" ]; then
        echo "$BENCH : SUCCESS (${ELAPSED}s)" | tee "$OUTDIR/status.txt"
    else
        echo "$BENCH : FAILED (exit code $STATUS, ${ELAPSED}s)" | tee "$OUTDIR/status.txt"
    fi

    echo
done

echo "===================================================="
echo "MESI-IN 16-CORE BATCH FINISHED"
echo "===================================================="

echo
echo "Result summary:"
for BENCH in blackscholes "${BENCHMARKS[@]}"; do
    if [ -s "$RESULTS/$BENCH/stats.txt" ]; then
        echo "$BENCH : OK"
    else
        echo "$BENCH : MISSING"
    fi
done
