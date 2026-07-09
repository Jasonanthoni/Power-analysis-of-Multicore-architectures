# Baseline Architecture

## Simulator

Simulator : gem5 v25.1.0.1
ISA : X86

---

## Benchmark

Benchmark : Blackscholes
Input : simsmall
Threads : 16

Command used:

parsecmgmt -a run -p blackscholes \
-c gcc-hooks \
-i simsmall \
-n 16

---

## Processor

Number of cores : 16

CPU Model:

X86KvmCPU (fast-forward)

followed by

BaseTimingSimpleCPU (ROI execution)

---

## Cache Coherence

Ruby Memory System : Enabled

Protocol :

MESI_Two_Level

---

## Cache Hierarchy

Private L1 Instruction Cache

Private L1 Data Cache

Private L2 Cache

Ruby based cache hierarchy

---

## Ruby Network

Virtual Networks : 3

---

## Memory

Memory Controllers : 2

Memory Address Size :

64-bit

---

## Files Generated

config.ini

config.json

stats.txt

config.dot

Ruby topology

---

## Output Folder

m5out_mesi_16core_blackscholes_simsmall
