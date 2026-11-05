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

**Evidence:** Tool-reported Icarus Verilog regression and Yosys synthesis results for the source revision cited above.
