// Modulul square_root - calcularea radacinii patrate a unui 
// numar natural reprezentat pe 8 biti folosind Algoritmul CORDIC

`timescale 1ns / 1ps

module square_root (
	output [15:0] out,
	input  [7:0] in );
  
	parameter PRECISION = 8; // 8-bit precision
	parameter OUTPUT_LEN = 16;
	parameter INPUT_LEN = OUTPUT_LEN + PRECISION;
  
	reg [OUTPUT_LEN - 1:0] base;
	reg [OUTPUT_LEN - 1:0] out_reg;
	
	reg [5:0] iterator;
	reg [INPUT_LEN - 1:0] new_in;
  

	always @(*) begin  
		new_in = in << (2 * PRECISION);
		base = 2 ** 11;
		out_reg = 0;
		for (iterator = 1; iterator <= 12; iterator = iterator + 1) begin
			out_reg = out_reg + base;
			if((out_reg * out_reg) > new_in) begin
				out_reg = out_reg - base;
		   end
		   base = base>>1;
		end
	end
   assign out = out_reg;
endmodule
