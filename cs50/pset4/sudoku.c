/****************************************************************************
 * sudoku.c
 *
 * Computer Science 50
 * Problem Set 4
 *
 * Implements the game of Sudoku.
 ***************************************************************************/

#include "sudoku.h"

#include <ctype.h>
#include <ncurses.h>
#include <signal.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>


// macro for processing control characters
#define CTRL(x) ((x) & ~0140)

// wrapper for our game's globals
struct
{
    // the current level
    char *level;

    // the game's board
    int board[9][9];

    // the board's number
    int number;

    // the board's top-left coordinates
    int top, left;

    // the cursor's current location between (0,0) and (8,8)
    int y, x;
} g; 

// globals
int board[9][9]; // original numbers in the board

// prototypes
void draw_grid();
void draw_borders();
void draw_logo();
void draw_numbers();
void hide_banner();
bool load_board();
void handle_signal(int);
void log_move(int);
void redraw_all();
bool restart_game();
void show_banner(char *);
void show_cursor();
void shutdown();
bool startup();

// prototypes added 
void replace_blanks(int);
void copy_board(); 
bool check_row();
bool check_col();
bool check_box();
void invalid_move();
bool check_cell(int, int, int, int);
bool is_won(); 

/*
 * int
 * main(int argc, char *argv[])
 *
 * Main driver for the game.
 */

int
main(int argc, char *argv[])
{
    // define usage
    const char *usage = "Usage: sudoku n00b|l33t [#]\n";

    // ensure that number of arguments is as expected
    if (argc != 2 && argc != 3)
    {
        fprintf(stderr, usage);
        return 1;
    }

    // ensure that level is valid
    if (!strcmp(argv[1], "debug"))
        g.level = "debug";
    else if (!strcmp(argv[1], "n00b"))
        g.level = "n00b";
    else if (!strcmp(argv[1], "l33t"))
        g.level = "l33t";
    else
    {
        fprintf(stderr, usage);
        return 2;
    }

    // n00b and l33t levels have 1024 boards; debug level has 9
    int max = (!strcmp(g.level, "debug")) ? 9 : 1024;

    // ensure that #, if provided, is in [1, max]
    if (argc == 3)
    {
        // ensure n is integral
        char c;
        if (!sscanf(argv[2], " %d %c", &g.number, &c) == 1)
        {
            fprintf(stderr, usage);
            return 3;
        }

        // ensure n is in [1, max]
        if (g.number < 1 || g.number > max)
        {
            fprintf(stderr, "That board # does not exist!\n");
            return 4;
        }

        // seed PRNG with # so that we get same sequence of boards
        srand(g.number);
    }
    else
    {
        // seed PRNG with current time so that we get any sequence of boards
        srand(time(NULL));

        // choose a random n in [1, max]
        g.number = rand() % max + 1;
    }

    // start up ncurses
    if (!startup())
    {
        fprintf(stderr, "Error starting up ncurses!\n");
        return 6;
    }

    // register handler for SIGWINCH (SIGnal WINdow CHanged)
    signal(SIGWINCH, (void (*)(int)) handle_signal);

    // start the first game
    if (!restart_game())
    {
        shutdown();
        fprintf(stderr, "Could not load board from disk!\n");
        return 7;
    }

    redraw_all();
    
    // let the user play!
    int ch;
    do
    {
        // refresh the screen
        refresh();

        // get user's input
        ch = getch();

        // capitalize input to simplify cases
        ch = toupper(ch);

        // process user's input
        switch (ch)
        {
            // start a new game
            case 'N': 
                g.number = rand() % max + 1;
                if (!restart_game())
                {
                    shutdown();
                    fprintf(stderr, "Could not load board from disk!\n");
                    return 7;
                }
                break;

            // restart current game
            case 'R': 
                if (!restart_game())
                {
                    shutdown();
                    fprintf(stderr, "Could not load board from disk!\n");
                    return 7;
                }
                break;

            // let user manually redraw screen with ctrl-L
            case CTRL('l'):
                redraw_all();
                break;

            case KEY_UP:
                if (g.y > 0) 
                   g.y--; 
                show_cursor();
                break;

            case KEY_DOWN:
                if (g.y < 8) 
                   g.y++; 
                show_cursor();
                break;

            case KEY_LEFT:
                if (g.x > 0) 
                   g.x--; 
                show_cursor();
                break;

            case KEY_RIGHT:
                if (g.x < 8) 
                   g.x++; 
                show_cursor();
                break;

            case '.':
            case '0':
            case '1':
            case '2':
            case '3':
            case '4':
            case '5':
            case '6':
            case '7':
            case '8':
            case '9':
            case KEY_BACKSPACE:
            case KEY_DC:
                 replace_blanks(ch);
                 draw_numbers();
                 show_cursor();
                 invalid_move();
                 break;
        } 

        show_banner("             "); // clear is won banner 

        show_cursor();

        if (is_won())
           show_banner("You have won!");
            
        // log input (and board's state) if any was received this iteration
        if (ch != ERR)
            log_move(ch);
    }
    while (ch != 'Q');

    // shut down ncurses
    shutdown();

    // tidy up the screen (using ANSI escape sequences)
    printf("\033[2J");
    printf("\033[%d;%dH", 0, 0);

    // that's all folks
    printf("\nkthxbai!\n\n");
    return 0;
}


