`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/03 15:13:47
// Design Name: 
// Module Name: pipeline_reg_M
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


module pipeline_reg_M(
    input rst                   ,
    input clk                   ,
    
    
    input wire [31:0] pc_M      ,
    input wire [31:0] alu_out   ,
    input wire [4:0]  reg_wa    ,
    input wire [31:0] imm20_e32 ,
    input wire [1:0]  c3        ,
    input wire        dmem_we   ,
    input wire        reg_we    ,
    input wire [31:0] reg_rd2   ,
    
    output wire [31:0] _pc_M      ,
    output wire [31:0] _alu_out   ,
    output wire [4:0]  _reg_wa    ,
    output wire [31:0] _imm20_e32 ,
    output wire [1:0]  _c3        ,
    output wire        _dmem_we   ,
    output wire        _reg_we    ,
    output wire [31:0] _reg_rd2   

    );
    reg [31:0] pc_M_reg     ;
    reg [31:0] alu_out_reg  ;
    reg [4:0]  reg_wa_reg   ;
    reg [31:0] imm20_e32_reg;
    reg [1:0]  c3_reg       ;
    reg        dmem_we_reg  ;
    reg        reg_we_reg   ;
    reg [31:0] reg_rd2_reg  ;
    
    always @(posedge clk or negedge rst) begin
        if(!rst) pc_M_reg <= 32'h00000000;
        else begin
            pc_M_reg      <= pc_M     ;
            alu_out_reg   <= alu_out  ;
            reg_wa_reg    <= reg_wa   ;
            imm20_e32_reg <= imm20_e32;
            c3_reg        <= c3       ;
            dmem_we_reg   <= dmem_we  ;
            reg_we_reg    <= reg_we   ;
            reg_rd2_reg   <= reg_rd2  ;
        end
    end
    assign _pc_M      = pc_M_reg     ;
    assign _alu_out   = alu_out_reg  ;
    assign _reg_wa    = reg_wa_reg   ;
    assign _imm20_e32 = imm20_e32_reg;
    assign _c3        = c3_reg       ;
    assign _dmem_we   = dmem_we_reg  ;
    assign _reg_we    = reg_we_reg   ;
    assign _reg_rd2   = reg_rd2_reg  ;
    assign _reg_rd2   = reg_rd2_reg  ;
    
endmodule
