`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/03 14:46:57
// Design Name: 
// Module Name: pipeline_reg_D
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


module pipeline_reg_D(
    input rst,
    input clk,
    input nop,
    
    input wire [31:0] pc_D         ,
    input wire [6:0]  opcode      ,
    input wire [2:0]  funct3        ,
    input wire [6:0]  funct7         ,
    input wire [4:0]  reg_ra1       ,
    input wire [4:0]  reg_ra2       ,
    input wire [4:0]  reg_wa     ,
    input wire [11:0] imm12_s   ,
    input wire [11:0] imm12_i   ,
    input wire [31:0] imm20_e32 ,//写回阶段需要的变量
    
    output  wire [31:0] _pc_D      ,
    output  wire [6:0]  _opcode    ,
    output  wire [2:0]  _funct3    ,
    output  wire [6:0]  _funct7    ,
    output  wire [4:0]  _reg_ra1   ,
    output  wire [4:0]  _reg_ra2   ,
    output  wire [4:0]  _reg_wa    ,
    output  wire [11:0] _imm12_s   ,
    output  wire [11:0] _imm12_i   ,
    output  wire [31:0] _imm20_e32 
    );
    reg    [31:0]   pc_D_reg     ;
    reg    [6:0]    opcode_reg   ;
    reg    [31:0]   pc_D_nop     ;
    reg    [6:0]    opcode_nop   ;
    reg    [2:0]    funct3_reg   ;
    reg    [6:0]    funct7_reg   ;
    reg    [4:0]    reg_ra1_reg  ;
    reg    [4:0]    reg_ra2_reg  ;
    reg    [4:0]    reg_wa_reg   ;
    reg    [11:0]   imm12_s_reg  ;
    reg    [11:0]   imm12_i_reg  ;
    reg    [31:0]   imm20_e32_reg;
    
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
        pc_D_reg <= 32'h00000000;
        pc_D_nop <=  32'h00000000;
        opcode_nop <= 7'b0000000;
        end
        else begin
            pc_D_reg      <= pc_D     ;
            opcode_reg    <= opcode   ;
            funct3_reg    <= funct3   ;
            funct7_reg    <= funct7   ;
            reg_ra1_reg   <= reg_ra1  ;
            reg_ra2_reg   <= reg_ra2  ;
            reg_wa_reg    <= reg_wa   ;
            imm12_s_reg   <= imm12_s  ;
            imm12_i_reg   <= imm12_i  ;
            imm20_e32_reg <= imm20_e32;
        end
        //pc_reg <= pc_in;
        end
        
    
    
    assign _pc_D      = nop ? pc_D_reg : pc_D_nop  ;
    assign _opcode    = nop ? opcode_reg : opcode_nop  ;
    assign _funct3    = funct3_reg   ;
    assign _funct7    = funct7_reg   ;
    assign _reg_ra1   = reg_ra1_reg  ;
    assign _reg_ra2   = reg_ra2_reg  ;
    assign _reg_wa    = reg_wa_reg   ;
    assign _imm12_s   = imm12_s_reg  ;
    assign _imm12_i   = imm12_i_reg  ;
    assign _imm20_e32 = imm20_e32_reg;

endmodule
