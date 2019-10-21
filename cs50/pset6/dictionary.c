/****************************************************************************
 * dictionary.c
 *
 * Computer Science 50
 * Problem Set 6
 *
 * Implements a dictionary's functionality.
 ***************************************************************************/

#include <stdbool.h>

#include <stddef.h>
#include <stdio.h>
#include <ctype.h>
#include <string.h>
#include <stdlib.h>

#include "dictionary.h"

// static global 
static int wordcount = 0; // number of words loaded into hash table


/**
  * hash function folds a string into an index
  */

int hash_function(char* sword) {

   // return empty string error

   int key = 0, wordlength = strlen(sword);
 
   for (int i = 0; i < wordlength; i++)
      if (isalpha(sword[i])) // ignores dashes and apostrophes 
        key += (sword[i] - 97);
      
   return key % HASH_KEYS;
}


/**
  * prints contents of hash table for debugging
  */

void print_table(void) {

  for (int i = 0; i < HASH_KEYS; i++) {

    if (dictionary[i] != NULL) {

      node* ptemp = dictionary[i]; 
      printf("%3d:  ", i);

      while (ptemp != NULL) {
        printf("%s ", ptemp->word, ptemp);        
        ptemp = ptemp->next;
      }

      printf("\n");

      ptemp = NULL;
    }
  } 

  printf("\n\nWord count = %d\n", wordcount);
}


/*
 * Returns true if word is in dictionary else false.
 */

bool
check(const char *word)
{
    // return false if word is an empty string 

    int i = 0, word_length = strlen(word);
    char starget[LENGTH + 1];
    
    // converts word to lower case to check against words in dictionary    

    while (i < word_length) {
      starget[i] = tolower(word[i]);
      i++;
    }

    starget[i] = '\0'; // add null terminator

    int index = hash_function(starget);

    // check if hash function returns an error

    node* ptemp = dictionary[index];
    
    while (ptemp != NULL) {

       if (strcmp(starget, ptemp->word) == 0) {
           ptemp = NULL;
           return true;
       }

       ptemp = ptemp->next;
    } 

    ptemp = NULL;

    return false; // no match 
}


/*
 * Loads dict into memory.  Returns true if successful else false.
 */

bool
load(const char *dict)
{
    // return false if dictionary file name string doesn't exist 

    // initialize hash table

    for (int i = 0; i < HASH_KEYS; i++)
      dictionary[i] = NULL;

    FILE* fpdict = fopen(dict, "r"); 
    if (!fpdict)
      return false; // filename doesn't exit or file open error
    
    char tempstring[LENGTH + 1];
    int i = 0;

    while (!feof(fpdict)) {

       int ch = fgetc(fpdict);
       
       if (!isspace(ch)) 
           tempstring[i++] = ch; // start copying chars into temp string
       else 
       {
           tempstring[i] = '\0'; // append null terminator at a newline

           if (i > 0) { // if not an empty string

             // add to list in hash table  

             int index = hash_function(tempstring);

             // check if hash function returns an error 
            
             node* pnew = malloc(sizeof(node));
             if (!pnew) { // if malloc fails
                free(pnew);
                pnew = NULL; 
                return false; 
             } 

             // initialize new node

             strcpy(pnew->word, tempstring);
             pnew->word[strlen(tempstring)] = '\0';
             pnew->next = NULL;

             // add entries in linked list in alphabetical order

             if (!dictionary[index]) // if dictionary array element is empty add new node
                dictionary[index] = pnew; 
             else if (strcmp(dictionary[index]->word, pnew->word) > 0) { // or add to head
                pnew->next = dictionary[index]; 
                dictionary[index] = pnew;           
             }
             else {

                 // or add to middle or tail of list 
                 
                 node* ptemp = dictionary[index];

                 while (1) { // find insertion point
                   
                   if (ptemp->next == NULL) {  // insert at tail of list
                       ptemp->next = pnew;
                       break; // reached end of list
                   } 
                   else if (strcmp(ptemp->word, pnew->word) < 0) { 
                   
                      if (ptemp != NULL) { // inset in middle of list
                         pnew->next = ptemp->next;
                         ptemp->next = pnew;
                         break;  
                      }
                   }

                   ptemp = ptemp->next;
                }

                ptemp = NULL;
             }
             
             // add to hash table or to head of list            

             // if dictionary is empty add new node 
             // if (!dictionary[index])
                // dictionary[index] = pnew; 
             // else { // or add to head
                // pnew->next = dictionary[index];
                // dictionary[index] = pnew;
             // } 

             pnew = NULL;  
             wordcount++; // increment word count
           }    
     
           i = 0; // clear
       }
    }

    // print_table(); // for debugging load function 

    fclose(fpdict);
    
    if (wordcount > 0) 
      return true;
    
    return false; // load function fails
}


/*
 * Returns number of words in dictionary if loaded else 0 if not yet loaded.
 */

unsigned int
size(void)
{
    if (wordcount > 0) 
       return wordcount;

    return 0;
}


/*
 * Unloads dictionary from memory.  Returns true if successful else false.
 */

bool
unload(void)
{
    int count = 0;

    for (int i = 0; i < HASH_KEYS; i++) {

        node* ptemp = dictionary[i]; // start at head

        while (ptemp != NULL) { // free memory and close off any memory leaks
           node* phead = ptemp;
           ptemp = ptemp->next;    
           free(phead);
           phead = NULL;
           count++;
        }
        
        ptemp = NULL;
    }
 
    for (int i = 0; i < HASH_KEYS; i++)
      dictionary[i] = NULL;
 
    if (count == wordcount)
       return true;

    return false; // unload fails 
}