/*
 * bool
 * is_won()
 *
 * Determines if game is won.  
 */

bool is_won() {

   int i, j, k, flag = 0, row_count, col_count;

   for (i = 0; i < 9; i++)
     for (j = 0; j < 9; j++)
        if (g.board[i][j] == 0)
           flag++; // count number of 0's left on board

   if (flag > 0) return false;

   // rows
        
   for (i = 0; i < 9; i++) {
      for (k  = 1; k < 10; k++) {
        row_count = 0; 
        for (j = 0; j < 9; j++) {  
           if (g.board[i][j] == k)
             row_count++;
        }
        if (row_count > 1) return false;
      } 
   }
    
   // columns 

   for (j = 0; j < 9; j++) {
      for (k  = 1; k < 10; k++) {
         col_count = 0;
         for (i = 0; i < 9; i++) {  
            if (g.board[i][j] == k)
               col_count++;
         }
         if (col_count > 1) return false;
      }
   } 

   return true;
}


/*
 * bool
 * check_row()
 *
 * checks row if move is valid  
 */

bool 
check_row() { // g.y

   int counts[9] = {0, 0, 0, 0, 0, 0, 0, 0, 0}, i;

   for (i = 0; i < 9; i++)
      counts[g.board[g.y][i] - 1]++;

   for (i = 0; i < 9; i++)
      if (counts[i] > 1)
         return false;
     
   return true;
}

/*
 * bool
 * check_col()
 *
 * checks col if move is valid  
 */

bool 
check_col() { // g.x

   int counts[9] = {0, 0, 0, 0, 0, 0, 0, 0, 0}, i;

   for (i = 0; i < 9; i++)
      counts[g.board[i][g.x] - 1]++;

   for (i = 0; i < 9; i++)
      if (counts[i] > 1)
         return false;

   return true;
}

/*
 * bool
 * check_cell()
 *
 * checks 3 x 3 cell if it is valid  
 */

bool 
check_cell(int x, int y, int a, int b) {

   int count, i, j, k;
   
   for (k = 1; k < 10; k++) {
      count = 0;
      for (i = x; i < a; i++) {
         for (j = y; j < b; j++) {
            if (g.board[i][j] == k)
               count++;
        }
      }
 
      if (count > 1) 
        return false;

   }

   return true;
}

/*
 * bool
 * check_box()
 *
 * checks each box (3 x 3 cell) in grid to see if it is valid  
 */

bool 
check_box() {

   if (!check_cell(0, 0, 3, 3) || !check_cell(3, 0, 6, 3) || !check_cell(6, 0, 9, 3) ||
       !check_cell(0, 3, 3, 6) || !check_cell(3, 3, 6 ,6) || !check_cell(6, 3 ,9, 6) ||
       !check_cell(0, 6 ,3, 9) || !check_cell(3, 6 ,6, 9) || !check_cell(6, 6 ,9, 9))
      return false;

   return true;
}

