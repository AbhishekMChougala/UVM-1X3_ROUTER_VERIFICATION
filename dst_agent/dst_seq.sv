

class dst_seqs extends uvm_sequence #(dst_xtns);

	`uvm_object_utils(dst_seqs)
//	extern function new(string name ="ram_wbase_seq");

	function new(string name = "dst_seqs");
		super.new(name);
	endfunction
endclass


class first_30 extends dst_seqs;
	`uvm_object_utils(first_30)
//	bit[1:0] addr;

	function new(string name = "first_30");
		super.new(name);
	endfunction

	task body();
	begin
		req = dst_xtns::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {no_of_cycles inside {[1:28]};});	
	  	 `uvm_info("ROUTR_DST_SEQUENCE",$sformatf("printing from dst_sequence \n %s", req.sprint()),UVM_MEDIUM) 	
		finish_item(req);
	end
	endtask

endclass

class after_30 extends dst_seqs;
	`uvm_object_utils(after_30)
//	bit[1:0] addr;

	function new(string name = "after_30");
		super.new(name);
	endfunction

	task body();
		begin
		req = dst_xtns::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {no_of_cycles inside {[29:60]};});	
	  	 `uvm_info("ROUTR_DST_SEQUENCE",$sformatf("printing from dst_sequence \n %s", req.sprint()),UVM_MEDIUM) 	
		finish_item(req);
		end
	endtask

endclass


/*class dst_small_pkt_seq extends dst_seqs;
	`uvm_object_utils(dst_small_pkt_seq)
	bit [1:0] addr;

	function new(string name = "dst_small_pkt_seq");
		super.new(name);
	endfunction

	task body();
    	repeat(100)
	  beginmake 
   	   req=dst_xtns::type_id::create("req");
	   start_item(req);
	//	assert(req.randomize() with {header[7:2] inside {[1:20]}; header[1:0]==addr;});
		assert(req.randomize() with {no_of_cycles inside {[1:10]};});

	   `uvm_info("RAM_RD_SEQUENCE",$sformatf("printing from dst_sequence \n %s", req.sprint()),UVM_MEDIUM) 
	   finish_item(req); 
	   end
    	endtask 

	task body();
		bit no_of_cycles;
		if(!uvm_config_db #(bit [1:0])::get(null, get_full_name(),"bit",no_of_cycles))
		`uvm_fatal("ADDR_GET_SP", "can't get addr check once ra howley") 
		req = dst_xtns::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {no_of_cycles inside {[1:28]};});	
	  	 `uvm_info("ROUTR_DST_SEQUENCE",$sformatf("printing from dst_sequence \n %s", req.sprint()),UVM_MEDIUM) 	
		finish_item(req);
	endtask

endclass */


/*class dst_medium_pkt_seq extends dst_seqs;
	`uvm_object_utils(dst_medium_pkt_seq)
	bit [1:0] addr;

	function new(string name = "dst_medium_pkt_seq");
		super.new(name);
	endfunction
	task body();
    	repeat(100)
	  begin
   	   req=dst_xtns::type_id::create("req");
	   start_item(req);
	//	assert(req.randomize() with {header[7:2] inside {[21:40]}; header[1:0]==addr;});
		assert(req.randomize() with {no_of_cycles inside {[11:20]};});
	
	   `uvm_info("RAM_RD_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_MEDIUM)
	   finish_item(req); 
	   end
    	endtask 
	virtual task body();
		bit no_of_cycles;
		if(!uvm_config_db #(bit [1:0])::get(null, get_full_name(),"bit",no_of_cycles))
		`uvm_fatal("ADDR_GET_SP", "can't get addr check once ra howley")
		req = dst_xtns::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {no_of_cycles inside {[11:19]};});
	  	 `uvm_info("ROUTR_DST_SEQUENCE",$sformatf("printing from dst_sequence \n %s", req.sprint()),UVM_MEDIUM) 

		finish_item(req);
	endtask

endclass */


/*class dst_big_pkt_seq extends dst_seqs;
	`uvm_object_utils(dst_big_pkt_seq)
	bit [1:0] addr;

	function new(string name = "dst_big_pkt_seq");
		super.new(name);
	endfunction

	virtual task body();
		bit no_of_cycles;
		if(!uvm_config_db #(bit [1:0])::get(null, get_full_name(),"bit",no_of_cycles))
		`uvm_fatal("CYCLES_GET_SP", "can't get addr check once ra howley")
		req = dst_xtns::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {no_of_cycles inside {[21:29]};});
	  	 `uvm_info("ROUTR_DST_SEQUENCE",$sformatf("printing from dst_sequence \n %s", req.sprint()),UVM_MEDIUM) 

		finish_item(req);
	endtask
endclass
*/



