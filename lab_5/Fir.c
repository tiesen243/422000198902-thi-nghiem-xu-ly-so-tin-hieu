//Fir.c  FIR filter with the C6416 DSK. Include coefficient file 
#include "lp1500_256.cof"		   		//coefficient file
//#include "lp_chuan.h"
#include "dsk6416_aic23.h"				//codec-dsk support file
Uint32 fs=DSK6416_AIC23_FREQ_48KHZ;	//set sampling rate
int yn = 0;				   				//initialize filter's output
int i;
int gain=1;
short dly[N];  
short gbuffer[200];                  	//delay samples
short h1[128];

interrupt void c_int11()	   		//ISR
{
 short i;
 dly[0]=input_sample();					//input newest sample
 yn = 0;                   	 		//initialize filter's output
 for (i = 0; i< N/2; i++)
	yn += (h[i] * dly[i]);  			//y(n) += h(i)* x(n-i)
 for (i = N/2-1; i > 0; i--)  			//starting @ end of buffer
   dly[i] = dly[i-1];      			//update delays with data move
 output_sample((short)(yn>>15)*gain);    	//scale output filter sample
 gbuffer[i]=((short)(yn>>15)); 
 return;
}

void main()
{
	for(i=0;i<128;i++)
	    h1[i]=h[2*i];
    comm_intr();               		//init DSK, codec, McBSP
  	while(1);                  		//infinite loop
}

