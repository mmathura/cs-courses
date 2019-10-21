/***************************************************************************
 * fifteen.c
 *
 * Computer Science 50
 * Problem Set 3
 *
 * Implements The Game of Fifteen (generalized to d x d).
 *
 * Usage: fifteen d
 *
 * whereby the board's dimensions are to be d x d,
 * where d must be in [DIM_MIN,DIM_MAX]
 *
 * Note that usleep is obsolete, but it offers more granularity than
 * sleep and is simpler to use than nanosleep; `man usleep` for more.
 ***************************************************************************/
 
#define _XOPEN_SOURCE 500

#include <cs50.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>


// constants
#define DIM_MIN 3
#define DIM_MAX 9


// board
int board[DIM_MAX][DIM_MAX];

// dimensions
int d;


// prototypes
void clear(void);
void greet(void);
void init(void);
void draw(void);
bool move(int tile);
bool won(void);


int
main(int argc, char *argv[])
{
    // greet user with instructions
    greet();

    // ensure proper usage
    if (argc != 2)
    {
        printf("Usage: %s d\n", argv[0]);
        return 1;
    }

    // ensure valid dimensions
    d = atoi(argv[1]);
    if (d < DIM_MIN || d > DIM_MAX)
    {
        printf("Board must be between %d x %d and %d x %d, inclusive.\n",
         DIM_MIN, DIM_MIN, DIM_MAX, DIM_MAX);
        return 2;
    }

    // initialize the board
    init();

    // accept moves until game is won
    while (true)
    {
        // clear the screen
        clear();

        // draw the current state of the board
        draw();

        // check for win
        if (won())
        {
            printf("ftw!\n");
            break;
        }

        // prompt for move
        printf("Tile to move: ");
        int tile = GetInt();

        // move if possible, else report illegality
        if (!move(tile))
        {
            printf("\nIllegal move.\n");
            usleep(500000);
        }

        // sleep thread for animation's sake
        usleep(500000);
    }

    // that's all folks
    return 0;
}


/*
 * Clears screen using ANSI escape sequences.
 */

void
clear(void)
{
    printf("\033[2J");
    printf("\033[%d;%dH", 0, 0);
}


/*
 * Greets player.
 */

void
greet(void)
{
    clear();
    printf("WELCOME TO THE GAME OF FIFTEEN\n");
    usleep(2000000);
}


/*
 * Initializes the game's board with tiles numbered 1 through d*d - 1
 * (i.e., fills 2D array with values but does not actually print them).  
 */

void
init(void)
{
    // init
    int i, j, n = d * d - 1;

    for (i = 0; i < d - 1; i++) { /* populate every row except the last */
       for (j = 0; j < d; j++) {
           board[i][j] = n--;
       }
    }
    
    for (j = 0; j < d - 3; j++) /* third row */
      board[d - 1][j] = n--;
    
    /* puts 1 and 2 or 2 and 1 in the right position */
    
    if (d % 2 == 0) { /* even */
       board[d - 1][d - 3] = 1;
       board[d - 1][d - 2] = 2; 
    } 
    else { /* odd */
       board[d - 1][d - 3] = 2;
       board[d - 1][d - 2] = 1;       
    }
  
    board[d - 1][d - 1] = d * d; /* blank space or sentinel */
       
}


/* 
 * Prints the board in its current state.
 */

void
draw(void)
{
    // print board
    int i, j;

    for (i = 0; i < d; i++) {
      for (j = 0; j < d; j++) {
        if (board[i][j] != d * d)
          printf(" %2d ", board[i][j]);
        else
          printf(" -- ");
      }
      printf("\n");
    } 

}


/* 
 * If tile borders empty space, moves tile and returns true, else
 * returns false. 
 */

bool
move(int tile)
{
    // move tiles
    int i, j, found = 0;

    if (tile == d * d) return false; /* value of sentinel */ 
     
    for (i = 0; i < d; i++) { /* get i and j of tile */ 
      for (j = 0; j < d; j++) {
        if (tile == board[i][j]) {
           found = 1; /* set */
           break;
        }
      }
      if (found) break;
    }

    /* check neighbours */

    if (board[i][j + 1] == d * d && j + 1 < d) { /* check right */
       board[i][j + 1] = board[i][j];
       board[i][j] = d * d;
       return true;
    }
    
    if (board[i][j - 1] == d * d && j - 1 >= 0) { /* check left */
       board[i][j - 1] = board[i][j];
       board[i][j] = d * d;
       return true;
    }
 
    if (board[i + 1][j] == d * d && i + 1 < d) { /* check top */
       board[i + 1][j] = board[i][j];
       board[i][j] = d * d;
       return true;
    }

    if (board[i - 1][j] == d * d && i - 1 >= 0) { /* check bottom */
       board[i - 1][j] = board[i][j];
       board[i][j] = d * d;
       return true;
    }

    return false;
}


/*
 * Returns true if game is won (i.e., board is in winning configuration), 
 * else false.
 */

bool
won(void)
{
    // checks elements are in sorted order
    int i, j, count = 0;

    for (i = 0; i < d; i++) {
      for (j = 0; j < d; j++) {
        if (j + 1 >= d && i + 1 < d) {
           if (board[i][j] < board[i + 1][0])
             count++;
        } 
        else if (j + 1 < d) {
          if (board[i][j] < board[i][j + 1])             
            count++;
        }
      }
    } 

    if (count == d*d - 1) return true; 
        
    return false;
}
