#include <stdio.h>


int main (void) {

  int MspottingF, FspottingM, FspottingF, MspottingM, sum, i;
  float fMsF, fFsM, fFsF, fMsM;  

  printf("\n");

  do {

    printf("M spotting F: ");
    scanf("%d", &MspottingF);
  
  } while (MspottingF < 0);

  do {
 
    printf("F spotting M: "); 
    scanf("%d", &FspottingM);

  } while (FspottingM < 0);

  do { 

    printf("F spotting F: "); 
    scanf("%d", &FspottingF);
  
  } while (FspottingF < 0);
 
  do {

    printf("M spotting M: ");
    scanf("%d", &MspottingM);
  
  } while (MspottingM < 0);
 
  sum = MspottingF + FspottingM + FspottingF + MspottingM;
  
  fMsF = ((float)MspottingF / (float)sum) * 80.0;
  fFsM = ((float)FspottingM / (float)sum) * 80.0;
  fFsF = ((float)FspottingF / (float)sum) * 80.0;
  fMsM = ((float)MspottingM / (float)sum) * 80.0;

  printf("\nWho is Spotting Whom\n\n");
  
  printf("M spotting F\n");
  for (i = 0; i < (int)fMsF; i++) printf("#"); printf("\n");
  
  printf("F spotting M\n");
  for (i = 0; i < (int)fFsM; i++) printf("#"); printf("\n");   
  
  printf("F spotting F\n");
  for (i = 0; i < (int)fFsF; i++) printf("#"); printf("\n");  
  
  printf("M spotting M\n");
  for (i = 0; i < (int)fMsM; i++) printf("#"); printf("\n\n");
    
  return 0;
}
