#include <stdint.h>

char MAX_TEMP=0;
char MIN_TEMP=0;

unsigned char MAX_WVEL=0;
unsigned char MIN_WVEL=0;

unsigned short MAX_WINDDEG=0;
unsigned short MIN_WINDDEG=0;

unsigned char MAX_ATMHUM=0;
unsigned char MIN_ATMHUM=0;

unsigned char MAX_SOILHUM=0;
unsigned char MIN_SOILHUM=0;

unsigned char MAX_PLUV=0;
unsigned char MIN_PLUV=0;
int N = 0;

int main(){
//uint32_t gen=pcg32_random_r();
//char result=checkValueInRangeChar(MAX_TEMP,MIN_TEMP,gen); // Sensor de temp
//unsigned char wind=checkValueInRangeUC(MAX_WVEL,MIN_WVEL,gen); //Sensor de velocidade do vento
//unsigned short windDir=checkValueInRangeUS(MAX_WINDDEG,MIN_WINDDEG,gen); // sensor direção de vento
//unsigned char atmHum=checkValueInRangeUC(MAX_ATMHUM,MIN_ATMHUM,gen); // sensor de humidade atmosferica
//unsigned char soloHum=checkValueInRangeUC(MAX_SOILHUM,MIN_SOILHUM,gen); // sensor de humidade de solo
//unsigned char pluvio=checkValueInRangeUC(MAX_PLUV,MIN_PLUV,gen); // sensor pluviosidade

printf ("insert limite maximo da temperatura: %s\n",MAX_TEMP);
scanf("%s",&MAX_TEMP);
printf ("insert limite minimo da temperatura: %s\n",MIN_TEMP);
scanf("%s",&MIN_TEMP);
printf ("insert limite maximo da velocidade do vento: %s\n",MAX_WVEL);
scanf("%s",&MAX_WVEL);
printf ("insert limite minimo da velocidade do vento: %s\n",MIN_WVEL);
scanf("%s",&MIN_WVEL);
printf ("insert limite maximo da direção do vento: %s\n",MAX_WINDDEG);
scanf("%s",&MAX_WINDDEG);
printf ("insert limite minimo da direção do vento: %s\n",MIN_WINDDEG);
scanf("%s",&MIN_WINDDEG);
printf ("insert limite maximo da humidade atmosferica: %s\n",MAX_ATMHUM);
scanf("%s",&MAX_ATMHUM);
printf ("insert limite minimo da humidade atmosferica: %s\n",MIN_ATMHUM);
scanf("%s",&MIN_ATMHUM);
printf ("insert limite maximo da humidade do solo: %s\n",MAX_SOILHUM);
scanf("%s",&MAX_SOILHUM);
printf ("insert limite minimo da humidade do solo: %s\n",MIN_SOILHUM);
scanf("%s",&MIN_SOILHUM);
printf ("insert limite maximo da pluviosidade: %s\n",MAX_PLUV);
scanf("%s",&MAX_PLUV);
printf ("insert limite minimo da pluviosidade: %s\n",MIN_PLUV);
scanf("%s",&MIN_PLUV);
printf ("insert numero maximo de leituras erradas: %s\n",N);
scanf("%s",&N);

char result=checkValueInRangeTemp(MAX_TEMP,MIN_TEMP);




return 0;

