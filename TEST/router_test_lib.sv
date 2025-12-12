

class router_base_test extends uvm_test;

	`uvm_component_utils(router_base_test)
	router_env_config m_tb_config;
	router_tb router_envh;

	bit has_scoreboard = 1;
	bit has_srcagent = 1;
	bit has_dstagent = 1;

	int no_of_s_agt = 1;
	int no_of_d_agt = 3;

	bit has_virtual_sequencer = 1;

	src_config m_src_agent_cfg[];
	dst_agt_config m_dst_agent_cfg[];
	
	function new(string name = "router_base_test", uvm_component parent);
                super.new(name, parent);
        endfunction

	



	function void build_phase(uvm_phase phase);
		m_tb_config = router_env_config::type_id::create("m_tb_config");
	m_tb_config.m_src_agent_cfg  = new[no_of_s_agt];
	m_tb_config.m_dst_agent_cfg  = new[no_of_d_agt];

	 if(has_srcagent)
        begin
            m_src_agent_cfg = new[no_of_s_agt];
          foreach(m_src_agent_cfg[i])
          begin
            m_src_agent_cfg[i] = src_config::type_id::create($sformatf("m_src_agent_cfg[%0d]",i));
            m_src_agent_cfg[i].is_active = UVM_ACTIVE;
		//	uvm_config_db #(src_config)::set(this,"*", "src_config",m_src_agent_cfg[i]);
            if(!uvm_config_db #(virtual router_if)::get(this,"",$sformatf("s_if_%0d",i),m_src_agent_cfg[i].r_if))
               `uvm_fatal("VIF CONFIG","Can't get vif")
	m_tb_config.m_src_agent_cfg[i]  =  m_src_agent_cfg[i];
		

          end
        end
        
	
	 
        if(has_dstagent)
        begin
           m_dst_agent_cfg = new[no_of_d_agt];
         foreach(m_dst_agent_cfg[i])
          begin
            m_dst_agent_cfg[i] = dst_agt_config::type_id::create($sformatf("m_dst_agent_cfg[%0d]",i));
			m_dst_agent_cfg[i].is_active = UVM_ACTIVE;
         //   uvm_config_db #(dst_agt_config)::set(this,"*","dst_agt_config",m_dst_agent_cfg[i]);
	if(!uvm_config_db #(virtual router_if)::get(this,"",$sformatf("d_if_%0d",i),m_dst_agent_cfg[i].r_if))
               `uvm_fatal("VIF CONFIG","Can't get vif")
		

          end
        end

 	m_tb_config.m_dst_agent_cfg =  m_dst_agent_cfg;

	m_tb_config.no_of_s_agt= no_of_s_agt;
       m_tb_config.no_of_d_agt= no_of_d_agt;
       m_tb_config.has_srcagent = has_srcagent;
       m_tb_config.has_dstagent = has_dstagent;
	   m_tb_config.has_scoreboard = has_scoreboard; 


       uvm_config_db #(router_env_config)::set(this,"*","router_env_config",m_tb_config);
       router_envh  = router_tb::type_id::create("router_envh",this);
		super.build_phase(phase);
	


	endfunction

	

	function void end_of_elaboration_phase(uvm_phase phase);
		uvm_top.print_topology;
	endfunction
endclass


/////////////////small packet/////////////////////////

class small_pkt_test extends router_base_test;
    `uvm_component_utils(small_pkt_test)
	   bit[1:0] addr = 2'b00;
	   small_pkt_seq small_h;
	 first_30 dst_small_h;
	   function new(string name = "small_pkt_test", uvm_component parent);
	        super.new(name, parent);
	   endfunction
	   
	   function void build_phase(uvm_phase phase);
	        super.build_phase(phase);
	        uvm_config_db #(bit[1:0])::set(this, "*", "bit[1:0]", addr);
			small_h = small_pkt_seq::type_id::create("small_h");
			dst_small_h = first_30::type_id::create("dst_small_h");
	   endfunction
	   
	   task run_phase(uvm_phase phase);
	      begin
	         phase.raise_objection(this);
			fork
		     small_h.start(router_envh.src_top.src_agth[0].src_seqrh);
		    dst_small_h.start(router_envh.dst_top.dst_agt_h[0].dst_seqrh);
			join
			#100;		
		    // small_h.start(router_envh.v_seqr);
		
			 phase.drop_objection(this);
		  end
	   endtask
endclass

/////////////////////////////// Medium packet //////////////////////

class medium_pkt_test extends router_base_test;
    `uvm_component_utils(medium_pkt_test)
	   bit[1:0] addr = 2'b00;
	   medium_pkt_seq medium_h;
	 first_30 dst_medium_h;
	
	   function new(string name = "medium_pkt_test", uvm_component parent);
	        super.new(name, parent);
	   endfunction
	   
	   function void build_phase(uvm_phase phase);
	        super.build_phase(phase);
	        uvm_config_db #(bit[1:0])::set(this, "*", "bit[1:0]", addr);
			medium_h = medium_pkt_seq::type_id::create("medium_h");
			dst_medium_h = first_30::type_id::create("dst_medium_h");

	   endfunction
	   
	   task run_phase(uvm_phase phase);
	      begin
	         phase.raise_objection(this);
		    // medium_h.start(router_envh.src_top.src_agth[0].src_seqrh);
			fork
		     medium_h.start(router_envh.src_top.src_agth[0].src_seqrh);
		     dst_medium_h.start(router_envh.dst_top.dst_agt_h[0].dst_seqrh);
			join
			#100;

			 phase.drop_objection(this);
		  end
	   endtask
endclass

/////////////////////////// Big packet ///////////////////

class big_pkt_test extends router_base_test;
    `uvm_component_utils(big_pkt_test)
	   bit[1:0] addr = 2'b00;
	   big_pkt_seq big_h;
	 first_30 dst_big_h;
//	after_30 after_h;
	
	   function new(string name = "big_pkt_test", uvm_component parent);
	        super.new(name, parent);
	   endfunction
	   
	   function void build_phase(uvm_phase phase);
	        super.build_phase(phase);
	        uvm_config_db #(bit[1:0])::set(this, "*", "bit[1:0]", addr);
			big_h = big_pkt_seq::type_id::create("big_h");
			dst_big_h = first_30::type_id::create("dst_big_h");

		//	after_h = after_30::type_id::create("after_h");

	   endfunction
	   
	   task run_phase(uvm_phase phase);
	      begin
	         phase.raise_objection(this);
	//	     big_h.start(router_envh.src_top.src_agth[0].src_seqrh);
			fork
		     big_h.start(router_envh.src_top.src_agth[0].src_seqrh);
		     dst_big_h.start(router_envh.dst_top.dst_agt_h[0].dst_seqrh);
			
		    // after_h.start(router_envh.dst_top.dst_agt_h[0].dst_seqrh);
			join
			#100;

			 phase.drop_objection(this);
		  end
	   endtask
endclass

