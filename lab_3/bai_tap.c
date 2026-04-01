// Sine8_LED.c  Sine generation with DIP switch control
#include "dsk6416_aic23.h" //support file for codec,DSK
#include <math.h>

#define BUFFSIZE 128
#define PI 3.14159265358979323846

short sine_table[8] = {0, 707, 1000, 707, 0, -707, -1000, -707};
short gBuffer[BUFFSIZE];

void main()
{
    // comm_poll();               		//init DSK,codec,McBSP
    c6416_dsk_init();
    DSK6416_LED_init(); // init LED from BSL
    DSK6416_DIP_init(); // init DIP from BSL

    while (1) // infinite loop
    {
        if (DSK6416_DIP_get(0) == 0) //=0 if DIP switch #0 pressed, DTMF output dual tone 3kHz and 6kHz, and register to buffer
        {
            DSK6416_LED_on(0); // turn LED #0 ON
        }
        else
            DSK6416_LED_off(0);
    }
}
