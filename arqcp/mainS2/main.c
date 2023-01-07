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

void parse_sensor_line(char* line, Sensor* sensor, int ID, int n) {
    char* token;
    char* line_copy = strdup(line);

    token = strtok(NULL, ",");
    sensor->sensor_type = (unsigned char)token[0];

    token = strtok(NULL, ",");
    sensor->frequency = (unsigned long)atoi(token);

    TipoSensor *tp;

    //switch case for sensor type
    switch (sensor->sensor_type) {
        case 'T':
            // associar constantes de max e min
            sensor->max_limit = 30;
            sensor->min_limit = -5;
            //gerar id
            sensor->id = ID;
            //icrementar id
            ID++;
            //gerar as leituras
            createArrayTemp(sensor, n);
            break;
        case 'H':
            sensor->max_limit = 100;
            sensor->min_limit = 0;
            sensor->id = ID;
            ID++;
            break;
        case 'P':
            sensor->max_limit = 150;
            sensor->min_limit = 0;
            sensor->id = ID;
            ID++;
            break;
        case 'V':
            sensor->max_limit = 150;
            sensor->min_limit = 0;
            sensor->id = ID;
            ID++;
            createArrayVelVento(sensor, n);
            break;
        case 'D':
            sensor->max_limit = 359;
            sensor->min_limit = 0;
            sensor->id = ID;
            ID++;
            createArrayDirVento(sensor, n);
            break;
        case 'S':
            sensor->max_limit = 100;
            sensor->min_limit = 0;
            sensor->id = ID;
            ID++;
            break;
        default:
            break;
    }

    //guardar no array

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
    int ID = 0;
    int n = 5;
    parse_sensor_line(line, &sensor, ID, n);
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
                TipoSensor *tp;

                // pedir os dados

                // verificar se o id ja existe

                // listar sensores ja existentes e escolher o sensor de temperatura e o sensor de pluviosidade para gerar os outros valores

                // guardar no array

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


