#include <iostream>
extern "C" long int gravity();

int main ()
{
    printf("\nWelcome to Gravitational Attraction maintained by Carolynn Madriaga.\n");
    printf("This program was last updated on March 20, 2022");

    long int code = -99;

    code = driver_mod();

    printf("\nThe driver module recieved this integer: %ld\n", code);
    printf("End of demonstration test.\n");

    return 0;

}