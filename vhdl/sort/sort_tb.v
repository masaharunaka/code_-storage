// shift_reg_tb.v
// author:manaka
// date:19/01/04
// Description:First

// History
// v0.1 create new
//

`timescale 1ps/1ps

module sort_tb();


    reg             CLK             ;
    reg             RST             ;
    reg             clr             ;
    reg             swap_en         ;
    reg             dout_en         ;
    reg      [4:0]  data_in         ;
    wire            dout_vld        ;
    wire     [4:0]  data_out        ;

//------------------------------------
//  shift_reg module
//------------------------------------

SORT sort_inst(
         .RST      ( RST      )
        ,.CLK      ( CLK      )
        ,.CLR      ( clr      )
        ,.SWAP_EN  ( swap_en  )
        ,.DOUT_EN  ( dout_en  )
        ,.DATA_IN  ( data_in  )
        ,.DOUT_VLD ( dout_vld )
        ,.DATA_OUT ( data_out )
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
        clr     = {1{1'b0}};
        swap_en = {1{1'b0}};
        dout_en = {1{1'b0}};
        data_in = {4{1'b0}};
        @(negedge CLK);
        while(RST==0) @(negedge CLK);
        repeat(50) @(negedge CLK);
        repeat(100) @(negedge CLK);  
        repeat(100) @(negedge CLK);  
        $stop;
end

endmodule