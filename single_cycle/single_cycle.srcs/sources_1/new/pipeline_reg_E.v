`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/03 14:56:42
// Design Name: 
// Module Name: pipeline_reg_E
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


module pipeline_reg_E(
    input rst,
    input clk,
    
    input wire [31:0] pc_E          ,
    input wire [31:0] alu_in1       ,
    input wire [31:0] alu_in2       ,
    input               flag         ,
    input wire [4:0]  reg_wa        ,
    input wire [4:0]  alu_op        ,
    input wire [31:0] imm20_e32     ,
    input wire [1:0]  c3            ,
    input wire        dmem_we       ,
    input wire        reg_we        ,
    input wire [31:0] reg_rd2       ,
    
    output wire [31:0] _pc_E          ,
    output wire [31:0] _alu_in1       ,
    output wire [31:0] _alu_in2       ,
    output              _flag         ,   
    output wire [4:0]  _reg_wa        ,
    output wire [4:0]  _alu_op        ,
    output wire [31:0] _imm20_e32     ,
    output wire [1:0]  _c3            ,
    output wire        _dmem_we       ,
    output wire        _reg_we        ,   
    output wire [31:0] _reg_rd2       
    
    );     
    reg [31:0] pc_E_reg     ;
    reg [31:0] alu_in1_reg  ;
    reg [31:0] alu_in2_reg  ;
    reg          flag_reg   ;
    reg [4:0]  reg_wa_reg   ;
    reg [4:0]  alu_op_reg   ;
    reg [31:0] imm20_e32_reg;
    reg [1:0]  c3_reg       ;
    reg        dmem_we_reg  ;
    reg        reg_we_reg   ;
    reg [31:0] reg_rd2_reg  ;
    
    always @(posedge clk or negedge rst) begin
        if(!rst) begin
            pc_E_reg <= 32'h00000000;
            flag_reg  <= 32'b1;
        end
        else begin
            pc_E_reg      <= pc_E     ;
            alu_in1_reg   <= alu_in1  ;
            alu_in2_reg   <= alu_in2  ;
              flag_reg    <=   flag   ;
            reg_wa_reg    <= reg_wa   ;
            alu_op_reg    <= alu_op   ;
            imm20_e32_reg <= imm20_e32;
            c3_reg        <= c3       ;
            dmem_we_reg   <= dmem_we  ;
            reg_we_reg    <= reg_we   ;
            reg_rd2_reg   <= reg_rd2  ;
        end
    end
    assign _pc_E     = pc_E_reg     ;
    assign _alu_in1  = alu_in1_reg  ;
    assign _alu_in2  = alu_in2_reg  ;
    assign  _flag    =   flag_reg   ;
    assign _reg_wa   = reg_wa_reg   ;
    assign _alu_op   = alu_op_reg   ;
    assign _imm20_e32= imm20_e32_reg;
    assign _c3       = c3_reg       ;
    assign _dmem_we  = dmem_we_reg  ;
    assign _reg_we   = reg_we_reg   ;
    assign _reg_rd2  = reg_rd2_reg  ;

endmodule