/*
 * bool
 * invalid_move()
 *
 * checks row, column or square if move is valid  
 */

void 
invalid_move() {

    char message[]  = "Invalid move!";
    char clear[]    = "             "; /* clear invalid message string */
      
    mvaddstr(g.top + 16, g.left + 25 - strlen(clear), clear);    
    show_cursor();

    if (!check_row() || !check_col() || !check_box()) {
        mvaddstr(g.top + 16, g.left + 25 - strlen(message), message);
        show_cursor();
    }
  
}

/*
 * void
 * copy_board()
 *
 * Makes copy of original numbers in game board 
 */

void
copy_board() {

    int i, j;
    
    // make copy of game board
    for (i = 0; i < 9; i++) {
       for (j = 0; j < 9; j++) {
          board[i][j] = g.board[i][j];
       }
    }
}

/*
 * void
 * replace_blanks(int ch)
 *
 * Replaces blanks in board with with user entered numbers
 */

void replace_blanks(int ch) {

      if ((ch >= '1' || ch <= '9') &&  (g.board[g.y][g.x] == 0 || /* put 1 to 9 in an empty space */
         board[g.y][g.x] != g.board[g.y][g.x])) /* or change a value that was entered */
             g.board[g.y][g.x] = ch - '0';
      else if ((ch == '0' || ch == '.' || ch == KEY_BACKSPACE || ch == KEY_DC) && 
         board[g.y][g.x] != g.board[g.y][g.x]) /* can't delete what's already there */
             g.board[g.y][g.x] = 0;
}

/*
 * void
 * draw_grid()
 *
 * Draw's the game's board.
 */

void
draw_grid()
{
    // get window's dimensions
    int maxy, maxx;
    getmaxyx(stdscr, maxy, maxx);

    // determine where top-left corner of board belongs 
    g.top = maxy/2 - 7;
    g.left = maxx/2 - 30;

    // enable color if possible
    if (has_colors())
        attron(COLOR_PAIR(PAIR_GRID));

    // print grid
    for (int i = 0 ; i < 3 ; ++i )
    {
        mvaddstr(g.top + 0 + 4 * i, g.left, "+-------+-------+-------+");
        mvaddstr(g.top + 1 + 4 * i, g.left, "|       |       |       |");
        mvaddstr(g.top + 2 + 4 * i, g.left, "|       |       |       |");
        mvaddstr(g.top + 3 + 4 * i, g.left, "|       |       |       |");
    }
    mvaddstr(g.top + 4 * 3, g.left, "+-------+-------+-------+" );

    // remind user of level and #
    char reminder[maxx+1];
    sprintf(reminder, "   playing %s #%d", g.level, g.number);
    mvaddstr(g.top + 15, g.left + 25 - strlen(reminder), reminder);

    // disable color if possible
    if (has_colors())
        attroff(COLOR_PAIR(PAIR_GRID));
}

/*
 * void
 * draw_borders()
 *
 * Draws game's borders.
 */

void
draw_borders()
{
    // get window's dimensions
    int maxy, maxx;
    getmaxyx(stdscr, maxy, maxx);

    // enable color if possible (else b&w highlighting)
    if (has_colors())
    {
        attron(A_PROTECT);
        attron(COLOR_PAIR(PAIR_BORDER));
    }
    else
        attron(A_REVERSE);

    // draw borders
    for (int i = 0; i < maxx; i++)
    {
        mvaddch(0, i, ' ');
        mvaddch(maxy-1, i, ' ');
    }

    // draw header
    char header[maxx+1];
    sprintf(header, "%s by %s", TITLE, AUTHOR);
    mvaddstr(0, (maxx - strlen(header)) / 2, header);

    // draw footer
    mvaddstr(maxy-1, 1, "[N]ew Game   [R]estart Game");
    mvaddstr(maxy-1, maxx-13, "[Q]uit Game");

    // disable color if possible (else b&w highlighting)
    if (has_colors())
        attroff(COLOR_PAIR(PAIR_BORDER));
    else
        attroff(A_REVERSE);
}

