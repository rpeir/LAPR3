short** createMatrix(char *sens_temp, unsigned char *sens_velc_vento, unsigned short *sens_dir_vento,
unsigned char *sens_humd_atm, unsigned char *sens_humd_solo, unsigned char *sens_pluvio) {
    short *matrix[6];
    short line[3];
    for (int i = 0; i < 3; i++) {
        *(line + i) = (short)*(sens_temp + i);
    }
    *(matrix + 0) = line;
    short line2[3];
    for (int i = 0; i < 3; i++) {
        *(line2 + i) = (short)*(sens_velc_vento + i);
    }
    *(matrix + 1) = line2;
    short line3[3];
    for (int i = 0; i < 3; i++) {
        *(line3 + i) = (short)*(sens_dir_vento + i);
    }
    *(matrix + 2) = line3;
    short line4[3];
    for (int i = 0; i < 3; i++) {
        *(line4 + i) = (short)*(sens_humd_atm + i);
    }
    *(matrix + 3) = line4;
    short line5[3];
    for (int i = 0; i < 3; i++) {
        *(line5 + i) = (short)*(sens_humd_solo + i);
    }
    *(matrix + 4) = line5;
    short line6[3];
    for (int i = 0; i < 3; i++) {
        *(line6 + i) = (short)*(sens_pluvio + i);
    }
    *(matrix + 5) = line6;
    return matrix;
}
