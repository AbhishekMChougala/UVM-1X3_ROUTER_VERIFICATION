

class dst_xtns extends uvm_sequence_item;

	`uvm_object_utils(dst_xtns)

//	   bit valid_out;
//	   bit read_enb;
//	   bit [7:0]data_out;

           bit [7:0]header;
           bit [7:0]payload[];
           bit [7:0]parity;
           bit error;
	   rand bit [5:0]no_of_cycles;
	

	function new(string name = "dst_xtns");
	super.new(name);
	endfunction

	function void do_print(uvm_printer printer);
//        	super.do_print(printer);
        	printer.print_field("header", this.header, 8, UVM_BIN);
        	foreach(payload[i])
        	printer.print_field($sformatf("payload[%0d]",i),this.payload[i], 8, UVM_DEC);
        	printer.print_field("parity", this.parity, 8, UVM_BIN);
        	printer.print_field("error", this.error, 1, UVM_BIN);
        	printer.print_field("no of cycles", this.no_of_cycles, 6, UVM_DEC);

     	endfunction

endclass
