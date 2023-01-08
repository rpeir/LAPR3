#define SECDAY 86400
#include <stdlib.h>
#include "checkValueInRange.h"
#include <stdint.h>
#include "../US101/pcg32_random_r.h"
#include <stdio.h>
#include "../US102/sens_dir_vento.h"
#include "../US102/sens_humd_atm.h"
#include "../US102/sens_humd_solo.h"
#include "../US102/sens_pluvio.h"
#include "../US102/sens_temp.h"
#include "../US102/sens_velc_vento.h"
#include "../mainS2/sensores.h"
uint64_t state = 0;
uint64_t inc = 0;

void createArrayDirVento(Sensor *sensor_dir_vento, int n)
{
    int isWrong = 0;
    short errorIsReached = 0;

    unsigned long dir_vento_frequency = sensor_dir_vento -> frequency;
    free(sensor_dir_vento -> readings);
    sensor_dir_vento->readings_size = (SECDAY / dir_vento_frequency);
    unsigned short *readings_dir_vento = (unsigned short*) malloc(sensor_dir_vento->readings_size * sizeof(unsigned short));
    do {
        errorIsReached = 0;
        *(readings_dir_vento) = sens_dir_vento(0,(short) pcg32_random_r());
    
        for(int i = 1; i < sensor_dir_vento -> readings_size; i++){
            short ult_dir_vento = sens_dir_vento(*(readings_dir_vento + i - 1), (short) pcg32_random_r());
            *(readings_dir_vento + i) = ult_dir_vento;
            
            
            if(!checkValueInRangeUS(sensor_dir_vento->max_limit, sensor_dir_vento->min_limit, *(readings_dir_vento + i))){
                isWrong ++;
                
                if(isWrong == n){
                    errorIsReached = 1;
                }
                
            } else {
                isWrong = 0;
            }
            if (errorIsReached == 1) {
                free(readings_dir_vento);
                readings_dir_vento = (unsigned short*) malloc(sensor_dir_vento->readings_size * sizeof(unsigned short));
                state = pcg32_random_r();
                inc = pcg32_random_r();
                isWrong = 0;
            }
        }
    } while (errorIsReached != 0);
    sensor_dir_vento -> readings = (void*) readings_dir_vento;
}

void createArrayHumAtm(Sensor *sensor_hum_atm, Sensor* sensor_pluvio, int n)
{
    int isWrong = 0;
    short errorIsReached = 0;

    unsigned short * readings_pluvio =(unsigned short*) sensor_pluvio -> readings;
    unsigned long pluvio_frequency = sensor_pluvio -> frequency;

    unsigned long hum_atm_frequency = sensor_hum_atm -> frequency;
    sensor_hum_atm->readings_size = ((SECDAY / hum_atm_frequency));
    free(sensor_hum_atm -> readings);
    unsigned short *readings_hum_atm = (unsigned short*) malloc(sensor_hum_atm->readings_size * sizeof(unsigned short));
    do {
        errorIsReached = 0;
        *(readings_hum_atm) = sens_humd_atm(20, *(readings_hum_atm), (short) pcg32_random_r());
    
        for(int i = 1; i < sensor_hum_atm -> readings_size; i++){
            int frequency = hum_atm_frequency * i / pluvio_frequency;
            
            short ult_pluvio = *(readings_pluvio + frequency);
                
            unsigned short ult_hum_atm = sens_humd_atm(*(readings_hum_atm + i - 1), ult_pluvio, (short) pcg32_random_r());
            *(readings_hum_atm + i) = ult_hum_atm;
            
            
            if(!checkValueInRangeUC(sensor_hum_atm->max_limit, sensor_hum_atm->min_limit, *(readings_hum_atm + i))){
                isWrong ++;
                
                if(isWrong == n){
                    errorIsReached = 1;
                }
                
            } else {
                isWrong = 0;
            }
            if (errorIsReached == 1) {
                free(readings_hum_atm);
                readings_hum_atm = (unsigned short*) malloc(sensor_hum_atm->readings_size * sizeof(unsigned short));
                state = pcg32_random_r();
                inc = pcg32_random_r();
                isWrong = 0;
            }
        }
    } while (errorIsReached != 0);
    sensor_hum_atm->readings = (void*) readings_hum_atm;
}

void createArrayHumSolo(Sensor *sensor_hum_solo, Sensor* sensor_pluvio, int n)
{
    int isWrong = 0;
    short errorIsReached = 0;

    unsigned short * readings_pluvio =(unsigned short*) sensor_pluvio -> readings;
    unsigned long pluvio_frequency = sensor_pluvio -> frequency;

    unsigned long hum_solo_frequency = sensor_hum_solo -> frequency;
    sensor_hum_solo->readings_size = ((SECDAY / hum_solo_frequency));
    free(sensor_hum_solo -> readings);
    unsigned short *readings_hum_solo = (unsigned short*) malloc(sensor_hum_solo->readings_size * sizeof(unsigned short));
    do {
        errorIsReached = 0;
        *(readings_hum_solo) = sens_humd_solo(20, *(readings_hum_solo), (short) pcg32_random_r());
    
        for(int i = 1; i < sensor_hum_solo -> readings_size; i++){
            int frequency = hum_solo_frequency * i / pluvio_frequency;
            
            short ult_pluvio = *(readings_pluvio + frequency);
                
            unsigned short ult_hum_solo = sens_humd_solo(*(readings_hum_solo + i - 1), ult_pluvio, (short) pcg32_random_r());
            *(readings_hum_solo + i) = ult_hum_solo;
            
            
            if(!checkValueInRangeUC(sensor_hum_solo->max_limit, sensor_hum_solo->min_limit, *(readings_hum_solo + i))){
                isWrong ++;
                
                if(isWrong == n){
                    errorIsReached = 1;
                }
                
            } else {
                isWrong = 0;
            }
            if (errorIsReached == 1) {
                free(readings_hum_solo);
                readings_hum_solo = (unsigned short*) malloc(sensor_hum_solo->readings_size * sizeof(unsigned short));
                state = pcg32_random_r();
                inc = pcg32_random_r();
                isWrong = 0;
            }
        }
    } while (errorIsReached != 0);
    sensor_hum_solo->readings = (void*) readings_hum_solo;
}

