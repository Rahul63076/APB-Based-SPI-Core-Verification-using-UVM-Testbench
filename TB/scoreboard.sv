class scoreboard extends uvm_scoreboard;
	`uvm_component_utils(scoreboard)

	uvm_tlm_analysis_fifo #(apb_trans) apb2sb;
	uvm_tlm_analysis_fifo #(spi_trans) spi2sb;
	
	apb_trans apb_xtn;
	spi_trans spi_xtn;

	apb_trans apb_xtn_cov;
	spi_trans spi_xtn_cov;

	//cover group of apb 

	covergroup apb_covergroup;
		option.per_instance = 1;
		Reset:coverpoint apb_xtn_cov.PRESET_n { bins rst = {0,1};}
		Address:coverpoint apb_xtn_cov.PADDR { bins addr[] = {0,1,2,3,5};}
		Selx:coverpoint apb_xtn_cov.PSEL {bins sel = {0,1};}
		Enable:coverpoint apb_xtn_cov.PENABLE {bins en = {0,1};}
		Write:coverpoint apb_xtn_cov.PWRITE {bins wr[] = {0,1};}
		Ready:coverpoint apb_xtn_cov.PREADY {bins rdy = {0,1};} 
		Error:coverpoint apb_xtn_cov.PSLVERR {bins err = {0,1};}
		Wdata:coverpoint apb_xtn_cov.PWDATA { bins wdata_low = {[8'h00 : 8'h7f]};
							bins wdata_high = {[8'h80 : 8'hff]};}
		Rdata:coverpoint apb_xtn_cov.PRDATA { bins rdata_low = {[8'h00 : 8'h7f]};
							bins rdata_high = {[8'h80 : 8'hff]};}
		Selx_Enable:cross Selx,Enable;
		Selx_Enable_Ready:cross Selx,Enable,Ready;
	endgroup

	covergroup spi_covergroup;
		option.per_instance = 1;
		Slave_Select:coverpoint spi_xtn_cov.ss { bins sls = {0,1};}
		miso_data:coverpoint spi_xtn_cov.miso { bins miso_low = {[8'h00 : 8'h7f]};
							bins miso_high = {[8'h80 : 8'hff]};}
		mosi_data:coverpoint spi_xtn_cov.mosi { bins mosi_low = {[8'h00 : 8'h7f]};
							bins mosi_high = {[8'h80 : 8'hff]};}
	endgroup

	
	
	function new(string name = "scoreboard" ,uvm_component parent);
		super.new(name,parent);
		apb2sb = new("apb2sb",this);
		spi2sb = new("spi2sb",this);
		apb_covergroup=new();
		spi_covergroup=new();
	endfunction


	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		fork
		begin
			forever 
			begin
				apb2sb.get(apb_xtn);
				apb_xtn_cov = new apb_xtn;
				apb_covergroup.sample();
				$display("==================================COVERAGE REPORT================================");
				$display("FUNCTION COVERAGE ===>  %0.2f",apb_covergroup.get_coverage());
				$display("=================================================================================");
				`uvm_info(get_type_name(),$sformatf("Scoreboard TXN apb :- %s",apb_xtn.sprint()),UVM_LOW)
				
				compare_of_reception(apb_xtn);
			end
		end
		begin
			forever	
			begin
				spi2sb.get(spi_xtn);
				spi_xtn_cov = new spi_xtn;
				spi_covergroup.sample();
				`uvm_info(get_type_name(),$sformatf("Scoreboard TXN spi :- %s",spi_xtn.sprint()),UVM_LOW)

				compare_of_transmission(apb_xtn);
			end

		end	
		join
	endtask
	
	task compare_of_transmission(apb_trans apb_xtn);
		wait(apb_xtn!=null);
        	wait(spi_xtn!=null);

        	if((apb_xtn.PWRITE) && (apb_xtn.PADDR == 3'b101))
        	begin
        		$display("********************************  Score Board Report *********************************");
        		if(apb_xtn.PWDATA == spi_xtn.mosi)
	 			`uvm_info(get_type_name(), "MOSI Data Comparision is successfull", UVM_LOW)
        		else
	 			`uvm_error(get_type_name(), "MOSI Data Comparision is failed")

       			`uvm_info(get_type_name(), $sformatf("Scoreboad : \n Apb_xtn = \n%s,\n Spi_xtn=\n%s", apb_xtn.sprint(), 													spi_xtn.sprint()), UVM_LOW)
       			$display("**************************************************************************************");
        	end
			
	endtask

	task compare_of_reception(apb_trans apb_xtn);
		 wait(apb_xtn!=null);
             //  	wait(spi_xtn!=null);
       		if((!apb_xtn.PWRITE) && (apb_xtn.PADDR == 3'b101))
	 	begin
	   		$display("###############################  Score Board Report #################################");
           		if(apb_xtn.PRDATA == spi_xtn.miso)
				//`uvm_info(get_type_name(),$sformatf("PRDATA = %0p, miso = %0p",apb_xtn.PRDATA, spi_xtn.miso),UVM_LOW)
	     			`uvm_info(get_type_name(), "MISO Data Comparision is successfull", UVM_LOW)
	   		else
	     			`uvm_error(get_type_name(), "MISO Data Comparision is failed")

           		`uvm_info(get_type_name(), $sformatf("Scoreboad : \n Apb_xtn = \n%s,\n Spi_xtn=\n%s", apb_xtn.sprint(), 													spi_xtn.sprint()), UVM_LOW)
	   		$display("######################################################################################");
	     end

	endtask
endclass
