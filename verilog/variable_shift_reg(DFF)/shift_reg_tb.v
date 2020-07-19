// shift_reg_tb.v
// author:manaka
// date:19/01/04
// Description:First

// History
// v0.1 create new
//

`timescale 1ps/1ps

module shift_reg_tb();


    reg             CLK             ;
    reg             RST             ;
    reg     [11:0]  DATA_1_IN       ;
    wire    [11:0]  DATA_1_OUT      ;
    reg     [31:0]  DATA_2_IN       ;
    wire    [31:0]  DATA_2_OUT      ;
    reg      [0:0]  DATA_3_IN       ;
    wire     [0:0]  DATA_3_OUT      ;

//------------------------------------
//  shift_reg module
//------------------------------------

shift_reg_top top_inst(
         .RST        (RST        )     
        ,.CLK        (CLK        )     
        ,.DATA_1_IN  (DATA_1_IN  )     
        ,.DATA_1_OUT (DATA_1_OUT )     
        ,.DATA_2_IN  (DATA_2_IN  )     
        ,.DATA_2_OUT (DATA_2_OUT )     
        ,.DATA_3_IN  (DATA_3_IN  )     
        ,.DATA_3_OUT (DATA_3_OUT )     
    );
	
//------------------------------------
//  Clock generator
//------------------------------------
parameter   CLK_PERIOD   = 20000;    // ps 20ns

  initial begin
      CLK      = 1'b0;
  end
  
  always #(CLK_PERIOD/2) begin
      CLK  <= ~CLK;
  end 
//------------------------------------
//  Reset generator
//------------------------------------
    initial begin
        RST = 1 ;
        repeat(20) @(negedge CLK);
        RST = 0 ;
    end
//------------------------------------
//  Test
//------------------------------------
initial begin
        DATA_1_IN= {12{1'b0}};
        DATA_2_IN= {32{1'b0}};
        DATA_3_IN=  {1{1'b0}};
        @(negedge CLK);
        while(RST==0) @(negedge CLK);
        repeat(50) @(negedge CLK);

        DATA_1_IN= {12{1'b1}};
        DATA_2_IN= {32{1'b1}};
        DATA_3_IN=  {1{1'b1}};
        repeat(100) @(negedge CLK);  
        DATA_1_IN= {12{1'b0}};
        DATA_2_IN= {32{1'b0}};
        DATA_3_IN=  {1{1'b0}};
        repeat(100) @(negedge CLK);  
        $stop;
end

endmodule