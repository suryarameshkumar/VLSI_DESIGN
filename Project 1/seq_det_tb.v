//EECT/CE 6325 VLSI Design -Fall 2022
//PROJECT - 1: Verilog/VHD

//Members: Sai Shantan Nagelli (sxn210083), Sanjay Sankarasubramanian (sxs220137), Surya Ramesh Kumar (sxr220066)

//Testbench for 5 Bit Non Overlapping Sequence Detector (10101 & 10001)

module seqDetect_tb;

  reg clock;
  reg reset; 
  reg data;
  
  wire detected_10001;
  wire detected_10101;

  //Link main modules with testbench 

  seq_det_10001 uut1 (.clock(clock),.reset(reset),.data(data),.detected_10001(detected_10001));
  seq_det_10101 uut2 (.clock(clock),.reset(reset),.data(data),.detected_10101(detected_10101));

  initial begin 
    
    //Initialize Inputs

    clock = 1'b0;
    reset = 1'b1;
    data = 0;

    #5 reset = 1'b0;	//Unset reset pin 

    //Input sequence stream 
    
    #10 data = 0;
    #10 data = 1;
    #10 data = 0;
    #10 data = 1;
    #10 data = 0;
    #10 data = 1;	//Overlap = Not counted as first bit of sequence 10101
    #10 data = 0;
    #10 data = 1;
    #10 data = 0;
    #10 data = 1;
    #10 data = 1;
    #10 data = 1;
    #10 data = 0;
    #10 data = 0;
    #10 data = 0;
    #10 data = 1;	//Overlap = Not counted as first bit of sequence 10001
    #10 data = 0;
    #10 data = 0;
    #10 data = 0;
    #10 data = 1;  
  end 
  
  initial #250 $finish;		//Finish simulation
  always #5 clock = ~clock;	//Switch clock from 0 to 1 for every 5 nanoseconds

endmodule 