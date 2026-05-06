# recursion1.s
# MIPS translation of recursion1.c

.data
prompt: .asciiz "Please enter a number: "
nl:     .asciiz "\n"

.text
.globl main

main:
    # print prompt
    la   $a0, prompt
    li   $v0, 4
    syscall

    # read integer
    li   $v0, 5
    syscall
    move $a0, $v0          # $a0 = x

    # call recursion(x)
    jal  recursion

    # print result
    move $a0, $v0
    li   $v0, 1
    syscall

    # print newline
    la   $a0, nl
    li   $v0, 4
    syscall

    # exit
    li   $v0, 10
    syscall


# int recursion(int m)
# argument: $a0 = m
# return:   $v0
recursion:
    addiu $sp, $sp, -16
    sw    $ra, 12($sp)
    sw    $a0, 8($sp)

    # if (m == -1) return 3;
    li    $t0, -1
    beq   $a0, $t0, ret_3

    # else if (m <= -2)
    li    $t0, -2
    ble   $a0, $t0, less_equal_neg2

    # else return recursion(m - 3) + m + recursion(m - 2);

    # first call: recursion(m - 3)
    lw    $a0, 8($sp)
    addi  $a0, $a0, -3
    jal   recursion

    # save recursion(m - 3)
    sw    $v0, 4($sp)

    # second call: recursion(m - 2)
    lw    $a0, 8($sp)
    addi  $a0, $a0, -2
    jal   recursion

    # final result = recursion(m - 3) + m + recursion(m - 2)
    lw    $t1, 4($sp)      # recursion(m - 3)
    lw    $t2, 8($sp)      # original m
    add   $v0, $t1, $v0
    add   $v0, $v0, $t2
    j     end_recursion


less_equal_neg2:
    # if (m < -2) return 2;
    li    $t0, -2
    blt   $a0, $t0, ret_2

    # else return 1;   # this means m == -2
    li    $v0, 1
    j     end_recursion


ret_3:
    li    $v0, 3
    j     end_recursion


ret_2:
    li    $v0, 2
    j     end_recursion


end_recursion:
    lw    $ra, 12($sp)
    addiu $sp, $sp, 16
    jr    $ra