#include "DSK6713_AIC23.h"

Uint32 fs = DSK6713_AIC23_FREQ_8KHZ;
short amp = 1;

void main() {
    short baseband[20] = {1000, 951, 809, 587, 309, 0, -309, -587, -809, -951, 
        -1000, -951, -809, -587, -309, 0, 309, 587, 809, 951}; // 400 Hz baseband
    short carrier[20] = {1000, 0, -1000, 0, 1000, 0, -1000, 0, 1000, 0,
        -1000, 0, 1000, 0, -1000, 0, 1000, 0, -1000, 0}; // 2 kHz carrier
    
    short output[20];
    short k;

    comm_poll();

    while (1) {
        for (k = 0; k < 20; k++) {
            output[k] = carrier[k] + ((amp * baseband[k] * carrier[k]/10) >> 12);
            output_sample(20 * output[k]);
        }
    }
}