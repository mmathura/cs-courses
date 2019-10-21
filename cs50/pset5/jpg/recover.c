#include <stdio.h> 
#include <stdint.h>
#include <stdlib.h>

/* constants for block size (512 B) and file name length (8 chars) */

#define BLOCK_SIZE 512
#define FILE_NAME_LEN 8

/* defines uint to 'byte' */

typedef uint8_t BYTE;


int main(void) {

   /* open a raw file */

   FILE *fp2, *fp = fopen("card.raw", "r");

   /* should exit program exit(1) if raw file doesn't exist */

   /* if (fp == NULL) { perror("card.raw does not exit\n"); exit(1); } */

   /* create a buffer */

   BYTE* buf = malloc(sizeof(BYTE) * BLOCK_SIZE);

   /* file names are 7 chars in length + null terminator e.g. ###.jpg */

   char sfilename[FILE_NAME_LEN];

   /* for file count; flag is set */

   int i = 1, flag = 1;
   
   while(!feof(fp)) { /* loop until end of file */

      /* skips over the slack space in the raw file */ 

      if (flag) 
         fread(buf, sizeof(BYTE) * BLOCK_SIZE, 1, fp);  

      /* finds a signature for a jpg in the first four bytes */
         
      if ((buf[0] == 0xff && buf[1] == 0xd8 && buf[2] == 0xff) && 
          (buf[3] == 0xe0 || buf[3] == 0xe1)) {

         /* create new file names;   
            for files 0 - 9 use two leading zeros otherwise use one for 10+ */

         /* if index i is greater than 50 break loop -- if (i > 50) break;  */
 
         if (i < 10) 
            sprintf(sfilename, "%s%d%s", "00", i++, ".jpg");
         else 
            sprintf(sfilename, "%s%d%s", "0", i++, ".jpg");

         fp2 = fopen(sfilename, "w");

         /* if jpeg signature detected start copying bytes */

         while(1) {

           if (feof(fp)) 
               break; /* exit -- reached EOF */

           fwrite(buf, sizeof(BYTE) * BLOCK_SIZE, 1, fp2);
           
           fread(buf, sizeof(BYTE) * BLOCK_SIZE, 1, fp);

           /* if jpeg signature is encountered close file and exit loop */

           if ((buf[0] == 0xff && buf[1] == 0xd8 && buf[2] == 0xff) && 
               (buf[3] == 0xe0 || buf[3] == 0xe1)) {
              fclose(fp2); 
              flag = 0; /* clear flag */
              break;
           } 
        } 
      } 
    }
    
    /* closes in and output files */
    
    fclose(fp2);    
    fclose(fp);

    /* frees allocated memory and closes off pointer to
       avoid memory leaks */

    free(buf);
    buf = NULL;
 
   return 0;
}
