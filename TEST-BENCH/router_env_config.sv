

class router_env_config extends uvm_object;

//	bit has_functional_coverage = 0;
//	bit has_srcagent_functional_coverage = 0;
	bit has_scoreboard ;
	bit has_srcagent ;
	bit has_dstagent ;

	int no_of_s_agt;
	int no_of_d_agt;

	bit has_virtual_sequencer;

	src_config m_src_agent_cfg[];
	dst_agt_config m_dst_agent_cfg[];
	
//	int no_of_duts;
	
	`uvm_object_utils(router_env_config)

	function new(string name = "router_env_config");
  		super.new(name);
	endfunction

	
	
endclass
