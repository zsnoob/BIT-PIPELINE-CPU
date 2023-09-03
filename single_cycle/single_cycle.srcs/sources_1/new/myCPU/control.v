`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/19 21:13:55
// Design Name: 
// Module Name: control
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

`include "macro.vh"

module control(
//    input           clk,
//    input           rst,

    input   [6:0]   opcode,
    input   [2:0]   funct3,
    input   [6:0]   funct7,
    
    output          c1,         
    output          c2,         
    output  [1:0]   c3,         
    output  [4:0]   alu_op,     
    output  [2:0]   branch,
    output          dmem_we,
    output          reg_we
);

    wire [3:0] inst_id = get_inst_id(opcode, funct3, funct7);
    function [3:0] get_inst_id(input [6:0] opcode, input [2:0] funct3, input [6:0] funct7);
    begin
        case (opcode)
            `OPCODE_R   : begin
                case (funct3)
                    `FUNCT3_ADDSUB  : begin
                        case (funct7)
                            `FUNCT7_ADD : get_inst_id = `ID_ADD;
                            `FUNCT7_SUB : get_inst_id = `ID_SUB;
                            default     : get_inst_id = `ID_NULL;
                        endcase
                     end
                    `FUNCT3_ORI : get_inst_id = `ID_OR;
                    `FUNCT3_XOR : get_inst_id = `ID_XOR;
                    `FUNCT3_AND : get_inst_id = `ID_AND;
                    default     : get_inst_id = `ID_NULL;
                endcase
            end
            `OPCODE_I   : begin
                case (funct3)
                    `FUNCT3_ORI : get_inst_id = `ID_ORI;
                    `FUNCT3_XOR : get_inst_id = `ID_XORI;
                    `FUNCT3_AND : get_inst_id = `ID_ANDI;
                    default     : get_inst_id = `ID_NULL;
                endcase
            end
            `OPCODE_L   : begin
                case (funct3)
                    `FUNCT3_LW  : get_inst_id = `ID_LW;
                    default     : get_inst_id = `ID_NULL;
                endcase
            end
            `OPCODE_S   : begin
                case (funct3)
                    `FUNCT3_SW  : get_inst_id = `ID_SW;
                    default     : get_inst_id = `ID_NULL;
                endcase
            end
            `OPCODE_B   : begin
                case (funct3)
                    `FUNCT3_BEQ : get_inst_id = `ID_BEQ;
                    `FUNCT3_BNE : get_inst_id = `ID_BNE;
                    `FUNCT3_BGE : get_inst_id = `ID_BGE;
                    `FUNCT3_BLT : get_inst_id = `ID_BLT;
                    default     : get_inst_id = `ID_NULL;
                endcase
            end
            `OPCODE_JAL : get_inst_id = `ID_JAL;
            `OPCODE_LUI : get_inst_id = `ID_LUI;
            default     : get_inst_id = `ID_NULL;
        endcase
    end
    endfunction

    assign c1 = (inst_id == `ID_SW ) ? 1 : 0;
    
    reg [16:0] mask_c2 = 17'b00011100000000110;
    assign c2 = mask_c2[inst_id];
    
    assign c3 = get_c3(inst_id);
    function [1:0] get_c3(input [3:0] inst_id);
    begin
        case (inst_id)
            `ID_LUI, `ID_SW, `ID_BEQ, `ID_BGE, `ID_BNE, `ID_BLT  : get_c3 = 2'b00;
            `ID_JAL                   : get_c3 = 2'b01;
            `ID_ADD, `ID_SUB, `ID_ORI, `ID_XORI, `ID_XOR, `ID_OR,
             `ID_AND, `ID_ANDI : get_c3 = 2'b10;
            `ID_LW                    : get_c3 = 2'b11;
            default                   : get_c3 = 2'b00;
        endcase
    end
    endfunction
    
    assign alu_op = get_alu_op(inst_id);
    function [4:0] get_alu_op(input [3:0] inst_id);
    begin
        case (inst_id)
            `ID_SW, `ID_LW, `ID_ADD : get_alu_op = `ALU_ADD;
            `ID_SUB                 : get_alu_op = `ALU_SUB;
            `ID_ORI, `ID_OR                 : get_alu_op = `ALU_OR;
            `ID_XOR, `ID_XORI             : get_alu_op = `ALU_XOR;
            `ID_AND, `ID_ANDI            : get_alu_op = `ALU_AND;
            default                 : get_alu_op = `ALU_NULL;
        endcase
    end
    endfunction
                   
    assign branch = get_branch(inst_id);
    function [2:0] get_branch(input [3:0] inst_id);
    begin
        case (inst_id)
            `ID_BEQ                 : get_branch = `BR_BEQ;
            `ID_JAL                 : get_branch = `BR_JAL;
            `ID_BNE                 : get_branch = `BR_BNE;
            `ID_BGE                 : get_branch = `BR_BGE;
            `ID_BLT                 : get_branch = `BR_BLT;
            default                 : get_branch = `BR_NULL;
        endcase
    end
    endfunction
                   
    assign dmem_we = (inst_id == `ID_SW ) ? 1 : 0;
    
    reg [16:0] mask_reg_we = 17'b00011111101011110;
    assign reg_we = mask_reg_we[inst_id];
    
endmodule
