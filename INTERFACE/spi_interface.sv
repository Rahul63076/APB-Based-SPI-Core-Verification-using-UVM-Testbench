interface spi_if(input bit clock);
	logic sclk;
	logic ss;
	logic mosi;
	logic miso;

	clocking spi_drv_cb@(posedge clock);
		default input #1 output #1;
		output miso;
		input ss,sclk,mosi;
	endclocking

	clocking spi_mon_cb@(posedge clock);
		default input #1 output #1;
		input sclk,ss,mosi, miso;
	endclocking

	modport DRV_MP(clocking spi_drv_cb);
	modport MON_MP(clocking spi_mon_cb);
endinterface
