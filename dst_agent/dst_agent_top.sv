

class dst_agt_top extends uvm_env;

	`uvm_component_utils(dst_agt_top)
	router_env_config env_config_h;
	dst_agent dst_agt_h[];

	function new(string name = "dst_agt_top" , uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
     		super.build_phase(phase);
// Create the instance of dst_agent
	if(!uvm_config_db #(router_env_config)::get(this,"","router_env_config",env_config_h))
              `uvm_fatal("CONFIG OBJ", "Can't get in dst_agent_top")

		uvm_config_db #(router_env_config)::set(this,"*","router_env_config",env_config_h);

           if(env_config_h.has_dstagent) 
           begin
              dst_agt_h = new[env_config_h.no_of_d_agt];
              foreach(dst_agt_h[i])
              begin
                  dst_agt_h[i] = dst_agent::type_id::create($sformatf("dst_agt_h[%0d]", i), this);
		
                 uvm_config_db#(dst_agt_config)::set(this, $sformatf("dst_agt_h[%0d]*" ,i),"dst_agt_config", env_config_h.m_dst_agent_cfg[i]);

$display("%p",env_config_h.m_dst_agent_cfg[i].r_if);
		  
              end
           end

   		
	endfunction


endclass

