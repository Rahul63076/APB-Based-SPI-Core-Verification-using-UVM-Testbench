class spi_sequence extends uvm_sequence #(spi_trans);
	`uvm_object_utils(spi_sequence)
	function new(string name ="spi_sequence");
		super.new(name);
	endfunction
endclass


class spi_seq1 extends spi_sequence;
	`uvm_object_utils(spi_seq1)
	function new(string name ="spi_seq1");
		super.new(name);
	endfunction

	task body();
		repeat(1)
			begin
				req = spi_trans::type_id::create("req");
				start_item(req);
				assert(req.randomize() with {miso == 8'b10101010;});
				finish_item(req);
			end
	endtask

endclass
