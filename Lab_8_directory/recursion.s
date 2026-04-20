# recursion.s — MIPS translation of recursion.c (Lab 8 TPS 2)
# int recursion(int n) {
#   if (n == 0) return 0;
#   if (n == -1) return -1;
#   return recursion(n - 1) + recursion(n - 2);
# }

.data
prompt:	.asciiz "Please enter a number: "
nl:	.asciiz "\n"

.text
.globl main

main:	la	$a0, prompt
	li	$v0, 4
	syscall

	li	$v0, 5			# read integer → $v0
	syscall
	move	$a0, $v0		# argument register for recursion(n)

	jal	recursion

	move	$t0, $v0		# save return value; syscall 1 uses $a0
	move	$a0, $t0
	li	$v0, 1
	syscall

	la	$a0, nl
	li	$v0, 4
	syscall

	li	$v0, 10
	syscall

# int recursion(int n); argument n in $a0, return in $v0
recursion:
	addiu	$sp, $sp, -12		# reserve 3 words: partial, saved n, $ra
	sw	$ra, 8($sp)		# first thing stored: return address

	beq	$a0, $zero, ret_zero	# if (n == 0) return 0;

not_minus_one:
	addi	$t0, $zero, -1
	beq	$a0, $t0, ret_minus_one	# if (n == -1) return -1;

not_zero:
	sw	$a0, 4($sp)		# save n before it is overwritten by calls

	addi	$a0, $a0, -1		# argument for recursion(n - 1)
	jal	recursion

	sw	$v0, 0($sp)		# save first return; $a0/$v0 will change

	lw	$a0, 4($sp)		# restore original n
	addi	$a0, $a0, -2		# argument for recursion(n - 2)
	jal	recursion

	lw	$t1, 0($sp)		# first subtree result
	add	$v0, $t1, $v0		# return sum of both calls
	j	end_recur

ret_zero:
	li	$v0, 0			# return 0
	j	end_recur

ret_minus_one:
	li	$v0, -1			# return -1
	j	end_recur

end_recur:
	lw	$ra, 8($sp)		# restore saved return address
	addiu	$sp, $sp, 12
	jr	$ra
