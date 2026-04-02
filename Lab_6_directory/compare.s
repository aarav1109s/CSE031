# compare.s - Lab 6 TPS 2
# n = 25; read integer; final: if input > n print str3, else print str2 (steps 7-8).
# Steps 5-6 kept below as comments for reference.

.data
n:      .word 25
str1:   .asciiz "Less than\n"
str2:   .asciiz "Less than or equal to\n"
str3:   .asciiz "Greater than\n"
str4:   .asciiz "Greater than or equal to\n"
prompt: .asciiz "Enter an integer: "

.text
main:
	la   $a0, prompt
	li   $v0, 4
	syscall

	li   $v0, 5			# read integer
	syscall
	move $t0, $v0			# user input in $t0

	la   $t1, n
	lw   $t1, 0($t1)		# n in $t1

	# ----- TPS steps 5-6 (comment out when doing 7-8 per handout) -----
	# slt  $t2, $t0, $t1		# $t2=1 if input < n
	# bne  $t2, $zero, print_lt
	# la   $a0, str4		# input >= n  -> "Greater than or equal to"
	# li   $v0, 4
	# syscall
	# j    done
	# print_lt:
	# la   $a0, str1
	# li   $v0, 4
	# syscall
	# j    done
	# ----- end steps 5-6 -----

	# Steps 7-8: input > n -> str3; else (input <= n) -> str2
	slt  $t2, $t1, $t0		# $t2=1 if n < input  i.e. input > n
	bne  $t2, $zero, print_gt
	la   $a0, str2
	li   $v0, 4
	syscall
	j    done

print_gt:
	la   $a0, str3
	li   $v0, 4
	syscall

done:
	li   $v0, 10
	syscall
