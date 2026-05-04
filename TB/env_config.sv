class env_config extends uvm_object;
	`uvm_object_utils(env_config)
	

	bit has_spi_agent = 1;
	bit has_apb_agent = 1;
	bit has_scoreboard = 1;

	apb_agent_config apb_agt_cfg;
	spi_agent_config spi_agt_cfg;

	function new (string name = "env_config");
		super.new(name);
	endfunction

endclass

	

	
