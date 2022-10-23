# =========================================================================================================
# @Author: Lipholo N.
# @Student No.: 202000868
# @Purpose: The program that determines and prints the first 10 reversible prime squares in MIPS assembly
# @Date: October 2022
# @Contact: nelipholo@gmail.com
# @github: https://github.com/Mokoepa/Reversible-Prime-Squares
# ==========================================================================================================
.data
      msg: .asciiz "List of reversible prime squares: \n"
      newLine: .asciiz "\n"
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
            move $t9, $zero
            jr $ra
# Implementation of squareNum(int num)
squareNum:
      mult $a0, $a0
      mflo $v0
      jr $ra
# Implementation of isSquareNum(int num, i)
isSquareNum:
      sub $sp, $sp, 12
      sw $ra, 0($sp)
      sw $s6, 4($sp)
      sw $s7, 8($sp)

      li $v1, 0 # bool flag = 0
      move $a0, $t6
      jal squareNum
      bne $v0, $s6, isFalse # (sqtrNum(num) != num)
      isTrue:
            move $v0, $v1
            add $v0, $v0, 1 # flag = true
            j exitIsSquareNum
      isFalse:
            move $v0, $zero
            j exitIsSquareNum
      exitIsSquareNum:
            lw $s7, 8($sp)
            lw $s6, 4($sp)
            lw $ra, 0($sp)
            add $sp, $sp, 12
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
      sub $sp, $sp, 36
      sw $ra, 0($sp)
      sw $s0, 4($sp)    # holds $a0
      sw $s1, 8($sp)    # holds SIZE
      sw $s2, 12($sp)   # holds index
      sw $s3, 16($sp)   # holds count
      sw $s4, 20($sp)   # holds set (bool type variable)
      sw $s5, 24($sp)   # hold the value 1 for comparison
      sw $s6, 28($sp)
      sw $s7, 32($sp)

      li $s1, 10  # int SIZE = 10
      li $s2, 0   # int index = 0
      li $s3, 1   # int count = 1
      li $s4, 0   # bool set = false
      li $s5, 1   # load value 1 into $s5
      li $s7, 0   # int i = 0
      print_forLoop:
            bgt $s7, $s3, end_forLoop
            move $a0, $s7     # $a0 <- i
                  # call isPrime
            jal isPrime       # check whether 'i' is a prime number
            bne $v0, $s5, isNotPrime
                  # call squareNum
            jal squareNum
            move $s0, $v0     # $s0, <- square(int i) , num = $s0
                  # call numReverse
            move $a0, $s0
            jal numReverse
            move $s6, $v0     # #s6 <- numReverse(int num) , numRev = $s6
                  # call isNotPalindrome
            move $a0, $s0     # $a0 <- num
            jal isNotPalindrome
            move $t7, $v0     # $t7 <- isNotPalindrome(int num)
                  # call numReverse
            move $a0, $s7     # $a0 <- i
            jal numReverse
            move $t6, $v0     # $t6 <- numReverse(i)
                  # call isSquareNum
            move $a0, $s6     # 
            jal isSquareNum   # isSquareNum($s6, $s7)
            move $t4, $v0     # $t4 <- isSquareNum($s6, $s7)
                  # call is prime
            move $a0, $t6     # $a0 <- numReverse(i)
            jal isPrime
            move $t5, $v0     # $t5 <- isPrime(sqrtNum(numReverse(num)))
                  # inner if statement
            and $t8, $t4, $t5  
            and $s4, $t7, $t8
            bne $s4, $s5, isNotPrime
            move $s4, $s5     # set = 1 == $s4 <- 1
                  # innermost if statement
            slt $t9, $s2, $s1 #  true if index < SIZE
            bne $s4, $t9, isNotPrime
                  # print a new line
            li $v0, 4
            la $a0, newLine
            syscall
                  # print num - reversiblePrimeSquare
            move $v0, $s0
            add $a0, $zero, $v0
            li $v0, 1
            syscall
                  # continue
            add $s2, $s2, 1   # index++
            # j endIfIsNotPrime
      isNotPrime:
            add $s3, $s3, 1   # count++
            add $s7, $s7, 1   # i++
            bne $s2, $s1, print_forLoop   # index != SIZE
            j end_forLoop
      end_forLoop:
            lw $s7, 32($sp)
            lw $s6, 28($sp)
            lw $s5, 24($sp)
            lw $s4, 20($sp)
            lw $s3, 16($sp)
            lw $s2, 12($sp)
            lw $s1, 8($sp)
            lw $s0, 4($sp)
            lw $ra 0($sp)
            add $sp, $sp, 36
            jr $ra