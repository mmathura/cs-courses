#include <stdio.h>
#include <math.h>

int main(void) {

  float change;
  int amount, coins = 0;
 
  printf("O hai! How much change is owed?\n");
  
  while(1) {

    while (!scanf("%f", &change)) { /* if not a float */
       printf("Retry: \n");
       clearerr(stdin);
       rewind(stdin);
    }
    
    if (change < 0) 
      printf("Er, how much change is owed?\n");
    else
      break;

  }

  amount = round(change * 100);
  
  while (amount != 0) {

    if      (amount >= 25) { amount -= 25; coins++; } 
    else if (amount >= 10) { amount -= 10; coins++; }
    else if (amount >= 5)  { amount -= 5;  coins++; }
    else if (amount >= 1)  { amount -= 1;  coins++; } 
  
  }

  printf("%d\n", coins);
 
  return 0;

}
