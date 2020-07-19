// shift_reg.v
// author:manaka
// date:19/01/04
// Description:First

// History
// v0.1 create new
//

module shift_reg #(
   parameter SHIFT_CYCLE = 5
  ,parameter SHIFT_WIDTH = 12
  )
  (
   input                   rst             // reset
  ,input                   clk             // clock
  ,input [SHIFT_WIDTH-1:0] data_in         // data_input
  ,output[SHIFT_WIDTH-1:0] data_out        // data_output
  );

genvar reg_lp  ; // reg  loop variable
genvar wire_lp ; // wire loop variable
reg  [SHIFT_WIDTH-1:0] data_ff_r[SHIFT_CYCLE:1]  ; // shift_reg
wire [SHIFT_WIDTH-1:0] data_ff  [SHIFT_CYCLE:0]  ; // shift_wire

/* shift register */
generate
  for(reg_lp = 0; reg_lp < SHIFT_CYCLE; reg_lp = reg_lp + 1) begin : gen_reg_lp
    always @(posedge clk or posedge rst)
      begin
      if(rst)begin
        data_ff_r[reg_lp+1] <= {SHIFT_WIDTH{1'b0}};
      end
      else begin
        data_ff_r[reg_lp+1] <= data_ff[reg_lp];
      end
    end
  end
endgenerate

generate
  for( wire_lp = 0; wire_lp < SHIFT_CYCLE; wire_lp = wire_lp + 1) begin : gen_wire_lp
    assign data_ff[wire_lp+1] = data_ff_r[wire_lp+1]; 
  end
endgenerate

/* external port */
assign data_ff[0] = data_in              ;
assign data_out   = data_ff[SHIFT_CYCLE] ;

endmodule