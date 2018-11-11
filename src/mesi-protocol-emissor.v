module emissor(CLK, CLR, CPU_event, state);
	input CLK, CLR;
	// Cinco bits para os eventos da CPU
	// 4 		3 		2 		1		0
	// sh    wh    wm    rh    rm
	// sendo:
	// - sh: 0 -> no shares; 1 -> other shared block (bit auxiliar)
	// - wh: 1 -> write hit
	// - wm: 1 -> write miss
	// - rh: 1 -> read hit
	// - rm: 1 -> read miss
	
	input [4:0] CPU_event;
	output reg [2:0] state;
	
	always @(posedge CLK, posedge CLR) begin
		if (CLR) begin
			state = 3'b001;
		end else 
			case (state)
				3'b001: begin
				end
			endcase
		end
	end
	
endmodule 