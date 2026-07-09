# Research Notes

## Day 2

Date:
09 July 2026

---

### Goal 1

Completed reconstruction of the baseline architecture.

Architecture:

- gem5 v25.1.0.1
- X86
- Full System
- 16 cores
- X86KvmCPU
- BaseTimingSimpleCPU
- Ruby
- MESI Two-Level
- 32 KB L1I
- 32 KB L1D
- 256 KB L2
- 3 GB Memory
- PARSEC Blackscholes
- simsmall

---

### Goal 2

Verified complete McPAT workflow.

Successfully understood

stats.txt

↓

config.ini

↓

gen_mcpat_xml.py

↓

mcpat_input.xml

↓

McPAT

↓

mcpat_output.txt

---

### Important Observation

McPAT report summarizes

2 cores

while the gem5 baseline configuration is

16 cores.

Need to verify

- XML generation
- Parser
- McPAT template

before using the baseline results.

---

### What I Learned

- How gem5 stores architecture information.
- Difference between config.ini and stats.txt.
- Purpose of gen_mcpat_xml.py.
- How McPAT estimates power.
- Meaning of Runtime Dynamic and Leakage Power.

---

### Next Goal

Investigate why McPAT reports 2 cores instead of 16.

Then reproduce the baseline simulation.

Finally integrate Adaptive Prefetcher with MESI-IN.
