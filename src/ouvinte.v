module ouvinte(CLK, CLR, CPU_event, state, BUS);
	input CLK, CLR;
	// Cinco bits para os eventos da CPU
	// 4 		3 		2 		1		0
	// inv   wh    wm    rh    rm
	// sendo:
	// - inv: 1 -> invalid
	// - wh: 1 -> write hit
	// - wm: 1 -> write miss
	// - rh: 1 -> read hit
	// - rm: 1 -> read miss
	input [4:0] CPU_event;
	output [5:0] BUS;
	output reg [2:0] state;
	
	always @(posedge CLK, posedge CLR) begin
		if (CLR) begin
			state = 3'b001;
			BUS = 6'b000_000;
		end else begin
			case (state) 
				3'b001: begin // Invalid
					// NADA
				end
				3'b010: begin // Shared
					case (CPU_event)
						5'b10000: begin // sinal de invalido
							state = 3'b001; // vai para invalid
						end
						5'b00100: begin // write miss
							state = 3'b001; // vai para invalid
						end
						5'b00001: begin
							// NADA
						end
					endcase
				end
				3'b011: begin // Exclusive
					5'b10000: begin // sinal de invalido
						state = 3'b001; // vai para invalid
					end
					5'b00100: begin // write miss
						state = 3'b001; // vai para invalid
					end
					5'b00001: begin // read miss
						state = 3'b010; // vai para shared
					end
				end
				3'b100: begin // Modified
					5'b00001: begin // read miss
						state = 3'b010; // vai para shared
						BUS = {3'b010, 3'b001}; // abort memory access/ write-back block
					end
					5'b00100: begin
						state = 3'b010; // vai para shared
						BUS = {3'b010, 3'b001}; // abort memory access/ write-back block
					end
				end
			endcase
		end
	end
	
endmodule 