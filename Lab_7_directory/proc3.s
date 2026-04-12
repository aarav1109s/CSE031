# proc3.s — MIPS translation of proc3.c (Lab 7)
# main: x->$s0, y->$s1, z->$s2
# foo:  p->$s0, q->$s1; args m->$a0, n->$a1, o->$a2
# bar:  a->$a0, b->$a1, c->$a2; return in $v0

.data
str_pq:	.asciiz "p + q: "
str_nl:	.asciiz "\n"

.text
.globl main

# MARS begins at the first instruction in .text — keep main first.
main:	li	$s0, 2
	li	$s1, 4
	li	$s2, 6

	move	$a0, $s0
	move	$a1, $s1
	move	$a2, $s2
	jal	foo

	addu	$t0, $s0, $s1
	addu	$t0, $t0, $s2
	addu	$s2, $t0, $v0		# z = x + y + z + foo(...)

	move	$a0, $s2
	li	$v0, 1
	syscall
	la	$a0, str_nl
	li	$v0, 4
	syscall

	li	$v0, 10
	syscall

# int foo(int m, int n, int o) { ... }
foo:	addiu	$sp, $sp, -24
	sw	$ra, 20($sp)
	sw	$s0, 16($sp)
	sw	$s1, 12($sp)
	sw	$a0, 8($sp)		# m
	sw	$a1, 4($sp)		# n
	sw	$a2, 0($sp)		# o

	# p = bar(m + o, n + o, m + n);
	lw	$t0, 8($sp)
	lw	$t1, 4($sp)
	lw	$t2, 0($sp)
	addu	$a0, $t0, $t2
	addu	$a1, $t1, $t2
	addu	$a2, $t0, $t1
	jal	bar
	move	$s0, $v0		# p

	# q = bar(m - o, n - m, n + n);
	lw	$t0, 8($sp)
	lw	$t1, 4($sp)
	lw	$t2, 0($sp)
	subu	$a0, $t0, $t2
	subu	$a1, $t1, $t0
	addu	$a2, $t1, $t1
	jal	bar
	move	$s1, $v0		# q

	addu	$t3, $s0, $s1		# p + q

	la	$a0, str_pq
	li	$v0, 4
	syscall
	move	$a0, $t3
	li	$v0, 1
	syscall
	la	$a0, str_nl
	li	$v0, 4
	syscall

	move	$v0, $t3		# return p + q

	lw	$s1, 12($sp)
	lw	$s0, 16($sp)
	lw	$ra, 20($sp)
	addiu	$sp, $sp, 24
	jr	$ra

# int bar(int a, int b, int c) { return (b - a) << (c); }
bar:	subu	$t0, $a1, $a0
	sllv	$v0, $t0, $a2
	jr	$ra
