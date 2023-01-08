#ifndef CREATE_ARRAY_SENS_H
#define CREATE_ARRAY_SENS_H

unsigned short *createArrayDirVento(unsigned short max, unsigned short min, unsigned int freq, int n);

unsigned short *createArrayHumAtm(unsigned short max, unsigned short min, unsigned int freq, int n, unsigned short *pluvio);

unsigned short *createArrayHumSolo(unsigned short max, unsigned short min, unsigned int freq, int n, unsigned short *pluvio);

unsigned short *createArrayPluvio(unsigned short max, unsigned short min, unsigned int freq, int n, short *temp);

short *createArrayTemp(short max, short min, unsigned int freq, int n);

unsigned short *createArrayVelVento(unsigned short max, unsigned short min, unsigned int freq, int n);

#endif