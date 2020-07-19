// decode_var_tb.v
// author:manaka
// date:19/01/04
// Description:First

// History
// v0.1 create new
//

`timescale 1ps/1ps

module decode_var_tb();


    reg             CLK             ;
    reg             RST             ;
    reg      [3:0]  DATA_1_IN       ;
    wire    [15:0]  DECODE_1_OUT    ;
    reg      [4:0]  DATA_2_IN       ;
    wire    [31:0]  DECODE_2_OUT    ;
    integer i ;

//------------------------------------
//  decoder_var module 
//------------------------------------
  decode_var_top top_inst(
     .DATA_1_IN    ( DATA_1_IN    )
    ,.DECODE_1_OUT ( DECODE_1_OUT )
    ,.DATA_2_IN    ( DATA_2_IN    )
    ,.DECODE_2_OUT ( DECODE_2_OUT )
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
        DATA_1_IN= {4{1'b0}};
        DATA_2_IN= {5{1'b0}};
        @(negedge CLK);
        while(RST==0) @(negedge CLK);
        repeat(50) @(negedge CLK);
        
        // count up decoder
        // count up decoder
	    for( i = 0; i < 16; i = i + 1) begin
            DATA_1_IN= DATA_1_IN + 1 ;
            repeat(10) @(negedge CLK);  
        end

	    for( i = 0; i < 32; i = i + 1) begin
            DATA_2_IN= DATA_2_IN + 1 ;
            repeat(10) @(negedge CLK);  
        end
		
        $stop;
end

endmodule