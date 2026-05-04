
class apb_agent extends uvm_agent;
	`uvm_component_utils(apb_agent)
	
	apb_monitor apb_monh;
	apb_driver apb_drvh;
	apb_sequencer apb_seqrh;
	apb_agent_config a_cfg;
	
	function new (string name = "apb_agent",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db #(apb_agent_config)::get(this,"","apb_agent_config",a_cfg))
			`uvm_fatal(get_type_name(),"Get method of apb agent config are failed from agent")
		
		apb_monh = apb_monitor :: type_id :: create("apb_monh",this);
		if(a_cfg.is_active == UVM_ACTIVE)
			apb_drvh = apb_driver :: type_id :: create("apb_drvh",this);
			apb_seqrh = apb_sequencer :: type_id :: create("apb_seqrh",this);
	endfunction

	function void connect_phase(uvm_phase phase);
		apb_drvh.seq_item_port.connect(apb_seqrh.seq_item_export);
	endfunction
endclass
	
	
	
