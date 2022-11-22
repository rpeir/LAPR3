#include <stdint.h>

int main(){
uint32_t gen=pcg32_random_r();
char result=checkValueInRangeChar(MAX_TEMP,MIN_TEMP,gen); // Sensor de temp
unsigned char wind=checkValueInRangeUC(MAX_WVEL,MIN_WVEL,gen); //Sensor de velocidade do vento
unsigned short windDir=checkValueInRangeUS(MAX_WINDDEG,MIN_WINDDEG,gen); // sensor direção de vento
unsigned char atmHum=checkValueInRangeUC(MAX_ATMHUM,MIN_ATMHUM,gen); // sensor de humidade atmosferica
unsigned char soloHum=checkValueInRangeUC(MAX_SOILHUM,MIN_SOILHUM,gen); // sensor de humidade de solo
unsigned char pluvio=checkValueInRangeUC(MAX_PLUV,MIN_PLUV,gen); // sensor pluviosidade

}