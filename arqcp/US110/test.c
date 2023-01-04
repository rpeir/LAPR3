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
#include "../US104/createArray.h"
#include "../US103/dailyValues.h"
#include "../US103/createMatrix.h"

typedef struct
{
    unsigned short id;
    unsigned char sensor_type;
    unsigned short max_limit; // limites do sensor
    unsigned short min_limit;
    unsigned long frequency; // frequency de leituras (em segundos)
    unsigned long readings_size; // tamanho do array de leituras
    unsigned short *readings; // array de leituras diárias
    // ... adicionar o que acharem conveniente
} Sensor;

int main() {
    int leiturasErradas = 5;

    Sensor * sensoresTemp = malloc(sizeof(Sensor));
    Sensor * sensoresHumdAtm = malloc(sizeof(Sensor));
    Sensor * sensoresHumdSolo = malloc(sizeof(Sensor));
    Sensor * sensoresVelcVento = malloc(sizeof(Sensor));
    Sensor * sensoresDirVento = malloc(sizeof(Sensor));
    Sensor * sensoresPluvio = malloc(sizeof(Sensor));

    Sensor sensorTemp;
    sensorTemp.id = 1;
    sensorTemp.sensor_type = 'T';
    sensorTemp.max_limit = 0;
    sensorTemp.min_limit = 0;
    sensorTemp.frequency = 0;
    sensorTemp.readings_size = 0;
    sensorTemp.readings = malloc(sizeof(unsigned short));

    Sensor sensorHumdAtm;
    sensorHumdAtm.id = 2;
    sensorHumdAtm.sensor_type = 'H';
    sensorHumdAtm.max_limit = 0;
    sensorHumdAtm.min_limit = 0;
    sensorHumdAtm.frequency = 0;
    sensorHumdAtm.readings_size = 0;
    sensorHumdAtm.readings = malloc(sizeof(unsigned short));

    Sensor sensorHumdSolo;
    sensorHumdSolo.id = 3;
    sensorHumdSolo.sensor_type = 'S';
    sensorHumdSolo.max_limit = 0;
    sensorHumdSolo.min_limit = 0;
    sensorHumdSolo.frequency = 0;
    sensorHumdSolo.readings_size = 0;
    sensorHumdSolo.readings = malloc(sizeof(unsigned short));

    Sensor sensorVelcVento;
    sensorVelcVento.id = 4;
    sensorVelcVento.sensor_type = 'V';
    sensorVelcVento.max_limit = 0;
    sensorVelcVento.min_limit = 0;
    sensorVelcVento.frequency = 0;
    sensorVelcVento.readings_size = 0;
    sensorVelcVento.readings = malloc(sizeof(unsigned short));

    Sensor sensorDirVento;
    sensorDirVento.id = 5;
    sensorDirVento.sensor_type = 'D';
    sensorDirVento.max_limit = 0;
    sensorDirVento.min_limit = 0;
    sensorDirVento.frequency = 0;
    sensorDirVento.readings_size = 0;
    sensorDirVento.readings = malloc(sizeof(unsigned short));

    Sensor sensorPluvio;
    sensorPluvio.id = 6;
    sensorPluvio.sensor_type = 'P';
    sensorPluvio.max_limit = 0;
    sensorPluvio.min_limit = 0;
    sensorPluvio.frequency = 0;
    sensorPluvio.readings_size = 0;
    sensorPluvio.readings = malloc(sizeof(unsigned short));

    sensoresTemp[0] = sensorTemp;
    sensoresHumdAtm[0] = sensorHumdAtm;
    sensoresHumdSolo[0] = sensorHumdSolo;
    sensoresVelcVento[0] = sensorVelcVento;
    sensoresDirVento[0] = sensorDirVento;
    sensoresPluvio[0] = sensorPluvio;

    printf("SENSORES INICIAIS\n");
    printf("1-Ler ficheiro | 2-Inserir manualmente\n");
    int opcao;
    scanf("%d", &opcao);

    if(opcao==2) {
        printf("Insira a frequencia do sensor de temperatura: ");
        scanf("%lu", &sensorTemp.frequency);
        fill_SensoresTemp(sensoresTemp);
        printf("Insira a frequencia do sensor de velocidade do vento: ");
        scanf("%lu", &sensorVelcVento.frequency);
        fill_SensoresVelcVento(sensoresVelcVento);
        printf("Insira a frequencia do sensor de direcao do vento: ");
        scanf("%lu", &sensorDirVento.frequency);
        fill_SensoresDirVento(sensoresDirVento);
        printf("Insira a frequencia do sensor de pluviosidade: ");
        scanf("%lu", &sensorPluvio.frequency);
        fill_SensoresPluvio(sensoresPluvio, sensoresTemp);
        printf("Insira a frequencia do sensor de humidade atmosferica: ");
        scanf("%lu", &sensorHumdAtm.frequency);
        fill_SensoresHumdAtm(sensoresHumdAtm, sensoresPluvio);
        printf("Insira a frequencia do sensor de humidade do solo: ");
        scanf("%lu", &sensorHumdSolo.frequency);
        fill_SensoresHumdSolo(sensoresHumdSolo, sensoresPluvio);

    } else if(opcao==1) {
        // ficheiro:
        // T, 8
        // P, 10
        // open csv
            FILE *file = fopen("sensor_config.csv", "r");
            if (file == NULL) {
                printf("Error opening file!\n");
                return 1;
            }

            // ler cada linha
            char line[1024];
            while (fgets(line, 1024, file)) {
                // tipo de sensor e frequencia
                char tipoSensor[2];
                unsigned long frequencia;
                sscanf(line, "%s %lu", tipoSensor, &frequencia);

                // fazer o update do sensor
                if(strcmp(tipoSensor, "T") == 0) {
                    sensorTemp.frequency = frequencia;
                    fill_SensoresTemp(sensoresTemp);
                } else if(strcmp(tipoSensor, "P") == 0) {
                    sensorPluvio.frequency = frequencia;
                    fill_SensoresPluvio(sensoresPluvio, sensoresTemp);
                } else if(strcmp(tipoSensor, "H") == 0) {
                    sensorHumdAtm.frequency = frequencia;
                    fill_SensoresHumdAtm(sensoresHumdAtm, sensoresPluvio);
                } else if(strcmp(tipoSensor, "S") == 0) {
                    sensorHumdSolo.frequency = frequencia;
                    fill_SensoresHumdSolo(sensoresHumdSolo, sensoresPluvio);
                } else if(strcmp(tipoSensor, "V") == 0) {
                    sensorVelcVento.frequency = frequencia;
                    fill_SensoresVelcVento(sensoresVelcVento);
                } else if(strcmp(tipoSensor, "D") == 0) {
                    sensorDirVento.frequency = frequencia;
                    fill_SensoresDirVento(sensoresDirVento);
                }
            }

            // close the file
            fclose(file);

            // print dos sensores atualizados
            printf("Sensores default: \n");

                printf("Sensor %d: %c, %lu, %d, %d, %d\n", sensoresTemp[i].id, sensoresTemp[i].sensor_type, sensoresTemp[i].frequency, sensoresTemp[i].max_limit, sensoresTemp[i].min_limit, sensoresTemp[i].readings_size);
                printf("Sensor %d: %c, %lu, %d, %d, %d\n", sensoresHumdAtm[i].id, sensoresHumdAtm[i].sensor_type, sensoresHumdAtm[i].frequency, sensoresHumdAtm[i].max_limit, sensoresHumdAtm[i].min_limit, sensoresHumdAtm[i].readings_size);
                printf("Sensor %d: %c, %lu, %d, %d, %d\n", sensoresHumdSolo[i].id, sensoresHumdSolo[i].sensor_type, sensoresHumdSolo[i].frequency, sensoresHumdSolo[i].max_limit, sensoresHumdSolo[i].min_limit, sensoresHumdSolo[i].readings_size);
                printf("Sensor %d: %c, %lu, %d, %d, %d\n", sensoresVelcVento[i].id, sensoresVelcVento[i].sensor_type, sensoresVelcVento[i].frequency, sensoresVelcVento[i].max_limit, sensoresVelcVento[i].min_limit, sensoresVelcVento[i].readings_size);
                printf("Sensor %d: %c, %lu, %d, %d, %d\n", sensoresDirVento[i].id, sensoresDirVento[i].sensor_type, sensoresDirVento[i].frequency, sensoresDirVento[i].max_limit, sensoresDirVento[i].min_limit, sensoresDirVento[i].readings_size);
                printf("Sensor %d: %c, %lu, %d, %d, %d\n", sensoresPluvio[i].id, sensoresPluvio[i].sensor_type, sensoresPluvio[i].frequency, sensoresPluvio[i].max_limit, sensoresPluvio[i].min_limit, sensoresPluvio[i].readings_size);

    }

    printf("Deseja inserir mais sensores? (1-Sim | 2-Nao)\n");
    scanf("%d", &opcao);
    if(opcao==1) {
        printf("Quantos sensores deseja inserir? ");
        int numSensores;
        scanf("%d", &numSensores);
            for(int i=0; i<numSensores; i++) {
                printf("Insira o tipo de sensor que deseja inserir: ");
                char tipoSensor;
                scanf("%c", &tipoSensor);
                printf("Insira o tipo de sensor: ");
                unsigned char tipoSensor;
                scanf("%c", &tipoSensor);
                printf("Insira a frequencia do sensor: ");
                unsigned long frequencia;
                scanf("%lu", &frequencia);
                switch (tipoSensor) {
                    case 'T':

                        break;
                    case 'P':

                        break;
                    case 'H':

                        break;
                    case 'S':

                        break;
                    case 'V':

                        break;
                    case 'D':

                        break;
                    default:
                        printf("Tipo de sensor invalido!\n");
                        break;
                    }
                }
    }

    else {
        printf("A sair do programa...\n");
        return 0;
    }

    return 0;
}