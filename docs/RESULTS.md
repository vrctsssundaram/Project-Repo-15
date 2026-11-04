# Verification record

Date: 05 November 2026
Source revision tested: `2e2748060e8bcb1baf686700c4311b2926738f5b`
Hosted verification: https://github.com/vrctsssundaram/Project-Repo-15/actions/runs/41900989062

| Measurement | Recorded result |
|---|---|
| SystemVerilog compilation | **PASS** (Icarus Verilog, `-g2012 -Wall`) |
| Directed self-checking simulation | **PASS** (exit code 0) |
| Directed checks | known CRC values, TX hold, stale ACK discard, NACK retry, timeout retry, successful ACK and sequence advance |
| Generic Yosys synthesis | **PASS**; 815 technology-independent cells |
| FPGA/ASIC technology-specific utilization | Not measured |
| Static timing, maximum clock, power | Not measured |
| Physical hardware throughput | Not measured |

The synthesis count is taken from the top-level `stat` section of the hosted generic Yosys run, not a device-mapped area estimate. The directed testbench is bounded and does not constitute exhaustive or formal verification. No artificial waveform, timing, area, or power result is presented as a measurement.
