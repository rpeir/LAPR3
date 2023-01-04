#ifndef CREATE_ARRAY_SENS_H
#define CREATE_ARRAY_SENS_H
#include "../US110/sensores.h"

unsigned short *createArrayDirVento(unsigned short max, unsigned short min, unsigned int freq, int n);

unsigned char *createArrayHumAtm(unsigned char max, unsigned char min, unsigned int freq, int n, unsigned char *pluvio);

unsigned char *createArrayHumSolo(unsigned char max, unsigned char min, unsigned int freq, int n, unsigned char *pluvio);

void fill_sens_pluvio(Sensor *sensor_pluvio, Sensor *sensor_temp, int maxWrongReads);

char *createArrayTemp(char max, char min, unsigned int freq, int n);

unsigned char *createArrayVelVento(unsigned char max, unsigned char min, unsigned int freq, int n);

#endif