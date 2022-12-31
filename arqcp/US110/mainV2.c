#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "sens_temp.h"
#include "sens_velc_vento.h"
#include "sens_dir_vento.h"
#include "sens_humd_atm.h"
#include "sens_humd_solo.h"
#include "sens_pluvio.h"
#include "pcg32_random_r.h"
#define INITIAL_ARRAY_SIZE 10

/////////////////////////////////////////////////////////////////////////////////

typedef struct
{
    unsigned short id;
    unsigned char sensor_type;
    unsigned short max_limit; // limites do sensor
    unsigned short min_limit;
    unsigned long frequency; // frequency de leituras (em segundos)
    unsigned long readings_size; // tamanho do array de leituras
    unsigned short *readings; // array de leituras diárias
    ... // adicionar o que acharem conveniente
} Sensor;
//////////////////////////////////////////////////////////////////////////////////

void add_sensor_to_list(Sensor sensor) {
    Sensor* sensors = malloc(INITIAL_ARRAY_SIZE * sizeof(Sensor));
    int num_sensors = 0;
    int array_size = INITIAL_ARRAY_SIZE;
    if (num_sensors == array_size) {
    array_size *= 2;
    sensors = realloc(sensors, array_size * sizeof(Sensor));
    }

    sensors[num_sensors] = sensor;
    num_sensors++;
}

