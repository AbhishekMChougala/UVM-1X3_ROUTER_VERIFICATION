

class src_agt_top extends uvm_env;

	`uvm_component_utils(src_agt_top)
	router_env_config rec_ch;
	src_agt src_agth[];

		function new(string name = "src_agt_top", uvm_component parent);
			super.new(name,parent);
		endfunction
//build_phase
		function void build_phase(uvm_phase phase);
			super.build_phase(phase);
	
		if(!uvm_config_db #(router_env_config)::get(this,"","router_env_config",rec_ch))
		`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?")

		uvm_config_db #(router_env_config)::set(this,"*","router_env_config",rec_ch);
		

		if(rec_ch.has_srcagent)
		begin
			src_agth=new[rec_ch.no_of_s_agt];
			foreach(src_agth[i])
			begin
			uvm_config_db #(src_config)::set(this, $sformatf("src_agth[%0d]*", i), "src_config", rec_ch.m_src_agent_cfg[i]);
			src_agth[i] = src_agt::type_id::create($sformatf("src_agth[%0d]", i), this);
			end
		end
		endfunctio
		
endclass

      
