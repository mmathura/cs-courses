#include <stdio.h>
#include <stdlib.h>
#include <string.h>


int main(int argc, char* argv[]) {

  int key, i, length, rotation;
  char plaintext[80], ciphertext[80]; 
  
  if (argc == 2 && argv[1] != NULL) {

    for (i = 0; i < strlen(argv[1]); i++) {
       if (!isdigit(argv[1][i])) {
         printf("Must be a positive integer.\n");
         return 1;
       }
    }

    key = atoi(argv[1]);
  } 
  else if (argc == 1 || argc > 2) {
    printf("Takes only one agrument.\n");
    return 1;    
  }

  for (i = 0; i < 80; i++)
    plaintext[i] = ciphertext[i] = '\0';
 
  printf("plaintext:     "); 
  fgets(plaintext, 80, stdin);

  rotation = key % 26;
  length = strlen(plaintext) - 1;

  printf("ciphertext:    ");
  
  for (i = 0; i < length; i++) {
   
    if (isalpha(plaintext[i])) {

      if (isupper(plaintext[i])) {
         if ((plaintext[i] + rotation) > 'Z') /* out of range of 'z' */ 
           ciphertext[i] = 'A' + rotation - ('Z' - plaintext[i]) - 1; /* calculate wrap around */ 
         else if (plaintext[i] == 'Z') /* at the end of alphabet */
            ciphertext[i] = 'A' + rotation; /* start at 'a' and apply the shift */
         else /* in range, apply the offset */
           ciphertext[i] = plaintext[i] + rotation; 
      }
      else if (islower(plaintext[i])) {
        if ((plaintext[i] + rotation) > 'z')
           ciphertext[i] = 'a' + rotation - ('z' - plaintext[i]) - 1;
        else if (plaintext[i] == 'z')
           ciphertext[i] = 'a' + rotation;
        else
           ciphertext[i] = plaintext[i] + rotation; 
      }
    } 
    else 
      ciphertext[i] = plaintext[i];

    printf("%c", ciphertext[i]);  
  }

  printf("\n");
 
  return 0;

} 
