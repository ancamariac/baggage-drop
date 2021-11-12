`timescale 1ns / 1ps

module sensors_input (
   output   [7 : 0]   height,
   input    [7 : 0]   sensor1,
   input    [7 : 0]   sensor2,
   input    [7 : 0]   sensor3,
   input    [7 : 0]   sensor4);

	reg [2:0] number_of_sensors;
	reg [11:0] sum;

	always @(*) begin

		sum = sensor1 + sensor2 + sensor3 + sensor4;
		number_of_sensors = 4;

		if (sensor1  == 0 || sensor3 == 0) begin
			sum = sum - sensor1;
			sum = sum - sensor3;
			number_of_sensors = number_of_sensors - 2;
		end

		if (sensor2  == 0 || sensor4 == 0) begin
			sum = sum - sensor2;
			sum = sum - sensor4;
			number_of_sensors = number_of_sensors - 2;
		end
		
		if (number_of_sensors == 0) begin
			sum = 0;
		end

		if (number_of_sensors == 2) begin
			if (sum[0] == 1) begin
				sum = (sum / number_of_sensors) + 1;
			end else begin
				sum = (sum / number_of_sensors);
			end
		end
		
		if (number_of_sensors == 4) begin
			if (sum[1] == 1) begin
				sum = (sum / number_of_sensors) + 1;
			end else begin
				sum = (sum / number_of_sensors);
			end
		end		
		
	end

	assign height = sum;
	
endmodule