

module top();
    import uvm_pkg::*;
    import router_test_pkg::*;

    bit clock;
 
 always
       #5 clock = ~clock;


    router_if s_if0(clock);
    router_if d_if0(clock);
    router_if d_if1(clock);
    router_if d_if2(clock);
       
     router_top DUV (.clock(clock),.resetn(s_if0.resetn),.read_enb_0(d_if0.read_enb),.read_enb_1(d_if1.read_enb),.read_enb_2(d_if2.read_enb),.data_in(s_if0.data_in),.pkt_valid(s_if0.pkt_valid),.data_out_0(d_if0.data_out),.data_out_1(d_if1.data_out),.data_out_2(d_if2.data_out),.valid_out_0(d_if0.valid_out),.valid_out_1(d_if1.valid_out),.valid_out_2(d_if2.valid_out),.error(s_if0.error),.busy(s_if0.busy));


    initial
	begin
		
	`ifdef VCS
	$fsdbDumpvars(0, top);
	`endif

	uvm_config_db #(virtual router_if)::set(null, "*", "s_if_0",s_if0);
	uvm_config_db #(virtual router_if)::set(null, "*", "d_if_0",d_if0);
	uvm_config_db #(virtual router_if)::set(null, "*", "d_if_1",d_if1);
	uvm_config_db #(virtual router_if)::set(null, "*", "d_if_2",d_if2);

        run_test();
	  end
endmodule

