class apb_trans extends uvm_sequence_item;
	`uvm_object_utils(apb_trans)
	
	rand bit PRESET_n;
	rand bit PWRITE;
	rand bit [2:0] PADDR;
	rand bit [7:0] PWDATA;
	bit PSEL;
	bit PENABLE;
	bit PREADY;
	bit PSLVERR;
	bit [7:0]PRDATA;

	function new (string name = "apb_trans");
		super.new(name);
	endfunction
	extern function void do_print(uvm_printer printer); 
endclass

	function void apb_trans:: do_print(uvm_printer printer); 
		super.do_print(printer);
		printer.print_field("PRESET_n",this.PRESET_n,1,UVM_BIN);
		printer.print_field("PADDR",this.PADDR,3,UVM_BIN);
		printer.print_field("PWRITE",this.PWRITE,1,UVM_BIN);
		printer.print_field("PWDATA",this.PWDATA,8,UVM_BIN);
		printer.print_field("PRDATA",this.PRDATA,8,UVM_BIN);
		printer.print_field("PSEL",this.PSEL,1,UVM_BIN);
		printer.print_field("PENABLE",this.PENABLE,1,UVM_BIN);
		printer.print_field("PREADY",this.PREADY,1,UVM_BIN);
		printer.print_field("PSLVERR",this.PSLVERR,1,UVM_BIN);
	endfunction