void parse_sensor_line(char* line, Sensor* sensor) {
    char* token;
    char* line_copy = strdup(line);
    // atoi = ascii to integer
    token = strtok(line_copy, ",");
    sensor->id = (unsigned short)atoi(token);

    token = strtok(NULL, ",");
    sensor->sensor_type = (unsigned char)token[0];

    token = strtok(NULL, ",");
    sensor->max_limit = (unsigned short)atoi(token);

    token = strtok(NULL, ",");
    sensor->min_limit = (unsigned short)atoi(token);

    token = strtok(NULL, ",");
    sensor->frequency = (unsigned long)atoi(token);

    // Calculate the size of the readings array
    sensor->readings_size = 86400 / sensor->frequency; // 86400 seconds in a day

    sensor->readings = malloc(sensor->readings_size * sizeof(unsigned short));

    //fill readings array here
    unsigned short leituras[sensor->readings_size];
    //switch case para cada tipo de sensor
    switch (sensor->sensor_type) {
        case 'T':
            char ult_temp = 14;
            for (int i = 0; i < sensor->readings_size; i++) {
                char comp_rand = (char) pcg32_random_r();
                char nov_temp = sens_temp(ult_temp,comp_rand);
                ult_temp = nov_temp;
                leituras[i] = (unsigned short)nov_temp;
            }
            break;
        case 'V':
            char ult_velc_vento = 14;
            for (int i = 0; i < sensor->readings_size; i++) {
                char comp_rand = (char) pcg32_random_r();
                char nov_velc_vento = sens_velc_vento(ult_velc_vento,comp_rand);
                ult_velc_vento = nov_velc_vento;
                leituras[i] = (unsigned short)nov_velc_vento;
            }
            break;
        case 'D':
            unsigned short ult_dir_vento = 14;
            for (int i = 0; i < sensor->readings_size; i++) {
                short comp_rand = (short) pcg32_random_r();
                unsigned short nov_dir_vento = sens_dir_vento(ult_dir_vento,comp_rand);
                ult_dir_vento = nov_dir_vento;
                leituras[i] = (unsigned short)nov_dir_vento;
            }
            break;
        case 'H':
            unsigned char ult_hmd_atm = 14;
            ult_pluvio = 0;
            for (int i = 0; i < sensor->readings_size; i++) {
                short comp_rand = (short) pcg32_random_r();
                unsigned short nov_dir_vento = sens_dir_vento(ult_dir_vento, comp_rand);
                ult_dir_vento = nov_dir_vento;
                leituras[i] = (unsigned short)nov_dir_vento;
            }
            break;
        case 'S':
            unsigned char ult_hmd_solo = 14;
            unsigned char ult_pluvio = 0;
            for (int i = 0; i < sensor->readings_size; i++) {
                char comp_rand = (char) pcg32_random_r();
                unsigned char nov_hmd_solo = sens_humd_solo(ult_hmd_solo, ult_pluvio, comp_rand);
                ult_hmd_solo = nov_hmd_solo;
                leituras[i] = (unsigned short)nov_hmd_solo;
            }
            break;
        case 'P':
            ult_temp = 14;
            ult_pluvio = 0;
            for (int i = 0; i < sensor->readings_size; i++) {
                char comp_rand = (char) pcg32_random_r();
                unsigned char nov_pluvio = sens_pluvio(ult_hmd_solo, ult_temp, comp_rand);
                ult_pluvio = nov_pluvio;
                leituras[i] = (unsigned short)nov_pluvio;
            }
            break;
    }
    unsigned short* leituras_ptr = leituras;
    sensor->readings = leituras_ptr;

    free(line_copy);
}
///////////////////////////////////////////////////////////////////////////////////
int main() {
    // choose if u want to import file or input the info yourself
    int choice;
    printf("1 - Import file\n2 - Input info\n");
    scanf("%d", &choice);

    if(choice==1) {
    FILE* file = fopen("sensores.csv", "r");
    if (file == NULL) {
    perror("Error opening file");
    return 1;
    }

    char line[1024];
    while (fgets(line, 1024, file) != NULL) {
    Sensor sensor;
    parse_sensor_line(line, &sensor);

    add_sensor_to_list(sensor);
    }

    fclose(file);

    }

    else if(choice==2) {
        int i;
        int nrSensors;
        printf("How many sensors do you want to add?\n");
        scanf("%d", &nrSensors);
        if(nrSensors>0) {
            for(i=0; i<nrSensors; i++) {
                Sensor sensor;
                printf("Sensor %d\n", i+1);
                printf("ID: ");
                scanf("%d", &sensor.id);
                printf("Sensor type: ");
                scanf("%d", &sensor.sensor_type);
                printf("Max limit: ");
                scanf("%d", &sensor.max_limit);
                printf("Min limit: ");
                scanf("%d", &sensor.min_limit);
                printf("Frequency: ");
                scanf("%d", &sensor.frequency);
                sensor.readings_size = 86400 / sensor.frequency;
                sensor.readings = malloc(sensor.readings_size * sizeof(unsigned short));
                //fill readings array here
                    unsigned short leituras[sensor->readings_size];
                    //switch case para cada tipo de sensor
                    switch (sensor->sensor_type) {
                        case 'T':
                            char ult_temp = 14;
                            for (int i = 0; i < sensor->readings_size; i++) {
                                char comp_rand = (char) pcg32_random_r();
                                char nov_temp = sens_temp(ult_temp,comp_rand);
                                ult_temp = nov_temp;
                                leituras[i] = (unsigned short)nov_temp;
                            }
                            break;
                        case 'V':
                            char ult_velc_vento = 14;
                            for (int i = 0; i < sensor->readings_size; i++) {
                                char comp_rand = (char) pcg32_random_r();
                                char nov_velc_vento = sens_velc_vento(ult_velc_vento,comp_rand);
                                ult_velc_vento = nov_velc_vento;
                                leituras[i] = (unsigned short)nov_velc_vento;
                            }
                            break;
                        case 'D':
                            unsigned short ult_dir_vento = 14;
                            for (int i = 0; i < sensor->readings_size; i++) {
                                short comp_rand = (short) pcg32_random_r();
                                unsigned short nov_dir_vento = sens_dir_vento(ult_dir_vento,comp_rand);
                                ult_dir_vento = nov_dir_vento;
                                leituras[i] = (unsigned short)nov_dir_vento;
                            }
                            break;
                        case 'H':
                            unsigned char ult_hmd_atm = 14;
                            ult_pluvio = 0;
                            for (int i = 0; i < sensor->readings_size; i++) {
                                short comp_rand = (short) pcg32_random_r();
                                unsigned short nov_dir_vento = sens_dir_vento(ult_dir_vento, comp_rand);
                                ult_dir_vento = nov_dir_vento;
                                leituras[i] = (unsigned short)nov_dir_vento;
                            }
                            break;
                        case 'S':
                            unsigned char ult_hmd_solo = 14;
                            unsigned char ult_pluvio = 0;
                            for (int i = 0; i < sensor->readings_size; i++) {
                                char comp_rand = (char) pcg32_random_r();
                                unsigned char nov_hmd_solo = sens_humd_solo(ult_hmd_solo, ult_pluvio, comp_rand);
                                ult_hmd_solo = nov_hmd_solo;
                                leituras[i] = (unsigned short)nov_hmd_solo;
                            }
                            break;
                        case 'P':
                            ult_temp = 14;
                            ult_pluvio = 0;
                            for (int i = 0; i < sensor->readings_size; i++) {
                                char comp_rand = (char) pcg32_random_r();
                                unsigned char nov_pluvio = sens_pluvio(ult_hmd_solo, ult_temp, comp_rand);
                                ult_pluvio = nov_pluvio;
                                leituras[i] = (unsigned short)nov_pluvio;
                            }
                            break;
                    }
                    unsigned short* leituras_ptr = leituras;
                    sensor->readings = leituras_ptr;
                    add_sensor_to_list(sensor);
            }
        }
        else {
            printf("Invalid number of sensors\n");
        }
    }
    else {
        printf("Invalid choice");
        return 1;
    }
    return 0;
}


