`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/20 20:35:35
// Design Name: 
// Module Name: pc
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


module pc(
    input  wire         clk,
    input  wire         rst,
    
    input  wire [31:0]  pc_pred,
    output wire [31:0]  pc_sel_in
);
    
    reg [31:0] pc_reg;

    always @(posedge clk or negedge rst) begin
        if (!rst) pc_reg <= 32'h00000000;
        else pc_reg <= pc_pred;
    end
    
    assign pc_sel_in = pc_reg;
    
endmodule
