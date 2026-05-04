class apb_sequence extends uvm_sequence #(apb_trans);
	`uvm_object_utils(apb_sequence)
	

	function new(string name = "apb_sequence");
		super.new(name);
	endfunction

endclass

//lsb bit first mode 3
class cpol1_cpha1_lsb extends apb_sequence;
	`uvm_object_utils(cpol1_cpha1_lsb)

	function new(string name = "cpol1_cpha1_lsb");
		super.new(name);
	endfunction
	bit [7:0] ctrl;
	
	task body();
		repeat(1)
		begin
			if(!uvm_config_db #(bit[7:0]) :: get(null,get_full_name(),"bit",ctrl))
				`uvm_fatal(get_type_name(),"Get method of ctrl are failed from apb sequence")

			req = apb_trans::type_id::create("req");

			// for control register 1
			start_item(req);
			assert(req.randomize() with {PRESET_n == 1'b1; PWRITE ==1'b1; PADDR == 3'b000; PWDATA == ctrl;});
			finish_item(req);
			//req.print();
	
			/*start_item(req);
			assert(req.randomize() with {PRESET_n == 1'b1; PWRITE ==1'b0; PADDR == 3'b000;});
			finish_item(req);*/


			// for control register 2
			start_item(req);
			assert(req.randomize() with {PRESET_n == 1'b1; PWRITE ==1'b1; PADDR == 3'b001; PWDATA ==8'b0001_1001 ;});
			finish_item(req);
			//req.print();

			// for boudrate register
			start_item(req);
			assert(req.randomize() with {PRESET_n == 1'b1; PWRITE ==1'b1; PADDR == 3'b010; PWDATA == 8'b0000_0001;});
			finish_item(req);
			//req.print();

			//for data register
			start_item(req);
			assert(req.randomize() with {PRESET_n == 1'b1; PWRITE ==1'b1; PADDR == 3'b101;PWDATA == 8'haa;});
			finish_item(req);
			//req.print();
	
			/*start_item(req);
			assert(req.randomize() with {PRESET_n == 1'b1; PWRITE ==1'b0; PADDR == 3'b101;});
			finish_item(req);*/

		end
	endtask
endclass
//lsb bit first mode 2
class cpol1_cpha0_lsb extends apb_sequence;
	`uvm_object_utils(cpol1_cpha0_lsb)

	function new(string name = "cpol1_cpha0_lsb");
		super.new(name);
	endfunction
	bit [7:0] ctrl;
	task body();
		repeat(1)
		begin
			if(!uvm_config_db #(bit[7:0]) :: get(null,get_full_name(),"bit",ctrl))
				`uvm_fatal(get_type_name(),"Get method of ctrl are failed from apb sequence")

			req = apb_trans::type_id::create("req");

			// for control register 1
			start_item(req);
			assert(req.randomize() with {PRESET_n == 1'b1; PWRITE ==1'b1; PADDR == 3'b000; PWDATA == ctrl;});
			finish_item(req);
			req.print();

			// for control register 2
			start_item(req);
			assert(req.randomize() with {PRESET_n == 1'b1; PWRITE ==1'b1; PADDR == 3'b001; PWDATA ==8'b0001_1001 ;});
			finish_item(req);
			req.print();

			// for boudrate register
			start_item(req);
			assert(req.randomize() with {PRESET_n == 1'b1; PWRITE ==1'b1; PADDR == 3'b010; PWDATA == 8'b0000_0001;});
			finish_item(req);
			req.print();

			//for data register
			start_item(req);
			assert(req.randomize() with {PRESET_n == 1'b1; PWRITE ==1'b1; PADDR == 3'b101;});
			finish_item(req);
			req.print();
		end
	endtask

endclass

//lsb bit first mode 1
class cpol0_cpha1_lsb extends apb_sequence;
	`uvm_object_utils(cpol0_cpha1_lsb)

	function new(string name = "cpol0_cpha1_lsb");
		super.new(name);
	endfunction
	bit [7:0] ctrl;
	task body();
		repeat(1)
		begin
			if(!uvm_config_db #(bit[7:0]) :: get(null,get_full_name(),"bit",ctrl))
				`uvm_fatal(get_type_name(),"Get method of ctrl are failed from apb sequence")

			req = apb_trans::type_id::create("req");

			// for control register 1
			start_item(req);
			assert(req.randomize() with {PRESET_n == 1'b1; PWRITE ==1'b1; PADDR == 3'b000; PWDATA == ctrl;});
			finish_item(req);

			// for control register 2
			start_item(req);
			assert(req.randomize() with {PRESET_n == 1'b1; PWRITE ==1'b1; PADDR == 3'b001; PWDATA ==8'b0001_1001 ;});
			finish_item(req);

			// for boudrate register
			start_item(req);
			assert(req.randomize() with {PRESET_n == 1'b1; PWRITE ==1'b1; PADDR == 3'b010; PWDATA == 8'b0000_0001;});
			finish_item(req);

			//for data register
			start_item(req);
			assert(req.randomize() with {PRESET_n == 1'b1; PWRITE ==1'b1; PADDR == 3'b101;});
			finish_item(req);

		end
	endtask
endclass
//lsb bit first mode 0
class cpol0_cpha0_lsb extends apb_sequence;
	`uvm_object_utils(cpol0_cpha0_lsb)

	function new(string name = "cpol0_cpha0_lsb");
		super.new(name);
	endfunction
	bit [7:0] ctrl;
	task body();
		repeat(1)
		begin
			if(!uvm_config_db #(bit[7:0]) :: get(null,get_full_name(),"bit",ctrl))
				`uvm_fatal(get_type_name(),"Get method of ctrl are failed from apb sequence")

			req = apb_trans::type_id::create("req");

			// for control register 1
			start_item(req);
			assert(req.randomize() with {PRESET_n == 1'b1; PWRITE ==1'b1; PADDR == 3'b000; PWDATA == ctrl;});
			finish_item(req);

			// for control register 2
			start_item(req);
			assert(req.randomize() with {PRESET_n == 1'b1; PWRITE ==1'b1; PADDR == 3'b001; PWDATA ==8'b0001_1001 ;});
			finish_item(req);

			// for boudrate register
			start_item(req);
			assert(req.randomize() with {PRESET_n == 1'b1; PWRITE ==1'b1; PADDR == 3'b010; PWDATA == 8'b0000_0001;});
			finish_item(req);

			//for data register
			start_item(req);
			assert(req.randomize() with {PRESET_n == 1'b1; PWRITE ==1'b1; PADDR == 3'b101;});
			finish_item(req);

		end
	endtask

endclass


//msb bit first mode 3
class cpol1_cpha1_msb extends apb_sequence;
	`uvm_object_utils(cpol1_cpha1_msb)

	function new(string name = "cpol1_cpha1_msb");
		super.new(name);
	endfunction
	bit [7:0] ctrl;
	task body();
		repeat(1)
		begin
			if(!uvm_config_db #(bit[7:0]) :: get(null,get_full_name(),"bit",ctrl))
				`uvm_fatal(get_type_name(),"Get method of ctrl are failed from apb sequence")

			req = apb_trans::type_id::create("req");

			// for control register 1
			start_item(req);
			assert(req.randomize() with {PRESET_n == 1'b1; PWRITE ==1'b1; PADDR == 3'b000; PWDATA == ctrl;});
			finish_item(req);
			req.print();

			// for control register 2
			start_item(req);
			assert(req.randomize() with {PRESET_n == 1'b1; PWRITE ==1'b1; PADDR == 3'b001; PWDATA ==8'b0001_1001;});
			finish_item(req);
			req.print();

			// for boudrate register
			start_item(req);
			assert(req.randomize() with {PRESET_n == 1'b1; PWRITE ==1'b1; PADDR == 3'b010; PWDATA == 8'b0000_0001;});
			finish_item(req);
			req.print();

			//for data register
			start_item(req);
			assert(req.randomize() with {PRESET_n == 1'b1; PWRITE ==1'b1; PADDR == 3'b101;});
			finish_item(req);
			req.print();
		end
	endtask


endclass

//msb bit first mode 2
class cpol1_cpha0_msb extends apb_sequence;
	`uvm_object_utils(cpol1_cpha0_msb)

	function new(string name = "cpol1_cpha0_msb");
		super.new(name);
	endfunction
	bit [7:0] ctrl;
	task body();
		repeat(1)
		begin
			if(!uvm_config_db #(bit[7:0]) :: get(null,get_full_name(),"bit",ctrl))
				`uvm_fatal(get_type_name(),"Get method of ctrl are failed from apb sequence")

			req = apb_trans::type_id::create("req");

			// for control register 1
			start_item(req);
			assert(req.randomize() with {PRESET_n == 1'b1; PWRITE ==1'b1; PADDR == 3'b000; PWDATA == ctrl;});
			finish_item(req);

			// for control register 2
			start_item(req);
			assert(req.randomize() with {PRESET_n == 1'b1; PWRITE ==1'b1; PADDR == 3'b001; PWDATA ==8'b0001_1001 ;});
			finish_item(req);

			// for boudrate register
			start_item(req);
			assert(req.randomize() with {PRESET_n == 1'b1; PWRITE ==1'b1; PADDR == 3'b010; PWDATA == 8'b0000_0001;});
			finish_item(req);

			//for data register
			start_item(req);
			assert(req.randomize() with {PRESET_n == 1'b1; PWRITE ==1'b1; PADDR == 3'b101;});
			finish_item(req);

		end
	endtask

endclass
//msb bit first mode 1
class cpol0_cpha1_msb extends apb_sequence;
	`uvm_object_utils(cpol0_cpha1_msb)

	function new(string name = "cpol0_cpha1_msb");
		super.new(name);
	endfunction
	bit [7:0] ctrl;
	task body();
		repeat(1)
		begin
			if(!uvm_config_db #(bit[7:0]) :: get(null,get_full_name(),"bit",ctrl))
				`uvm_fatal(get_type_name(),"Get method of ctrl are failed from apb sequence")
			req = apb_trans::type_id::create("req");

			// for control register 1
			start_item(req);
			assert(req.randomize() with {PRESET_n == 1'b1; PWRITE ==1'b1; PADDR == 3'b000; PWDATA == ctrl;});
			finish_item(req);

			// for control register 2
			start_item(req);
			assert(req.randomize() with {PRESET_n == 1'b1; PWRITE ==1'b1; PADDR == 3'b001; PWDATA ==8'b0001_1001 ;});
			finish_item(req);

			// for boudrate register
			start_item(req);
			assert(req.randomize() with {PRESET_n == 1'b1; PWRITE ==1'b1; PADDR == 3'b010; PWDATA == 8'b0000_0001;});
			finish_item(req);

			//for data register
			start_item(req);
			assert(req.randomize() with {PRESET_n == 1'b1; PWRITE ==1'b1; PADDR == 3'b101;});
			finish_item(req);

		end
	endtask

endclass
//msb bit first mode 0
class cpol0_cpha0_msb extends apb_sequence;
	`uvm_object_utils(cpol0_cpha0_msb)

	function new(string name = "cpol0_cpha0_msb");
		super.new(name);
	endfunction
	bit [7:0] ctrl;
	task body();
		repeat(1)
		begin
			if(!uvm_config_db #(bit[7:0]) :: get(null,get_full_name(),"bit",ctrl))
				`uvm_fatal(get_type_name(),"Get method of ctrl are failed from apb sequence")

			req = apb_trans::type_id::create("req");

			// for control register 1
			start_item(req);
			assert(req.randomize() with {PRESET_n == 1'b1; PWRITE ==1'b1; PADDR == 3'b000; PWDATA == ctrl;});
			finish_item(req);

			// for control register 2
			start_item(req);
			assert(req.randomize() with {PRESET_n == 1'b1; PWRITE ==1'b1; PADDR == 3'b001; PWDATA ==8'b0001_1001 ;});
			finish_item(req);

			// for boudrate register
			start_item(req);
			assert(req.randomize() with {PRESET_n == 1'b1; PWRITE ==1'b1; PADDR == 3'b010; PWDATA == 8'b0000_0001;});
			finish_item(req);

			//for data register
			start_item(req);
			assert(req.randomize() with {PRESET_n == 1'b1; PWRITE ==1'b1; PADDR == 3'b101;});
			finish_item(req);

		end
	endtask
endclass

//for read of sequence
class apb_data_read_seq extends apb_sequence;
	`uvm_object_utils(apb_data_read_seq)

	function new(string name = "apb_data_read_seq");
		super.new(name);
	endfunction
	
	task body();
		repeat(1)
		begin
			req = apb_trans::type_id::create("req");
			start_item(req);
			assert(req.randomize() with {PRESET_n == 1'b1; PWRITE ==1'b0; PADDR == 3'b101;});
			finish_item(req);
			req.print();
		end
	endtask

endclass


