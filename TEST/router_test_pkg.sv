

package router_test_pkg;

	import uvm_pkg::*;
	`include "uvm_macros.svh"
	`include "trans.sv"
	
	`include "src_config.sv"
	`include "dst_agt_config.sv"
	`include "router_env_config.sv"
	`include "src_drv.sv"
	`include "src_mon.sv"
	`include "src_swqr.sv"
	`include "src_agt.sv"
	`include "agt_top.sv"
	`include "src_seqs.sv"


	`include "dst_xtn.sv"
	`include "dst_mon.sv"
	`include "dst_sequencer.sv"
	`include "dst_seqs.sv"
	`include "dst_driver.sv"
	`include "dst_agent.sv"
	`include "dst_agt_top.sv"

	`include "router_virtual_sequencer.sv"
	`include "router_virtual_seqs.sv"
	`include "router_scoreboard.sv"

	`include "router_tb.sv"


	`include "router_vtest_lib.sv"
			
endpackage

