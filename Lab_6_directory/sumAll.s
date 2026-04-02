# sumAll.s - Lab 6 Individual Assignment
# Sums even and odd inputs until user enters 0.
# Forbidden: div, and, or, andi, ori
# Even test: x == (x>>1)<<1 using arithmetic shift (works for negatives).
#
# Pseudocode:
#   even_sum = 0; odd_sum = 0
#   loop:
#     read x
#     if x == 0: break
#     if x is even: even_sum += x
#     else:         odd_sum += x
#   print even_sum, odd_sum

.data
prompt:          .asciiz "Please enter a number: "
even_msg:        .asciiz "Sum of even numbers is: "
odd_msg:         .asciiz "Sum of odd numbers is: "
newline:         .asciiz "\n"

.text
main:
	add  $s0, $zero, $zero		# even_sum
	add  $s1, $zero, $zero		# odd_sum

loop:
	la   $a0, prompt
	li   $v0, 4
	syscall

	li   $v0, 5
	syscall

	beq  $v0, $zero, print_sums

	move $t0, $v0			# current number

	# even if $t0 == (sra 1 then sll 1)
	move $t1, $t0
	sra  $t2, $t1, 1
	sll  $t2, $t2, 1
	beq  $t1, $t2, add_even

	add  $s1, $s1, $t0		# odd
	j    loop

add_even:
	add  $s0, $s0, $t0
	j    loop

print_sums:
	la   $a0, even_msg
	li   $v0, 4
	syscall

	move $a0, $s0
	li   $v0, 1
	syscall

	la   $a0, newline
	li   $v0, 4
	syscall

	la   $a0, odd_msg
	li   $v0, 4
	syscall

	move $a0, $s1
	li   $v0, 1
	syscall

	la   $a0, newline
	li   $v0, 4
	syscall

	li   $v0, 10
	syscall
