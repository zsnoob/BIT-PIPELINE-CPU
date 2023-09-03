`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/02 19:58:33
// Design Name: 
// Module Name: pred_pc
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


module pred_pc(
    input  wire [11:0]  imm12_b,
    input  wire [19:0]  imm20_j,
    input  wire [6:0]  opcode,
    input  wire [31:0]  select_pc_out,
    
    output wire [31:0] pc_pred
);


    wire [31:0] offset_b = {{19{imm12_b[11]}}, imm12_b, 1'b0};
    wire [31:0] offset_j = {{11{imm20_j[19]}}, imm20_j, 1'b0};
    assign pc_pred = ((opcode == `OPCODE_JAL) ? offset_j:
                    (opcode == `OPCODE_B) ? offset_b : 
                    32'h4) + select_pc_out;
                    
                    
endmodule
