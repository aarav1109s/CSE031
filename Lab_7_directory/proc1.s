.data
m: 	.word 10
n: 	.word 5

.text
MAIN:	la $t0, m		# Load address of m
	lw $a0, 0($t0)		# a0 = m
	la $t0, n			# Load address of n
	lw $a1, 0($t0)		# a1 = n

	# jal places the address of the next instruction in $ra (no manual $ra).
	# addi $ra, $zero, 0  # replaced by jal per lab / calling convention
	jal SUM
	
	addi $a0, $v0, 0	# Print out result
	li $v0, 1		 
	syscall	
	
	j END

SUM:	add $v0, $a0, $a1
	jr $ra
		
END:
