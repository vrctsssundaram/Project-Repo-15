# Chiplet-RetryLink

Stop-and-wait reliable payload transport control with sequence and CRC.

## Features

- 32-bit payload framing with four-bit rolling sequence
- CRC-16/CCITT polynomial 0x1021, initialization 0xFFFF
- ACK/NACK feedback, stale acknowledgment rejection and timeout retransmission
- Registered frame hold and transaction/retry counters

## Verification

Run `make test` for the self-checking regression or `make synth` for a synthesis check. See `docs/` for the design, interface, procedure and recorded results.

**Architecture:** Stop-and-wait 32-bit payload framing with sequence, CRC-16 and ACK/NACK retransmission.

Project owner: Sundaram S S.
