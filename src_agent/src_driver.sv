

class src_drv extends uvm_driver #(trans);

	`uvm_component_utils(src_drv)
	 virtual router_if.SDRV_MP r_if;
   	src_config src_cfg;


	function new(string name ="src_drv",uvm_component parent);
		super.new(name,parent);
	endfunction


	function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	if(!uvm_config_db #(src_config)::get(this,"","src_config",src_cfg))
		`uvm_fatal("CONFIG","cannot get() src_cfg from uvm_config_db. Have you set() it?") 
  	endfunction

	 function void connect_phase(uvm_phase phase);
	r_if=src_cfg.r_if;
  	endfunction


       // task run phase--------------------------->
	 task run_phase(uvm_phase phase);
		@(r_if.source_drv_cb);    // 1 st clock cycle
		r_if.source_drv_cb.resetn <= 1'b0;
		@(r_if.source_drv_cb);    // 1 st clock cycle
		r_if.source_drv_cb.resetn <= 1'b1;
	repeat(2)
		@(r_if.source_drv_cb);  // 2 nd clock cycle
        forever begin
	    seq_item_port.get_next_item(req);
            send_to_dut(req);	
	    seq_item_port.item_done();
		end
  	endtask
 
	
	//task send to DUT-------------------------->

	task send_to_dut(trans xtn);
		`uvm_info("SRC_DRV", $sformatf("printing froom src_driver \n %s", xtn.sprint()),UVM_LOW)
	
	while(r_if.source_drv_cb.busy!==0)
		@(r_if.source_drv_cb);
			r_if.source_drv_cb.data_in <= req.header;
			 r_if.source_drv_cb.pkt_valid <= 1'b1;

                @(r_if.source_drv_cb);
			foreach(req.payload[i])
			begin
			 while(r_if.source_drv_cb.busy!==0)
		@(r_if.source_drv_cb);
			r_if.source_drv_cb.data_in <= req.payload[i];
                @(r_if.source_drv_cb);
			end
	r_if.source_drv_cb.pkt_valid <= 1'b0;
        r_if.source_drv_cb.data_in <= req.parity;

	//req.print();
	
	
	repeat(2)
	begin
  	        @(r_if.source_drv_cb);
	req.error = r_if.source_drv_cb.error;
	end
endtask
endclass


