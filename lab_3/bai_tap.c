// Sine8_LED.c  Sine generation with DIP switch control
#include "dsk6416_aic23.h" //support file for codec,DSK
#include <math.h>

unsigned int _fs = DSK6416_AIC23_FREQ_48KHZ;

#define BUFFSIZE 128
#define PI 3.14159265358979323846

short sine_table[8] = {0, 707, 1000, 707, 0, -707, -1000, -707};
short gBuffer[BUFFSIZE];
float phase3k = 0.0f;
float phase6k = 0.0f;
const float w3k = (2.0f * (float)PI * 3000.0f) / 48000.0f;
const float w6k = (2.0f * (float)PI * 6000.0f) / 48000.0f;
short idx = 0;

void _main()
{
    // comm_poll();               		//init DSK,codec,McBSP
    c6416_dsk_init();
    DSK6416_LED_init(); // init LED from BSL
    DSK6416_DIP_init(); // init DIP from BSL

    while (1) // infinite loop
    {
        if (DSK6416_DIP_get(1) == 0) // DIP1 pressed: output dual tone 3kHz + 6kHz
        {
            float tone = 0.5f * (sinf(phase3k) + sinf(phase6k));
            short sample = (short)(12000.0f * tone);

            DSK6416_LED_on(1);
            output_left_sample(sample);

            gBuffer[idx] = sample;
            idx++;
            if (idx >= BUFFSIZE)
                idx = 0;

            phase3k += w3k;
            phase6k += w6k;
            if (phase3k >= 2.0f * (float)PI)
                phase3k -= 2.0f * (float)PI;
            if (phase6k >= 2.0f * (float)PI)
                phase6k -= 2.0f * (float)PI;
        }
        else
        {
            DSK6416_LED_off(1);
            output_left_sample(0);
        }
    }
}
