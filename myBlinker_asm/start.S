.section ".init", "ax", %progbits
.balign	8
.globl _start
_start:	
	mrs x0, mpidr_el1
	ands x0, x0, #0x3
	cmp x0, #0
	bne hang
	mov x0, #0x3f200000
	mov x1, #0x1
	mov x2, #0x7
	lsl x1, x1, 27
	lsl x2, x2, 27
	ldr w3, [x0, #8]     // Read function mode
	bic x3, x3, x2
	orr x3, x3, x1
	str w3, [x0, #8]    // Write function mode back
	mov x1, #0x1
	lsl x1, x1, #29
flash:
	str w1, [x0, #40]	// Hit the clear register     
	mov x2, #0x800000
1:
	sub x2, x2, #1
	cmp x2, #0
	bne 1b
	str w1, [x0, #28]	// Hit the set register  
	mov x2, #0x800000
2:
	sub x2, x2, #1
	cmp x2, #0
	bne 2b
	b flash


/*================================================================"
      Just safety dead loop
"================================================================*/
hang:
	b hang

.ltorg


