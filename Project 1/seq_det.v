 
//EECT/CE 6325 VLSI Design -Fall 2022
//PROJECT - 1: Verilog/VHD

//Members: Sai Shantan Nagelli (sxn210083), Sanjay Sankarasubramanian (sxs220137), Surya Ramesh Kumar (sxr220066)

//5 Bit Non Overlapping Sequence Detector (10101 & 10001)

//D Flip Flop Module 

module dff (
  input clock,		// Clock input to drive the flip flop
  input reset,		// Reset input to reset flip flop state
  input d,              // Data input to flip flop
  output reg q          // Output of flip flop - Register Q
  );

  always @ (posedge clock or posedge reset)		//Flip flop works on either postive edge of clock or reset inputs
  begin
    if(reset)		//When Reset pin set to 1, output of flipflop 'q' is reset to 0
      q <= 0;
    else 
      q <= d;		//On positve edge of clock, output of flipflop 'q' is set to Data input 'd'
  end
endmodule 

// Module to detect 5 bit sequence 10101

module seq_det_10101 (
  input clock,		// Clock input to drive the flip flop
  input reset,		// Reset input to reset the flip flop state
  input data,		// Data input to flip flop
  output detected_10101		//Output - O when sequence is not detected, 1 when sequence is detected
  );
  
  wire [2:0] D1;		//3-bit wire for flipflop data inputs
  wire [2:0] Q1;		//3-bit wire for flipflop output

//Boolean Expressions from reducing State Table using K-Map

  assign D1[0] = (~Q1[0] & Q1[1] & Q1[2] & ~data);		//Input to flipflop A

  assign D1[1] = (~Q1[0] & Q1[1] & ~Q1[2] & data) | (~Q1[0] & ~Q1[1] & Q1[2] & ~data);		//Input to flipflop B

  assign D1[2] = (~Q1[0] & data);		//Input to flipflop C

  assign detected_10101 = ~Q1[1] & data & Q1[0] & ~Q1[2];	//Sequence detection output for 10101

//Passing input and output parameters to the flipflops (A, B and C)
  
  dff DA (clock, reset, D1[0], Q1[0]); 
  dff DB (clock, reset, D1[1], Q1[1]);
  dff DC (clock, reset, D1[2], Q1[2]);

endmodule

// Module to detect 5 bit sequence 10001

module seq_det_10001 (
  input clock,		// Clock input to drive the flip flop
  input reset,		// Reset input to reset the flip flop state
  input data,		// Data input to flip flop
  output detected_10001		//Output - O when sequence is not detected, 1 when sequence is detected	
  );
  
  wire [2:0] D2;	//3-bit wire for flipflop data inputs
  wire [2:0] Q2;	//3-bit wire for flipflop output

//Boolean Expressions from reducing State Table using K-Map 

  assign D2[0] = (~Q2[0] & Q2[1] & Q2[2] & ~data);		//Input to flipflop D

  assign D2[1] = (~Q2[0] & Q2[1] & ~Q2[2] & ~data) | (~Q2[0] & ~Q2[1] & Q2[2] & ~data);		//Input to flipflop E

  assign D2[2] = (~Q2[0] & data) + (~Q2[0] & Q2[1] & ~Q2[2]);		//Input to flipflop F

  assign detected_10001 = ~Q2[1] & data & Q2[0] & ~Q2[2];		//Sequence detection output for 10001	

//Passing input and output parameters to the flipflops (D, E and F)

  dff DD (clock, reset, D2[0], Q2[0]); 
  dff DE (clock, reset, D2[1], Q2[1]);
  dff DF (clock, reset, D2[2], Q2[2]);

endmodule