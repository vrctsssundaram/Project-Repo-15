# Technical design

IDLE captures an input payload and computes CRC over `{sequence,payload}`. TX holds that exact frame until the forward channel accepts it. WAIT_ACK matches a four-bit acknowledgment sequence; a positive acknowledgment advances the sequence, while a negative acknowledgment or configured timeout retransmits the unchanged frame. Only one frame can be outstanding.

## Scope boundary

A link-layer demonstrator, not a compliant UCIe PHY or complete chiplet protocol. Requires externally synchronized/trusted ACK feedback; no receiver, serializer, credit scheme, error-correction decoder or retry cap.
