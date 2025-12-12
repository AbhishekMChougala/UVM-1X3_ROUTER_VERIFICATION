

class router_virtual_sequencer extends uvm_sequencer #(uvm_sequence_item);
 	`uvm_component_utils(router_virtual_sequencer)

	src_seqr src_seqrh[];
	dst_sequencer dst_seqrh[];

	router_env_config m_cfg;

	function new(string name = "router_virtual_sequencer", uvm_component parent);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		// get the config object ram_env_config using uvm_config_db 
	  if(!uvm_config_db #(router_env_config)::get(this,"","router_env_config",m_cfg))
		`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?")
    		 super.build_phase(phase); 
		src_seqrh = new[m_cfg.no_of_s_agt];
		dst_seqrh = new[m_cfg.no_of_d_agt];		
	endfunction
endclass
