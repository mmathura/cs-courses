#include <stdio.h>
#include <stdlib.h>
#include <time.h>


int main() {

  int skittles, guess;

  /* gets a random number between 0 and 1023 */
  
  srand(time(NULL));
  skittles = rand() % 1024;

  printf("O hai! I'm thinking of a number between 0 and 1023. What is it?\n");
 
  /* asks user to guess number until its right */

  do {
    
    scanf("%d", &guess);
    
    if (guess < 0) 
      printf("Nope! Don't be difficult. Guess again.\n");
    else if (guess > skittles) 
      printf("Nope! There are fewer Skittles than that. Guess again.\n"); 
    else if (guess < skittles)
      printf("Nope! There are way more Skittles than that. Guess again.\n");
  
  } while (skittles != guess);

  if (guess == skittles) 
    printf("That's right! Nom nom nom.\n");
   
  return 0;
}
