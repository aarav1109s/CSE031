# fib.s — iterative Fibonacci (Lab 6 / Lab 8 TPS 1)
# Reads n from the user; prints str1, a newline, then F(n) in $t0.

.data
# n:	.word 13		# no longer used; n comes from user input
m:	.word 20
str1:	.asciiz "I love CSE31!"
prompt:	.asciiz "Please enter a number: "

.text
.globl main

main:	add	$t0, $0, $zero
	addi	$t1, $zero, 1

	# la	$t3, n		# commented: n is not loaded from .data
	# lw	$t3, 0($t3)

	la	$a0, prompt
	li	$v0, 4
	syscall

	li	$v0, 5			# read integer
	syscall
	move	$t3, $v0		# store n in $t3 as required

fib:	beq	$t3, $0, finish
	add	$t2, $t1, $t0
	move	$t0, $t1
	move	$t1, $t2
	addi	$t3, $t3, -1
	j	fib

finish:	la	$a0, str1
	li	$v0, 4			# print string
	syscall
	li	$a0, 10
	li	$v0, 11			# print character (newline)
	syscall
	addi	$a0, $t0, 0
	li	$v0, 1
	syscall
	li	$v0, 10
	syscall
