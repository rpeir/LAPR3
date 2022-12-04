#ifndef CREATE_ARRAY_SENS_H
#define CREATE_ARRAY_SENS_H

unsigned short *createArrayDirVento(unsigned short max, unsigned short min, unsigned int freq, int n);

unsigned char *createArrayHumAtm(unsigned char max, unsigned char min, unsigned int freq, int n, unsigned char *pluvio);

unsigned char *createArrayHumSolo(unsigned char max, unsigned char min, unsigned int freq, int n, unsigned char *pluvio);

unsigned char *createArrayPluvio(unsigned char max, unsigned char min, unsigned int freq, int n, char *temp);

char *createArrayTemp(char max, char min, unsigned int freq, int n);

unsigned char *createArrayVelVento(unsigned char max, unsigned char min, unsigned int freq, int n);

#endif