void createArrayPluvio(Sensor *sensor_pluvio, Sensor *sensor_temp, int n)
{
    int isWrong = 0;
    short errorIsReached = 0;

    short * readings_temp =(short*) sensor_temp -> readings;
    unsigned long temp_frequency = sensor_temp -> frequency;

    unsigned long pluvio_frequency = sensor_pluvio -> frequency;
    sensor_pluvio->readings_size = ((SECDAY / pluvio_frequency));
    free(sensor_pluvio -> readings);
    unsigned short *readings_pluvio = (unsigned short*) malloc(sensor_pluvio->readings_size * sizeof(unsigned short));
    do {
        errorIsReached = 0;
        *(readings_pluvio) = sens_pluvio(55, *(readings_temp), (short) pcg32_random_r());
    
        for(int i = 1; i < sensor_pluvio -> readings_size; i++){
            int frequency = pluvio_frequency * i / temp_frequency;
            
            short ult_temp = *(readings_temp + frequency);
                
            unsigned short ult_pluvio = sens_pluvio(*(readings_pluvio + i - 1), ult_temp, (short) pcg32_random_r());
            *(readings_pluvio + i) = ult_pluvio;
            
            
            if(!checkValueInRangeUC(sensor_pluvio->max_limit, sensor_pluvio->min_limit, *(readings_pluvio + i))){
                isWrong ++;
                
                if(isWrong == n){
                    errorIsReached = 1;
                }
                
            } else {
                isWrong = 0;
            }
            if (errorIsReached == 1) {
                free(readings_pluvio);
                readings_pluvio = (unsigned short*) malloc(sensor_pluvio->readings_size * sizeof(unsigned short));
                state = pcg32_random_r();
                inc = pcg32_random_r();
                isWrong = 0;
            }
        }
    } while (errorIsReached != 0);
    sensor_pluvio->readings = (void*) readings_pluvio;
}

void createArrayTemp(Sensor *sensor_temp, int n)
{
    int isWrong = 0;
    short errorIsReached = 0;

    unsigned long temp_frequency = sensor_temp -> frequency;
    free(sensor_temp -> readings);
    sensor_temp->readings_size = (SECDAY / temp_frequency);
    short *readings_temp = (short*) malloc(sensor_temp->readings_size * sizeof(short));
    do {
        errorIsReached = 0;
        *(readings_temp) = sens_temp(15,(short) pcg32_random_r());
    
        for(int i = 1; i < sensor_temp -> readings_size; i++){    
            short ult_temp = sens_temp(*(readings_temp + i - 1), (short) pcg32_random_r());
            *(readings_temp + i) = ult_temp;
            
            
            if(!checkValueInRangeChar(sensor_temp->max_limit, sensor_temp->min_limit, *(readings_temp + i))){
                isWrong ++;
                
                if(isWrong == n){
                    errorIsReached = 1;
                }
                
            } else {
                isWrong = 0;
            }
            if (errorIsReached == 1) {
                free(readings_temp);
                readings_temp = (short*) malloc(sensor_temp->readings_size * sizeof(short));
                state = pcg32_random_r();
                inc = pcg32_random_r();
                isWrong = 0;
            }
        }
    } while (errorIsReached != 0);
    sensor_temp -> readings = (void*) readings_temp;
}

void createArrayVelVento(Sensor *sensor_vel_vento, int n)
{
    int isWrong = 0;
    short errorIsReached = 0;

    unsigned long vel_vento_frequency = sensor_vel_vento -> frequency;
    free(sensor_vel_vento -> readings);
    sensor_vel_vento->readings_size = (SECDAY / vel_vento_frequency);
    unsigned short *readings_vel_vento = (unsigned short*) malloc(sensor_vel_vento->readings_size * sizeof(unsigned short));
    do {
        errorIsReached = 0;
        *(readings_vel_vento) = sens_velc_vento(20,(short) pcg32_random_r());
    
        for(int i = 1; i < sensor_vel_vento -> readings_size; i++){
                
            short ult_vel_vento = sens_velc_vento(*(readings_vel_vento + i - 1), (short) pcg32_random_r());
            *(readings_vel_vento + i) = ult_vel_vento;
            
            
            if(!checkValueInRangeUC(sensor_vel_vento->max_limit, sensor_vel_vento->min_limit, *(readings_vel_vento + i))){
                isWrong ++;
                
                if(isWrong == n){
                    errorIsReached = 1;
                }
                
            } else {
                isWrong = 0;
            }
            if (errorIsReached == 1) {
                free(readings_vel_vento);
                readings_vel_vento = (unsigned short*) malloc(sensor_vel_vento->readings_size * sizeof(unsigned short));
                state = pcg32_random_r();
                inc = pcg32_random_r();
                isWrong = 0;
            }
        }
    } while (errorIsReached != 0);
    sensor_vel_vento -> readings = (void*) readings_vel_vento;
}