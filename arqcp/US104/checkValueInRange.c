char checkValueInRangeChar(char max,char min, char generated){
    if (generated<max && generated>min){
        return 1;
    }else{
        return 0;
    }
}

char checkValueInRangeUC(unsigned char max, unsigned char min, unsigned char generated){
    if (generated < max && generated > min){
        return 1;
    }else{
        return 0;
    }
}

char checkValueInRangeUS(unsigned short max, unsigned short min, unsigned short generated){
    if (generated < max && generated > min){
        return 1;
    }else{
        return 0;
    }
}