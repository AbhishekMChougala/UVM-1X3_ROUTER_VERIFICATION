

class src_agt extends uvm_agent;
	
	`uvm_component_utils(src_agt)

        src_config src_cfgh;
	src_mon src_monh;
	src_seqr src_seqrh;
	src_drv src_drvh;	

	function new(string name = "src_agt", uvm_component parent);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	
		if(!uvm_config_db #(src_config)::get(this,"","src_config",src_cfgh))
		`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?")
	
	        src_monh=src_mon::type_id::create("src_monh",this);
		if(src_cfgh.is_active==UVM_ACTIVE)
		begin
		src_drvh=src_drv::type_id::create("src_drvh",this);
		src_seqrh=src_seqr::type_id::create("src_seqrh",this);
		end
	endfunction

	function void connect_phase(uvm_phase phase);
		//connection
		if(src_cfgh.is_active==UVM_ACTIVE)
		src_drvh.seq_item_port.connect(src_seqrh.seq_item_export);
	endfunction 

endclass