/*
 * void
 * draw_logo()
 *
 * Draws game's logo.  Must be called after draw_grid has been
 * called at least once.
 */

void
draw_logo()
{
    // determine top-left coordinates of logo
    int top = g.top + 2;
    int left = g.left + 30;

    // enable color if possible
    if (has_colors())
        attron(COLOR_PAIR(PAIR_LOGO));

    // draw logo
    mvaddstr(top + 0, left, "               _       _          ");
    mvaddstr(top + 1, left, "              | |     | |         ");
    mvaddstr(top + 2, left, " ___ _   _  __| | ___ | | ___   _ ");
    mvaddstr(top + 3, left, "/ __| | | |/ _` |/ _ \\| |/ / | | |");
    mvaddstr(top + 4, left, "\\__ \\ |_| | (_| | (_) |   <| |_| |");
    mvaddstr(top + 5, left, "|___/\\__,_|\\__,_|\\___/|_|\\_\\\\__,_|");

    // sign logo
    char signature[3+strlen(AUTHOR)+1];
    sprintf(signature, "by %s", AUTHOR);
    mvaddstr(top + 7, left + 35 - strlen(signature) - 1, signature);

    // disable color if possible
    if (has_colors())
        attroff(COLOR_PAIR(PAIR_LOGO));
}

/*
 * void
 * draw_numbers()
 *
 * Draw's game's numbers.  Must be called after draw_grid has been
 * called at least once.
 */

void
draw_numbers()
{  
    // iterate over board's numbers
    for (int i = 0; i < 9; i++)
    {
        for (int j = 0; j < 9; j++)
        {
           // determine char
           char c = (g.board[i][j] == 0) ? '.' : g.board[i][j] + '0';

           if (board[i][j] == g.board[i][j] && g.board[i][j] != 0) 
               // enable color if possible
               if (has_colors())
                  attron(COLOR_PAIR(PAIR_NUMBERS)); // numbers that came with board are in red
            
           mvaddch(g.top + i + 1 + i/3, g.left + 2 + 2*(j + j/3), c);

           if (board[i][j] == g.board[i][j] && g.board[i][j] != 0) 
              // disable color if possible
              if (has_colors())
                  attroff(COLOR_PAIR(PAIR_NUMBERS));

        }
    }  
 }

/*
 * void
 * handle_signal(int signum)
 *
 * Designed to handles signals (e.g., SIGWINCH).
 */

void
handle_signal(int signum)
{
    // handle a change in the window (i.e., a resizing)
    if (signum == SIGWINCH)
        redraw_all();

    // re-register myself so this signal gets handled in future too
    signal(signum, (void (*)(int)) handle_signal);
}

/*
 * void
 * hide_banner()
 *
 * Hides banner.
 */

void
hide_banner()
{
    // get window's dimensions
    int maxy, maxx;
    getmaxyx(stdscr, maxy, maxx);

    // overwrite banner with spaces
    for (int i = 0; i < maxx; i++)
        mvaddch(g.top + 16, i, ' ');
}

/*
 * bool
 * load_board()
 *
 * Loads current board from disk, returning true iff successful.
 */

bool
load_board()
{
    // open file with boards of specified level
    char filename[strlen(g.level) + 5];
    sprintf(filename, "%s.bin", g.level);
    FILE *fp = fopen(filename, "rb");
    if (fp == NULL)
        return false;

    // determine file's size
    fseek(fp, 0, SEEK_END);
    int size = ftell(fp);

    // ensure file is of expected size
    if (size % (81 * sizeof(int)) != 0)
    {
        fclose(fp);
        return false;
    }

    // compute offset of specified board
    int offset = ((g.number - 1) * 81 * sizeof(int));

    // seek to specified board
    fseek(fp, offset, SEEK_SET);

    // read board into memory
    if (fread(g.board, 81 * sizeof(int), 1, fp) != 1)
    {
        fclose(fp);
        return false;
    }

    // w00t
    fclose(fp);
    return true;
}

