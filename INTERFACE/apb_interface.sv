interface apb_if(input bit clock);
	bit PCLK;
	logic PRESET_n,PREADY,PWRITE,PENABLE,PSEL,PSLVERR;
	logic [2:0] PADDR;
	logic [7:0] PWDATA,PRDATA;

	assign PCLK = clock;

	clocking apb_drv_cb@(posedge PCLK);
		default input #1 output #1;
		output PRESET_n,PADDR,PWRITE,PENABLE,PSEL,PWDATA;
		input PSLVERR ,PREADY ,PRDATA;
	endclocking

	clocking apb_mon_cb@(posedge PCLK);
		default input #1 output #1;
		input PRESET_n,PADDR,PWRITE,PENABLE,PSEL,PWDATA,PSLVERR ,PREADY ,PRDATA;
	endclocking

	modport DRV_MP (clocking apb_drv_cb);
	modport MON_MP (clocking apb_mon_cb);

	//................ASSERTIONS...........................
	//=====================================================
	
	property signal_stable;
		@(posedge clock) $rose(PSEL) |-> ($stable(PWRITE) && $stable(PADDR) && $stable(PWDATA)) until PREADY[->1];
	endproperty

	property penable_stable;
		@(posedge clock) $rose(PENABLE) |-> ($stable(PSEL) && $stable(PENABLE)) until PREADY[->1];
	endproperty
	
	property address_reserved;
		@(posedge clock) PSEL |-> ((PADDR != 3'b100) || (PADDR != 3'b110) || (PADDR != 3'b111));
	endproperty

	property psel_to_pready;
		@(posedge clock) (PSEL && PENABLE)|-> ##[0:$]PREADY;
	endproperty

	property penable_deassert;
		@(posedge clock) (!PSEL) |-> (!PENABLE);
	endproperty

	property valid_write_data_transfer;
		@(posedge clock) (PSEL && PENABLE && PWRITE) |-> (PWDATA != 'hx);
	endproperty

	property valid_read_data;
		@(posedge clock) (PSEL && PENABLE && !PWRITE) |->(PRDATA != 'hx);
	endproperty

	property pready_low_at_start;
		@(posedge clock) (PSEL && !PENABLE) |-> (!PREADY);
	endproperty

	property pready_dasserted;
		@(posedge clock)(!PSEL && !PENABLE) |-> (!PREADY);
	endproperty

	signalstable:assert property(signal_stable)
			$display("signal_stable pass");
		else
			$display("signal_stable fail");

	penablestable:assert property(penable_stable)
			$display("penable_stable pass");
		else
			$display("penable_stable fail");

	addressreserved:assert property(address_reserved)
			$display("address_reserved pass");
		else
			$display("address_reserved fail");

	pseltopready:assert property(psel_to_pready)
			$display("psel_to_pready pass");
		else
			$display("psel_to_pready fail");
	
	penabledeassert:assert property(penable_deassert)
			$display("penable_deassert pass");
		else
			$display("penable_deassert fail");

	validwritedata_transfer:assert property(valid_write_data_transfer)
			$display("valid_write_data_transfer pass");
		else
			$display("valid_write_data_transfer fail");

	validreaddata:assert property(valid_read_data)
			$display("valid_read_data pass");
		else
			$display("valid_read_data fail");

	preadylowatstart:assert property(pready_low_at_start)
			$display("pready_low_at_start pass");
		else
			$display("pready_low_at_start fail");

	preadydasserted:assert property(pready_dasserted)
			$display("pready_dasserted pass");
		else
			$display("pready_dasserted fail");
		
	
endinterface

