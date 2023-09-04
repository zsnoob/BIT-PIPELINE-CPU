.data
	#.word 0x12345

.text
	ori t0, zero, 0x300
	ori t1, zero, 0x45
	nop
	nop
	nop
	add t2, t0, t1
	sub t3, t0, t1
	lui t4, 0x12
	nop
	nop
	nop
	add t4, t4, t2
	jal label1
	ori t6, zero, 0x1
label1:
	lui a0, 0x40
	nop
	nop
	ori a1, zero, 0x4
	sw t4, (a0)
	nop
	nop
	add a1, a0, a1
	nop
	nop
	#lw t5, (a0)
	sw t4, (a1) 
label3:
	beq t4, t5, label2 #差分支预测错误检�?
	ori t6, zero, 0x2
label2:
	jal label3
