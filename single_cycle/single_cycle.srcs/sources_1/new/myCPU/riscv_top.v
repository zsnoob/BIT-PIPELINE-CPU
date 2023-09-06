`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/12 01:41:49
// Design Name: 
// Module Name: riscv_top
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


module mycpu(
    input         rstn,
    input         clk,

    output [31:0] inst_rom_addr,
    input  [31:0] inst_rom_rdata,

    output [31:0] data_ram_addr,
    output [31:0] data_ram_wdata,
    output        data_ram_wen,
    input  [31:0] data_ram_rdata
);
    
    wire flag_D;
    wire [31:0] pc_out;
    wire [31:0] pc_pred;
    wire [31:0] select_pc_out;

    wire [31:0] instr;
            
    wire [6:0]  opcode;
    wire [2:0]  funct3;
    wire [6:0]  funct7;
    wire        c1;
    wire        c2;
    wire [1:0]  c3;
    wire [4:0]  alu_op;
    wire [2:0]  branch;
    wire        dmem_we;
    wire        reg_we;
    
    wire [4:0]  reg_ra1;
    wire [4:0]  reg_ra2;
    wire [31:0] reg_rd1;
    wire [31:0] reg_rd2;
    wire [4:0]  reg_wa;
    wire [19:0] imm20_u;
    wire [31:0] imm20_e32;
    wire [31:0] pc_plus4;
    wire [31:0] reg_wd;
    
    wire [11:0] imm12_s;
    wire [11:0] imm12_i;
    wire [31:0] imm12_e32;
    wire [31:0] alu_in1;
    wire [31:0] alu_in2;
    wire [31:0] alu_out;

    wire [31:0] dmem_rd;
    
    wire [11:0] imm12_b;
    wire [19:0] imm20_j;
    wire [31:0] offset;
        
    wire [31:0] pc_D;
    wire [6:0] opcode_D;
    wire [2:0] funct3_D;
    wire [6:0] funct7_D;
    wire [4:0] reg_ra1_D;
    wire [4:0] reg_ra2_D;
    wire [4:0] reg_wa_D;
    wire [11:0] imm12_s_D;
    wire [11:0] imm12_i_D;
    wire [31:0] imm20_e32_D;
    
    wire [31:0] pc_E;
    wire [31:0] alu_in1_E;
    wire [31:0] alu_in2_E;
    wire flag_E;
    wire [4:0] reg_wa_E;
    wire [4:0] alu_op_E; 
    wire [31:0] imm20_e32_E;
    wire [1:0] c3_E;
    wire dmem_we_E;
    wire reg_we_E;
    wire [31:0] reg_rd2_E;
    
    wire [31:0] pc_M;     
    wire [31:0] alu_out_M;     
    wire [4:0]  reg_wa_M;     
    wire [31:0] imm20_e32_M;     
    wire [1:0]  c3_M;     
    wire        dmem_we_M;     
    wire        reg_we_M;     
    wire [31:0] reg_rd2_M; 
    
    wire [31:0] pc_W;     
    wire [31:0] alu_out_W;     
    wire [4:0]  reg_wa_W;     
    wire [31:0] imm20_e32_W;     
    wire [1:0]  c3_W;     
    wire        reg_we_W;     
    wire [31:0] dmem_rd_W;      
    //assign pc_in = pc_out + (jump ? offset : 32'h4);
    
    assign select_pc_out = flag_E ? pc_out : pc_E +32'h4;
    
    assign inst_rom_addr = select_pc_out;
    assign instr = inst_rom_rdata;

    assign funct7 = instr[31:25];
    assign funct3 = instr[14:12];
    assign opcode = instr[6:0];

    assign reg_ra1 = instr[19:15];
    assign reg_ra2 = instr[24:20];
    assign reg_wa = instr[11:7];
    
    assign imm20_u = instr[31:12];
    assign imm20_e32 = {imm20_u, 12'b0};
    assign pc_plus4 = pc_W + 32'h4;
    assign reg_wd = sel_2to4(c3_W, imm20_e32_W, pc_plus4, alu_out_W, dmem_rd_W);
    function [31:0] sel_2to4(input [1:0] sel,
                             input [31:0] in0, input [31:0] in1,
                             input [31:0] in2, input [31:0] in3);
    begin
        case (sel)
            2'b00 : sel_2to4 = in0;
            2'b01 : sel_2to4 = in1;
            2'b10 : sel_2to4 = in2;
            2'b11 : sel_2to4 = in3;
        endcase
    end
    endfunction
    
    assign alu_in1 = reg_rd1;
    assign imm12_s = {instr[31:25], instr[11:7]};
    assign imm12_i = instr[31:20];
    assign imm12_e32 = c1 ? {{20{imm12_s_D[11]}}, imm12_s_D} : {{20{imm12_i_D[11]}}, imm12_i_D};
    assign alu_in2 = c2 ? reg_rd2 : imm12_e32;
    
    assign data_ram_addr = alu_out_M;
    assign data_ram_wen = dmem_we_M;
    assign data_ram_wdata = reg_rd2_M;
    assign dmem_rd = data_ram_rdata;

    assign imm12_b = {instr[31], instr[7], instr[30:25], instr[11:8]};
    assign imm20_j = {instr[31], instr[19:12], instr[20], instr[30:21]};

    pc _pc(
        .clk(clk),
        .rst(rstn),
        .pc_pred(pc_pred),
        .pc_sel_in(pc_out)
    );

    
    pipeline_reg_D _pipeline_reg_D(
        .rst(rstn),
        .clk(clk),
        .nop(flag_E),
        .pc_D(select_pc_out),       
        .opcode(opcode),     
        .funct3(funct3),     
        .funct7(funct7),     
        .reg_ra1(reg_ra1),    
        .reg_ra2(reg_ra2),   
        .reg_wa(reg_wa),
        .imm12_s(imm12_s),
        .imm12_i(imm12_i),
        .imm20_e32(imm20_e32),
        ._pc_D(pc_D),
        ._opcode(opcode_D),
        ._funct3(funct3_D),
        ._funct7(funct7_D),
        ._reg_ra1(reg_ra1_D),
        ._reg_ra2(reg_ra2_D),
        ._reg_wa(reg_wa_D),
        ._imm12_s(imm12_s_D),
        ._imm12_i(imm12_i_D),
        ._imm20_e32(imm20_e32_D)
    );

    control _cu(
        .opcode(opcode_D),
        .funct3(funct3_D),
        .funct7(funct7_D),
        .c1(c1),
        .c2(c2),
        .c3(c3),
        .alu_op(alu_op),
        .branch(branch),
        .dmem_we(dmem_we),
        .reg_we(reg_we)
    );
    
    regfile _regfile(
        .clk(clk),
        .rst(rstn),
        .reg_we(reg_we_W),
        .reg_ra1(reg_ra1_D),
        .reg_ra2(reg_ra2_D),
        .reg_wa(reg_wa_W),
        .reg_wd(reg_wd),
        .reg_rd1(reg_rd1),
        .reg_rd2(reg_rd2)
    );
    
         
    pipeline_reg_E _pipeline_reg_E(
        .rst(rstn),
        .clk(clk),
        .pc_E(pc_D),
        .alu_in1(alu_in1),
        .alu_in2(alu_in2),
        .flag(flag_D),
        .reg_wa(reg_wa_D),
        .alu_op(alu_op),
        .imm20_e32(imm20_e32_D),
        .c3(c3),
        .dmem_we(dmem_we),
        .reg_we(reg_we),
        .reg_rd2(reg_rd2),    
        ._pc_E(pc_E),
        ._alu_in1(alu_in1_E),
        ._alu_in2(alu_in2_E),
        ._flag(flag_E),   
        ._reg_wa(reg_wa_E),
        ._alu_op(alu_op_E),
        ._imm20_e32(imm20_e32_E),
        ._c3(c3_E),
        ._dmem_we(dmem_we_E),
        ._reg_we(reg_we_E),   
        ._reg_rd2(reg_rd2_E)                 
    );

    alu _alu(
        .alu_op(alu_op_E),
        .alu_in1(alu_in1_E),
        .alu_in2(alu_in2_E),
        .alu_out(alu_out)
    );    
    
    pipeline_reg_M _pipeline_reg_M(
        .rst(rstn),
        .clk(clk),
        .pc_M(pc_E),
        .alu_out(alu_out),
        .reg_wa(reg_wa_E),
        .imm20_e32(imm20_e32_E),
        .c3(c3_E),
        .dmem_we(dmem_we_E),
        .reg_we(reg_we_E),
        .reg_rd2(reg_rd2_E),       
        ._pc_M(pc_M),
        ._alu_out(alu_out_M),
        ._reg_wa(reg_wa_M),
        ._imm20_e32(imm20_e32_M),
        ._c3(c3_M),
        ._dmem_we(dmem_we_M),
        ._reg_we(reg_we_M),
        ._reg_rd2(reg_rd2_M)           
    );
       
    
    pipeline_reg_W _pipeline_reg_W(
        .rst(rstn),
        .clk(clk),
        .pc_W(pc_M),
        .alu_out(alu_out_M),
        .reg_wa(reg_wa_M),
        .imm20_e32(imm20_e32_M),
        .c3(c3_M),
        .reg_we(reg_we_M),
        .dmem_rd(dmem_rd),       
        ._pc_W(pc_W),
        ._alu_out(alu_out_W),
        ._reg_wa(reg_wa_W),
        ._imm20_e32(imm20_e32_W),
        ._c3(c3_W),
        ._reg_we(reg_we_W),
        ._dmem_rd(dmem_rd_W)           
    );
    
//    br _br(
//        .branch(branch),
//        .imm12_b(imm12_b),
//        .imm20_j(imm20_j),
//        .reg_rd1(reg_rd1),
//        .reg_rd2(reg_rd2),
//        .jump(jump),
//        .offset(offset)
//    );
    
    pred_pc _pred_pc(
        .imm12_b(imm12_b),
        .imm20_j(imm20_j),        
        .opcode(opcode),
        .select_pc_out(select_pc_out),
        .pc_pred(pc_pred)    
    );
    
    flag_gen _flag_gen(
        .branch(branch),
        .reg_rd1(reg_rd1),
        .reg_rd2(reg_rd2),        
        .flag(flag_D)
    );

endmodule
