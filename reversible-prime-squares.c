
/***********************************************************************************************************
// @Author: Lipholo N.
// @Student No.: 202000868
// @Purpose: The program that determines and prints the first 10 reversible prime numbers in c
// @Date: October 2022
// @Contact: nelipholo@gmail.com
// @github: https://github.com/Mokoepa/Reversible-Prime-Squares
************************************************************************************************************/

#include <stdio.h>
#include <stdbool.h>
#include <math.h>

bool isPrime(int num);  // return true if a number is prime
int squareNum(int num);    // return (num * num) - could have used pow() instead - Please refer to README.md as to why pow() was possibly not used
bool isSquareNum(int num, int i);     // return true if num is a square num
int numReverse(int num);       // return the reverse of num
bool isNotPalindrome(int num); // return true if num is not a palindrome
void printReversiblePrimeNumbers(); // print a list of reversible prime squares to the screen/terminal

int main()
{
  printReversiblePrimeNumbers();
  return 0;
}

bool isPrime(int num)
{
  bool flag = 0;
  int factors = 0; // Keeps track of factors of num
  for (int i = 1; i <= num; i++)
  {
    if (num % i == 0) // check for a factor of a sqrt of a number
    {
      factors++;
    }
  }
  if (factors == 2) // A prime number has two factors only
  {
    flag = 1;
  }
  return flag;
}

int squareNum(int num)
{
  return (num * num); // could have used pow() instead - Refer to README.md as to why pow() was possibly not used
}

bool isSquareNum(int num, int i)
{
  bool flag = 0;
  if (squareNum(numReverse(i)) == num)
    flag = true;
  return flag;
}

int numReverse(int num)
{
  int result, reverse = 0;
  while (num > 0)
  {
    result = num % 10;
    reverse = (reverse * 10) + result;
    num /= 10;
  }
  return reverse;
}

bool isNotPalindrome(int num)
{
  bool flag = true;
  if (num == numReverse(num))
  {
    flag = false;
  }
  return flag;
}

void printReversiblePrimeNumbers()
{
  int index = 0, count = 1, SIZE = 10;
  bool set = false;
  printf("List of reversible prime squares: \n");
  for (int i = 0; i < count; i++) {
    if (isPrime(i))
    {
      int num = squareNum(i);
      int numRev = numReverse(num);
      if (isNotPalindrome(num) && isPrime(numReverse(i)) && isSquareNum(numRev, i))
      {
        set = 1;
        if (set && (index < SIZE))
        {
          printf("%i \n", num);
          index++;
        }
      }
    }
    count++;
    if (index == SIZE) return; // Exit the non return type function
  }
}