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

void fill_sens_dir_vento(Sensor *sensor_dir_vento, int n)
{
    int count_wrong = 0;
    char maxErrorReached = 0;

    unsigned long dir_vento_frequency = sensor_dir_vento -> frequency;
    free(sensor_dir_vento -> readings);
    sensor_dir_vento->readings_size = (SECDAY / dir_vento_frequency);
    unsigned short *readings_dir_vento = (char*) malloc(sensor_dir_vento->readings_size * sizeof(unsigned short));
    do {
        maxErrorReached = 0;
        *(readings_dir_vento) = sens_dir_vento(0,(char) pcg32_random_r());
    
        //Sensor Direcao do Vento
        for(int i = 1; i < sensor_dir_vento -> readings_size; i++){
            char ult_dir_vento = sens_dir_vento(*(readings_dir_vento + i - 1), (char) pcg32_random_r());
            *(readings_dir_vento + i) = ult_dir_vento;
            
            
            //Leituras erradas sensor da Temperatura
            if(!checkValueInRangeUS(sensor_dir_vento->max_limit, sensor_dir_vento->min_limit, *(readings_dir_vento + i))){
                count_wrong ++;
                
                if(count_wrong == n){
                    maxErrorReached == 1;
                }
                
            } else {
                count_wrong = 0;
            }
            if (maxErrorReached == 1) {
                free(readings_dir_vento);
                readings_dir_vento = (unsigned short*) malloc(sensor_dir_vento->readings_size * sizeof(unsigned short));
                state = pcg32_random_r();
                inc = pcg32_random_r();
                count_wrong = 0;
            }
        }
    } while (maxErrorReached != 0);
    sensor_dir_vento -> readings = (void*) readings_dir_vento;
}

void fill_sens_hum_atm(Sensor *sensor_hum_atm, Sensor* sensor_pluvio, int n)
{
    int count_wrong = 0;
    char maxErrorReached = 0;

    //A Pluviosidade influencia a Humidade Atmosferica
    unsigned char * readings_pluvio =(unsigned char*) sensor_pluvio -> readings;
    unsigned long pluvio_frequency = sensor_pluvio -> frequency;

    unsigned long hum_atm_frequency = sensor_hum_atm -> frequency;
    sensor_hum_atm->readings_size = ((SECDAY / hum_atm_frequency));
    free(sensor_hum_atm -> readings);
    unsigned char *readings_hum_atm = (unsigned char*) malloc(sensor_hum_atm->readings_size * sizeof(unsigned char));
    do {
        maxErrorReached = 0;
        *(readings_hum_atm) = sens_humd_atm(20, *(readings_hum_atm), (char) pcg32_random_r());
    
        //Sensor Humidade Atmosferica
        for(int i = 1; i < sensor_hum_atm -> readings_size; i++){
            int frequency = hum_atm_frequency * i / pluvio_frequency;
            
            char ult_pluvio = *(readings_pluvio + frequency);
                
            unsigned char ult_hum_atm = sens_humd_atm(*(readings_hum_atm + i - 1), ult_pluvio, (char) pcg32_random_r());
            *(readings_hum_atm + i) = ult_hum_atm;
            
            
            //Leituras erradas sensor da Humidade Atmosferica
            if(!checkValueInRangeUC(sensor_hum_atm->max_limit, sensor_hum_atm->min_limit, *(readings_hum_atm + i))){
                count_wrong ++;
                
                if(count_wrong == n){
                    maxErrorReached == 1;
                }
                
            } else {
                count_wrong = 0;
            }
            if (maxErrorReached == 1) {
                free(readings_hum_atm);
                readings_hum_atm = (unsigned char*) malloc(sensor_hum_atm->readings_size * sizeof(unsigned char));
                state = pcg32_random_r();
                inc = pcg32_random_r();
                count_wrong = 0;
            }
        }
    } while (maxErrorReached != 0);
    sensor_hum_atm->readings = (void*) readings_hum_atm;
}

void fill_sens_hum_solo(Sensor *sensor_hum_solo, Sensor* sensor_pluvio, int n)
{
    int count_wrong = 0;
    char maxErrorReached = 0;

    //A Pluviosidade influencia a Humidade do Solo
    unsigned char * readings_pluvio =(unsigned char*) sensor_pluvio -> readings;
    unsigned long pluvio_frequency = sensor_pluvio -> frequency;

    unsigned long hum_solo_frequency = sensor_hum_solo -> frequency;
    sensor_hum_solo->readings_size = ((SECDAY / hum_solo_frequency));
    free(sensor_hum_solo -> readings);
    unsigned char *readings_hum_solo = (unsigned char*) malloc(sensor_hum_solo->readings_size * sizeof(unsigned char));
    do {
        maxErrorReached = 0;
        *(readings_hum_solo) = sens_humd_solo(20, *(readings_hum_solo), (char) pcg32_random_r());
    
        //Sensor Humidade do Solo
        for(int i = 1; i < sensor_hum_solo -> readings_size; i++){
            int frequency = hum_solo_frequency * i / pluvio_frequency;
            
            char ult_pluvio = *(readings_pluvio + frequency);
                
            unsigned char ult_hum_solo = sens_humd_solo(*(readings_hum_solo + i - 1), ult_pluvio, (char) pcg32_random_r());
            *(readings_hum_solo + i) = ult_hum_solo;
            
            
            //Leituras erradas sensor da Humidade do Solo
            if(!checkValueInRangeUC(sensor_hum_solo->max_limit, sensor_hum_solo->min_limit, *(readings_hum_solo + i))){
                count_wrong ++;
                
                if(count_wrong == n){
                    maxErrorReached == 1;
                }
                
            } else {
                count_wrong = 0;
            }
            if (maxErrorReached == 1) {
                free(readings_hum_solo);
                readings_hum_solo = (unsigned char*) malloc(sensor_hum_solo->readings_size * sizeof(unsigned char));
                state = pcg32_random_r();
                inc = pcg32_random_r();
                count_wrong = 0;
            }
        }
    } while (maxErrorReached != 0);
    sensor_hum_solo->readings = (void*) readings_hum_solo;
}

