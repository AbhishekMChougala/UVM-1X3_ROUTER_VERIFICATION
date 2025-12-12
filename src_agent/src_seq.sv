

class src_seqs extends uvm_sequence #(trans);

	`uvm_object_utils(src_seqs)
	function new(string name ="src_seqs");
		super.new(name);
	endfunction
endclass

class small_pkt_seq extends src_seqs;
	`uvm_object_utils(small_pkt_seq)
	bit [1:0] addr;

	function new(string name = "small_pkt_seq");
		super.new(name);
	endfunction

 
	virtual task body();
		bit[1:0] addr;
		if(!uvm_config_db #(bit [1:0])::get(null, get_full_name(), "bit[1:0]", addr))
		`uvm_fatal("ADDR_GET_SP", "can't get addr check once ra howley")
		req = trans::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {header[7:2] inside {[0:15]}; header[1:0]==addr;});
	  	 `uvm_info("ROUTR_DST_SEQUENCE",$sformatf("printing from src_small_sequence \n %s", req.sprint()),UVM_MEDIUM) 	
		finish_item(req);
	endtask
endclass


class medium_pkt_seq extends src_seqs;
        `uvm_object_utils(medium_pkt_seq)
        bit [1:0] addr;

        function new(string name = "medium_pkt_seq");
                super.new(name);
        endfunction


        virtual task body();
                bit[1:0] addr;
                if(!uvm_config_db #(bit [1:0])::get(null, get_full_name(), "bit[1:0]", addr))
                `uvm_fatal("ADDR_GET_SP", "can't get addr check once ra howley")
                req = trans::type_id::create("req");
                start_item(req);
                assert(req.randomize() with {header[7:2] inside{[16:30]}; header[1:0]==addr;});
	  	 `uvm_info("ROUTR_DST_SEQUENCE",$sformatf("printing from src_medium_sequence \n %s", req.sprint()),UVM_MEDIUM) 	
                finish_item(req);
        endtask
endclass


class big_pkt_seq extends src_seqs;
`uvm_object_utils(big_pkt_seq)
        bit [1:0] addr;

        function new(string name = "big_pkt_seq");
                super.new(name);
        endfunction


        virtual task body();
                bit[1:0] addr;
                if(!uvm_config_db #(bit [1:0])::get(null, get_full_name(), "bit[1:0]", addr))
                `uvm_fatal("ADDR_GET_SP", "can't get addr check once ra howley")
                req = trans::type_id::create("req");
                start_item(req);
                assert(req.randomize() with {header[7:2] inside{[31:63]}; header[1:0]==addr;});
	  	 `uvm_info("ROUTR_DST_SEQUENCE",$sformatf("printing from src_big_sequence \n %s", req.sprint()),UVM_MEDIUM) 	
                finish_item(req);
        endtask
endclass


