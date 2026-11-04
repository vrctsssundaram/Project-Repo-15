module retry_link32 (
    input  wire        clk,
    input  wire        rst_n,
    input  wire [31:0] s_payload,
    input  wire        s_valid,
    output wire        s_ready,
    output reg  [31:0] tx_payload,
    output reg  [3:0]  tx_seq,
    output reg  [15:0] tx_crc,
    output wire        tx_valid,
    input  wire        tx_ready,
    input  wire        ack_valid,
    input  wire [3:0]  ack_seq,
    input  wire        ack_ok,
    input  wire [15:0] cfg_timeout,
    output wire        pending,
    output reg  [31:0] transmissions,
    output reg  [31:0] retries,
    output reg  [31:0] acknowledgments
);
    localparam [1:0] IDLE=0, TX=1, WAIT_ACK=2;
    reg [1:0] state;
    reg [15:0] timer;
    wire [15:0] timeout_cycles = cfg_timeout < 2 ? 16'd2 : cfg_timeout;
    assign s_ready = (state==IDLE);
    assign tx_valid = (state==TX);
    assign pending = (state!=IDLE);

    function automatic [15:0] crc16(input [35:0] value);
        reg [15:0] c;
        reg feedback;
        integer i;
        begin
            c = 16'hffff;
            for(i=35;i>=0;i=i-1) begin
                feedback = value[i] ^ c[15];
                c = {c[14:0],1'b0};
                if(feedback) c = c ^ 16'h1021;
            end
            crc16 = c;
        end
    endfunction

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            state <= IDLE;
            tx_payload <= 0;
            tx_seq <= 0;
            tx_crc <= 0;
            timer <= 0;
            transmissions <= 0;
            retries <= 0;
            acknowledgments <= 0;
        end else begin
            case(state)
                IDLE: if(s_valid) begin
                    tx_payload <= s_payload;
                    tx_crc <= crc16({tx_seq,s_payload});
                    state <= TX;
                end
                TX: if(tx_ready) begin
                    transmissions <= transmissions + 1'b1;
                    timer <= 0;
                    state <= WAIT_ACK;
                end
                WAIT_ACK: begin
                    if(ack_valid && ack_seq==tx_seq) begin
                        if(ack_ok) begin
                            acknowledgments <= acknowledgments + 1'b1;
                            tx_seq <= tx_seq + 1'b1;
                            state <= IDLE;
                        end else begin
                            retries <= retries + 1'b1;
                            state <= TX;
                        end
                        timer <= 0;
                    end else if(timer >= timeout_cycles - 1'b1) begin
                        retries <= retries + 1'b1;
                        timer <= 0;
                        state <= TX;
                    end else timer <= timer + 1'b1;
                end
                default: state <= IDLE;
            endcase
        end
    end
endmodule
