short** createMatrix(char *sens_temp, unsigned char *sens_velc_vento, unsigned short *sens_dir_vento,
unsigned char *sens_humd_atm, unsigned char *sens_humd_solo, unsigned char *sens_pluvio) {
    short matrix[6][3];
    for (int i = 0; i < 3; i++) {
        matrix[0][i] = (short) sens_temp[i];
        matrix[1][i] = (short) sens_velc_vento[i];
        matrix[2][i] = (short) sens_dir_vento[i];
        matrix[3][i] = (short) sens_humd_atm[i];
        matrix[4][i] = (short) sens_humd_solo[i];
        matrix[5][i] = (short) sens_pluvio[i];
    }
    return matrix;
}
