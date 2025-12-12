

class router_tb extends uvm_env;

	`uvm_component_utils(router_tb)


	src_agt_top src_top;
	dst_agt_top dst_top;


	router_env_config m_cfg;

	router_scoreboard sb;
	router_virtual_sequencer v_seqrh;

	extern function new(string name = "router_tb", uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);

endclass


	function router_tb::new(string name = "router_tb", uvm_component parent);
		super.new(name,parent);
	endfunction


	//build phase
	function void router_tb::build_phase(uvm_phase phase);
		super.build_phase(phase);
	 if(!uvm_config_db #(router_env_config)::get(this,"","router_env_config",m_cfg))
		`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?")
                if(m_cfg.has_srcagent) 
		//	uvm_config_db #(src_config)::set(this, "*", "src_config", m_cfg.m_src_agent_cfg[0]);
			src_top = src_agt_top::type_id::create("src_top", this);
		if(m_cfg.has_dstagent) 
	         	dst_top = dst_agt_top::type_id::create("dst_top",this);
		v_seqrh = router_virtual_sequencer::type_id::create("v_seqrh", this);
 		if(m_cfg.has_scoreboard) 
                  sb = router_scoreboard::type_id::create("sb", this);	

	endfunction

	//connect phase
   	function void router_tb::connect_phase(uvm_phase phase);
	      super.connect_phase(phase);
			if(m_cfg.has_srcagent)
			begin
			    for(int i=0;i<m_cfg.no_of_s_agt;i++)
				v_seqrh.src_seqrh[i] = src_top.src_agth[i].src_seqrh;
			end

                      if(m_cfg.has_dstagent)
			begin
			    for(int i=0;i<m_cfg.no_of_d_agt;i++)
				v_seqrh.dst_seqrh[i] = dst_top.dst_agt_h[i].dst_seqrh;
			end

                       if(m_cfg.has_scoreboard) 
			 begin
			    		for(int i=0;i<m_cfg.no_of_s_agt;i++)
    		                         src_top.src_agth[i].src_monh.s_mon_port.connect(sb.SF[i].analysis_export);
			    		for(int i=0;i<m_cfg.no_of_d_agt;i++)
      		                         dst_top.dst_agt_h[i].dst_monh.d_mon_port.connect(sb.DF[i].analysis_export);
			 end
	
	
	endfunction


