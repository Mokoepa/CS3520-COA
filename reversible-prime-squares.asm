# =========================================================================================================
# @Author: Lipholo N.
# @Student No.: 202000868
# @Purpose: The program that determines and prints the first 10 reversible prime numbers in MIPS assembly
# @Date: October 2022
# @Contact: nelipholo@gmail.com
# @github: https://github.com/Mokoepa/Reversible-Prime-Squares
# ==========================================================================================================
.data
      # num: .word 19
      msg: .asciiz "List of reversible prime squares: \n"
      newLine: .asciiz "\n"
      # debug: .asciiz "EXIT_SUCCESS"
.text
.globl main
main:
            # Display message
      li $v0, 4
      la $a0, msg
      syscall
            # Function call
      jal printReversiblePrimeNumbers
            # Exit program
      li $v0, 10
      syscall
# Implementation of isPrime(int num)
isPrime:
    li $v0, 0 # bool flag = 0
    li $t1, 1 # int i = 1
    li $t2, 2 # Set factors to two - prime has two factors
is_prime_loop:
    bgt $t1, $a0, checkFactors
    rem $t3, $a0, $t1
    bnez $t3, endofForLoop_prime
    addi $t9, $t9, 1 # factors++ - increase number of factors by 1
    addi $t1, $t1, 1 # i++
    j is_prime_loop
endofForLoop_prime:
    addi $t1, $t1, 1 # i++
    j is_prime_loop 
checkFactors:
    li $t3, 1
    beq $t9, $t2, True # is number of factors 2?
    j exitIsPrime
True:
    move $v0, $t3
exitIsPrime:
    jr $ra
# Implementation of square(int num)
squareNum:
      mult $a0, $a0
      mflo $v0
      jr $ra
# Implementation of root(int num)
sqrtNum:
      add $v0, $a0, 0 # int res = num
      li $t0, 0; # int i = 0
sqrtNumLoop:
      div $t1,$a0, 2 # store num/2 into $t1
      bgt $t0, $t1, exitSqrtNumLoop
      div $t4, $a0,$v0  # store num/res into $t4
      add $t3, $v0, $t4
      div $v0, $t3, 2
      add $t0, $t0, 1
      j sqrtNumLoop
exitSqrtNumLoop:
      jr $ra
# Implementation of isSquareNum(int)
isSquareNum:
      sub $sp, $sp, 8
      sw $ra, 0($sp)
      sw $s0, 4($sp)
      move $s0, $a0
      li $v1, 0 # bool flag = 0
      jal sqrtNum
      move $t0, $v0 
      add $a0, $t0, $zero
      jal squareNum
      move $t0, $v0 # store contents of $v0 in $t0
      move $v0, $v1
      bne $t0, $s0, exitIsSquareNum # (sqtrNum(num) != num) 
      add $v0, $v0, 1 # flag = true
exitIsSquareNum:
      lw $s0, 4($sp)
      lw $ra, 0($sp)
      add $sp, $sp, 8
      jr $ra
# Implementation of numReverse
numReverse:
      add $v0, $zero, 0 # int reverse = 0
loopNumReverse:
      ble $a0, 0, exitNumReverse
      li $t2, 10 # store 10 into register $t2
      div $a0, $t2
      mfhi $t0
      mult $v0, $t2 # reverse * 10
      mflo $t1 # $t1 = reverse * 10
      add $v0, $t1, $t0 # reverse = (reverse * 10) + result
      div $a0, $t2 # num / 10
      mflo $a0 # num = num / 10
      j loopNumReverse 
exitNumReverse:
      jr $ra
# Implementation of isNotPalindrome(int num)
isNotPalindrome:
      sub $sp, $sp, 8
      sw $ra, 0($sp)
      sw $s0, 4($sp)
      move $s0, $a0 # $s0 <- argument
      li $v1, 1 # bool flag = true
      jal numReverse # a function call: numReverse(num)
      add $t0, $v0, $zero # store the result of the function call in $t0
      move $v0, $v1
      bne $s0, $t0, exitIsNotPalindrome # if ($a0 != $t0) goto exit
      move $v0, $zero # if (num == numReverse(num)) set flag = false
exitIsNotPalindrome:
      lw $s0, 4($sp)
      lw $ra, 0($sp)
      add $sp, $sp, 8
      jr $ra
# Implementation of printReversiblePrimeNumbers()
printReversiblePrimeNumbers:
      sub $sp, $sp, 34
      sw $ra, 0($sp)
      sw $s0, 4($sp)
      sw $s1, 8($sp)
      sw $s2, 12($sp)
      sw $s3, 16($sp)
      sw $s4, 20($sp)
      sw $s5, 24($sp)
      sw $s6, 28($sp)
      sw $s7, 32($sp)
      li $s7, 0 # int index = 0
      li $t1, 1 # int count = 1
      # li $t2, 0 # bool set = false
      li $s2, 10 # SIZE = 10
      li $s0, 0 # int i = 0
printLoop: # for (int i = 0; i <= count; i++)
      bgt $s0, $t1, endPrint # inside the for loop
      move $a0, $s0 # set $a0 the value of i
      li $t3, 1 
      # call isPrime
      jal isPrime
      move $t9, $zero # Reset $t9
      bne $v0, $t3, endIfIsNotPrime
      # call squareNum
      jal squareNum
      move $s3, $v0 # store num = square(i) in register $s3
      # call numReverse
      move $a0, $s3
      jal numReverse
      move $s4, $v0
      # call isNotPalindrome
      move $a0, $s3
      jal isNotPalindrome
      move $s1, $v0
      # call sqrtNum
      move $a0, $s4
      jal sqrtNum # check the square root of numReverse
      # call isPrime
      move $a0, $v0
      move $t3, $zero # reset $t3
      jal isPrime
      move $s6, $v0
      # call isSquareNum
      move $a0, $s4
      jal isSquareNum
      move $t5, $v0
      # execute conditions in the if statement
      and $t8, $t5, $s6
      beq $s1, $t8, ifIsTrue
endIfIsNotPrime:
      add $t1, $t1, 1 # count++
      add $s0, $s0, 1 # i++
      beq $s7, $s2, endPrint
      j printLoop
ifIsTrue:
      li $t2, 1 # set = 1
      slt $s5, $s7, $s2
      beq $t2, $s5, whileIsTrue
      j endIfIsNotPrime
whileIsTrue:
            # Display message
      li $v0, 4
      la $a0, newLine
      syscall
            # printResult
      move $v0, $s3
      add $a0, $zero, $v0
      li $v0, 1
      syscall
            # continue
      add $t2, $t2, 0 # reset
      add $s7, $s7, 1 # index++
      j endIfIsNotPrime
endPrint:
      lw $s7, 32($sp)
      lw $s6, 28($sp)
      lw $s5, 24($sp)
      lw $s4, 20($sp)
      lw $s3, 16($sp)
      lw $s2, 12($sp)
      lw $s1, 8($sp)
      lw $s0, 4($sp)
      lw $ra, 0($sp)
      add $sp, $sp, 34
      jr $ra