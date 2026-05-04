class env extends uvm_env;
	`uvm_component_utils(env)

	env_config e_cfg;

	function new(string name = "env",uvm_component parent);
		super.new(name,parent);
	endfunction

	
	apb_agent_config apb_agt_cfg;
	spi_agent_config spi_agt_cfg;

	apb_agent_top apb_agt_top;
	spi_agent_top spi_agt_top;
	scoreboard sb;

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		
		if(!uvm_config_db #(env_config) ::get (this,"","env_config",e_cfg))
			`uvm_fatal(get_type_name(),"Get method of env config are failed from env")
	
		
		if(e_cfg.has_apb_agent)
			uvm_config_db #(apb_agent_config) ::set(this,"*","apb_agent_config",e_cfg.apb_agt_cfg);
			apb_agt_top = apb_agent_top :: type_id :: create("apb_agt_top",this);

		if(e_cfg.has_spi_agent)
			uvm_config_db #(spi_agent_config) ::set(this,"*","spi_agent_config",e_cfg.spi_agt_cfg);
			spi_agt_top = spi_agent_top :: type_id :: create("spi_agt_top",this);
		if(e_cfg.has_scoreboard)
			sb = scoreboard::type_id::create("sb",this);
	endfunction
	
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		apb_agt_top.apb_agth.apb_monh.mon2sb.connect(this.sb.apb2sb.analysis_export);
		spi_agt_top.spi_agth.spi_monh.mon2sb.connect(this.sb.spi2sb.analysis_export);
	endfunction
endclass

