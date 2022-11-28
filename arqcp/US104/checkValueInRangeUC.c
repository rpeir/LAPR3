char checkValueInRangeChar(unsigned char max, unsigned char min, unsigned char generated)
{
    if (generated < max && generated > min)
    {
        return 1;
    }
    else
    {
        return 0;
    }
}
