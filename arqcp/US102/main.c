#include <stdio.h>
#include <stdint.h> 
#include "sens_temp.h"
#include "sens_velc_vento.h"
#include "sens_dir_vento.h"
#include "sens_humd_atm.h"
#include "sens_humd_solo.h"
#include "sens_pluvio.h"
#include "pcg32_random_r.h"

uint64_t state=2;  
uint64_t inc=2;
int main(){
printf("Sensor de temperatura \n");
char ult_temp = 14;
for(int i = 0; i < 5; i++){
char comp_rand = (char) pcg32_random_r();
char nov_temp = sens_temp(ult_temp,comp_rand);
printf("ult_temp = %d | comp_rand = %d | nov_temp = %d \n", ult_temp, comp_rand, nov_temp);
ult_temp = nov_temp;
}

printf("=================================== \nSensor de velocidade do vento \n");
char ult_velc_vento = 14;
for(int i = 0; i < 5; i++){
char comp_rand = (char) pcg32_random_r();
char nov_velc_vento = sens_velc_vento(ult_velc_vento,comp_rand);
printf("ult_velc_vento = %d | comp_rand = %d | nov_velc_vento = %d \n", ult_velc_vento, comp_rand, nov_velc_vento);
ult_velc_vento = nov_velc_vento;
}

printf("=================================== \nSensor de direcao do vento \n");
unsigned short ult_dir_vento = 14;
for(int i = 0; i < 5; i++){
short comp_rand = (short) pcg32_random_r();
unsigned short nov_dir_vento = sens_dir_vento(ult_dir_vento, comp_rand);
printf("ult_dir_vento = %d | comp_rand = %d | nov_dir_vento = %d \n", ult_dir_vento, comp_rand, nov_dir_vento);
ult_dir_vento = nov_dir_vento;
}

printf("=================================== \nSensor de humidade atmosférica \n");
unsigned char ult_hmd_atm = 14;
unsigned char ult_pluvio = 0;
for(int i = 0; i < 5; i++){
char comp_rand = (char) pcg32_random_r();
unsigned char nov_hmd_atm = sens_humd_atm(ult_hmd_atm, ult_pluvio, comp_rand);
printf("ult_hmd_atm = %d | comp_rand = %d | nov_hmd_atm = %d \n", ult_hmd_atm, comp_rand, nov_hmd_atm);
ult_hmd_atm = nov_hmd_atm;
}

printf("=================================== \nSensor de humidade do solo \n");
unsigned char ult_hmd_solo = 14;
ult_pluvio = 0;
for(int i = 0; i < 5; i++){
char comp_rand = (char) pcg32_random_r();
unsigned char nov_hmd_solo = sens_humd_solo(ult_hmd_solo, ult_pluvio, comp_rand);
printf("ult_hmd_solo = %d | comp_rand = %d | nov_hmd_solo = %d \n", ult_hmd_solo, comp_rand, nov_hmd_solo);
ult_hmd_solo = nov_hmd_solo;
}

printf("=================================== \nSensor de luviosidade \n");
ult_temp = 14;
ult_pluvio = 0;
for(int i = 0; i < 5; i++){
char comp_rand = (char) pcg32_random_r();
unsigned char nov_pluvio = sens_pluvio(ult_hmd_solo, ult_temp, comp_rand);
printf("ult_pluvio = %d | comp_rand = %d | nov_hmd_solo = %d \n", ult_pluvio, comp_rand, nov_pluvio);
ult_pluvio = nov_pluvio;
}
return 0;
}
