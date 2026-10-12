# Adaptive Prefetcher Source Overlay

This directory preserves the relevant gem5 source files for the
adaptive-prefetcher and cache-hierarchy integration.

The paths beneath this directory mirror paths beneath the root of
the gem5 source tree.

To apply the overlay to a separate gem5 checkout, from the research
repository root run:

    cp -a source/adaptive_prefetcher_overlay/src/. /path/to/gem5/src/

Review the target checkout and its existing changes before applying.
The experiment configurations are stored separately under configs/.
