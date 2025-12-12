

interface router_if(input bit clock);
   
        bit resetn,pkt_valid,error,busy,valid_out,read_enb;
        logic[7:0]data_in;
        logic[7:0]data_out;

        clocking source_drv_cb@(posedge clock);
           default input #1 output #1;
           input  busy;
           input  error;
           output resetn;
           output pkt_valid;
           output data_in;
        endclocking
        clocking source_mon_cb@(posedge clock);
           default input #1 output #1;
           input data_in;
           input pkt_valid;
           input resetn;
           input error;
           input busy;
        endclocking
        clocking dest_drv_cb@(posedge clock);
           // default input #1 output #1;
            output read_enb;
            input valid_out;
        endclocking
        clocking dest_mon_cb@(posedge clock);
            default input #1 output #1;
            input valid_out;
            input read_enb;
            input data_out;
        endclocking
       
        modport SDRV_MP(clocking source_drv_cb);
        modport SMON_MP(clocking source_mon_cb);
        modport DDRV_MP(clocking dest_drv_cb);
        modport DMON_MP(clocking dest_mon_cb);


	property stable_data;
	@(posedge clock) s_if0.busy |=>$stable(s_if0.data_in);
	endproperty

	property busy_check;
	@(posedge clock) $rose(s_if0.pkt_valid) |=>s_if0.busy;
	endproperty

	property valid_signal;
	@(posedge clock) $rose(s_if0.pkt_valid)|->##3(d_if0.valid_out|d_if1.valid_out|d_if2.valid_out);
	endproperty

	property rd_en1;
	@(posedge clock) d_if0.valid_out|->##[1:29]d_if0.read_enb;
	endproperty

	property rd_en2;
	@(posedge clock) d_if1.valid_out|->##[1:29]d_if1.read_enb;
	endproperty

	property rd_en3;
	@(posedge clock) d_if2.valid_out|->##[1:29]d_if2.read_enb;
	endproperty

	

	c1:assert property(stable_data)
	$display("assertions is done for stable data");
	else
	$display("assertions is not done for stable data");

	c2:assert property(busy_check)
	$display("assertions is done for busy check");
	else
	$display("assertions is not done for busy check");

	c3:assert property(valid_signal)
	$display("assertions is done for valid out");
	else
	$display("assertions is not done for valid out");
	
	c4:assert property(rd_en1)
	$display("assertions is done for read en1");
	else
	$display("assertions is not done for read en1");

	c5:assert property(rd_en2)
	$display("assertions is done for read en 2");
	else
	$display("assertions is not done for read en 2");

	c6:assert property(rd_en3)
	$display("assertions is done for read en 3");
	else
	$display("assertions is not done for read en 3");


	STABLE_DATA : assert property (stable_data);
	BUSY_CHECK : assert property (busy_check);
	VALID_SIGNAL : assert property (valid_signal);
	READ_ENABLE1 : assert property (rd_en1);
	READ_ENABLE2 : assert property (rd_en2);
	READ_ENABLE3 : assert property (rd_en3); 
	
		
endinterface

    
