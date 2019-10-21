/****************************************************************************
 * dictionary.h
 *
 * Computer Science 50
 * Problem Set 6
 *
 * Declares a dictionary's functionality.
 ***************************************************************************/

#ifndef DICTIONARY_H
#define DICTIONARY_H

#include <stdbool.h>
#include <stddef.h>
#include <stdio.h>
#include <ctype.h>
#include <string.h>
#include <stdlib.h>


// maximum length for a word
// (e.g., pneumonoultramicroscopicsilicovolcanoconiosis)
#define LENGTH 45
#define HASH_KEYS 10000


// for list of nodes that contain dictionary words
typedef struct node {

   char word[LENGTH + 1]; // for a word in the dictionary + 1 for the null terminator
   struct node* next; // pointer to next node in the list 

} node; 


// hash table for dictionary
node* dictionary[HASH_KEYS];


// hash function prototype
int hash_function(char* sword);


// for debugging
void print_table(void);


/*
 * Returns true if word is in dictionary else false.
 */

bool check(const char *word);


/*
 * Loads dict into memory.  Returns true if successful else false.
 */

bool load(const char *dict);


/*
 * Returns number of words in dictionary if loaded else 0 if not yet loaded.
 */

unsigned int size(void);


/*
 * Unloads dictionary from memory.  Returns true if successful else false.
 */

bool unload(void);


#endif // DICTIONARY_H
