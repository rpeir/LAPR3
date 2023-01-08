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

Sensor* getSensorByIndex(int index, TipoSensor* tp) {
    if (index >= tp->nrSensores || index < 0) {
        printf("Indice invalido");
        return NULL;
    }
    return &tp->sensores[index];
}


void change_freq_sensor(Sensor *sensor, Sensor* sensor_aux, char tipo_sensor, int n) 
{
    printf("Insira a nova frequencia do sensor: ");
    scanf("%lu", &(sensor->frequency));
    switch (tipo_sensor)
    {
    case 'T':
        createArrayTemp(sensor, n);
        break;
    case 'V':
        createArrayVelVento(sensor, n);
        break;
    case 'D':
        createArrayDirVento(sensor, n);
        break;
    case 'P':
        createArrayPluvio(sensor, sensor_aux, n);
        break;
    case 'H':
        createArrayHumAtm(sensor, sensor_aux, n);
        break;
    case 'S':
        createArrayHumSolo(sensor, sensor_aux, n);
        break;
    }    

}

void remove_sensor_from_list(int i, TipoSensor *tp)
{
    if (tp->nrSensores == 0) {
        printf("Não há sensores criados deste tipo\n");
        return;
    }
    Sensor *sensores = tp->sensores;
    for (int j = i; j < tp->nrSensores; j++)
    {
        sensores[j] = sensores[j + 1];
    }
    free((tp->sensores[tp->nrSensores].readings));
    tp->nrSensores--;
    if (tp->nrSensores == 0)
    {
        free(sensores);
    }
    else
    {
        Sensor *tmp = realloc(sensores, (tp->nrSensores) * (sizeof(Sensor)));
        if (tmp != NULL)
        {
            sensores = tmp;
        }
        else
        {
            printf("Erro ao alocar memoria");
        }
        tp->sensores = sensores;
    }
}

void consult_sensors(TipoSensor *tp, char option)
{
    int nr = tp->nrSensores;
    if (nr == 0)
    {
        printf("Não há sensores criados deste tipo\n");
    }
    else
    {
        Sensor *sensores = tp->sensores;
        for (int i = 0; i < nr; i++)
        {
            printf("Sensor: %d\n", i);
            printf("ID: %d\n", sensores[i].id);
            printf("Tipo: %c\n", sensores[i].sensor_type);
            printf("Frequencia: %lu\n", sensores[i].frequency);
            printf("Limite maximo: %hu\n", sensores[i].max_limit);
            printf("Limite minimo: %hd\n", (short)sensores[i].min_limit);
            printf("Tamanho do array de leituras: %lu\n", sensores[i].readings_size);
            if (option == '3') {
                            printf("Array de leituras:\n");
                            for (int j = 0; j < sensores[i].readings_size; j++)
                            {
                                //print index
                                printf("Valor: %d ", j);
                                //print value
                                if (sensores[i].sensor_type == 'T'){
                                    printf("%d", *((char*) (sensores[i].readings)+ j));
                                }else if (sensores[i].sensor_type == 'D'){
                                    printf("%d", *((unsigned short*) (sensores[i].readings)+ j));
                                }else {
                                    printf("%d", *((unsigned char*) (sensores[i].readings)+ j));
                                }
                            }
                        }
            printf("\n");
        }
    }
}

