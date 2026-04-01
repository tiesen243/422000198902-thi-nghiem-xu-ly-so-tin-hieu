#include "DSK6713_AIC23.h"

Uint32 fs = DSK6713_AIC23_FREQ_8KHZ;
short input, output;
short buffer[8000];
short buffer_length = 1000;
short i = 0, delay = 3, delay_flag = 1, amp = 5, echo_type = 1;

void main()
{
    comm_poll();

    while (1)
    {
        short new_count = (i - 1) % buffer_length;
        output = input + 0.1 * amp * buffer[i];

        if (echo_type == 1)
        {
            new_count = (i - 1) % buffer_length;
            buffer[new_count] = output;
        }

        output_sample(output);
        input = input_sample();

        if (delay_flag != delay)
        {
            delay_flag = delay;
            buffer_length = 1000 * delay;

            i = 0;
        }

        buffer[i] = input;
        i++;

        if (i == buffer_length)
            i = 0;
    }
}