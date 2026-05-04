class test_base extends uvm_test;
	`uvm_component_utils(test_base)

	env_config e_cfg;
	apb_agent_config apb_agt_cfg;
	spi_agent_config spi_agt_cfg;
	env envh;

	int has_spi_agent = 1;
	int has_apb_agent = 1;
	
	function new (string name = "test_base",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		e_cfg = env_config :: type_id :: create("e_cfg");
		if(has_apb_agent)
		begin
			apb_agt_cfg = apb_agent_config::type_id::create("apb_agt_cfg");
			apb_agt_cfg.is_active = UVM_ACTIVE;
			if(!uvm_config_db #(virtual apb_if)::get(this,"","apb_if",apb_agt_cfg.vif))
				`uvm_fatal(get_type_name(),"Get method failed interface not get into test")
			e_cfg.apb_agt_cfg=apb_agt_cfg;			
		end
		
		if(has_spi_agent)
		begin
			spi_agt_cfg = spi_agent_config::type_id::create("spi_agt_cfg");
			spi_agt_cfg.is_active = UVM_ACTIVE;
			if(!uvm_config_db #(virtual spi_if)::get(this,"","spi_if",spi_agt_cfg.vif))
				`uvm_fatal(get_type_name(),"Get method failed interface not get into test")
			e_cfg.spi_agt_cfg=spi_agt_cfg;
		end
	
		e_cfg.has_apb_agent = has_apb_agent;
		e_cfg.has_spi_agent = has_spi_agent;

		uvm_config_db #(env_config) ::set(this,"*","env_config",e_cfg);

		envh = env :: type_id :: create("envh",this);
	endfunction

	function void end_of_elaboration_phase(uvm_phase phase);
		uvm_top.print_topology(uvm_default_table_printer);
	endfunction

	
endclass

class test_cpol1_cpha1_lsb extends test_base;
	`uvm_component_utils(test_cpol1_cpha1_lsb)

	cpol1_cpha1_lsb apb_seq1;
	spi_seq1 spi_seq;
	apb_data_read_seq apb_read_seq;
	bit[7:0] ctrl = 8'b1111_1111;

	function new (string name = "test_cpol1_cpha1_lsb",uvm_component parent);
		super.new(name,parent);
	endfunction
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		uvm_config_db #(bit[7:0]) ::set(this,"*","bit",ctrl);			
	endfunction
	task run_phase(uvm_phase phase);
		apb_seq1 = cpol1_cpha1_lsb :: type_id :: create("apb_seq1");
		spi_seq = spi_seq1 :: type_id :: create("spi_seq");
		apb_read_seq = apb_data_read_seq :: type_id :: create("apb_read_seq");

		phase.raise_objection(this);
			
			apb_seq1.start(envh.apb_agt_top.apb_agth.apb_seqrh);
			//apb_read_seq.start(envh.apb_agt_top.apb_agth.apb_seqrh);
			spi_seq.start(envh.spi_agt_top.spi_agth.spi_seqrh);
			
			#900;
			apb_read_seq.start(envh.apb_agt_top.apb_agth.apb_seqrh);
			#100;
		phase.drop_objection(this);
	endtask

endclass

class test_cpol1_cpha0_lsb extends test_base;
	`uvm_component_utils(test_cpol1_cpha0_lsb)

	cpol1_cpha0_lsb apb_seq2;
	spi_seq1 spi_seq;
	apb_data_read_seq apb_read_seq;

	bit[7:0] ctrl = 8'b1111_1011;
	function new (string name = "test_cpol1_cpha0_lsb",uvm_component parent);
		super.new(name,parent);
	endfunction
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		uvm_config_db #(bit[7:0]) ::set(this,"*","bit",ctrl);			
	endfunction
	task run_phase(uvm_phase phase);
		apb_seq2 = cpol1_cpha0_lsb :: type_id :: create("apb_seq2");
		spi_seq = spi_seq1 :: type_id :: create("spi_seq");
		apb_read_seq = apb_data_read_seq :: type_id :: create("apb_read_seq");
		phase.raise_objection(this);
			apb_seq2.start(envh.apb_agt_top.apb_agth.apb_seqrh);
			
			spi_seq.start(envh.spi_agt_top.spi_agth.spi_seqrh);
			#700;
			apb_read_seq.start(envh.apb_agt_top.apb_agth.apb_seqrh);
			#100;
		phase.drop_objection(this);
	endtask


endclass

class test_cpol0_cpha1_lsb extends test_base;
	`uvm_component_utils(test_cpol0_cpha1_lsb)

	cpol0_cpha1_lsb apb_seq3;
	spi_seq1 spi_seq;
	apb_data_read_seq apb_read_seq;

	bit[7:0] ctrl = 8'b1111_0111;
	function new (string name = "test_cpol0_cpha1_lsb",uvm_component parent);
		super.new(name,parent);
	endfunction
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		uvm_config_db #(bit[7:0]) ::set(this,"*","bit",ctrl);			
	endfunction
	task run_phase(uvm_phase phase);
		apb_seq3 = cpol0_cpha1_lsb :: type_id :: create("apb_seq3");
		spi_seq = spi_seq1 :: type_id :: create("spi_seq");
		apb_read_seq = apb_data_read_seq :: type_id :: create("apb_read_seq");

		phase.raise_objection(this);
			apb_seq3.start(envh.apb_agt_top.apb_agth.apb_seqrh);
			spi_seq.start(envh.spi_agt_top.spi_agth.spi_seqrh);
			#700;
			apb_read_seq.start(envh.apb_agt_top.apb_agth.apb_seqrh);
			#100;
		phase.drop_objection(this);
	endtask

endclass

class test_cpol0_cpha0_lsb extends test_base;
	`uvm_component_utils(test_cpol0_cpha0_lsb)
	
	cpol0_cpha0_lsb apb_seq4;
	spi_seq1 spi_seq;
	apb_data_read_seq apb_read_seq;

	bit[7:0] ctrl = 8'b1111_0011;
	function new (string name = "test_cpol0_cpha0_lsb",uvm_component parent);
		super.new(name,parent);
	endfunction
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		uvm_config_db #(bit[7:0]) ::set(this,"*","bit",ctrl);			
	endfunction
	task run_phase(uvm_phase phase);
		apb_seq4 = cpol0_cpha0_lsb :: type_id :: create("apb_seq4");
		spi_seq = spi_seq1 :: type_id :: create("spi_seq");
		apb_read_seq = apb_data_read_seq :: type_id :: create("apb_read_seq");
		phase.raise_objection(this);
			apb_seq4.start(envh.apb_agt_top.apb_agth.apb_seqrh);
			spi_seq.start(envh.spi_agt_top.spi_agth.spi_seqrh);
			#700;
			apb_read_seq.start(envh.apb_agt_top.apb_agth.apb_seqrh);
			#100;
		phase.drop_objection(this);
	endtask


endclass

class test_cpol1_cpha1_msb extends test_base;
	`uvm_component_utils(test_cpol1_cpha1_msb)
	
	cpol1_cpha1_msb apb_seq5;
	spi_seq1 spi_seq;
	apb_data_read_seq apb_read_seq;

	bit[7:0] ctrl = 8'b1111_1110;
	function new (string name = "test_cpol1_cpha1_msb",uvm_component parent);
		super.new(name,parent);
	endfunction
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		uvm_config_db #(bit[7:0]) ::set(this,"*","bit",ctrl);			
	endfunction
	task run_phase(uvm_phase phase);
		apb_seq5 = cpol1_cpha1_msb :: type_id :: create("apb_seq5");
		spi_seq = spi_seq1 :: type_id :: create("spi_seq");
		apb_read_seq = apb_data_read_seq :: type_id :: create("apb_read_seq");
		phase.raise_objection(this);
			apb_seq5.start(envh.apb_agt_top.apb_agth.apb_seqrh);
			spi_seq.start(envh.spi_agt_top.spi_agth.spi_seqrh);
			#10;
			apb_read_seq.start(envh.apb_agt_top.apb_agth.apb_seqrh);
		phase.drop_objection(this);
	endtask
endclass

class test_cpol1_cpha0_msb extends test_base;
	`uvm_component_utils(test_cpol1_cpha0_msb)
	
	cpol1_cpha0_msb apb_seq6;
	spi_seq1 spi_seq;
	apb_data_read_seq apb_read_seq;

	bit[7:0] ctrl = 8'b1111_1010;
	function new (string name = "test_cpol1_cpha0_msb",uvm_component parent);
		super.new(name,parent);
	endfunction
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		uvm_config_db #(bit[7:0]) ::set(this,"*","bit",ctrl);			
	endfunction
	task run_phase(uvm_phase phase);
		apb_seq6 = cpol1_cpha0_msb :: type_id :: create("apb_seq6");
		spi_seq = spi_seq1 :: type_id :: create("spi_seq");
		apb_read_seq = apb_data_read_seq :: type_id :: create("apb_read_seq");
		phase.raise_objection(this);
			apb_seq6.start(envh.apb_agt_top.apb_agth.apb_seqrh);
			spi_seq.start(envh.spi_agt_top.spi_agth.spi_seqrh);
			#100;
			apb_read_seq.start(envh.apb_agt_top.apb_agth.apb_seqrh);
			#70;
		phase.drop_objection(this);
	endtask

endclass

class test_cpol0_cpha1_msb extends test_base;
	`uvm_component_utils(test_cpol0_cpha1_msb)
	
	cpol0_cpha1_msb apb_seq7;
	spi_seq1 spi_seq;
	apb_data_read_seq apb_read_seq;

	bit[7:0] ctrl = 8'b1111_0110;
	function new (string name = "test_cpol0_cpha1_msb",uvm_component parent);
		super.new(name,parent);
	endfunction
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		uvm_config_db #(bit[7:0]) ::set(this,"*","bit",ctrl);			
	endfunction
	task run_phase(uvm_phase phase);
		apb_seq7 = cpol0_cpha1_msb :: type_id :: create("apb_seq7");
		spi_seq = spi_seq1 :: type_id :: create("spi_seq");
		apb_read_seq = apb_data_read_seq :: type_id :: create("apb_read_seq");
		phase.raise_objection(this);
			apb_seq7.start(envh.apb_agt_top.apb_agth.apb_seqrh);
			spi_seq.start(envh.spi_agt_top.spi_agth.spi_seqrh);
			#100;
			apb_read_seq.start(envh.apb_agt_top.apb_agth.apb_seqrh);
			#100;
		phase.drop_objection(this);
	endtask

endclass

class test_cpol0_cpha0_msb extends test_base;
	`uvm_component_utils(test_cpol0_cpha0_msb)

	cpol0_cpha0_msb apb_seq8;
	spi_seq1 spi_seq;
	apb_data_read_seq apb_read_seq;

	bit[7:0] ctrl = 8'b1111_0010;
	function new (string name = "test_cpol0_cpha0_msb",uvm_component parent);
		super.new(name,parent);
	endfunction
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		uvm_config_db #(bit[7:0]) ::set(this,"*","bit",ctrl);			
	endfunction
	task run_phase(uvm_phase phase);
		apb_seq8 = cpol0_cpha0_msb :: type_id :: create("apb_seq8");
		spi_seq = spi_seq1 :: type_id :: create("spi_seq");
		apb_read_seq = apb_data_read_seq :: type_id :: create("apb_read_seq");
		phase.raise_objection(this);
			apb_seq8.start(envh.apb_agt_top.apb_agth.apb_seqrh);
			spi_seq.start(envh.spi_agt_top.spi_agth.spi_seqrh);
			#100;
			apb_read_seq.start(envh.apb_agt_top.apb_agth.apb_seqrh);
			#100;
		phase.drop_objection(this);
	endtask

endclass

class test_apb_data_read_seq extends test_base;
	`uvm_component_utils(test_apb_data_read_seq)
	apb_data_read_seq apb_seq9;
	spi_seq1 spi_seq;
	function new (string name = "test_apb_data_read_seq",uvm_component parent);
		super.new(name,parent);
	endfunction
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);			
	endfunction
	task run_phase(uvm_phase phase);
		apb_seq9 = apb_data_read_seq :: type_id :: create("apb_seq9");
		spi_seq = spi_seq1 :: type_id :: create("spi_seq");
		phase.raise_objection(this);
			apb_seq9.start(envh.apb_agt_top.apb_agth.apb_seqrh);
			spi_seq.start(envh.spi_agt_top.spi_agth.spi_seqrh);
		phase.drop_objection(this);
	endtask
endclass




	

