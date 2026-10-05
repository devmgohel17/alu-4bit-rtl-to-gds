module alu_4bit (
	input [3:0] A,
	input [3:0] B,
	input [2:0] OP,
	output [3:0] Y,
	output Zero,
	output Carry
);
	reg [3:0] result;
	reg carry;

	always @(*)begin
	    
	// Defautlt values
	result = 4'b0000;
	carry = 1'b0;
	
	case (OP)

	3'b000: begin	// ADD
	     {carry, result} = A + B;
	end

	3'b001: begin    //SUB
	     result = A - B;
	end
	
	3'b010: begin   //AND
	    result = A & B;
	end
	
	3'b011: begin   //OR
	     result = A | B;
	end

	3'b100: begin    //XOR
	     result = A ^ B;
	end

	3'b101: begin      //NOT A
	       result = ~A;
	end

	3'b110: begin        // A < B
	     result = A < B;
	end

	3'b111: begin       //A == B	
	     result = (A == B);
	end
	
      endcase
    end

    assign Y = result;
    assign Carry = carry;
    assign Zero = (result == 4'b0000);	    
	
endmodule 
