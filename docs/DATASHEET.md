# Interface summary

| Field | Definition |
|---|---|
| Input | 32-bit payload, valid/ready |
| Forward channel | Payload, 4-bit sequence, 16-bit CRC, valid/ready |
| Feedback | ACK-valid, 4-bit ACK sequence and success bit |
| Timeout | Clock cycles, minimum effective setting 2; retries continue until acknowledgment |
| Status | Pending flag, transmissions, retries and acknowledged-frame counters |

## Integration profile

The stop-and-wait link control uses externally synchronized ACK feedback, 4-bit sequence IDs, CRC-16 and timeout-driven retransmission.