void fill_sens_pluvio(Sensor *sensor_pluvio, Sensor *sensor_temp, int n)
{
    int count_wrong = 0;
    char maxErrorReached = 0;

    //A Temperatura influencia a Pluviosidade
    char * readings_temp =(char*) sensor_temp -> readings;
    unsigned long temp_frequency = sensor_temp -> frequency;

    unsigned long pluvio_frequency = sensor_pluvio -> frequency;
    sensor_pluvio->readings_size = ((SECDAY / pluvio_frequency));
    free(sensor_pluvio -> readings);
    unsigned char *readings_pluvio = (unsigned char*) malloc(sensor_pluvio->readings_size * sizeof(unsigned char));
    do {
        maxErrorReached = 0;
        *(readings_pluvio) = sens_pluvio(55, *(readings_temp), (char) pcg32_random_r());
    
        //Sensor Pluviosidade
        for(int i = 1; i < sensor_pluvio -> readings_size; i++){
            int frequency = pluvio_frequency * i / temp_frequency;
            
            char ult_temp = *(readings_temp + frequency);
                
            unsigned char ult_pluvio = sens_pluvio(*(readings_pluvio + i - 1), ult_temp, (char) pcg32_random_r());
            *(readings_pluvio + i) = ult_pluvio;
            
            
            //Leituras erradas sensor da Pluviosidade
            if(!checkValueInRangeUC(sensor_pluvio->max_limit, sensor_pluvio->min_limit, *(readings_pluvio + i))){
                count_wrong ++;
                
                if(count_wrong == n){
                    maxErrorReached == 1;
                }
                
            } else {
                count_wrong = 0;
            }
            if (maxErrorReached == 1) {
                free(readings_pluvio);
                readings_pluvio = (unsigned char*) malloc(sensor_pluvio->readings_size * sizeof(unsigned char));
                state = pcg32_random_r();
                inc = pcg32_random_r();
                count_wrong = 0;
            }
        }
    } while (maxErrorReached != 0);
    sensor_pluvio->readings = (void*) readings_pluvio;
}

void fill_sens_temp(Sensor *sensor_temp, int n)
{
    int count_wrong = 0;
    char maxErrorReached = 0;

    unsigned long temp_frequency = sensor_temp -> frequency;
    free(sensor_temp -> readings);
    sensor_temp->readings_size = (SECDAY / temp_frequency);
    char *readings_temp = (char*) malloc(sensor_temp->readings_size * sizeof(char));
    do {
        maxErrorReached = 0;
        *(readings_temp) = sens_temp(15,(char) pcg32_random_r());
    
        //Sensor Temperatura
        for(int i = 1; i < sensor_temp -> readings_size; i++){    
            char ult_temp = sens_temp(*(readings_temp + i - 1), (char) pcg32_random_r());
            *(readings_temp + i) = ult_temp;
            
            
            //Leituras erradas sensor da Temperatura
            if(!checkValueInRangeChar(sensor_temp->max_limit, sensor_temp->min_limit, *(readings_temp + i))){
                count_wrong ++;
                
                if(count_wrong == n){
                    maxErrorReached == 1;
                }
                
            } else {
                count_wrong = 0;
            }
            if (maxErrorReached == 1) {
                free(readings_temp);
                readings_temp = (char*) malloc(sensor_temp->readings_size * sizeof(char));
                state = pcg32_random_r();
                inc = pcg32_random_r();
                count_wrong = 0;
            }
        }
    } while (maxErrorReached != 0);
    sensor_temp -> readings = (void*) readings_temp;
}

void fill_sens_vel_vento(Sensor *sensor_vel_vento, int n)
{
    int count_wrong = 0;
    char maxErrorReached = 0;

    unsigned long vel_vento_frequency = sensor_vel_vento -> frequency;
    free(sensor_vel_vento -> readings);
    sensor_vel_vento->readings_size = (SECDAY / vel_vento_frequency);
    unsigned char *readings_vel_vento = (unsigned char*) malloc(sensor_vel_vento->readings_size * sizeof(unsigned char));
    do {
        maxErrorReached = 0;
        *(readings_vel_vento) = sens_velc_vento(20,(char) pcg32_random_r());
    
        //Sensor Velocidade Vento
        for(int i = 1; i < sensor_vel_vento -> readings_size; i++){
            int frequency = sensor_vel_vento -> frequency * i / vel_vento_frequency;
                
            char ult_vel_vento = sens_velc_vento(*(readings_vel_vento + i - 1), (char) pcg32_random_r());
            *(readings_vel_vento + i) = ult_vel_vento;
            
            
            //Leituras erradas sensor da velocidade do vento
            if(!checkValueInRangeUC(sensor_vel_vento->max_limit, sensor_vel_vento->min_limit, *(readings_vel_vento + i))){
                count_wrong ++;
                
                if(count_wrong == n){
                    maxErrorReached == 1;
                }
                
            } else {
                count_wrong = 0;
            }
            if (maxErrorReached == 1) {
                free(readings_vel_vento);
                readings_vel_vento = (unsigned char*) malloc(sensor_vel_vento->readings_size * sizeof(unsigned char));
                state = pcg32_random_r();
                inc = pcg32_random_r();
                count_wrong = 0;
            }
        }
    } while (maxErrorReached != 0);
    sensor_vel_vento -> readings = (void*) readings_vel_vento;
}