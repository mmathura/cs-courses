/****************************************************************************
 * resize.c
 *
 * Computer Science 50
 * Problem Set 5
 *
 * Copies a BMP piece by piece, just because and resizes it by a factor of n
 ***************************************************************************/
       
#include <stdio.h>
#include <stdlib.h>

#include "bmp.h"


int
main(int argc, char *argv[])
{
    // ensure proper usage
    if (argc != 4)
    {
        printf("Usage: resize n infile outfile\n");
        return 1;
    }

    int n = atoi(argv[1]);

    // make sure that n is in range 
    if (n > 100 || n < 0)
       return 5;

    // remember filenames
    char *infile = argv[2];
    char *outfile = argv[3];

    // open input file 
    FILE *inptr = fopen(infile, "r");
    if (inptr == NULL)
    {
        printf("Could not open %s.\n", infile);
        return 2;
    }

    // open output file
    FILE *outptr = fopen(outfile, "w");
    if (outptr == NULL)
    {
        fclose(inptr);
        fprintf(stderr, "Could not create %s.\n", outfile);
        return 3;
    }

    // read infile's BITMAPFILEHEADER
    BITMAPFILEHEADER bf, bf2;
    fread(&bf, sizeof(BITMAPFILEHEADER), 1, inptr);

    // read infile's BITMAPINFOHEADER
    BITMAPINFOHEADER bi, bi2;
    fread(&bi, sizeof(BITMAPINFOHEADER), 1, inptr);

    // ensure infile is (likely) a 24-bit uncompressed BMP 4.0
    if (bf.bfType != 0x4d42 || bf.bfOffBits != 54 || bi.biSize != 40 || 
        bi.biBitCount != 24 || bi.biCompression != 0)
    {
        fclose(outptr);
        fclose(inptr);
        fprintf(stderr, "Unsupported file format.\n");
        return 4;
    }

    // copy fields of file and info headers 
    bf2 = bf;
    bi2 = bi;

    // set fields in new structures
    bi2.biWidth = bi.biWidth * n;
    bi2.biHeight = bi.biHeight * n; // saved as negative value
    bf2.bfSize = bf2.bfOffBits + (bi2.biWidth  * abs(bi2.biHeight) * 3);
    bi2.biSizeImage = bf2.bfSize - bf2.bfOffBits;
    
    // write outfile's BITMAPFILEHEADER
    fwrite(&bf2, sizeof(BITMAPFILEHEADER), 1, outptr);

    // write outfile's BITMAPINFOHEADER
    fwrite(&bi2, sizeof(BITMAPINFOHEADER), 1, outptr);

    // determine padding for scanlines
    int padding  =  (4 - (bi.biWidth * sizeof(RGBTRIPLE))  % 4) % 4;
    int padding2 =  (4 - (bi2.biWidth * sizeof(RGBTRIPLE)) % 4) % 4;

    // create temp buffer for row of pixels 
    RGBTRIPLE* buf = malloc(sizeof(RGBTRIPLE) * bi2.biWidth);

    // for debugging
    
    /* printf("N = %d W = %d H = %d Size = %dB  ImgSize = %dB Padding = %d\n",
           n,
           bi2.biWidth, 
           bi2.biHeight,    
           bf2.bfSize, 
           bi2.biSizeImage,
           padding2); */

    // iterate over infile's scanlines
    for (int i = 0, biHeight = abs(bi.biHeight); i < biHeight; i++) { 

        int l = 0; // keeps count of index in buf[]

        // iterate over pixels in scanline
        for (int j = 0; j < bi.biWidth; j++) {

            // temporary storage
            RGBTRIPLE triple;

            // read RGB triple from infile
            fread(&triple, sizeof(RGBTRIPLE), 1, inptr);

            // copy triple n times to buffer 
            for (int m = 0; m < n; m++) {
              if (l < bi2.biWidth) 
                  buf[l++] = triple;  
            }
            
        }
        
        // skip over padding, if any
        fseek(inptr, padding, SEEK_CUR);   

        // write RGB triple to outfile n times
        for (int o = 0; o < n; o++)  {            
  
           fwrite(buf, sizeof(RGBTRIPLE) * bi2.biWidth, 1, outptr); 
  
           // write new padding to outfile
           for (int k = 0; k < padding2; k++)
              fputc(0x00, outptr);      
        }
          
    }

    // close off buf 
    free(buf); 
    buf = NULL;  
      
    // close infile
    fclose(inptr);

    // close outfile
    fclose(outptr);

    // that's all folks
    return 0;
}
