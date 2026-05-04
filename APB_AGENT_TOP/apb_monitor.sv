class apb_monitor extends uvm_monitor;
	`uvm_component_utils(apb_monitor)
	
	virtual apb_if.MON_MP vif;
	apb_agent_config m_cfg;
	
	uvm_analysis_port #(apb_trans) mon2sb;

	function new(string name = "apb_monitor",uvm_component parent);
		super.new(name,parent);
		mon2sb = new("mon2sb",this);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db #(apb_agent_config)::get(this,"","apb_agent_config",m_cfg))
			`uvm_fatal(get_type_name(),"Get method of apb agent config are failed from monitor")
	endfunction

	function void connect_phase(uvm_phase phase);
		vif = m_cfg.vif;
	endfunction
	
	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		forever
		collect_data();
	endtask

	task collect_data();
		apb_trans xtn;
		xtn = apb_trans :: type_id :: create("xtn");
		@(vif.apb_mon_cb);

		// setup to access phase
		wait((vif.apb_mon_cb.PREADY) && (vif.apb_mon_cb.PENABLE));

	//	wait(vif.apb_mon_cb.PREADY);
		//wait((vif.apb_mon_cb.PSEL) && !(vif.apb_mon_cb.PENABLE))
		begin
			//capture the signal in setup phase
			xtn.PRESET_n = vif.apb_mon_cb.PRESET_n;
			xtn.PSEL = vif.apb_mon_cb.PSEL;
			xtn.PENABLE = vif.apb_mon_cb.PENABLE;
			xtn.PADDR = vif.apb_mon_cb.PADDR;
			xtn.PWRITE= vif.apb_mon_cb.PWRITE;
			xtn.PREADY = vif.apb_mon_cb.PREADY;
			xtn.PSLVERR = vif.apb_mon_cb.PSLVERR;

		end
		//Access Phase
		
			if(xtn.PWRITE)
				xtn.PWDATA = vif.apb_mon_cb.PWDATA;
			else
				xtn.PRDATA = vif.apb_mon_cb.PRDATA;
	
		`uvm_info(get_type_name(),$sformatf("APB Monitor capture txn :- %s",xtn.sprint()),UVM_LOW)

		//send to scoreboard
		
		mon2sb.write(xtn);
		@(vif.apb_mon_cb);

		//end
	endtask
endclass
