module top;
	import uvm_pkg::*;

	import test_pkg::*;

	`include "uvm_macros.svh"

	//clock generation
	bit clock;
	always
	#10 clock = ~clock;
	
	//APB INTERFACE
	apb_if IF1(clock);

	//SPI INTERFACE
	spi_if IF2(clock);

	SPI_Top_Block DUV(.PCLK(IF1.PCLK), 
			  .PRESET_n(IF1.PRESET_n),
			  .PWRITE(IF1.PWRITE), 
			  .PSEL(IF1.PSEL),
			  .PENABLE(IF1.PENABLE),
			  .miso(IF2.miso),
			  .PADDR(IF1.PADDR), 
			  .PWDATA(IF1.PWDATA), 
			  .ss(IF2.ss),  
			  .sclk(IF2.sclk),
			  .mosi(IF2.mosi),    
			  .PREADY(IF1.PREADY),
			  .PSLVERR(IF1.PSLVERR),
			  .PRDATA(IF1.PRDATA));
	

	initial
	 begin
		//setting virtual interface for APB interface
		uvm_config_db #(virtual apb_if)::set(null,"*","apb_if",IF1);

		//setting virtual interface for SPI interface
		uvm_config_db #(virtual spi_if)::set(null,"*","spi_if",IF2);
		run_test("test_base");
	end
endmodule


