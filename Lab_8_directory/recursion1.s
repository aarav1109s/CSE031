# recursion1.s — MIPS translation of recursion1.c (Lab 8 individual)
# Classic recursive Fibonacci with MIPS calling conventions.

.data
prompt:	.asciiz "Please enter a number: "
nl:	.asciiz "\n"

.text
.globl main

main:	la	$a0, prompt
	li	$v0, 4
	syscall

	li	$v0, 5
	syscall
	move	$a0, $v0		# fib(n)

	jal	fib

	move	$t0, $v0
	move	$a0, $t0
	li	$v0, 1
	syscall

	la	$a0, nl
	li	$v0, 4
	syscall

	li	$v0, 10
	syscall

# int fib(int n); $a0 = n, returns $v0
fib:	addiu	$sp, $sp, -12
	sw	$ra, 8($sp)
	sw	$s0, 4($sp)

	beq	$a0, $zero, fib_ret0
	li	$t0, 1
	beq	$a0, $t0, fib_ret1

	move	$s0, $a0		# callee-saved copy of n

	addi	$a0, $s0, -1
	jal	fib
	sw	$v0, 0($sp)		# save fib(n-1)

	addi	$a0, $s0, -2
	jal	fib
	lw	$t1, 0($sp)
	add	$v0, $t1, $v0
	j	fib_done

fib_ret0:
	li	$v0, 0
	j	fib_done

fib_ret1:
	li	$v0, 1

fib_done:
	lw	$s0, 4($sp)
	lw	$ra, 8($sp)
	addiu	$sp, $sp, 12
	jr	$ra
