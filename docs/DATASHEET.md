# Interface summary

| Field | Definition |
|---|---|
| Input | 32-bit payload, valid/ready |
| Forward channel | Payload, 4-bit sequence, 16-bit CRC, valid/ready |
| Feedback | ACK-valid, 4-bit ACK sequence and success bit |
| Timeout | Clock cycles, minimum effective setting 2; no maximum retry limit |
| Status | Pending flag, transmissions, retries and acknowledged-frame counters |

## Assumptions and limits

A link-layer demonstrator, not a compliant UCIe PHY or complete chiplet protocol. Requires externally synchronized/trusted ACK feedback; no receiver, serializer, credit scheme, error-correction decoder or retry cap.
