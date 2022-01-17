#include <stdio.h>
#include <stdlib.h>

#define DEBUG 1 

int main(int argc, char *argv[]) {
   int	             PileInts[1024];
   // This allows you to access the pixels (individual bytes)
   // as byte array accesses (e.g., Pile[25] gives pixel 25):
   char *Pile = (char *)PileInts;

   int	             NumInts, ColorToFind=0;
   int               UpperLeft=0, LowerRight=0;
   int  Load_Mem(char *, int *);

   if (argc != 3) {
     printf("usage: ./P1-1 testcase_file color_code\n");
     exit(1);
   }
   ColorToFind = atoi(argv[2]);
   NumInts = Load_Mem(argv[1], PileInts);
   if (NumInts != 1024) {
      printf("valuefiles must contain 1024 entries\n");
      exit(1);
   }

   if (DEBUG){
     printf("Pile[0] is Pixel 0: 0x%02x\n", Pile[0]);
     printf("Pile[107] is Pixel 107: 0x%02x\n", Pile[107]);
   }

    int maxy = 4095; 
    int miny = 0;
    int minx = 63; 
    int maxx = 0;
    int arraycolor;

   for (int r = 0 ; r < 64; r++) {
     for (int c = 0; c < 64; c++) {

        int i = r * 64 + c;
        arraycolor = Pile[i];

        if (arraycolor == ColorToFind && (i < maxy)) {
          maxy = i;
        }
        if (arraycolor == ColorToFind && (i > miny)) {
          miny = i;
        }  
     }  
   }
    
    printf("Maximum Y: %d,\n", maxy);
    printf("Minimum Y: %d,\n", miny);

    for (int r = 0 ; r < 64; r++) {
     for (int c = 0 ; c < 64; c++) {

        int i = r * 64 + c;
        arraycolor = Pile[i];

        if (arraycolor == ColorToFind) {
          int rem = i % 64;
          if (rem <= minx){
            minx = rem;
          }
          if (rem >= maxx){
            maxx = rem;
          }
        }
        
     }
   }
    
    printf("Maximum X: %d,\n", maxx);
    printf("Minimum X: %d,\n", minx);

    int upperleftoffset = maxy % 64;
    int bottomrightoffset = miny % 64;

    printf("Column of maxy: %d,\n", upperleftoffset);
    printf("Column of miny: %d,\n", bottomrightoffset);

    UpperLeft = (maxy - (upperleftoffset - minx));
    LowerRight = (miny + (maxx - bottomrightoffset));

   printf("The part is located at: %d, %d, color: %d\n",
	  UpperLeft, LowerRight, ColorToFind);
   exit(0);
}

/* This routine loads in up to 1024 newline delimited integers from
a named file in the local directory. The values are placed in the
passed integer array. The number of input integers is returned. */

int Load_Mem(char *InputFileName, int IntArray[]) {
   int	N, Addr, Value, NumVals;
   FILE	*FP;

   FP = fopen(InputFileName, "r");
   if (FP == NULL) {
      printf("%s could not be opened; check the filename\n", InputFileName);
      return 0;
   } else {
      for (N=0; N < 1024; N++) {
         NumVals = fscanf(FP, "%d: %d", &Addr, &Value);
         if (NumVals == 2)
            IntArray[N] = Value;
         else
            break;
      }
      fclose(FP);
      return N;
   }
}
