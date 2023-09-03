`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/03 15:22:02
// Design Name: 
// Module Name: pipeline_reg_W
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


module pipeline_reg_W(
    input rst                   ,
    input clk                   ,
    
    
    input wire [31:0] pc_W      ,
    input wire [31:0] alu_out   ,
    input wire [4:0]  reg_wa    ,
    input wire [31:0] imm20_e32 ,
    input wire [1:0]  c3        ,
    input wire        reg_we    ,
    input wire [31:0] dmem_rd   ,
    
    output wire [31:0] _pc_W      ,
    output wire [31:0] _alu_out   ,
    output wire [4:0]  _reg_wa    ,
    output wire [31:0] _imm20_e32 ,
    output wire [1:0]  _c3        ,
    output wire        _reg_we    ,
    output wire [31:0] _dmem_rd   

    );
    reg [31:0] pc_W_reg     ;
    reg [31:0] alu_out_reg  ;
    reg [4:0]  reg_wa_reg   ;
    reg [31:0] imm20_e32_reg;
    reg [1:0]  c3_reg       ;
    reg        reg_we_reg   ;
    reg [31:0] dmem_rd_reg  ;
    
    always @(posedge clk or negedge rst) begin
        if(!rst) pc_W_reg <= 32'h00000000;
        else begin
            pc_W_reg      <= pc_W     ;
            alu_out_reg   <= alu_out  ;
            reg_wa_reg    <= reg_wa   ;
            imm20_e32_reg <= imm20_e32;
            c3_reg        <= c3       ;
            reg_we_reg    <= reg_we   ;
            dmem_rd_reg   <= dmem_rd  ;
        end
    end
    assign _pc_W      = pc_W_reg     ;
    assign _alu_out   = alu_out_reg  ;
    assign _reg_wa    = reg_wa_reg   ;
    assign _imm20_e32 = imm20_e32_reg;
    assign _c3        = c3_reg       ;
    assign _reg_we    = reg_we_reg   ;
    assign _dmem_rd   = dmem_rd_reg  ;
    
endmodule
