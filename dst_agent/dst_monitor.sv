

class dst_mon extends uvm_monitor;

	`uvm_component_utils(dst_mon)
	virtual router_if.DMON_MP r_if;
	dst_agt_config d_cfg;
	
	uvm_analysis_port #(dst_xtns) d_mon_port;
	

	function new(string name = "dst_mon", uvm_component parent);
		super.new(name,parent);
		d_mon_port = new("d_mon_port", this);
  	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	if(!uvm_config_db #(dst_agt_config)::get(this,"","dst_agt_config",d_cfg))
		`uvm_fatal(get_type_name(),"cannot get() dst_cfg from uvm_config_db. Have you set() it?") 
	endfunction

	 function void connect_phase(uvm_phase phase);
	r_if = d_cfg.r_if;
	super.connect_phase(phase);
	endfunction

	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		`uvm_info("DEBUG_MSG", "run_phase of dst_mon started", UVM_HIGH);
	forever

  //              `uvm_info("DEBUG_MSG", "run_phase of dst_mon started", UVM_HIGH);

		collect_data();
	endtask

       
//collect data.......................................>


	task collect_data();
		dst_xtns data_sent;
	data_sent = dst_xtns::type_id::create("data_sent");
		@(r_if.dest_mon_cb);

		while(r_if.dest_mon_cb.valid_out!==1)
		@(r_if.dest_mon_cb);
		@(r_if.dest_mon_cb);

		while(r_if.dest_mon_cb.read_enb!==1)
		@(r_if.dest_mon_cb);
		@(r_if.dest_mon_cb);
	data_sent.header = r_if.dest_mon_cb.data_out;
	data_sent.payload = new[data_sent.header[7:2]];
                @(r_if.dest_mon_cb);

	foreach(data_sent.payload[i])
	begin
		data_sent.payload[i] = r_if.dest_mon_cb.data_out;
		@(r_if.dest_mon_cb);
	end
	data_sent.parity = r_if.dest_mon_cb.data_out;
//	data_sent.no_of_cycles = r_if.dest_mon_cb.data_out;
//	while(r_if.dest_mon_cb.read_enb!==0)
	repeat(2)	
	@(r_if.dest_mon_cb);
	
		
	d_mon_port.write(data_sent);
	//data_sent.print;				
		   `uvm_info("PKT_DMON", $sformatf("Packet from dst_mon: \n %s", data_sent.sprint()), UVM_LOW)
	endtask


endclass 
