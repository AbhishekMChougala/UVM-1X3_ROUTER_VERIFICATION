

class dst_driver extends uvm_driver #(dst_xtns);

	`uvm_component_utils(dst_driver)

	virtual router_if.DDRV_MP r_if;
   	dst_agt_config dst_agt_config_h;
//	dst_xtns xtn;

	function new(string name ="dst_driver",uvm_component parent);
		super.new(name,parent);
	endfunction


	function void build_phase(uvm_phase phase);
          super.build_phase(phase);
	if(!uvm_config_db #(dst_agt_config)::get(this,"","dst_agt_config",dst_agt_config_h))
		`uvm_fatal("CONFIG","cannot get() src_cfg from uvm_config_db. Have you set() it?") 


//$display("%p",dst_agt_config_h.r_if);


        endfunction

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
	r_if = dst_agt_config_h.r_if;
	if(r_if==dst_agt_config_h.r_if)
		  `uvm_info("DEBUG_MSG", "VIF_CONNECT_SUCCESS_IN_DDRV", UVM_HIGH)

        endfunction

	task run_phase(uvm_phase phase);
             forever begin
		seq_item_port.get_next_item(req);
//$display("######################################### iam in driver");

		send_to_dut(req);
		seq_item_port.item_done();
		end
	endtask


	task send_to_dut(dst_xtns xtn);
		@(r_if.dest_drv_cb);

         `uvm_info("DST_DRIVER",$sformatf("printing from  dst_driver \n %s", xtn.sprint()),UVM_LOW) 
		while(r_if.dest_drv_cb.valid_out==1'b0)
		
		@(r_if.dest_drv_cb);
		repeat(xtn.no_of_cycles)
		@(r_if.dest_drv_cb);
//		req.print;
		r_if.dest_drv_cb.read_enb<=1'b1;
		@(r_if.dest_drv_cb);

		while(r_if.dest_drv_cb.valid_out!==0)
		@(r_if.dest_drv_cb);
		@(r_if.dest_drv_cb);
		r_if.dest_drv_cb.read_enb<=1'b0;
		  `uvm_info("DEBUG_MSG", "D_DRV Run phase Completed3", UVM_HIGH)

	endtask


endclass


