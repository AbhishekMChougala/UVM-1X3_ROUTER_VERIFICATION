

class src_config extends uvm_object;

	`uvm_object_utils(src_config)

	virtual router_if r_if;

	uvm_active_passive_enum is_active;
function new(string name="src_config");
	super.new(name);
endfunction
	

endclass

