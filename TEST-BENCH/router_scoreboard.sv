

class router_scoreboard extends uvm_scoreboard;
	
	 `uvm_component_utils(router_scoreboard)

	uvm_tlm_analysis_fifo #(trans) SF[];
	uvm_tlm_analysis_fifo #(dst_xtns) DF[];

	router_env_config env_config_h;
	dst_xtns d_xtnh;
	trans s_xtnh;
	bit[1:0]addr;
//	logic [63:0] ref_data [bit[31:0]];
	function new(string name = "router_scoreboard", uvm_component parent);
      	super.new(name, parent);
      	src_cvrg = new();
      	dst_cvrg = new();
   	endfunction

		

	function void build_phase(uvm_phase phase);
		if(!uvm_config_db #(router_env_config)::get(this,"","router_env_config",env_config_h))
       	       		`uvm_fatal("CONFIG OBJ", "Can't get in scoreboard")
		SF = new[env_config_h.no_of_s_agt];
      		 DF = new[env_config_h.no_of_d_agt];

		s_xtnh=trans::type_id::create("s_xtnh");
		d_xtnh=dst_xtns::type_id::create("d_xtnh");

		foreach(SF[i])
			SF[i]=new($sformatf("SF[%0d]",i),this);	
		foreach(DF[i])
			DF[i]=new($sformatf("DF[%0d]",i),this);	
	endfunction

	covergroup src_cvrg;
		option.per_instance=1;
		ADDR: coverpoint s_xtnh.header[1:0]{bins addr0 = {2'b00};
					            bins addr1 = {2'b01};
						    bins addr2 = {2'b10};}
		PAYLOAD: coverpoint s_xtnh.header[7:2]{bins small_pkt = {[1:15]};
						       bins medium_pkt = {[16:30]}; 
						       bins big_pkt = {[31:63]};}
		ERROR: coverpoint s_xtnh.error{bins no_error = {0};
						bins error = {1};}

	
	//	SRC: cross ADDR,PAYLOAD,ERROR;
	endgroup

	covergroup dst_cvrg;
		option.per_instance=1;
		ADDR: coverpoint d_xtnh.header[1:0]{bins addr0 = {2'b00};
					            bins addr1 = {2'b01};
						    bins addr2 = {2'b10};}
		PAYLOAD: coverpoint d_xtnh.header[7:2]{bins small_pkt = {[1:15]};
						       bins medium_pkt = {[16:30]}; 
						       bins big_pkt = {[31:63]};}
		//DST: cross ADDR,PAYLOAD;
	endgroup


	task run_phase(uvm_phase phase);
	`uvm_info("DEBUG", "score board run phase started", UVM_HIGH)
		forever
		begin
		  fork
		    begin
			SF[0].get(s_xtnh);
         		s_xtnh.print();	
		   	src_cvrg.sample();
		    end
		    begin
		    if(!uvm_config_db#(bit[1:0])::get(this,"","bit[1:0]",addr))
    			    `uvm_fatal( get_type_name(),"getting is failed")

		    		DF[0].get(d_xtnh);
				d_xtnh.print();
		   		dst_cvrg.sample();
		        end
		   			join
	       compare(s_xtnh,d_xtnh);
	      end
	endtask

	task compare(trans s_xtnh,dst_xtns d_xtnh);
	
	if(s_xtnh.header == d_xtnh.header)
	$display("Header Comparision Success");
	else
	$display("Header Comparision Failed ");
	
	if(s_xtnh.payload == d_xtnh.payload)
	$display("Payload Comparision Success");
	else
	$display("Payload Comparision Failed");

	if(s_xtnh.parity == d_xtnh.parity)
	$display("Parity Comparision Success");
	else
	$display("Parity Comparision Failed");

	endtask			
endclass

	

