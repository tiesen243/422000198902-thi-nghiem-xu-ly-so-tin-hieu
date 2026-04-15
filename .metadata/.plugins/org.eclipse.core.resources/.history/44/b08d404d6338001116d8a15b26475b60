#include "lp1500_256.cof"
#include "dsk6416_aic23.h"

#include "record.h"

#define INPUT_LEN SPEECHBUF
#define OUTPUT_LEN INPUT_LEN

Uint32 fs = DSK6416_AIC23_FREQ_44KHZ;
int yn = 0;
int gain = 1;
short dly[N];
int temp = 0;

short y[OUTPUT_LEN];

void main()
{
	int i, n;
	comm_poll();
	DSK6416_LED_init();

	for (n = 0; n < OUTPUT_LEN; n++)
	{
		short i;

		dly[0] = Speech[n];
		yn = 0;

		for (i = 0; i < N; i++)
			yn += (h[i] * dly[i]);
		for (i = N - 1; i > 0; i--)
			dly[i] = dly[i - 1];

		output_sample((short)(yn >> 15) * gain);
		y[n] = ((short)(yn >> 15));
	}

	while (1)
	{
		if (DSK6416_DIP_get(0) == 0)
		{
			for (n = 0; n < SPEECHBUF; n++)
				output_sample(Speech[n]);
		}

		if (DSK6416_DIP_get(1) == 0)
		{
			for (n = 0; n < SPEECHBUF; n++)
				output_sample(y[n]);
		}
	}
}
