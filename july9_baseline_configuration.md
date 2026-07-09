# Baseline Configuration

## Research Project

**Power Analysis of Adaptive Prefetcher and MESI-IN Cache Coherence Protocol using gem5, PARSEC, and McPAT**

---

# Simulator

| Parameter | Value |
|-----------|-------|
| Simulator | gem5 |
| Version | v25.1.0.1 |
| ISA | X86 |
| Simulation Mode | Full System (FS) |

---

# Benchmark

| Parameter | Value |
|-----------|-------|
| Benchmark Suite | PARSEC |
| Benchmark | Blackscholes |
| Input Set | simsmall |
| Threads | 16 |

### Execution Command

```bash
parsecmgmt -a run \
-p blackscholes \
-c gcc-hooks \
-i simsmall \
-n 16
```

---

# Processor Configuration

| Parameter | Value |
|-----------|-------|
| Number of Cores | 16 |
| Fast-forward CPU | X86KvmCPU |
| Detailed CPU | BaseTimingSimpleCPU |
| ROI Simulation | BaseTimingSimpleCPU |

---

# Memory System

| Parameter | Value |
|-----------|-------|
| Ruby Memory System | Enabled |
| Cache Coherence Protocol | MESI_Two_Level |
| Main Memory | 3 GiB |
| Memory Controllers | 2 |
| Address Size | 64-bit |

---

# Cache Hierarchy

## L1 Instruction Cache

| Parameter | Value |
|-----------|-------|
| Type | RubyCache |
| Size | 32 KB |
| Associativity | 8-way |
| Latency | 1 cycle |
| Sharing | Private per core |

---

## L1 Data Cache

| Parameter | Value |
|-----------|-------|
| Type | RubyCache |
| Size | 32 KB |
| Associativity | 8-way |
| Latency | 1 cycle |
| Sharing | Private per core |

---

## L2 Cache

| Parameter | Value |
|-----------|-------|
| Type | RubyCache |
| Size | 256 KB |
| Associativity | 16-way |
| Latency | 1 cycle |
| Sharing | Private per core |
| Number of L2 Controllers | 16 |

---

# Ruby Interconnection Network

| Parameter | Value |
|-----------|-------|
| Network Type | Ruby Network |
| Virtual Networks | 3 |

---

# Generated Output Files

The simulation generates the following files inside the output directory:

- `config.ini`
- `config.json`
- `stats.txt`
- `config.dot`
- Ruby topology files

---

# Output Directory

```text
m5out_mesi_16core_blackscholes_simsmall
```

---

# Baseline Architecture Summary

```
                 PARSEC Blackscholes (simsmall)
                           │
                    16 Software Threads
                           │
               X86 Full-System Simulation
                           │
      ┌───────────────────────────────────────┐
      │            gem5 v25.1.0.1             │
      └───────────────────────────────────────┘
                           │
          Fast-forward : X86KvmCPU
                           │
                     Switch at ROI
                           │
         Detailed CPU : BaseTimingSimpleCPU
                           │
                   Ruby Memory System
                           │
                 MESI_Two_Level Protocol
                           │
      ┌───────────────────────────────────────┐
      │ 16 × Private L1I (32 KB, 8-way)       │
      │ 16 × Private L1D (32 KB, 8-way)       │
      │ 16 × Private L2  (256 KB, 16-way)     │
      └───────────────────────────────────────┘
                           │
                Ruby Interconnection Network
                    (3 Virtual Networks)
                           │
               2 Memory Controllers
                           │
                      3 GiB Main Memory
```

---

# Planned Research Flow

```
Baseline (MESI_Two_Level)
            │
            ▼
Adaptive Prefetcher
            │
            ▼
MESI-IN Cache Coherence
            │
            ▼
Adaptive Prefetcher + MESI-IN
            │
            ▼
McPAT Power Estimation
            │
            ▼
MATLAB Analysis & Visualization
```
