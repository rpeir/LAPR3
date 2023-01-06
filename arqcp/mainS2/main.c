#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "../US102/sens_dir_vento.h"
#include "../US102/sens_humd_atm.h"
#include "../US102/sens_humd_solo.h"
#include "../US102/sens_pluvio.h"
#include "../US102/sens_temp.h"
#include "../US102/sens_velc_vento.h"
#include "../US101/pcg32_random_r.h"
#include "../US104/createArrayNew.h"
#include "../US103/dailyValues.h"
#include "../US103/createMatrix.h"
#include "sensores.h"

void add_sensor_to_list(Sensor *sensor, TipoSensor* tp) {
    Sensor* sensores;
    if (tp->nrSensores == 0) {
        sensores = malloc(sizeof(Sensor));
    } else {
        Sensor* tmp = realloc(sensores, ((tp->nrSensores)+1)*(sizeof(Sensor)));
        if (tmp != NULL) {
            sensores = tmp;
        }
        else {
            printf("Erro ao alocar memoria");
        }
    }
    sensores[tp->nrSensores].id = sensor->id;
    sensores[tp->nrSensores].sensor_type = sensor->sensor_type;
    sensores[tp->nrSensores].max_limit = sensor->max_limit;
    sensores[tp->nrSensores].min_limit = sensor->min_limit;
    sensores[tp->nrSensores].frequency = sensor->frequency;
    sensores[tp->nrSensores].readings_size = sensor->readings_size;
    sensores[tp->nrSensores].readings = sensor->readings;
    tp->nrSensores++;
    tp->sensores = sensores;
}

void parse_sensor_line(char* line, Sensor* sensor) {
    char* token;
    char* line_copy = strdup(line);
    // atoi = ascii to integer
//    token = strtok(line_copy, ",");
//    sensor->id = (unsigned short)atoi(token);

    token = strtok(NULL, ",");
    sensor->sensor_type = (unsigned char)token[0];

//    token = strtok(NULL, ",");
//    sensor->max_limit = (unsigned short)atoi(token);
//
//    token = strtok(NULL, ",");
//    sensor->min_limit = (unsigned short)atoi(token);

    token = strtok(NULL, ",");
    sensor->frequency = (unsigned long)atoi(token);

    int n = 5;
    //fill readings array here
    unsigned short* leituras;
    //switch case para cada tipo de sensor
    switch (sensor->sensor_type) {
        case 'T':
            createSensTemp(sensor, n);
            break;
        case 'V':
            createSensVelVento(sensor, n);
            break;
        case 'D':
            createSensDirVento(sensor, n);
            break;
        case 'H':

            break;
        case 'S':

            break;
        case 'P':

            break;
    }

    free(line_copy);
}
///////////////////////////////////////////////////////////////////////////////////
int main() {
    TipoSensor tpTemps, tpVelVents, tpDirVents, tpPluvios, tpHumAtms, tpHumSolos;
    tpTemps.nrSensores=0;
    tpVelVents.nrSensores=0;
    tpDirVents.nrSensores=0;
    tpPluvios.nrSensores=0;
    tpHumAtms.nrSensores=0;
    tpHumSolos.nrSensores=0;

    // choose if u want to import file or input the info yourself
    int choice;
    printf("1 - Import file\n2 - Input info\n");
    scanf("%d", &choice);

    if(choice==1) {
    FILE* file = fopen("input_sensores.csv", "r");
    if (file == NULL) {
    perror("Error opening file");
    return 1;
    }

    char line[1024];
    while (fgets(line, 1024, file) != NULL) {
    Sensor sensor;
    parse_sensor_line(line, &sensor);

    //add_sensor_to_list(sensor);
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
                //fill readings array here
                //switch case para cada tipo de sensor

    int n = 5;

    TipoSensor *tp;
    switch (sensor->sensor_type) {
        case 'T':

            tp = &tpTemps;
            break;
        case 'V':

            tp = &tpVelVents;
            break;
        case 'D':

            tp = &tpDirVents;
            break;
        case 'H':

            tp = &tpHumSolos;
            break;
        case 'S':

            tp = &tpHumSolos;
            break;
        case 'P':

            tp = &tpPluvios;
            break;
    }
    sensor->readings = leituras;
    add_sensor_to_list(sensor, tp);
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


