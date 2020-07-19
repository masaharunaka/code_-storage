// decode_var.v
// author:manaka
// date:19/01/04
// Description:First

// History
// v0.1 create new
//

module decode_var #(
   parameter DATA_BITS = 4 // decoder inout bits
  ,parameter DCD_BITS = 16 // decoder output bits(2^DATA_BITS)
  )
  (
   input [DATA_BITS-1:0] data_in        // decode_input
  ,output[DCD_BITS-1:0]  decode_out     // decode_output
  );

genvar    dcd_lp                   ;    // decode  loop variable

/* decoder */
generate
  for( dcd_lp = 0; dcd_lp < DCD_BITS; dcd_lp = dcd_lp + 1) begin : gen_dcd_lp
    assign decode_out[dcd_lp] = (data_in == dcd_lp )? 1'b1: 1'b0;
  end
endgenerate

endmodule