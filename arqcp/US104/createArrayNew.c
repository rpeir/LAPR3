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
#include "../US110/sensores.h"
uint64_t state = 0;
uint64_t inc = 0;

unsigned short *createArrayDirVento(unsigned short max, unsigned short min, unsigned int freq, int n)
{
    int count = 0;
    char errorIsReached = 0;
    int size = SECDAY / freq;
    unsigned short *vec = malloc(size * sizeof(short));
    do
    {
        errorIsReached = 0;
        short comp_rand = (short)pcg32_random_r();
        vec[0] = sens_dir_vento(0, comp_rand);
        for (int i = 1; i < size && errorIsReached != 1; i++)
        {
            comp_rand = (short)pcg32_random_r();
            *(vec + i) = sens_dir_vento(*(vec + i - 1), comp_rand);
            char valid = checkValueInRangeUS(max, min, *(vec + i));
            if (valid == 0)
            {
                count++;
            }
            else if (count != 0)
            {
                count = 0;
            }
            if (count == n)
            {
                errorIsReached = 1;
            }
        }
        if (errorIsReached == 1)
        {
            free(vec);
            vec = malloc(size * sizeof(short));
            state = pcg32_random_r();
            inc = pcg32_random_r();
        }
    } while (errorIsReached != 0);
    return vec;
}

unsigned char *createArrayHumAtm(unsigned char max, unsigned char min, unsigned int freq, int n, unsigned char *pluvio)
{
    int count = 0;
    char errorIsReached = 0;
    int size = SECDAY / freq;
    unsigned char *vec = malloc(size * sizeof(char));
    do
    {
        errorIsReached = 0;
        char comp_rand = (unsigned char)pcg32_random_r();
        unsigned ult_pluvio = *(pluvio + 0);
        vec[0] = sens_humd_atm(20, ult_pluvio, comp_rand);
        for (int i = 1; i < size && errorIsReached != 1; i++)
        {
            comp_rand = (unsigned char)pcg32_random_r();
            *(vec + i) = sens_humd_atm(*(vec + i - 1), ult_pluvio, comp_rand);
            ult_pluvio = *(pluvio + i);
            char valid = checkValueInRangeUC(max, min, *(vec + i));
            if (valid == 0)
            {
                count++;
            }
            else if (count != 0)
            {
                count = 0;
            }
            if (count == n)
            {
                errorIsReached = 1;
            }
        }
        if (errorIsReached == 1)
        {
            free(vec);
            vec = malloc(size * sizeof(char));
            state = pcg32_random_r();
            inc = pcg32_random_r();
        }
    } while (errorIsReached != 0);
    return vec;
}

void createSensHumSolo(Sensor *sensor_hum_solo, Sensor* sensor_pluvio, int n)
{
    int isWrong = 0;
    char errorIsReached = 0;

    unsigned char * readings_pluvio =(unsigned char*) sensor_pluvio -> readings;
    unsigned long pluvio_frequency = sensor_pluvio -> frequency;

    unsigned long hum_solo_frequency = sensor_pluvio -> frequency;
    sensor_hum_solo->readings_size = ((SECDAY / hum_solo_frequency));
    free(sensor_hum_solo -> readings);
    unsigned char *readings_hum_solo = (unsigned char*) malloc(sensor_hum_solo->readings_size * sizeof(unsigned char));
    do {
        *(readings_hum_solo) = sens_humd_solo(20, *(readings_hum_solo), (char) pcg32_random_r());
    
        for(int i = 1; i < sensor_hum_solo -> readings_size; i++){
            int frequency = hum_solo_frequency * i / pluvio_frequency;
            
            char ult_pluvio = *(readings_pluvio + frequency);
                
            unsigned char ult_hum_solo = sens_pluvio(*(readings_hum_solo + i - 1), ult_pluvio, (char) pcg32_random_r());
            *(readings_hum_solo + i) = ult_hum_solo;
            
            
            if(!checkValueInRangeUC(sensor_hum_solo->max_limit, sensor_hum_solo->min_limit, *(readings_hum_solo + i))){
                isWrong ++;
                
                if(isWrong == n){
                    errorIsReached == 1;
                }
                
            } else {
                isWrong = 0;
            }
            if (errorIsReached == 1) {
                free(readings_pluvio);
                readings_hum_solo = (unsigned char*) malloc((SECDAY / hum_solo_frequency) * sizeof(unsigned char));
                state = pcg32_random_r();
                inc = pcg32_random_r();
                isWrong = 0;
            }
        }
    } while (errorIsReached != 0);
    sensor_hum_solo->readings = (void*) readings_hum_solo;
}

unsigned char *createArrayHumSolo(unsigned char max, unsigned char min, unsigned int freq, int n, unsigned char *pluvio)
{
    int count = 0;
    char errorIsReached = 0;
    int size = SECDAY / freq;
    unsigned char *vec = malloc(size * sizeof(char));
    do
    {
        errorIsReached = 0;
        char comp_rand = (unsigned char)pcg32_random_r();
        unsigned ult_pluvio = *(pluvio + 0);
        vec[0] = sens_humd_solo(20, ult_pluvio, comp_rand);
        for (int i = 1; i < size && errorIsReached != 1; i++)
        {
            comp_rand = (unsigned char)pcg32_random_r();
            *(vec + i) = sens_humd_solo(*(vec + i - 1), ult_pluvio, comp_rand);
            ult_pluvio = *(pluvio + i);
            char valid = checkValueInRangeUC(max, min, *(vec + i));
            if (valid == 0)
            {
                count++;
            }
            else if (count != 0)
            {
                count = 0;
            }
            if (count == n)
            {
                errorIsReached = 1;
            }
        }
        if (errorIsReached == 1)
        {
            free(vec);
            vec = malloc(size * sizeof(char));
            state = pcg32_random_r();
            inc = pcg32_random_r();
        }
    } while (errorIsReached != 0); 
    return vec;
}

