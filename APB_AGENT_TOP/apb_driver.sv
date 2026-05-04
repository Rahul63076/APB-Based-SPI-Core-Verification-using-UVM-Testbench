class apb_driver extends uvm_driver #(apb_trans);
	`uvm_component_utils(apb_driver)
	
	virtual apb_if.DRV_MP vif ;
	apb_agent_config d_cfg;

	function new (string name = "apb_driver",uvm_component parent);
		super.new(name,parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db #(apb_agent_config) ::get(this,"","apb_agent_config",d_cfg))
			`uvm_fatal(get_type_name(),"Get method of apb agent config are failed from driver")
	endfunction

	function void connect_phase(uvm_phase phase);
		vif = d_cfg.vif;
	endfunction
	
	task run_phase(uvm_phase phase);
		reset_dut();	
		forever
		begin
			seq_item_port.get_next_item(req);
			send_to_dut(req);
			seq_item_port.item_done();
		end
	endtask

	task send_to_dut(apb_trans xtn);

		//setup phase
		@(vif.apb_drv_cb);
		vif.apb_drv_cb.PADDR <= xtn.PADDR;
		vif.apb_drv_cb.PWRITE <= xtn.PWRITE;
		vif.apb_drv_cb.PSEL <= 1'b1;
		vif.apb_drv_cb.PENABLE <= 1'b0;

		if(xtn.PWRITE)
			vif.apb_drv_cb.PWDATA <= xtn.PWDATA;
		

		//Access/Enable Phase
		
		@(vif.apb_drv_cb);
		vif.apb_drv_cb.PENABLE <= 1'b1;
		
		wait(vif.apb_drv_cb.PREADY);
		
		//read operation
		if(!xtn.PWRITE)
		begin
			xtn.PRDATA = vif.apb_drv_cb.PRDATA;
		end
		`uvm_info(get_type_name(),$sformatf("APB TXN :- %s",xtn.sprint()),UVM_LOW)
		
		vif.apb_drv_cb.PSEL <= 1'b0;
		vif.apb_drv_cb.PENABLE <= 1'b0;
		
	endtask

	task reset_dut();
		@(vif.apb_drv_cb);
		vif.apb_drv_cb.PRESET_n<=1'b0;
		repeat(2)
		@(vif.apb_drv_cb);
		vif.apb_drv_cb.PRESET_n<=1'b1;
	endtask
endclass
