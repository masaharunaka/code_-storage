// shift_reg_tb.v
// author:manaka
// date:19/01/04
// Description:First

// History
// v0.1 create new
//

module shift_reg_top
  (
   input                   RST             // reset
  ,input                   CLK             // clock
  ,input [11:0]            DATA_1_IN       // data_input
  ,output[11:0]            DATA_1_OUT      // data_output
  ,input [31:0]            DATA_2_IN       // data_input
  ,output[31:0]            DATA_2_OUT      // data_output
  ,input  [0:0]            DATA_3_IN       // data_input
  ,output [0:0]            DATA_3_OUT      // data_output
  );

//------------------------------------
//  shift_reg module
//------------------------------------
defparam S1.SHIFT_CYCLE =  5 ;
defparam S1.SHIFT_WIDTH = 12 ;

shift_reg S1(
         .rst      (RST) 
        ,.clk      (CLK)
        ,.data_in  (DATA_1_IN)        
        ,.data_out (DATA_1_OUT)
    );

defparam S2.SHIFT_CYCLE = 11 ;
defparam S2.SHIFT_WIDTH = 32 ;

shift_reg S2(
         .rst      (RST) 
        ,.clk      (CLK)
        ,.data_in  (DATA_2_IN)        
        ,.data_out (DATA_2_OUT)
    );

defparam S3.SHIFT_CYCLE = 22;
defparam S3.SHIFT_WIDTH =  1;

shift_reg S3(
         .rst      (RST) 
        ,.clk      (CLK)
        ,.data_in  (DATA_3_IN)        
        ,.data_out (DATA_3_OUT)
    );

endmodule