#include <stdio.h>
#include <stdlib.h>
#include <string.h>


int main(int argc, char* argv[]) {

  int i, j, length, rotation, offsets, keys[80];
  char plaintext[80], ciphertext[80];
  
  if (argc == 2 && argv[1] != NULL) {

    for (i = 0; i < strlen(argv[1]); i++) {
       if (!isalpha(argv[1][i])) {
         printf("Must be an aphabetical string.\n");
         return 1;
       }
    }
  } 
  else if (argc == 1 || argc > 2) {
    printf("Takes only one agrument.\n");
    return 1;    
  }

  /* init arrays */
 
  for (i = 0; i < 80; i++) {
    plaintext[i] = ciphertext[i] = '\0';
    keys[i] = -1;
  }
  
  /* calculate offsets */
  
  offsets = strlen(argv[1]);
 
  for (i = 0; i < offsets; i++) {

    if (isupper(argv[1][i]))
       keys[i] = argv[1][i] - 'A';
    else /* lowercase */
       keys[i] = argv[1][i] - 'a';
  }
 
  printf("plaintext:     "); 
  fgets(plaintext, 80, stdin);

  length = strlen(plaintext) - 1;

  printf("ciphertext:    ");
  
  j = 0;

  for (i = 0; i < length; i++) {
   
    if (isalpha(plaintext[i])) {
     
      if (j == offsets)
        j = 0; /* reset index */

      rotation = keys[j++] % 26;
 
      if (isupper(plaintext[i])) {
         if ((plaintext[i] + rotation) > 'Z') 
           ciphertext[i] = 'A' + rotation - ('Z' - plaintext[i]) - 1; 
         else if (plaintext[i] == 'Z')           
           ciphertext[i] = 'A' + rotation; 
         else 
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
