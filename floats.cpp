#include <iostream>
extern "C" bool floats(char []);

bool floats(char w[])
{
    bool answer = true;
    int index = 0;
    bool decimalGiven = false;

    if (w[0]== '-' || w[0=='+'])
    {
        index = 1;
    }

    while (!(w[index] == '\0') && answer)
    {
        if( w[index] == '.' && decimalGiven)
        {
            decimalGiven = true;
        }

        else
        {
            answer = answer && isdigit(w[index]);

            index++;
        }

        return result && decimalGiven;
    }
}