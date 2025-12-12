

class trans extends uvm_sequence_item;

	`uvm_object_utils(trans)

	rand bit [7:0]header;
     	rand bit [7:0]payload[];
     	bit [7:0]parity;
	bit pkt_valid;
     	bit error;
	

	constraint VLD_ADDR{header[1:0]!=2'b11;}
     	constraint PL_LEN{payload.size == header[7:2];}
     	constraint VLD_PL_LEN{header[7:2]!=0;}

	function new(string name = "s_xtn");
           	super.new(name);
     	endfunction

	function void do_print(uvm_printer printer);
        super.do_print(printer);
        printer.print_field("header", this.header, 8, UVM_BIN);
        foreach(payload[i])
        printer.print_field($sformatf("payload[%0d]",i), this.payload[i], 8, UVM_DEC);
        printer.print_field("parity", this.parity, 8, UVM_BIN);
        printer.print_field("error", this.error, 1, UVM_BIN);
     endfunction
	 
     function void post_randomize();
          parity = header;
          foreach(payload[i])
             parity = parity^payload[i];
     endfunction

endclass