void createSensPluvio(Sensor *sensor_pluvio, Sensor *sensor_temp, int n)
{
    int isWrong = 0;
    char errorIsReached = 0;

    char * readings_temp =(char*) sensor_temp -> readings;
    unsigned long temp_frequency = sensor_temp -> frequency;

    unsigned long pluvio_frequency = sensor_pluvio -> frequency;
    sensor_pluvio->readings_size = ((SECDAY / pluvio_frequency));
    free(sensor_pluvio -> readings);
    unsigned char *readings_pluvio = (unsigned char*) malloc(sensor_pluvio->readings_size * sizeof(unsigned char));
    do {
        *(readings_pluvio) = sens_pluvio(55, *(readings_temp), (char) pcg32_random_r());
    
        for(int i = 1; i < sensor_pluvio -> readings_size; i++){
            int frequency = pluvio_frequency * i / temp_frequency;
            
            char ult_temp = *(readings_temp + frequency);
                
            unsigned char ult_pluvio = sens_pluvio(*(readings_pluvio + i - 1), ult_temp, (char) pcg32_random_r());
            *(readings_pluvio + i) = ult_pluvio;
            
            
            if(!checkValueInRangeUC(sensor_pluvio->max_limit, sensor_pluvio->min_limit, *(readings_pluvio + i))){
                isWrong ++;
                
                if(isWrong == n){
                    errorIsReached == 1;
                }
                
            } else {
                isWrong = 0;
            }
            if (errorIsReached == 1) {
                free(readings_pluvio);
                readings_pluvio = (unsigned char*) malloc((SECDAY / pluvio_frequency) * sizeof(unsigned char));
                state = pcg32_random_r();
                inc = pcg32_random_r();
                isWrong = 0;
            }
        }
    } while (errorIsReached != 0);
    sensor_pluvio->readings = (void*) readings_pluvio;
}

void createSensTemp(Sensor *sensor_temp, int n)
{
    int isWrong = 0;
    char errorIsReached = 0;

    unsigned long temp_frequency = sensor_temp -> frequency;
    free(sensor_temp -> readings);
    sensor_temp->readings_size = (SECDAY / temp_frequency);
    char *readings_temp = (char*) malloc(sensor_temp->readings_size * sizeof(char));
    do {
        *(readings_temp) = sens_temp(15,(char) pcg32_random_r());
    
        for(int i = 1; i < sensor_temp -> readings_size; i++){
            int frequency = sensor_temp -> frequency * i / temp_frequency;
                
            char ult_temp = sens_temp(*(readings_temp + i - 1), (char) pcg32_random_r());
            *(readings_temp + i) = ult_temp;
            
            
            if(!checkValueInRangeChar(sensor_temp->max_limit, sensor_temp->min_limit, *(readings_temp + i))){
                isWrong ++;
                
                if(isWrong == n){
                    errorIsReached == 1;
                }
                
            } else {
                isWrong = 0;
            }
            if (errorIsReached == 1) {
                free(readings_temp);
                readings_temp = (char*) malloc(sensor_temp->readings_size * sizeof(char));
                state = pcg32_random_r();
                inc = pcg32_random_r();
                isWrong = 0;
            }
        }
    } while (errorIsReached != 0);
    sensor_temp -> readings = (void*) readings_temp;
}

void createSensVelVento(Sensor *sensor_vel_vento, int n) 
{
    int isWrong = 0;
    char errorIsReached = 0;

    unsigned long vel_vento_frequency = sensor_vel_vento -> frequency;
    free(sensor_vel_vento -> readings);
    sensor_vel_vento->readings_size = (SECDAY / vel_vento_frequency);
    unsigned char *readings_vel_vento = (unsigned char*) malloc(sensor_vel_vento->readings_size * sizeof(unsigned char));
    do {
        *(readings_vel_vento) = sens_velc_vento(20,(char) pcg32_random_r());
    
        for(int i = 1; i < sensor_vel_vento -> readings_size; i++){
            int frequency = sensor_vel_vento -> frequency * i / vel_vento_frequency;
                
            char ult_vel_vento = sens_velc_vento(*(readings_vel_vento + i - 1), (char) pcg32_random_r());
            *(readings_vel_vento + i) = ult_vel_vento;
            
            
            if(!checkValueInRangeUC(sensor_vel_vento->max_limit, sensor_vel_vento->min_limit, *(readings_vel_vento + i))){
                isWrong ++;
                
                if(isWrong == n){
                    errorIsReached == 1;
                }
                
            } else {
                isWrong = 0;
            }
            if (errorIsReached == 1) {
                free(readings_vel_vento);
                readings_vel_vento = (unsigned char*) malloc(sensor_vel_vento->readings_size * sizeof(unsigned char));
                state = pcg32_random_r();
                inc = pcg32_random_r();
                isWrong = 0;
            }
        }
    } while (errorIsReached != 0);
    sensor_vel_vento -> readings = (void*) readings_vel_vento;
}