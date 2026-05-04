class spi_monitor extends uvm_monitor;
	`uvm_component_utils(spi_monitor)
	
	virtual spi_if.MON_MP vif;
	spi_agent_config m_cfg;
	uvm_analysis_port #(spi_trans) mon2sb;
	bit [7:0]ctrl;
	bit cpol,cpha,lsb;
	
	function new(string name = "spi_monitor",uvm_component parent);
		super.new(name,parent);
		mon2sb = new("mon2sb",this);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db #(spi_agent_config) ::get(this,"","spi_agent_config",m_cfg))
			`uvm_fatal(get_type_name(),"Get method of spi agent config failed from monitor")
	endfunction

	function void connect_phase(uvm_phase phase);
		vif = m_cfg.vif;
	endfunction

	task run_phase(uvm_phase phase);
		forever
			collect_data();
	endtask

	task collect_data();
		spi_trans xtn;
		xtn = spi_trans :: type_id ::create("xtn");
		if(!uvm_config_db #(bit[7:0])::get(this,"","bit",ctrl))
			`uvm_fatal(get_type_name(),"Get method of ctrl are failed from spi driver")
		cpol = ctrl[3];
		cpha = ctrl[2];
		lsb = ctrl[0];
		if(lsb)
		begin
			if((cpol && cpha) || ((!cpol)  &&  (!cpha)))
			begin
				for(int i=0;i<8;i++)
				begin
					@(posedge vif.spi_mon_cb.sclk);
					xtn.miso[i] = vif.spi_mon_cb.miso;
					xtn.mosi[i] = vif.spi_mon_cb.mosi;
					xtn.ss = vif.spi_mon_cb.ss;
					$display("mosi = %0b",xtn.mosi);
				end
			//	$display("mosi = %0b",xtn.mosi);
			end
			else
			begin
				for(int i=0;i<8;i++)
				begin
					@(negedge vif.spi_mon_cb.sclk);
					xtn.miso[i] = vif.spi_mon_cb.miso;
					xtn.mosi[i] = vif.spi_mon_cb.mosi;
					xtn.ss = vif.spi_mon_cb.ss;
				end

			end
		end
		else
		begin
			if((cpol && cpha) || ((!cpol)  &&  (!cpha)))
			begin
				for(int i=7;i>=0;i--)
				begin
					@(posedge vif.spi_mon_cb.sclk);
					xtn.miso[i] = vif.spi_mon_cb.miso;
					xtn.mosi[i] = vif.spi_mon_cb.mosi;
					xtn.ss = vif.spi_mon_cb.ss;
				end

			end
			else
			begin
				for(int i=7;i>=0;i--)
				begin
					@(negedge vif.spi_mon_cb.sclk);
					xtn.miso[i] = vif.spi_mon_cb.miso;
					xtn.mosi[i] = vif.spi_mon_cb.mosi;
					xtn.ss = vif.spi_mon_cb.ss;
				end

			end
		end
		`uvm_info(get_type_name(),$sformatf("SPI MONITOR TXN :- %s",xtn.sprint()),UVM_LOW)
		mon2sb.write(xtn);
		@(vif.spi_mon_cb);
	endtask

endclass
