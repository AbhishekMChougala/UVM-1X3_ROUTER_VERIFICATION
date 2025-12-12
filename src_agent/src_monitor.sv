

class src_mon extends uvm_monitor;

	`uvm_component_utils(src_mon)
	
	virtual router_if.SMON_MP r_if;
	
	src_config s_cfg;
	
	uvm_analysis_port #(trans) s_mon_port;

	function new(string name = "src_mon", uvm_component parent);
		super.new(name,parent);
		s_mon_port = new("s_mon_port", this);
  	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	if(!uvm_config_db #(src_config)::get(this,"","src_config",s_cfg))
		`uvm_fatal("CONFIG","cannot get() src_cfg from uvm_config_db. Have you set() it?") 
	endfunction


	function void connect_phase(uvm_phase phase);
	r_if = s_cfg.r_if;
	endfunction

	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		`uvm_info("DEBUG_MSG", "run_phase of src_mon started", UVM_HIGH);
	forever
		collect_data();
	endtask


//Collect data------------>


	task collect_data();
		trans data_sent;

	data_sent = trans::type_id::create("data_sent");

	while(r_if.source_mon_cb.busy!==0)
	@(r_if.source_mon_cb);

	while(r_if.source_mon_cb.pkt_valid!==1)
	@(r_if.source_mon_cb);
	
	data_sent.header = r_if.source_mon_cb.data_in;
	@(r_if.source_mon_cb);
 	data_sent.payload = new[data_sent.header[7:2]];	
	
	foreach(data_sent.payload[i])
	begin
		while(r_if.source_mon_cb.busy==1)
		@(r_if.source_mon_cb);
		data_sent.payload[i]=r_if.source_mon_cb.data_in;
		@(r_if.source_mon_cb);
	end

	while(r_if.source_mon_cb.pkt_valid!==0)
	@(r_if.source_mon_cb);
	while(r_if.source_mon_cb.busy==1)
	@(r_if.source_mon_cb);
	data_sent.parity = r_if.source_mon_cb.data_in;
        @(r_if.source_mon_cb);

//	repeat(2)
//	@(r_if.source_mon_cb);
	data_sent.error=r_if.source_mon_cb.error;
	
	
	s_mon_port.write(data_sent);
    `uvm_info("SRC_MON", $sformatf("printing from src_monitor \n %s", data_sent.sprint()),UVM_LOW)
	
	endtask
	
endclass


