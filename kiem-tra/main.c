/*
 * main.c
 *
 *  Created on: Apr 22, 2026
 *      Author: Tran Tien (2265399)
 */

#include "dsk6416_aic23.h"
#include "lp5000_256.cof"

Uint32 fs = DSK6416_AIC23_FREQ_16KHZ;

#define BUFF_SIZE 256
short buffer_in[BUFF_SIZE],
    buffer_out[BUFF_SIZE];
int buff_ptr;

short sin_table_1[8] = {0, 707, 1000, 707, 0, -707, -1000, -707};
short sin_table_2[4] = {0, 707, 0, -707};

short diy[N], gain = 1;
long yn = 0;

short x1, x2, x_in, y_out;
int i, idx_1, idx_2;

void main() {
    c6416_dsk_init();

    DSK6416_DIP_init();
    DSK6416_LED_init();

    while (1) {
        if (DSK6416_DIP_get(0) == 0) {
            DSK6416_LED_on(0);

            x1 = sin_table_1[idx_1];
            x2 = sin_table_2[idx_2];
            x_in = (x1 + x2);

            idx_1 = (idx_1 + 1) % (sizeof(sin_table_1) / sizeof(sin_table_1[0]));
            idx_2 = (idx_2 + 1) % (sizeof(sin_table_2) / sizeof(sin_table_2[0]));

            diy[0] = x_in;
            yn = 0;
            for (i = 0; i < N; i++) {
                yn += (long)h[i] * diy[i];
            }

            for (i = N / 2 - 1; i > 0; i--) {
                diy[i] = diy[i - 1];
            }

            y_out = (short)(yn >> 15) * gain;

            buffer_in[buff_ptr] = x_in;
            buffer_out[buff_ptr] = y_out;
            buff_ptr = (buff_ptr + 1) % BUFF_SIZE;

            output_sample(y_out);
        } else {
            DSK6416_LED_off(0);
        }
    }
}
