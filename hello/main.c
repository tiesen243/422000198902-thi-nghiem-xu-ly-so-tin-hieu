// Sine8_LED.c  Sine generation with DIP switch control
#include "dsk6416_aic23.h" //support file for codec,DSK
#include <math.h>
#define M 24
Uint32 fs = DSK6416_AIC23_FREQ_48KHZ; // set sampling rate
short loop = 0;
short i = 0;         // table index
short gain = 1;      // gain factor
short sine_table[M]; // sine values
#define BUFFSIZE 128

// Global Variables
short gBuffer[BUFFSIZE];
void main()
{
   // comm_poll();                     //init DSK,codec,McBSP
   c6416_dsk_init();

   DSK6416_LED_init(); // init LED from BSL
   DSK6416_DIP_init(); // init DIP from BSL
   for (i = 0; i < M; i++)
      sine_table[i] = 1000 * sin(3.14 * 2 * i / M);
   while (1) // infinite loop
      for (i = 0; i < BUFFSIZE; i++)
      {
         if (DSK6416_DIP_get(0) == 0) //=0 if DIP switch #0 pressed
         {
            DSK6416_LED_on(0); // turn LED #0 ON
            for (loop = 0; loop < M; loop++)
            {
               output_sample(sine_table[loop] * gain); // output sine values
               gBuffer[i + loop] = (sine_table[loop] * gain);
            }
            if (loop == M)
               i = i + loop - 1, loop = 0; // check for end of table
         }
         else
            DSK6416_LED_off(0); // turn LED off if not pressed
      } // end of while(1) infinite loop
} // end of main
