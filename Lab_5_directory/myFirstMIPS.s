# myFirstMIPS.s
# Given a value in $s0 (set manually in MARS before running), compute:
#   $t0 = $s0
#   $t1 = $t0 - 7
#   $t2 = $t1 + $t0
#   $t3 = $t2 + 2
#   $t4 = $t3 + $t2
#   $t5 = $t4 - 28
#   $t6 = $t4 - $t5
#   $t7 = $t6 + 12
# Do NOT set $s0 in code. Set it in the Registers pane in MARS (double-click
# the value for $s0 and enter your desired number).

	.text
	.globl main
main:
	add	$t0, $s0, $zero		# $t0 = $s0
	addi	$t1, $t0, -7		# $t1 = $t0 - 7
	add	$t2, $t1, $t0		# $t2 = $t1 + $t0
	addi	$t3, $t2, 2		# $t3 = $t2 + 2
	add	$t4, $t3, $t2		# $t4 = $t3 + $t2
	addi	$t5, $t4, -28		# $t5 = $t4 - 28
	sub	$t6, $t4, $t5		# $t6 = $t4 - $t5
	addi	$t7, $t6, 12		# $t7 = $t6 + 12

	li	$v0, 10			# exit
	syscall
