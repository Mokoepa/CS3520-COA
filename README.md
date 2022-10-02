# CS3520-COA

Compiled the C source file on Fedora using g++, the program was also tested on windows using gcc. 
The program however, does not compile successfully on Fedora when gcc is used for compilation.
This (line 4 above) is true when the #include <math.h> is part of out program, false otherwise.
The result of compiling using gcc leads to the following error message:

  /usr/bin/ld: /tmp/ccWDTvqO.o: in function `isSquareNum':
  reversible-prime-squares.c:(.text+0x8f): undefined reference to `sqrt'
  /usr/bin/ld: /tmp/ccWDTvqO.o: in function `printReversiblePrimeNumbers':
  reversible-prime-squares.c:(.text+0x1bf): undefined reference to `sqrt'
  collect2: error: ld returned 1 exit status
