.data
	#

.text
	lui t0, 0xbfaf8
	lui t1, 0xbfaf8
	lui t2, 0x00100 #0x00100000
	lui t3, 0
	#lui t0, 0x10010
	ori t0, t0, 0x8
	#lui t1, 0x10010
	ori t1, t1, 0x4
	#lui t2, 0x00001	
disp:
	lw t5, (t1)
	ori t6, zero, 1
	lui t4, 0
	nop
	add t5, t5, t3
	nop
	nop
	add t3, t3, t6
	sw t5, (t0)
delay:
	ori t6, zero, 1
	nop
	nop
	nop
	add t4, t4, t6
	nop
	nop
	nop
	beq t4, t2, disp
	jal delay