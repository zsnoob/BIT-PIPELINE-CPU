
// opcode
`define OPCODE_R    7'b0110011
`define OPCODE_I    7'b0010011
`define OPCODE_L    7'b0000011
`define OPCODE_S    7'b0100011
`define OPCODE_B    7'b1100011
`define OPCODE_JAL  7'b1101111
`define OPCODE_LUI  7'b0110111

// funct3
`define FUNCT3_ADDSUB   3'b000
`define FUNCT3_ORI      3'b110
`define FUNCT3_LW       3'b010
`define FUNCT3_SW       3'b010
`define FUNCT3_BEQ      3'b000
`define FUNCT3_AND      3'b111
`define FUNCT3_XOR      3'b100
`define FUNCT3_BNE      3'b001
`define FUNCT3_BGE      3'b101
`define FUNCT3_BLT      3'b100

// funct7
`define FUNCT7_ADD  7'b0000000
`define FUNCT7_SUB  7'b0100000

// inst_id
`define ID_NULL     0
`define ID_ADD      1
`define ID_SUB      2
`define ID_ORI      3
`define ID_LUI      4
`define ID_SW       5
`define ID_LW       6
`define ID_BEQ      7
`define ID_JAL      8
// I¿‡
`define ID_XORI     9
`define ID_ANDI     10
// R¿‡
`define ID_XOR     11
`define ID_OR       12
`define ID_AND      13
// B¿‡
`define ID_BNE      14
`define ID_BGE      15
`define ID_BLT      16

// alu_op
`define ALU_NULL    5'b00000
`define ALU_ADD     5'b00001
`define ALU_SUB     5'b00010
`define ALU_OR      5'b00100
`define ALU_AND     5'b01000
`define ALU_XOR     5'b10000

// branch
`define BR_NULL     3'b000
`define BR_BEQ      3'b001
`define BR_JAL      3'b010
`define BR_BNE     3'b011
`define BR_BGE      3'b100
`define BR_BLT      3'b101
