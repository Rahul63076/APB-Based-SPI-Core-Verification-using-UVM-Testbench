class spi_agent extends uvm_agent;
	`uvm_component_utils(spi_agent)
	
	spi_monitor spi_monh;
	spi_driver spi_drvh;
	spi_sequencer spi_seqrh;
	spi_agent_config a_cfg;
	
	function new (string name = "spi_agent",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db #(spi_agent_config)::get(this,"","spi_agent_config",a_cfg))
			`uvm_fatal(get_type_name(),"Get method of spi agent config are failed from spi agent")
		
		spi_monh = spi_monitor :: type_id :: create("spi_monh",this);
		
		if(a_cfg.is_active == UVM_ACTIVE)
			spi_drvh = spi_driver :: type_id :: create("spi_drvh",this);
			spi_seqrh = spi_sequencer :: type_id :: create("spi_seqrh",this);
	endfunction
	
	function void connect_phase(uvm_phase phase);
		spi_drvh.seq_item_port.connect(spi_seqrh.seq_item_export);
	endfunction
endclass


