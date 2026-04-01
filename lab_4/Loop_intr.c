//Loop_intr.c Loop program with the DSK6416. Output = delayed input

#include "dsk6416_aic23.h"				//codec-DSK support file
Uint32 fs = DSK6416_AIC23_FREQ_48KHZ;	//set sampling rate
int gain = 1;

interrupt void c_int11()         	//interrupt service routine
{
    short sample_data;

    sample_data = input_sample(); 	//input data
    output_sample(sample_data * gain);   	//output data
    return;
}

void main()
{

    comm_intr();                   	//init DSK, codec, McBSP
    while (1)
        ;                	   	//infinite loop
}
