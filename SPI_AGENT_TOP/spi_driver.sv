class spi_driver extends uvm_driver #(spi_trans);
	`uvm_component_utils(spi_driver)
	
	virtual spi_if.DRV_MP vif;
	spi_agent_config d_cfg;
	bit [7:0] ctrl;
	bit cpha,cpol,lsb;

	function new (string name = "spi_driver", uvm_component parent);
		super.new(name,parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db #(spi_agent_config)::get(this,"","spi_agent_config",d_cfg))
			`uvm_fatal(get_type_name(),"Get method of spi agent config failed from spi driver")
	endfunction

	function void connect_phase(uvm_phase phase);
		vif = d_cfg.vif;
	endfunction

	task run_phase(uvm_phase phase);
		forever
		begin
			seq_item_port.get_next_item(req);
			send_to_dut(req);
			seq_item_port.item_done();	
		end
	endtask

	task send_to_dut(spi_trans xtn);
		if(!uvm_config_db #(bit[7:0])::get(this,"","bit",ctrl))
			`uvm_fatal(get_type_name(),"Get method of ctrl are failed from spi driver")
		cpol = ctrl[3];
		cpha = ctrl[2];
		lsb = ctrl[0];
	
		wait(!vif.spi_drv_cb.ss);
		
		begin
			// LSB FIRST
			if (lsb)  
			begin
    				// CPOL=0, CPHA=0
    				if ((!cpol) && (!cpha))
    				begin
        				vif.spi_drv_cb.miso <= xtn.miso[0];
        				for (int i = 1; i < 8; i++)
        				begin
            					@(negedge vif.spi_drv_cb.sclk);
            					vif.spi_drv_cb.miso <= xtn.miso[i];
       			 		end
    				end

    				// CPOL=0, CPHA=1
    				else if ((!cpol) && (cpha))
    				begin
        				
        				for (int i = 0; i < 8; i++)
        				begin
            					@(posedge vif.spi_drv_cb.sclk);
            					vif.spi_drv_cb.miso <= xtn.miso[i];
        				end
    				end

    				// CPOL=1, CPHA=0
    				else if ((cpol) && (!cpha))
    				begin
        				vif.spi_drv_cb.miso <= xtn.miso[0];
        				for (int i = 1; i < 8; i++)
        				begin
            					@(posedge vif.spi_drv_cb.sclk);
            					vif.spi_drv_cb.miso <= xtn.miso[i];
        				end
    				end

    				// CPOL=1, CPHA=1
    				else if ((cpol) && (cpha))
    				begin
        				
        				for (int i = 0; i < 8; i++)
        				begin
            					@(negedge vif.spi_drv_cb.sclk);
            					vif.spi_drv_cb.miso <= xtn.miso[i];
				

        				end
    				end
			end
			// =====================================================
			else  	// MSB FIRST (lsb == 0)
			begin
    				// CPOL=0, CPHA=0
    				if ((!cpol) && (!cpha))
    				begin
        				vif.spi_drv_cb.miso <= xtn.miso[7];
        				for (int i = 6; i >= 0; i--)
        				begin
            					@(negedge vif.spi_drv_cb.sclk);
            					vif.spi_drv_cb.miso <= xtn.miso[i];
        				end
    				end

    				// CPOL=0, CPHA=1
    				else if ((!cpol) && (cpha))
   	 			begin
        				
        				for (int i = 7; i >= 0; i--)
        				begin
            					@(posedge vif.spi_drv_cb.sclk);
            					vif.spi_drv_cb.miso <= xtn.miso[i];
        				end
    				end

    				// CPOL=1, CPHA=0
    				else if ((cpol) && (!cpha))
    				begin
        				vif.spi_drv_cb.miso <= xtn.miso[7];
        				for (int i = 6; i >= 0; i--)
					begin
            					@(posedge vif.spi_drv_cb.sclk);
            					vif.spi_drv_cb.miso <= xtn.miso[i];
        				end
    				end

    				// CPOL=1, CPHA=1
    				else if ((cpol) && (cpha))
   				begin
        				
        				for (int i = 7; i >= 0; i--)
       	 				begin
            					@(negedge vif.spi_drv_cb.sclk);
            					vif.spi_drv_cb.miso <= xtn.miso[i];
        				end
    				end
			end
		end
		`uvm_info(get_type_name(),$sformatf("SPI TXN :- %s",xtn.sprint()),UVM_LOW)
	
	endtask
endclass