/*
 * void
 * log_move(int ch)
 *
 * Logs input and board's state to log.txt to facilitate automated tests.
 */

void
log_move(int ch)
{
    // open log
    FILE *fp = fopen("log.txt", "a");
    if (fp == NULL)
        return;

    // log input
    fprintf(fp, "%d\n", ch);

    // log board
    for (int i = 0; i < 9; i++)
    {
        for (int j = 0; j < 9; j++)
            fprintf(fp, "%d", g.board[i][j]);
        fprintf(fp, "\n");
    }

    // that's it
    fclose(fp);
}

/*
 * void
 * redraw_all()
 *
 * (Re)draws everything on the screen.
 */

void
redraw_all()
{
    // reset ncurses
    endwin();
    refresh();

    // clear screen
    clear();

    // re-draw everything
    draw_borders();
    draw_grid();
    draw_logo();
    draw_numbers();

    // show cursor
    show_cursor();
}

/*
 * bool
 * restart_game()
 *
 * (Re)starts current game, returning true iff succesful.
 */

bool
restart_game()
{
    // reload current game
    if (!load_board())
        return false;

    // copy original numbers
    copy_board();    

    // redraw board
    draw_grid();
    draw_numbers();

    // get window's dimensions
    int maxy, maxx;
    getmaxyx(stdscr, maxy, maxx);

    // move cursor to board's center
    g.y = g.x = 4;
    show_cursor();

    // remove log, if any
    remove("log.txt");

    // w00t
    return true;
}

/*
 * void
 * show_cursor()
 *
 * Shows cursor at (g.y, g.x).
 */

void
show_cursor()
{
    // restore cursor's location
    move(g.top + g.y + 1 + g.y/3, g.left + 2 + 2*(g.x + g.x/3));
}

/*
 * void
 * show_banner(char *b)
 *
 * Shows a banner.  Must be called after show_grid has been
 * called at least once.
 */

void
show_banner(char *b)
{
    // enable color if possible
    if (has_colors())
        attron(COLOR_PAIR(PAIR_BANNER));

    // determine where top-left corner of board belongs 
    mvaddstr(g.top + 16, g.left + 64 - strlen(b), b);

    // disable color if possible
    if (has_colors())
        attroff(COLOR_PAIR(PAIR_BANNER));
}

/*
 * void
 * shutdown()
 *
 * Shuts down ncurses.
 */

void
shutdown()
{
    endwin();
}

/*
 * bool
 * startup()
 *
 * Starts up ncurses.
 */

bool
startup()
{
    // initialize ncurses
    if (initscr() == NULL)
        return false;

    // prepare for color if possible
    if (has_colors())
    {
        // enable color
        if (start_color() == ERR || attron(A_PROTECT) == ERR)
        {
            endwin();
            return false;
        }

        // initialize pairs of colors
        if (init_pair(PAIR_BANNER, FG_BANNER, BG_BANNER) == ERR ||
            init_pair(PAIR_GRID, FG_GRID, BG_GRID) == ERR ||
            init_pair(PAIR_BORDER, FG_BORDER, BG_BORDER) == ERR ||
            init_pair(PAIR_LOGO, FG_LOGO, BG_LOGO) == ERR ||
            init_pair(PAIR_NUMBERS, FG_NUMBERS, BG_NUMBERS) == ERR)  // for numbers that came with board

        {
            endwin();
            return false;
        }
    }

    // don't echo keyboard input
    if (noecho() == ERR)
    {
        endwin();
        return false;
    }

    // disable line buffering and certain signals
    if (raw() == ERR)
    {
        endwin();
        return false;
    }

    // enable arrow keys
    if (keypad(stdscr, true) == ERR)
    {
        endwin();
        return false;
    }

    // wait 1000 ms at a time for input
    timeout(1000);

    // w00t
    return true;
}
