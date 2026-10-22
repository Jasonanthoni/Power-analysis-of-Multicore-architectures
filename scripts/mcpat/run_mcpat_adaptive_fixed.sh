#!/bin/bash

set -u

BASE_DIR="$HOME/gem5/adaptive_prefetch_fixed_results"
GENERATOR="$HOME/REU/scripts/gen_mcpat_xml.py"
MCPAT="$HOME/REU/mcpat/mcpat/mcpat"

benchmarks=(
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
)

SUCCESS=0
FAILED=0
SKIPPED=0

echo "=================================================="
echo "McPAT: Adaptive Prefetcher — 16-core simulations"
echo "Results: $BASE_DIR"
echo "=================================================="

for b in "${benchmarks[@]}"; do
    BENCH_DIR="$BASE_DIR/$b"

    echo
    echo "=================================================="
    echo "Processing: $b"
    echo "=================================================="

    if [ ! -s "$BENCH_DIR/stats.txt" ]; then
        echo "SKIPPED: stats.txt missing or empty"
        SKIPPED=$((SKIPPED + 1))
        continue
    fi

    echo "[1/2] Generating McPAT XML..."

    if ! python3 "$GENERATOR" "$BENCH_DIR"; then
        echo "FAILED: XML generation for $b"
        FAILED=$((FAILED + 1))
        continue
    fi

    if [ ! -s "$BENCH_DIR/mcpat_input.xml" ]; then
        echo "FAILED: mcpat_input.xml missing or empty"
        FAILED=$((FAILED + 1))
        continue
    fi

    echo "[2/2] Running McPAT..."

    if "$MCPAT" \
        -infile "$BENCH_DIR/mcpat_input.xml" \
        -print_level 5 \
        > "$BENCH_DIR/mcpat_output.txt" 2>&1; then

        if grep -Eqi 'Processor:\s*$|Processor:' "$BENCH_DIR/mcpat_output.txt"; then
            echo "McPAT finished for $b; checking output summary."
        fi

        if grep -Eqi 'error|fatal' "$BENCH_DIR/mcpat_output.txt"; then
            echo "WARNING: Check McPAT output for errors: $b"
            FAILED=$((FAILED + 1))
        else
            echo "SUCCESS: $b"
            SUCCESS=$((SUCCESS + 1))
        fi
    else
        echo "FAILED: McPAT execution for $b"
        tail -20 "$BENCH_DIR/mcpat_output.txt"
        FAILED=$((FAILED + 1))
    fi
done

echo
echo "=================================================="
echo "McPAT RUN SUMMARY"
echo "=================================================="
echo "Successful: $SUCCESS"
echo "Failed:     $FAILED"
echo "Skipped:    $SKIPPED"
echo "=================================================="
