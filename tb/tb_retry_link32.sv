module tb_retry_link32;
    reg clk=0; always #5 clk=~clk;
    reg rst_n=0,s_valid=0,tx_ready=0,ack_valid=0,ack_ok=0;
    reg [31:0] s_payload=0;
    reg [3:0] ack_seq=0;
    reg [15:0] cfg_timeout=16'd20;
    wire s_ready,tx_valid,pending;
    wire [31:0] tx_payload,transmissions,retries,acknowledgments;
    wire [3:0] tx_seq;
    wire [15:0] tx_crc;
    retry_link32 dut(.*);
    task send(input [31:0] payload);
        begin
            @(negedge clk);
            while(!s_ready) @(negedge clk);
            s_payload=payload;s_valid=1;
            @(negedge clk);s_valid=0;
        end
    endtask
    task ack(input [3:0] seq,input success);
        begin
            @(negedge clk);ack_seq=seq;ack_ok=success;ack_valid=1;
            @(negedge clk);ack_valid=0;
        end
    endtask
    initial begin
        repeat(3) @(negedge clk);rst_n=1;
        send(32'h12345678);
        repeat(3) begin
            @(negedge clk);
            if(!tx_valid || tx_payload!==32'h12345678 || tx_seq!==0 || tx_crc!==16'h7924)
                $fatal(1,"Transmit hold/CRC");
        end
        tx_ready=1;
        wait(transmissions==1);
        ack(4'd3,1); // Stale/wrong acknowledgment must be ignored.
        if(!pending || acknowledgments!==0) $fatal(1,"Stale ACK accepted");
        ack(4'd0,0); // Negative acknowledgment requests retransmission.
        wait(transmissions==2);
        if(retries!==1 || tx_seq!==0 || tx_crc!==16'h7924)
            $fatal(1,"NACK retransmission");
        ack(4'd0,1);
        wait(acknowledgments==1);
        if(pending || tx_seq!==1) $fatal(1,"ACK completion/sequence");

        cfg_timeout=3;
        send(32'hcafebabe);
        wait(transmissions==3);
        if(tx_crc!==16'hf3d6 || tx_seq!==1) $fatal(1,"Next CRC/sequence");
        wait(transmissions==4);
        if(retries!==2) $fatal(1,"Timeout retransmission");
        ack(4'd1,1);
        wait(acknowledgments==2);
        if(transmissions!==4 || retries!==2 || pending)
            $fatal(1,"Final counters");
        $display("PASS: CRC16, stable TX, stale ACK, NACK, timeout retry and sequence advance");
        $finish;
    end
    initial begin #100000;$fatal(1,"Watchdog");end
endmodule
