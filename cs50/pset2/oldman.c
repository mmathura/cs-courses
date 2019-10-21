#include <stdio.h>


int main(void) {

  int i;

  char* numbers[] = {"one", "two", "three", "four", "five", 
                     "six", "seven", "eight", "nine", "ten"};

  char* objects[] = {"thumb", "shoe", "knee", "door", "hive", 
                     "sticks", "heaven", "gate", "spine", "once again"}; 

  printf("\n");

  for (i = 0; i < 10; i++) {

    printf("This old man, he played %s\n", numbers[i]);

    if (i == 6) /* heaven condition */
      printf("He played knick-knack up in %s\n", objects[i]);
    else if (i == 9) /* once again condition */
      printf("He played knick-knack %s\n", objects[i]); 
    else
      printf("He played knick-knack on my %s\n", objects[i]); 
    
    printf("Knick-knack paddywhack, give your dog a bone\n");
    printf("This old man came rolling home\n\n");

  }

  return 0;

}
