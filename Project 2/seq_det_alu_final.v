

module sequence_detect(
  input reset, 
  input clock, 
  input data_in, 

  input [15:0] A,
  input [15:0] B,
  input [15:0] C,              
  output [15:0] ALU_Out 
);

  parameter SIZE = 3;
  parameter S0 = 3'b000;
  parameter S1 = 3'b001;
  parameter S2 = 3'b010;
  parameter S3 = 3'b011;
  parameter S4 = 3'b100; 
 
  reg data_out_1;
  reg data_out_2;
  reg data_out_3;
  reg data_out_4;
  reg data_out_5;

  reg [SIZE-1:0] current_state_1;
  reg [SIZE-1:0] current_state_2;
  reg [SIZE-1:0] current_state_3;
  reg [SIZE-1:0] current_state_4;
  reg [SIZE-1:0] current_state_5;

  reg [SIZE-1:0] next_state_1;
  reg [SIZE-1:0] next_state_2;
  reg [SIZE-1:0] next_state_3;
  reg [SIZE-1:0] next_state_4;
  reg [SIZE-1:0] next_state_5;
  
  reg [4:0] func_sel;
  reg [4:0] func_sel_1;
  reg [4:0] func_sel_2;
  reg [4:0] func_sel_3;
  reg [4:0] func_sel_4;
  reg [4:0] func_sel_5;

  always @ (posedge clock)
  begin	
    if (reset)
      begin
      current_state_1 <= S0;
      current_state_2 <= S0;     
      current_state_3 <= S0;
      current_state_4 <= S0;
      current_state_5 <= S0;
      end
    else
      begin
      current_state_1 <= next_state_1;
      current_state_2 <= next_state_2;
      current_state_3 <= next_state_3;
      current_state_4 <= next_state_4;
      current_state_5 <= next_state_5; 
      end
  end

  always @ (current_state_1 or current_state_2 or current_state_3 or current_state_4 or current_state_5 or data_in or reset)	
  begin : FSM_10101	
    next_state_1 = current_state_1;
    data_out_1 <= 1'b0;
    func_sel <= 5'b00000;
        case(current_state_1)
	S0 : if (data_in) 
		  next_state_1 = S1; 
	S1 : if (~data_in) 
		   next_state_1 = S2;
        S2 : if (~data_in)
		   next_state_1 = S0;
	     else  
		   next_state_1 = S3;
	S3 : if (~data_in) 
		   next_state_1 = S4;
	     else
		   next_state_1 = S1;
	S4 : if (data_in) 
		begin
		   data_out_1 <= 1'b1;
	           func_sel <= 5'b10101;
		   next_state_1 = S0;
                end
	     else
		   next_state_1 = S0;
	default :
		   next_state_1 = S0;
	endcase
    next_state_2 = current_state_2;
    data_out_2 <= 1'b0;
        case(current_state_2)
	S0 : if (data_in) 
		  next_state_2 = S1; 
	S1 : if (~data_in) 
		   next_state_2 = S2;
        S2 : if (~data_in)
		   next_state_2 = S3;
	     else  
		   next_state_2 = S1;
	S3 : if (~data_in) 
		   next_state_2 = S4;
	     else
		   next_state_2 = S1;
	S4 : if (data_in) 
		begin
		   data_out_2 <= 1'b1;
                   func_sel <= 5'b10001;
		   next_state_2 = S0;
                end
	     else
		   next_state_2 = S0;
	default :
		   next_state_2 = S0;
	endcase
    next_state_3 = current_state_3;
    data_out_3 <= 1'b0;
        case(current_state_3)
	S0 : if (data_in) 
		  next_state_3 = S1; 
	S1 : if (data_in) 
		   next_state_3 = S2;
             else  
		   next_state_3 = S0;
        S2 : if (~data_in)
		   next_state_3 = S3;
	     else  
		   next_state_3 = S1;
	S3 : if (data_in) 
		   next_state_3 = S4;
	     else
		   next_state_3 = S0;
	S4 : if (~data_in) 
		begin
		   data_out_3 <= 1'b1;
                   func_sel <= 5'b11010;
		   next_state_3 = S0;
                end
	     else
		   next_state_3 = S2;
	default :
		   next_state_3 = S0;
	endcase
    next_state_4 = current_state_4;
    data_out_4 <= 1'b0;
        case(current_state_4)
	S0 : if (~data_in) 
		  next_state_4 = S1; 
	S1 : if (data_in) 
		   next_state_4 = S0;
             else  
		   next_state_4 = S2;
        S2 : if (data_in)
		   next_state_4 = S3;
	S3 : if (data_in) 
		   next_state_4 = S4;
	     else
		   next_state_4 = S0;
	S4 : if (~data_in) 
		begin
		   data_out_4 <= 1'b1;
                   func_sel <= 5'b00110;
		   next_state_4 = S4;
                end
	     else
		   next_state_4 = S0;
	default :
		   next_state_4 = S0;
	endcase
    next_state_5 = current_state_5;
    data_out_5 <= 1'b0;
        case(current_state_5)
	S0 : if (~data_in) 
		  next_state_5 = S1; 
	S1 : if (data_in) 
		   next_state_5 = S2;
        S2 : if (data_in)
		   next_state_5 = S0;
	     else  
		   next_state_5 = S3;
	S3 : if (data_in) 
		   next_state_5 = S4;
	     else
		   next_state_5 = S1;
	S4 : if (~data_in) 
		begin
		   data_out_5 <= 1'b1;
                   func_sel <= 5'b01010;
		   next_state_5 = S0;
                end
	     else
		   next_state_5 = S0;
	default :
		   next_state_5 = S0;
	endcase

  end

    reg [15:0] ALU_Result;
    assign ALU_Out = ALU_Result; // ALU out
    
  always @(*)
  begin
        case(func_sel)
        5'b10101: // Addition
           ALU_Result = A + B + C; 
        5'b10001: // Subtraction
           ALU_Result = A - B - C;
        5'b11010: // Multiplication
           ALU_Result = A * B * C;
        5'b00110: // Division
           ALU_Result = (A / B) / C;
        5'b01010: // OR
           ALU_Result = A | B | C;
        default: ALU_Result = A + B + C; 
        endcase
  end
endmodule 

`timescale 1ns / 1ns
module seq_detector_tb();
   
    parameter T = 20; 
    reg clock, reset;
    reg data_in;

    reg [15:0] A;
    reg [15:0] B;
    reg [15:0] C;
    wire [15:0] ALU_Out;

    sequence_detect uut(
        .clock(clock),
        .reset(reset),
        .data_in(data_in),
        .A(A),
        .B(B),
        .C(C),
        .ALU_Out(ALU_Out)
        );

    initial
    begin
        reset = 1'b1;
        A = 16'b110;
        B = 16'b011;
        C = 16'b010;
        data_in = 1'b0;
        #(2*T); 

        reset = 1'b0;
        data_in = 1'b1;
        #(T); 
        data_in = 1'b0;
        #(T); 
        data_in = 1'b0;
        #(T); 
        data_in = 1'b0;
        #(T); 
        data_in = 1'b1;
        #(T); 
        $finish;

    end

    initial 
    begin
	clock = 0;
	forever begin
	#10;
	clock = ~clock;
	end
    end
endmodule