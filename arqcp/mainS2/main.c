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
    /*Sensor* sensores;
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
    }*/
    Sensor* sensores;
    if (tp->nrSensores == 0) {
        sensores = malloc(sizeof(Sensor));
    } else {
        sensores = tp->sensores; // iniciar os sensores antes de usar o realloc
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

void parse_sensor_line(char* line, Sensor* sensor, int ID, int n, TipoSensor* tpTemps, TipoSensor* tpVelVents, TipoSensor* tpDirVents, TipoSensor* tpPluvios, TipoSensor* tpHumAtms, TipoSensor* tpHumSolos) {
    char* token;
    char* line_copy = strdup(line);

    token = strtok(NULL, ",");
    sensor->sensor_type = (unsigned char)token[0];

    token = strtok(NULL, ",");
    sensor->frequency = (unsigned long)atoi(token);
    int i = 0;
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
            //guardar no array
            add_sensor_to_list(sensor, tpTemps);
            break;
        case 'H':
            // pedir o index do sensor a usar
            printf("Qual o index do sensor de temp a usar? ");
            scanf("%d", &i);
            if (tpPluvios->nrSensores != 0 && i >= 0 && i < tpPluvios->nrSensores) {
                Sensor chosenSensor = tpPluvios->sensores[i];
                sensor->max_limit = 100;
                sensor->min_limit = 0;
                sensor->id = ID;
                ID++;
                createArrayHumAtm(sensor, &chosenSensor, n);
                add_sensor_to_list(sensor, tpHumAtms);
            }
            else {
                printf("Index invalido ou nao existem sensores de pluviosidade");
            }
                break;
        case 'P':
            // pedir o index do sensor a usar
            printf("Qual o index do sensor de temp a usar? ");
            scanf("%d", &i);
            if (tpTemps->nrSensores != 0 && i >= 0 && i < tpTemps->nrSensores) {
                Sensor chosenSensor = tpTemps->sensores[i];
                sensor->max_limit = 150;
                sensor->min_limit = 0;
                sensor->id = ID;
                ID++;
                createArrayPluvio(sensor, &chosenSensor, n);
                add_sensor_to_list(sensor, tpPluvios);
            }
            else {
                printf("Index invalido ou nao existem sensores de temperatura");
            }            
            break;
        case 'V':
            sensor->max_limit = 150;
            sensor->min_limit = 0;
            sensor->id = ID;
            ID++;
            createArrayVelVento(sensor, n);
            add_sensor_to_list(sensor, tpVelVents);
            break;
        case 'D':
            sensor->max_limit = 359;
            sensor->min_limit = 0;
            sensor->id = ID;
            ID++;
            createArrayDirVento(sensor, n);
            add_sensor_to_list(sensor, tpDirVents);
            break;
        case 'S':
            // pedir o index do sensor a usar
            printf("Qual o index do sensor de temp a usar? ");
            scanf("%d", &i);
            if (tpPluvios->nrSensores != 0 && i >= 0 && i < tpPluvios->nrSensores) {
                Sensor chosenSensor = tpPluvios->sensores[i];
                sensor->max_limit = 100;
                sensor->min_limit = 0;
                sensor->id = ID;
                ID++;
                createArrayHumSolo(sensor, &chosenSensor, n);
                add_sensor_to_list(sensor, tpHumSolos);
            }
            else {
                printf("Index invalido ou nao existem sensores de pluviosidade");
            }
            break;
        default:
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
    int ID = 0;
    int n = 5;

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
    parse_sensor_line(line, &sensor, ID, n, &tpTemps, &tpVelVents, &tpDirVents, &tpPluvios, &tpHumAtms, &tpHumSolos);
}

    fclose(file);

    }

    else if(choice==2) {
        int nrSensors;
        printf("How many sensors do you want to add?\n");
        scanf("%d", &nrSensors);
        if(nrSensors>0) {
            for(int j=0; j<nrSensors; j++) {
                Sensor sensor;
                // pedir os dados
                printf("Tipo de sensor: ");
                scanf("%c", &sensor.sensor_type);
        int i = 0;
        switch (sensor.sensor_type) {
        case 'T':
            //preencher o resto dos dados
            printf("Qual o valor maximo? ");
            scanf("%hu", &sensor.max_limit);
            printf("Qual o valor minimo? ");
            scanf("%hu", &sensor.min_limit);
            printf("Qual a frequencia? ");
            scanf("%lu", &sensor.frequency);
            sensor.id = ID;
            ID++;
            createArrayTemp(&sensor, n);
            add_sensor_to_list(&sensor, &tpTemps);
            break;
        case 'H':
            // pedir o index do sensor a usar
            printf("Qual o index do sensor de temp a usar? ");
            scanf("%d", &i);
            if (tpPluvios.nrSensores != 0 && i >= 0 && i < tpPluvios.nrSensores) {
                Sensor chosenSensor = tpPluvios.sensores[i];
                printf("Qual o valor maximo? ");
                scanf("%hu", &sensor.max_limit);
                printf("Qual o valor minimo? ");
                scanf("%hu", &sensor.min_limit);
                printf("Qual a frequencia? ");
                scanf("%lu", &sensor.frequency);
                sensor.id = ID;
                ID++;
                createArrayHumAtm(&sensor, &chosenSensor, n);
                add_sensor_to_list(&sensor, &tpHumAtms);
            }
            else {
                printf("Index invalido ou nao existem sensores de pluviosidade");
            }
            break;
        case 'P':
            // pedir o index do sensor a usar
            printf("Qual o index do sensor de temp a usar? ");
            scanf("%d", &i);
            if (tpTemps.nrSensores != 0 && i >= 0 && i < tpTemps.nrSensores) {
                Sensor chosenSensor = tpTemps.sensores[i];
                printf("Qual o valor maximo? ");
                scanf("%hu", &sensor.max_limit);
                printf("Qual o valor minimo? ");
                scanf("%hu", &sensor.min_limit);
                printf("Qual a frequencia? ");
                scanf("%lu", &sensor.frequency);
                sensor.id = ID;
                ID++;
                createArrayPluvio(&sensor, &chosenSensor, n);
                add_sensor_to_list(&sensor, &tpPluvios);
            }
            else {
                printf("Index invalido ou nao existem sensores de temperatura");
            }               
            break;
        case 'V':
            printf("Qual o valor maximo? ");
            scanf("%hu", &sensor.max_limit);
            printf("Qual o valor minimo? ");
            scanf("%hu", &sensor.min_limit);
            printf("Qual a frequencia? ");
            scanf("%lu", &sensor.frequency);
            sensor.id = ID;
            ID++;
            createArrayVelVento(&sensor, n);
            add_sensor_to_list(&sensor, &tpVelVents);            
            break;
        case 'D':
            printf("Qual o valor maximo? ");
            scanf("%hu", &sensor.max_limit);
            printf("Qual o valor minimo? ");
            scanf("%hu", &sensor.min_limit);
            printf("Qual a frequencia? ");
            scanf("%lu", &sensor.frequency);
            sensor.id = ID;
            ID++;
            createArrayDirVento(&sensor, n);
            add_sensor_to_list(&sensor, &tpDirVents);   
            break;
        case 'S':
            // pedir o index do sensor a usar
            printf("Qual o index do sensor de temp a usar? ");
            scanf("%d", &i);
            if (tpPluvios.nrSensores != 0 && i >= 0 && i < tpPluvios.nrSensores) {
                Sensor chosenSensor = tpPluvios.sensores[i];
                printf("Qual o valor maximo? ");
                scanf("%hu", &sensor.max_limit);
                printf("Qual o valor minimo? ");
                scanf("%hu", &sensor.min_limit);
                printf("Qual a frequencia? ");
                scanf("%lu", &sensor.frequency);
                sensor.id = ID;
                ID++;
                createArrayHumSolo(&sensor, &chosenSensor, n);
                add_sensor_to_list(&sensor, &tpHumSolos);
            }
            else {
                printf("Index invalido ou nao existem sensores de pluviosidade");
            }
            break;
        
        default:
            printf("O tipo de sensor nao existe.\n");
            break;
                
        }

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


