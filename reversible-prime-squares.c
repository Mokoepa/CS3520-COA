#include <stdio.h>
#include <stdbool.h>
#include <math.h>

bool isPrime(int num); // return true when a number is prime
int square(int num); // return (num * num)
bool isSquareNum(int num); // return true if num is a square num
int numReverse(int num);       // return the reverse of num
bool isNotPalindrome(int num); // return true if num is not a palindrome
void printReversiblePrimeNumbers(); // print a list of reversible prime numbers to they

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

int square(int num)
{
  return (num * num);
}

bool isSquareNum(int num)
{
  bool flag = false;
  if (square(sqrt(num)) == num)
  {
    flag = true;
  }
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
  int index = 0, count = 1, num;
  bool set = false;
  for (int i = 0; i <= count; i++)
  {
    if (isPrime(i))
    {
      num = square(i);
      if (isNotPalindrome(num) && isPrime(sqrt(numReverse(num))) && isSquareNum(numReverse(num)))
      {
        // printf("running");
        set = 1;
        while(set && (index < 10))
        {
          printf("%d \n", num);
          set = 0;
          index++;
        }
      }
    }
    count++;
    if (index == 10) return;
  }
}
