char checkValueInRangeChar(unsigned short max, unsigned short min, unsigned short generated)
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
