.data 

orig: .space 100	# In terms of bytes (25 elements * 4 bytes each)
sorted: .space 100

str0: .asciiz "Enter the number of assignments (between 1 and 25): "
str1: .asciiz "Enter score: "
str2: .asciiz "Original scores: "
str3: .asciiz "Sorted scores (in descending order): "
str4: .asciiz "Enter the number of (lowest) scores to drop: "
str5: .asciiz "Average (rounded down) with dropped scores removed: "
str_all_dropped: .asciiz "All scores dropped!\n"
space: .asciiz " "
newline: .asciiz "\n"

.text 

# This is the main program.
# It first asks user to enter the number of assignments.
# It then asks user to input the scores, one at a time.
# It then calls selSort to perform selection sort.
# It then calls printArray twice to print out contents of the original and sorted scores.
# It then asks user to enter the number of (lowest) scores to drop.
# It then calls calcSum on the sorted array with the adjusted length (to account for dropped scores).
# It then prints out average score with the specified number of (lowest) scores dropped from the calculation.
main: 
	addi $sp, $sp, -4
	sw $ra, 0($sp)
read_num_assignments:
	la $a0, str0 
	li $v0, 4 
	syscall 
	li $v0, 5	# Read the number of scores from user
	syscall
	
	# Your code here to handle invalid number of scores (can't be less than 1 or greater than 25)
	blt $v0, 1, read_num_assignments
	bgt $v0, 25, read_num_assignments
	
	move $s0, $v0	# $s0 = numScores
	move $t0, $0
	la $s1, orig	# $s1 = orig
	la $s2, sorted	# $s2 = sorted
loop_in:
	li $v0, 4 
	la $a0, str1 
	syscall 
	sll $t1, $t0, 2
	add $t1, $t1, $s1
	li $v0, 5	# Read elements from user
	syscall
	sw $v0, 0($t1)
	addi $t0, $t0, 1
	bne $t0, $s0, loop_in
	
	move $a0, $s0
	jal selSort	# Call selSort to perform selection sort in original array
	
	li $v0, 4 
	la $a0, str2 
	syscall
	move $a0, $s1	# More efficient than la $a0, orig
	move $a1, $s0
	jal printArray	# Print original scores
	li $v0, 4 
	la $a0, str3 
	syscall 
	move $a0, $s2	# More efficient than la $a0, sorted
	jal printArray	# Print sorted scores
	
read_drop_prompt:
	li $v0, 4 
	la $a0, str4 
	syscall 
	li $v0, 5	# Read the number of (lowest) scores to drop
	syscall
	
	# Your code here to handle invalid number of (lowest) scores to drop (can't be less than 0, or 
	# greater than the number of scores). Also, handle the case when number of (lowest) scores to drop 
	# equals the number of scores. 
	blt $v0, $0, read_drop_prompt
	bgt $v0, $s0, read_drop_prompt
	
	beq $v0, $s0, all_scores_dropped
	
	move $t4, $v0			# $t4 = drop
	sub $t5, $s0, $t4		# $t5 = numScores - drop (count for average)
	move $a1, $t5
	move $a0, $s2
	jal calcSum	# Call calcSum to RECURSIVELY compute the sum of scores that are not dropped
	
	# Your code here to compute average and print it (you may also end up having some code here to help 
	# handle the case when number of (lowest) scores to drop equals the number of scores
	div $v0, $t5
	mflo $t6
	li $v0, 4
	la $a0, str5
	syscall
	move $a0, $t6
	li $v0, 1
	syscall
	j end
	
all_scores_dropped:
	li $v0, 4
	la $a0, str_all_dropped
	syscall
	
end:	lw $ra, 0($sp)
	addi $sp, $sp, 4
	li $v0, 10 
	syscall
	
	
# printList takes in an array and its size as arguments. 
# It prints all the elements in one line with a newline at the end.
printArray:
	move $t0, $a0		# base address
	move $t1, $a1		# length
	move $t2, $0		# i = 0
pa_loop:
	beq $t2, $t1, pa_done
	bgtz $t2, pa_space
	j pa_after_space
pa_space:
	li $v0, 4
	la $a0, space
	syscall
pa_after_space:
	sll $t3, $t2, 2
	add $t3, $t0, $t3
	lw $a0, 0($t3)
	li $v0, 1
	syscall
	addi $t2, $t2, 1
	j pa_loop
pa_done:
	li $v0, 4
	la $a0, newline
	syscall
	jr $ra
	
	
# selSort takes in the number of scores as argument. 
# It performs SELECTION sort in descending order and populates the sorted array
selSort:
	# Copy orig[i] -> sorted[i] for i in 0..len-1
	la $t0, orig
	la $t1, sorted
	move $t2, $0
ss_copy:
	beq $t2, $a0, ss_copy_done
	sll $t3, $t2, 2
	add $t4, $t0, $t3
	lw $t5, 0($t4)
	add $t4, $t1, $t3
	sw $t5, 0($t4)
	addi $t2, $t2, 1
	j ss_copy
ss_copy_done:
	addi $t6, $a0, -1		# last index for outer loop (len - 1)
	blez $t6, ss_end		# len <= 1: nothing to sort
	move $t2, $0			# i = 0
ss_outer:
	bge $t2, $t6, ss_end
	move $t7, $t2			# maxIndex = i
	addi $t8, $t2, 1		# j = i + 1
	la $t1, sorted
ss_inner:
	bge $t8, $a0, ss_inner_done
	sll $t3, $t8, 2
	add $t3, $t1, $t3
	lw $t4, 0($t3)			# sorted[j]
	sll $t3, $t7, 2
	add $t3, $t1, $t3
	lw $t5, 0($t3)			# sorted[maxIndex]
	ble $t4, $t5, ss_no_new_max
	move $t7, $t8
ss_no_new_max:
	addi $t8, $t8, 1
	j ss_inner
ss_inner_done:
	# swap sorted[i] and sorted[maxIndex]
	la $t1, sorted
	sll $t3, $t2, 2
	add $t3, $t1, $t3
	lw $t4, 0($t3)			# temp = sorted[i]
	sll $t9, $t7, 2
	add $t9, $t1, $t9
	lw $t5, 0($t9)			# sorted[maxIndex]
	sw $t5, 0($t3)
	sw $t4, 0($t9)
	addi $t2, $t2, 1
	j ss_outer
ss_end:
	jr $ra
	
	
# calcSum takes in an array and its size as arguments.
# It RECURSIVELY computes and returns the sum of elements in the array.
# Note: you MUST NOT use iterative approach in this function.
calcSum:
	addi $sp, $sp, -12
	sw $ra, 8($sp)
	sw $a0, 4($sp)
	sw $a1, 0($sp)
	blez $a1, cs_base
	addi $a1, $a1, -1
	jal calcSum
	lw $a0, 4($sp)
	lw $a1, 0($sp)
	addi $t0, $a1, -1
	sll $t0, $t0, 2
	add $t0, $a0, $t0
	lw $t1, 0($t0)
	add $v0, $v0, $t1
	j cs_done
cs_base:
	li $v0, 0
cs_done:
	lw $ra, 8($sp)
	addi $sp, $sp, 12
	jr $ra
	
