.data
x:	.word 5
y:	.word 10
m:	.word 15
b:	.word 2

.text
MAIN:	la $t0, x
	lw $s0, 0($t0)		# s0 = x
	la $t0, y
	lw $s1, 0($t0)		# s1 = y
	
	# Prepare to call sum(x)
	addu $a0, $zero, $s0	# Set a0 as input argument for SUM
	jal SUM
	addu $t0, $s1, $s0
	addu $s1, $t0, $v0
	addiu $a0, $s1, 0 
	li $v0, 1		 
	syscall	
	j END
		
SUM:	# Prologue: save $ra (MAIN's link), caller's $s0 (x), and original n ($a0)
	addiu $sp, $sp, -12
	sw $ra, 8($sp)
	sw $s0, 4($sp)
	sw $a0, 0($sp)		# saved n

	la $t0, m
	lw $s0, 0($t0)		# s0 = m
	lw $a0, 0($sp)		# reload n for (m + n)
	addu $a0, $s0, $a0	# $a0 = m + n for SUB
	jal SUB
	lw $t0, 0($sp)		# original n
	addu $v0, $t0, $v0	# n + sub(m + n)

	# Epilogue
	lw $s0, 4($sp)
	lw $ra, 8($sp)
	addiu $sp, $sp, 12
	jr $ra
		
SUB:	la $t0, b
	addiu $sp, $sp, -4
	sw $s0, 0($sp)		# Backup s0 from SUM
	lw $s0, 0($t0)		# s0 = b
	subu $v0, $a0, $s0
	lw $s0, 0($sp)		# Restore s0 from SUM
	addiu $sp, $sp, 4
	jr $ra

END:
