`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/02 19:59:24
// Design Name: 
// Module Name: flag_gen
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module flag_gen(
    input wire [2:0] branch,
    input wire [31:0] reg_rd1,
    input wire [31:0] reg_rd2,
    
    output wire flag
);

    wire branch_eq = (reg_rd1 == reg_rd2) ? 1'b1 : 1'b0;
    wire branch_ge = (reg_rd1 >= reg_rd2) ? 1'b1 : 1'b0;
    wire branch_ne = (reg_rd1 != reg_rd2) ? 1'b1 : 1'b0;
    wire branch_lt = (reg_rd1 < reg_rd2) ? 1'b1 : 1'b0;
    assign flag = (branch == `BR_BEQ) ? branch_eq :  
                  (branch == `BR_BGE) ? branch_ge : 
                  (branch == `BR_BNE) ? branch_ne : 
                  (branch == `BR_BLT) ? branch_lt : 
                  1'b1;
                  
endmodule
