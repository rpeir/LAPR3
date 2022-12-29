#ifndef EX08_H
#define EX08_H
typedef struct
{
    unsigned short id;
    unsigned char sensor_type;
    unsigned short max_limit; // limites do sensor
    unsigned short min_limit;
    unsigned long frequency; // frequency de leituras (em segundos)
    unsigned long readings_size; // tamanho do array de leituras
    unsigned short *readings; // array de leituras diárias
} Sensor;

void write_sensor_file(Sensor *sensor);

#endif