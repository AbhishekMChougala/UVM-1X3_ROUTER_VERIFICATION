

class dst_agent extends uvm_agent;

	`uvm_component_utils(dst_agent)

	dst_agt_config dst_agt_config_h;
	dst_driver dst_drvh;
	dst_mon dst_monh;
	dst_sequencer dst_seqrh;
	
	function new(string name = "dst_agent", uvm_component parent);
		super.new(name, parent);
	endfunction


	function void build_phase(uvm_phase phase);
	
	super.build_phase(phase);	
	if(!uvm_config_db #(dst_agt_config)::get(this,"","dst_agt_config",dst_agt_config_h))
		`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?")
//		$display("@@@@@@@@@@@@@@@@@@@@@@@@@ %p",dst_agt_config_h);
	dst_monh = dst_mon::type_id::create("dst_monh", this);
	if(dst_agt_config_h.is_active == UVM_ACTIVE)
	begin
		dst_drvh = dst_driver::type_id::create("dst_drvh", this);
		dst_seqrh = dst_sequencer::type_id::create("dst_seqrh", this);
	end
	endfunction

	function void connect_phase(uvm_phase phase);
		//connection
		if(dst_agt_config_h.is_active==UVM_ACTIVE)
		
		dst_drvh.seq_item_port.connect(dst_seqrh.seq_item_export);
	endfunction
endclass


