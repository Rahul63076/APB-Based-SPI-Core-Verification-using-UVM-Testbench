class spi_trans extends uvm_sequence_item;
	`uvm_object_utils(spi_trans)

	rand bit [7:0]miso;
	bit [7:0]mosi;
	bit ss;
	bit sclk;


	function new (string name = "spi_trans");
		super.new(name);
	endfunction

	extern function void do_print(uvm_printer printer);

endclass

	function void spi_trans::do_print(uvm_printer printer);
		super.do_print(printer);
		printer.print_field("miso",this.miso,8,UVM_BIN);
		printer.print_field("mosi",this.mosi,8,UVM_BIN);
		printer.print_field("ss",this.ss,1,UVM_BIN);
	endfunction