void add_sensor_to_list(Sensor *sensor, TipoSensor *tp)
{
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
    Sensor *sensores;
    if (tp->nrSensores == 0)
    {
        sensores = malloc(sizeof(Sensor));
    }
    else
    {
        sensores = tp->sensores; // iniciar os sensores antes de usar o realloc
        Sensor *tmp = realloc(sensores, ((tp->nrSensores) + 1) * (sizeof(Sensor)));
        if (tmp != NULL)
        {
            sensores = tmp;
        }
        else
        {
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

void parse_sensor_line(char *line, Sensor *sensor, int ID, int n, TipoSensor *tpTemps, TipoSensor *tpVelVents, TipoSensor *tpDirVents, TipoSensor *tpPluvios, TipoSensor *tpHumAtms, TipoSensor *tpHumSolos)
{
    char *token;
    char *line_copy = strdup(line);

    sscanf(line_copy, "%c,%lu", &sensor->sensor_type, &sensor->frequency);

    int i = 0;
    // switch case for sensor type
    switch (sensor->sensor_type)
    {
    case 'T':
        // preencher o resto dos dados
        printf("Qual o valor maximo? ");
        scanf("%hu", &sensor->max_limit);
        printf("Qual o valor minimo? ");
        scanf("%hu", &sensor->min_limit);
        sensor->id = ID;
        sensor->readings = NULL;
        ID++;
        createArrayTemp(sensor, n);
        add_sensor_to_list(sensor, tpTemps);
        //print da info dos sensores
        printf("Tipo de sensor: %c\n", sensor->sensor_type);
        printf("Frequencia: %lu\n", sensor->frequency);
        printf("Valor maximo: %hu\n", sensor->max_limit);
        printf("Valor minimo: %hu\n", sensor->min_limit);
        printf("ID: %d\n", sensor->id);
        printf("Tamanho do array de leituras: %lu\n", sensor->readings_size);
        break;
    case 'H':
        // pedir o index do sensor a usar
        printf("Qual o index do sensor de pluviosidade a usar? ");
        scanf("%d", &i);
        if (tpPluvios->nrSensores != 0 && i >= 0 && i < tpPluvios->nrSensores)
        {
            Sensor chosenSensor = tpPluvios->sensores[i];
            printf("Qual o valor maximo? ");
            scanf("%hu", &sensor->max_limit);
            printf("Qual o valor minimo? ");
            scanf("%hu", &sensor->min_limit);
            sensor->id = ID;
            sensor->readings = NULL;
            ID++;
            createArrayHumAtm(sensor, &chosenSensor, n);
            add_sensor_to_list(sensor, tpHumAtms);
            //print da info dos sensores
            printf("Tipo de sensor: %c\n", sensor->sensor_type);
            printf("Frequencia: %lu\n", sensor->frequency);
            printf("Valor maximo: %hu\n", sensor->max_limit);
            printf("Valor minimo: %hu\n", sensor->min_limit);
            printf("ID: %d\n", sensor->id);
            printf("Tamanho do array de leituras: %lu\n", sensor->readings_size);
        }
        else
        {
            printf("Index invalido ou nao existem sensores de pluviosidade");
        }
        break;
    case 'P':
        // pedir o index do sensor a usar
        printf("Qual o index do sensor de temp a usar? ");
        scanf("%d", &i);
        if (tpTemps->nrSensores != 0 && i >= 0 && i < tpTemps->nrSensores)
        {
            Sensor chosenSensor = tpTemps->sensores[i];
            printf("Qual o valor maximo? ");
            scanf("%hu", &sensor->max_limit);
            printf("Qual o valor minimo? ");
            scanf("%hu", &sensor->min_limit);
            sensor->id = ID;
            sensor->readings = NULL;
            ID++;
            createArrayPluvio(sensor, &chosenSensor, n);
            add_sensor_to_list(sensor, tpPluvios);
            //print da info dos sensores
            printf("Tipo de sensor: %c\n", sensor->sensor_type);
            printf("Frequencia: %lu\n", sensor->frequency);
            printf("Valor maximo: %hu\n", sensor->max_limit);
            printf("Valor minimo: %hu\n", sensor->min_limit);
            printf("ID: %d\n", sensor->id);
            printf("Tamanho do array de leituras: %lu\n", sensor->readings_size);
        }
        else
        {
            printf("Index invalido ou nao existem sensores de temperatura");
        }
        break;
    case 'V':
         printf("Qual o valor maximo? ");
        scanf("%hu", &sensor->max_limit);
        printf("Qual o valor minimo? ");
        scanf("%hu", &sensor->min_limit);
        sensor->id = ID;
        sensor->readings = NULL;
        ID++;
        createArrayVelVento(sensor, n);
        add_sensor_to_list(sensor, tpVelVents);
        //print da info dos sensores
        printf("Tipo de sensor: %c\n", sensor->sensor_type);
        printf("Frequencia: %lu\n", sensor->frequency);
        printf("Valor maximo: %hu\n", sensor->max_limit);
        printf("Valor minimo: %hu\n", sensor->min_limit);
        printf("ID: %d\n", sensor->id);
        printf("Tamanho do array de leituras: %lu\n", sensor->readings_size);
        break;
    case 'D':
         printf("Qual o valor maximo? ");
        scanf("%hu", &sensor->max_limit);
        printf("Qual o valor minimo? ");
        scanf("%hu", &sensor->min_limit);
        sensor->id = ID;
        sensor->readings = NULL;
        ID++;
        createArrayDirVento(sensor, n);
        add_sensor_to_list(sensor, tpDirVents);
        //print da info dos sensores
        printf("Tipo de sensor: %c\n", sensor->sensor_type);
        printf("Frequencia: %lu\n", sensor->frequency);
        printf("Valor maximo: %hu\n", sensor->max_limit);
        printf("Valor minimo: %hu\n", sensor->min_limit);
        printf("ID: %d\n", sensor->id);
        printf("Tamanho do array de leituras: %lu\n", sensor->readings_size);
        break;
    case 'S':
        // pedir o index do sensor a usar
        printf("Qual o index do sensor de pluviosidade a usar? ");
        scanf("%d", &i);
        if (tpPluvios->nrSensores != 0 && i >= 0 && i < tpPluvios->nrSensores)
        {
            Sensor chosenSensor = tpPluvios->sensores[i];
            printf("Qual o valor maximo? ");
            scanf("%hu", &sensor->max_limit);
            printf("Qual o valor minimo? ");
            scanf("%hu", &sensor->min_limit);
            sensor->id = ID;
            sensor->readings = NULL;
            ID++;
            createArrayHumSolo(sensor, &chosenSensor, n);
            add_sensor_to_list(sensor, tpHumSolos);
            //print da info dos sensores
            printf("Tipo de sensor: %c\n", sensor->sensor_type);
            printf("Frequencia: %lu\n", sensor->frequency);
            printf("Valor maximo: %hu\n", sensor->max_limit);
            printf("Valor minimo: %hu\n", sensor->min_limit);
            printf("ID: %d\n", sensor->id);
            printf("Tamanho do array de leituras: %lu\n", sensor->readings_size);
        }
        else
        {
            printf("Index invalido ou nao existem sensores de pluviosidade");
        }
        break;
    default:
        break;
    }

    free(line_copy);
}
///////////////////////////////////////////////////////////////////////////////////
int main()
{
    TipoSensor tpTemps, tpVelVents, tpDirVents, tpPluvios, tpHumAtms, tpHumSolos;
    tpTemps.nrSensores = 0;
    tpVelVents.nrSensores = 0;
    tpDirVents.nrSensores = 0;
    tpPluvios.nrSensores = 0;
    tpHumAtms.nrSensores = 0;
    tpHumSolos.nrSensores = 0;
    int ID = 0;
    int n = 5;

    int choice;
    do
    {
        printf("1 - Importar ficheiro\n2 - Adicionar Sensores\n3 - Remover Sensores\n4 - Consultar Sensores\n");
        printf("5 - Alterar frequencia de leituras\n0 - Sair\n");
        scanf("%d", &choice);
        if (choice == 0)
        {
            exit(0);
        }
        else if (choice == 1)
        {
            FILE *file = fopen("input_sensores.csv", "r");
            if (file == NULL)
            {
                perror("Error opening file");
                return 1;
            }

            char line[1024];
            while (fgets(line, 1024, file) != NULL)
            {
                Sensor sensor;
                parse_sensor_line(line, &sensor, ID, n, &tpTemps, &tpVelVents, &tpDirVents, &tpPluvios, &tpHumAtms, &tpHumSolos);
            }

            fclose(file);
        }

        else if (choice == 2)
        {
            int nrSensors;
            printf("Quantos sensores quer adicionar?\n");
            scanf("%d", &nrSensors);
            if (nrSensors > 0)
            {
                for (int j = 0; j < nrSensors; j++)
                {
                    Sensor sensor;
                    // pedir os dados
                    printf("Tipo de sensor: \n");

                    scanf(" %c", &sensor.sensor_type);
                    int i = 0;
                    switch (sensor.sensor_type)
                    {
                    case 'T':
                        // preencher o resto dos dados
                        printf("Qual o valor maximo? ");
                        scanf("%hu", &sensor.max_limit);
                        printf("Qual o valor minimo? ");
                        scanf("%hu", &sensor.min_limit);
                        printf("Qual a frequencia? ");
                        scanf("%lu", &sensor.frequency);
                        sensor.id = ID;
                        sensor.readings = NULL;
                        ID++;
                        createArrayTemp(&sensor, n);
                        add_sensor_to_list(&sensor, &tpTemps);
                        break;
                    case 'H':
                        // pedir o index do sensor a usar
                        printf("Qual o index do sensor de temp a usar? ");
                        scanf("%d", &i);
                        if (tpPluvios.nrSensores != 0 && i >= 0 && i < tpPluvios.nrSensores)
                        {
                            Sensor chosenSensor = tpPluvios.sensores[i];
                            printf("Qual o valor maximo? ");
                            scanf("%hu", &sensor.max_limit);
                            printf("Qual o valor minimo? ");
                            scanf("%hu", &sensor.min_limit);
                            printf("Qual a frequencia? ");
                            scanf("%lu", &sensor.frequency);
                            sensor.id = ID;
                            sensor.readings = NULL;
                            ID++;
                            createArrayHumAtm(&sensor, &chosenSensor, n);
                            add_sensor_to_list(&sensor, &tpHumAtms);
                        }
                        else
                        {
                            printf("Index invalido ou nao existem sensores de pluviosidade");
                        }
                        break;
                    case 'P':
                        // pedir o index do sensor a usar
                        printf("Qual o index do sensor de temp a usar? ");
                        scanf("%d", &i);
                        if (tpTemps.nrSensores != 0 && i >= 0 && i < tpTemps.nrSensores)
                        {
                            Sensor chosenSensor = tpTemps.sensores[i];
                            printf("Qual o valor maximo? ");
                            scanf("%hu", &sensor.max_limit);
                            printf("Qual o valor minimo? ");
                            scanf("%hu", &sensor.min_limit);
                            printf("Qual a frequencia? ");
                            scanf("%lu", &sensor.frequency);
                            sensor.id = ID;
                            sensor.readings = NULL;
                            ID++;
                            createArrayPluvio(&sensor, &chosenSensor, n);
                            add_sensor_to_list(&sensor, &tpPluvios);
                        }
                        else
                        {
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
                        sensor.readings = NULL;
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
                        sensor.readings = NULL;
                        ID++;
                        createArrayDirVento(&sensor, n);
                        add_sensor_to_list(&sensor, &tpDirVents);
                        break;
                    case 'S':
                        // pedir o index do sensor a usar
                        printf("Qual o index do sensor de pluviosidade a usar? ");
                        scanf("%d", &i);
                        if (tpPluvios.nrSensores != 0 && i >= 0 && i < tpPluvios.nrSensores)
                        {
                            Sensor chosenSensor = tpPluvios.sensores[i];
                            printf("Qual o valor maximo? ");
                            scanf("%hu", &sensor.max_limit);
                            printf("Qual o valor minimo? ");
                            scanf("%hu", &sensor.min_limit);
                            printf("Qual a frequencia? ");
                            scanf("%lu", &sensor.frequency);
                            sensor.id = ID;
                            sensor.readings = NULL;
                            ID++;
                            createArrayHumSolo(&sensor, &chosenSensor, n);
                            add_sensor_to_list(&sensor, &tpHumSolos);
                        }
                        else
                        {
                            printf("Index invalido ou nao existem sensores de pluviosidade\n");
                        }
                        break;

                    default:
                        printf("O tipo de sensor nao existe.\n");
                        break;
                    }
                }
            }
            else
            {
                printf("Invalid number of sensors\n");
            }
        }
        else if (choice == 3 || choice == 4 || choice == 5)
        {
            printf("Indique o tipo de sensor: \n");
            printf("T - Temperatura\n");
            printf("H - Humidade atmosferica\n");
            printf("P - Pluviosidade\n");
            printf("V - Velocidade do vento\n");
            printf("D - Direcao do vento\n");
            printf("S - Humidade do solo\n");
            char option;
            scanf(" %c", &option);
            switch (option)
            {
            case 'T':
                consult_sensors(&tpTemps, choice);
                break;
            case 'H':
                consult_sensors(&tpHumAtms, choice);
                break;
            case 'P':
                consult_sensors(&tpPluvios, choice);
                break;
            case 'V':
                consult_sensors(&tpVelVents, choice);
                break;
            case 'D':
                consult_sensors(&tpDirVents, choice);
                break;
            case 'S':
                consult_sensors(&tpHumSolos, choice);
                break;
            default:
                printf("O tipo de sensor nao existe.\n");
                break;
            }
            if (choice == 3)
            {
                printf("Indique o index do sensor a remover: ");
                int index;
                scanf("%d", &index);
                switch (option)
                {
                case 'T':
                    remove_sensor_from_list(index, &tpTemps);
                    break;
                case 'H':
                    remove_sensor_from_list(index, &tpHumAtms);
                    break;
                case 'P':
                    remove_sensor_from_list(index, &tpPluvios);
                    break;
                case 'V':
                    remove_sensor_from_list(index, &tpVelVents);
                    break;
                case 'D':
                    remove_sensor_from_list(index, &tpDirVents);
                    break;
                case 'S':
                    remove_sensor_from_list(index, &tpHumSolos);
                    break;
                default:
                    printf("O tipo de sensor nao existe.\n");
                    break;
                }
            }
            else if (choice == 5)
            {
                printf("Indique o index do sensor a alterar: ");
                int index;
                scanf("%d", &index);
                Sensor *sens, *sens_aux = NULL;
                int i;
                switch (option)
                {
                case 'T':
                    sens = getSensorByIndex(index, &tpTemps);
                    change_freq_sensor(sens, sens_aux, option, n);
                    break;
                case 'H':
                    sens = getSensorByIndex(index, &tpHumAtms);
                    consult_sensors(&tpPluvios, choice);
                    printf("Indique o index do sensor de Pluviosodade a utilizar: ");
                    scanf(" %d", &i);
                    sens_aux = getSensorByIndex(i, &tpPluvios);
                    change_freq_sensor(sens, sens_aux, option, n);
                    break;
                case 'P':
                    sens = getSensorByIndex(index, &tpPluvios);
                    consult_sensors(&tpTemps, choice);
                    printf("Indique o index do sensor de Temperatura a utilizar: ");
                    scanf(" %d", &i);
                    sens_aux = getSensorByIndex(i, &tpTemps);
                    change_freq_sensor(sens, sens_aux, option, n);
                    break;
                case 'V':
                    sens = getSensorByIndex(index, &tpVelVents);
                    change_freq_sensor(sens, sens_aux, option, n);
                    break;
                case 'D':
                    sens = getSensorByIndex(index, &tpDirVents);
                    change_freq_sensor(sens, sens_aux, option, n);
                    break;
                case 'S':
                    sens = getSensorByIndex(index, &tpHumSolos);
                    consult_sensors(&tpPluvios, choice);
                    printf("Indique o index do sensor de Pluviosodade a utilizar: ");
                    scanf(" %d", &i);
                    sens_aux = getSensorByIndex(i, &tpPluvios);
                    change_freq_sensor(sens, sens_aux, option, n);
                    break;
                default:
                    printf("O tipo de sensor nao existe.\n");
                    break;
                }
            }
        }
        else
        {
            printf("Invalid choice\n");
        }
    } while (1);

    return 0;
}
