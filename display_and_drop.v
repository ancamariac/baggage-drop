// Modulul display_and_drop - afisarea unui mesaj prin 
// intermediul 7 segmente controlabile individual

`timescale 1ns / 1ps

module display_and_drop (
    output   [6 : 0]   seven_seg1, 
    output   [6 : 0]   seven_seg2,
    output   [6 : 0]   seven_seg3,
    output   [6 : 0]   seven_seg4,
    output   [0 : 0]   drop_activated,
    input    [15: 0]   t_act,
    input    [15: 0]   t_lim,
    input              drop_en);
	 
	 reg [6:0] seven_seg1_reg;
	 reg [6:0] seven_seg2_reg;
	 reg [6:0] seven_seg3_reg;
	 reg [6:0] seven_seg4_reg;
	 
	 reg [0:0] is_activated;
	 
	 always @(*) begin
		if (drop_en == 0) begin
			// CoLd
			seven_seg1_reg = 7'b011_1001; // C
			seven_seg2_reg = 7'b101_1100; // o
			seven_seg3_reg = 7'b011_1000; // L
			seven_seg4_reg = 7'b101_1110; // d
			is_activated = 0;
		end
				
		if ((t_act < t_lim) && (drop_en == 1)) begin
			// droP
			seven_seg1_reg = 7'b101_1110; // d
			seven_seg2_reg = 7'b101_0000; // r
			seven_seg3_reg = 7'b101_1100; // o
			seven_seg4_reg = 7'b111_0011; // P
			is_activated = 1;
		end
		
		if ((t_act > t_lim) && (drop_en == 1)) begin
			// Hot
			seven_seg1_reg = 7'b000_0000;
			seven_seg2_reg = 7'b111_0110; // H
			seven_seg3_reg = 7'b101_1100; // o
			seven_seg4_reg = 7'b111_1000; // t			
			is_activated = 0;
		end
	 end
	 
	 assign seven_seg1 = seven_seg1_reg;
	 assign seven_seg2 = seven_seg2_reg;
	 assign seven_seg3 = seven_seg3_reg;
	 assign seven_seg4 = seven_seg4_reg;
	 
	 assign drop_activated = is_activated;

endmodule