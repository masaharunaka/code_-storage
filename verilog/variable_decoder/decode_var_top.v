// decode_var_top.v
// author:manaka
// date:19/01/05
// Description:First

// History
// v0.1 create new
//


module decode_var_top(
     input    [3:0]  DATA_1_IN      
    ,output  [15:0]  DECODE_1_OUT   
    ,input    [4:0]  DATA_2_IN      
    ,output  [31:0]  DECODE_2_OUT   
);

//------------------------------------
//  decoder_var module 
//------------------------------------
defparam D1.DATA_BITS =  4  ;
defparam D1.DCD_BITS  =  16 ;

decode_var D1(
         .data_in    (DATA_1_IN)        
        ,.decode_out (DECODE_1_OUT)
    );
	
defparam D2.DATA_BITS =  5  ;
defparam D2.DCD_BITS  =  32 ;

decode_var D2(
         .data_in    (DATA_2_IN)        
        ,.decode_out (DECODE_2_OUT)
    );

endmodule