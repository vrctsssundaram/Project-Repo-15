IVERILOG ?= iverilog
VVP ?= vvp
YOSYS ?= yosys
.PHONY: test synth clean
test:
	mkdir -p build
	$(IVERILOG) -g2012 -Wall -s tb_retry_link32 -o build/sim rtl/retry_link32.sv tb/tb_retry_link32.sv
	$(VVP) build/sim
synth:
	mkdir -p build
	$(YOSYS) -Q -T -l build/synthesis.log -p 'read_verilog -sv rtl/retry_link32.sv; hierarchy -check -top retry_link32; synth -top retry_link32; stat'
clean:
	rm -f build/sim
