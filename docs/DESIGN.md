# Technical design

IDLE captures an input payload and computes CRC over `{sequence,payload}`. TX holds that exact frame until the forward channel accepts it. WAIT_ACK matches a four-bit acknowledgment sequence; a positive acknowledgment advances the sequence, while a negative acknowledgment or configured timeout retransmits the unchanged frame. Only one frame can be outstanding.

## Integration profile

The stop-and-wait link control uses externally synchronized ACK feedback, 4-bit sequence IDs, CRC-16 and timeout-driven retransmission.
