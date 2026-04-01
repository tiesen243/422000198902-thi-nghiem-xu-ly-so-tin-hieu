//IIR.c  IIR filter using cascaded Direct Form II
//Coefficients a's and b's correspond to b's and a's from MATLAB

#include "DSK6416_AIC23.h"              //codec-DSK support file
Uint32 fs=DSK6416_AIC23_FREQ_48KHZ;     //set sampling rate
//#include "bp2002.cof" //ok
//#include "fda_iir.h"  //ok
//#include "float_hsl.h" //ok
#include "fdacoef1.h"
//#include "impinv3.cof"               //coefficient file
float w[NUM_SECTIONS][2] = {0};
int gain=0.0000001;

interrupt void c_int11()                //ISR
{  
   int section; //index for section number
   float input; //input to each section
   float wn,yn; //intermediate and output               //input to 1st stage
   input = ((float)input_left_sample());
   
 for (section=0 ; section< NUM_SECTIONS ; section++)        //repeat for each stage
 {
    wn = input - a[section][0]*w[section][0]- a[section][1]*w[section][1];
    yn = b[section][0]*wn + b[section][1]*w[section][0] + b[section][2]*w[section][1];
    w[section][1] = w[section][0];
    w[section][0] = wn*gain;
    input = yn; //output of current section //intermediate output->input to next stage
 }
  output_left_sample((short)(yn)); //before writing to codec
    return;                         //return from ISR
}

void main()
{
//  c6416_dsk_init();            // chu y co nhung dong khoi lap nay ct ngat se ko chay duoc
//  DSK6416_LED_init();             //init LED from BSL
//  DSK6416_DIP_init();             //init DIP from BSL
 
  
 
  comm_intr();                      //init DSK, codec, McBSP
  while(1);
    //infinite loop
}

