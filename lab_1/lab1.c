#include <stdio.h>
#include <math.h>          // Standard C output library
#include "dsk6416_aic23.h" // support file for codec,DSK

Uint32 fs = DSK6416_AIC23_FREQ_16KHZ; // set sampling rate
// Prototypes
void blockSine(short *buf, int len);
void blockGenerate(short *buf, int len, int waveType);

// Declarations
#define BUFFSIZE 128

// Global Variables
short gBuffer[BUFFSIZE];

//  ======== main ========
//  Simple function which calls blockSine
void main()
{
    c6416_dsk_init();
    DSK6416_LED_init(); // init LED from BSL
    DSK6416_DIP_init(); // init DIP from BSL

    printf("dsp lab1\n");
    blockGenerate(gBuffer, BUFFSIZE, 1); // Fill buffer with sine data
    printf("Bo nho gBuffer (o dia chi %d) duoc dien voi du lieu  Sin\n", gBuffer);

    while (1)
    {
        if (DSK6416_DIP_get(0) == 0) // =0 if DIP switch #0 pressed
            DSK6416_LED_on(0);       // turn LED #0 ON
        else
            DSK6416_LED_off(0); // turn LED #0 OFF
    }
}
