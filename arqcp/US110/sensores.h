#ifndef SENSORES_H
#define SENSORES_H

typedef struct
{
    unsigned short id;
    unsigned char sensor_type;
    unsigned short max_limit; // limites do sensor
    unsigned short min_limit;
    unsigned long frequency; // frequency de leituras (em segundos)
    unsigned long readings_size; // tamanho do array de leituras
    void *readings; // array de leituras diárias
    // ... adicionar o que acharem conveniente
} Sensor;

typedef struct {
    int nrSensores;
    Sensor *sensores;
} TipoSensor;

#endif