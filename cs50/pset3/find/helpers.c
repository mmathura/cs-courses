/**************************************************************************** 
 * helpers.c
 *
 * Computer Science 50
 * Problem Set 3
 *
 * Helper functions for Problem Set 3.
 ***************************************************************************/
       
#include <cs50.h>
#include <stdio.h>

#include "helpers.h"


/*
 * Returns true if value is in array of n values, else false.
 */

bool 
search(int value, int array[], int n)
{
    // re-implemented as binary search instead of linear
    // int i;
    // for (i = 0; i < n; i++)
    //    if (array[i] == value)
    //        return true;
    // return false;
    
    int middle, first = 0, last = n - 1; 
    
    while (first <= last) { /* exit if first exceeds the last index */
                            /* if first falls off or is on the edge exit loop */
      middle = (first + last) / 2;
      
      if (value < array[middle]) 
         last =  middle - 1; /* new last is at left of middle */
      else if (value > array[middle])
         first = middle + 1; /* new first is at right of middle */
      else if (value == array[middle]) 
         return true; /* match */                
    }

    return false;  /* no match found */
}


/*
 * Sorts array of n values.
 */

void 
sort(int values[], int n)
{
    // implemented as an O(n^2) sort -- i.e., 
    // bubble sort
    int i, swapped, temp;
  
    do {
      swapped = 0; // clear flag
      for (i = 0; i < n; i++) {
        if (values[i] > values[i + 1]) {
           temp = values[i];
           values[i] = values[i + 1];
           values[i + 1] = temp;
           swapped++; // set flag
        }
      }   
    } while (swapped);

    return;
}
