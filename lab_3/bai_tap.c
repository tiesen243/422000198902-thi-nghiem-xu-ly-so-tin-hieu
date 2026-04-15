// Sine8_LED.c  Sine generation with DIP switch control
#include "dsk6416_aic23.h" //support file for codec,DSK
#include <math.h>

Uint32 fs = DSK6416_AIC23_FREQ_48KHZ;

#define BUFFSIZE 128
#define PI 3.14159265358979323846

short gBuffer[BUFFSIZE];
short z = 0, _gain = 1;

void main()
{
    // comm_poll();               		//init DSK,codec,McBSP
    c6416_dsk_init();
    DSK6416_LED_init(); // init LED from BSL
    DSK6416_DIP_init(); // init DIP from BSL

    /* Bai 1
    const float w3k = (2.0f * (float)PI * 3000.0f) / 48000.0f;
    const float w6k = (2.0f * (float)PI * 6000.0f) / 48000.0f;
    float phase3k = 0.0f;
    float phase6k = 0.0f;

    const float w2_4k = (2.0f * (float)PI * 2400.0f) / 48000.0f;
    const float w4_8k = (2.0f * (float)PI * 4800.0f) / 48000.0f;
    float phase2_4k = 0.0f;
    float phase4_8k = 0.0f;
    while (1) // infinite loop
    {
        if (DSK6416_DIP_get(1) == 0) // DIP1 pressed: output dual tone 3kHz + 6kHz
        {
            float tone = 0.5f * (sinf(phase3k) + sinf(phase6k));
            short sample = (short)(12000.0f * tone);

            DSK6416_LED_on(1);
            output_left_sample(sample);

            gBuffer[z] = sample;
            z++;
            if (z >= BUFFSIZE)
                z = 0;

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

        if (DSK6416_DIP_get(2) == 0) // DIP2 pressed: output dual tone 2.4kHz + 4.8kHz
        {
            float tone = 0.5f * (sinf(phase2_4k) + sinf(phase4_8k));
            short sample = (short)(12000.0f * tone);

            DSK6416_LED_on(2);
            output_left_sample(sample);

            gBuffer[z] = sample;
            z++;
            if (z >= BUFFSIZE)
                z = 0;

            phase2_4k += w2_4k;
            phase4_8k += w4_8k;
            if (phase2_4k >= 2.0f * (float)PI)
                phase2_4k -= 2.0f * (float)PI;
            if (phase4_8k >= 2.0f * (float)PI)
                phase4_8k -= 2.0f * (float)PI;
        }
        else
        {
            DSK6416_LED_off(2);
            output_left_sample(0);
        }
    }
    */

    /* Bai 2
    const float w697 = (2.0f * (float)PI * 697.0f) / 48000.0f;
    const float w770 = (2.0f * (float)PI * 770.0f) / 48000.0f;
    const float w941 = (2.0f * (float)PI * 941.0f) / 48000.0f;
    const float w1209 = (2.0f * (float)PI * 1209.0f) / 48000.0f;
    float phase697 = 0.0f;
    float phase770 = 0.0f;
    float phase941 = 0.0f;
    float phase1209 = 0.0f;

    while (1)
    {
        if (DSK6416_DIP_get(0) == 0)
        {
            float tone = 0.5f * (sinf(phase697) + sinf(phase1209));
            short sample = (short)(12000.0f * tone);

            DSK6416_LED_on(0);
            output_left_sample(sample);

            gBuffer[z] = sample;
            z++;
            if (z >= BUFFSIZE)
                z = 0;

            phase697 += w697;
            phase1209 += w1209;
            if (phase697 >= 2.0f * (float)PI)
                phase697 -= 2.0f * (float)PI;
            if (phase1209 >= 2.0f * (float)PI)
                phase1209 -= 2.0f * (float)PI;
        }
        else
        {
            DSK6416_LED_off(0);
            output_left_sample(0);
        }

        if (DSK6416_DIP_get(1) == 0)
        {
            float tone = 0.5f * (sinf(phase770) + sinf(phase1209));
            short sample = (short)(12000.0f * tone);

            DSK6416_LED_on(1);
            output_left_sample(sample);

            gBuffer[z] = sample;
            z++;
            if (z >= BUFFSIZE)
                z = 0;

            phase770 += w770;
            phase1209 += w1209;
            if (phase770 >= 2.0f * (float)PI)
                phase770 -= 2.0f * (float)PI;
            if (phase1209 >= 2.0f * (float)PI)
                phase1209 -= 2.0f * (float)PI;
        }
        else
        {
            DSK6416_LED_off(1);
            output_left_sample(0);
        }

        if (DSK6416_DIP_get(2) == 0)
        {
            float tone = 0.5f * (sinf(phase941) + sinf(phase1209));
            short sample = (short)(12000.0f * tone);

            DSK6416_LED_on(2);
            output_left_sample(sample);

            gBuffer[z] = sample;
            z++;
            if (z >= BUFFSIZE)
                z = 0;

            phase941 += w941;
            phase1209 += w1209;
            if (phase941 >= 2.0f * (float)PI)
                phase941 -= 2.0f * (float)PI;
            if (phase1209 >= 2.0f * (float)PI)
                phase1209 -= 2.0f * (float)PI;
        }
        else
        {
            DSK6416_LED_off(2);
            output_left_sample(0);
        }

        if (DSK6416_DIP_get(3) == 0)
        {
            float tone = 0.5f * (sinf(phase941) + sinf(phase1209));
            short sample = (short)(12000.0f * tone);

            DSK6416_LED_on(3);
            output_left_sample(sample);

            gBuffer[z] = sample;
            z++;
            if (z >= BUFFSIZE)
                z = 0;

            phase941 += w941;
            phase1209 += w1209;
            if (phase941 >= 2.0f * (float)PI)
                phase941 -= 2.0f * (float)PI;
            if (phase1209 >= 2.0f * (float)PI)
                phase1209 -= 2.0f * (float)PI;
        }
        else
        {
            DSK6416_LED_off(3);
            output_left_sample(0);
        }
    }
    */

    // Intro Ballad: Am Em7 G C Am Em7 G Am
    const float wA3 = (2.0f * (float)PI * 220.00f) / 48000.0f;
    const float wB3 = (2.0f * (float)PI * 246.94f) / 48000.0f;
    const float wC4 = (2.0f * (float)PI * 261.63f) / 48000.0f;
    const float wD4 = (2.0f * (float)PI * 293.66f) / 48000.0f;
    const float wE4 = (2.0f * (float)PI * 329.63f) / 48000.0f;
    const float wG4 = (2.0f * (float)PI * 392.00f) / 48000.0f;

    const float fA4 = 440.00f;
    const float fB4 = 493.88f;
    const float fC5 = 523.25f;
    const float fD5 = 587.33f;
    const float fE5 = 659.25f;
    const float fG5 = 783.99f;

    float phaseA3 = 0.0f;
    float phaseB3 = 0.0f;
    float phaseC4 = 0.0f;
    float phaseD4 = 0.0f;
    float phaseE4 = 0.0f;
    float phaseG4 = 0.0f;
    float phaseLead = 0.0f;

    const int bpm = 78;
    const int samplesPerBeat = (48000 * 60) / bpm;
    const int chordSeq[8] = {0, 1, 2, 3, 0, 1, 2, 0};
    const int chordBeats[8] = {2, 2, 2, 2, 2, 2, 2, 2};
    int chordIndex = 0;
    int sampleCount = 0;

    while (1)
    {
        // 0: Am(A-C-E), 1: Em7(E-G-B-D), 2: G(G-B-D), 3: C(C-E-G)
        float padSample = 0.0f;
        float leadSample = 0.0f;
        float sampleFloat = 0.0f;
        float melodyFreq = 0.0f;
        int chord = chordSeq[chordIndex];
        int chordSamples = chordBeats[chordIndex] * samplesPerBeat;
        int subStep = (sampleCount * 8) / chordSamples;

        if (subStep > 7)
            subStep = 7;

        if (chord == 0)
        {
            padSample = (sinf(phaseA3) + sinf(phaseC4) + sinf(phaseE4)) / 3.0f;

            phaseA3 += wA3;
            phaseC4 += wC4;
            phaseE4 += wE4;

            if (phaseA3 >= 2.0f * (float)PI)
                phaseA3 -= 2.0f * (float)PI;
            if (phaseC4 >= 2.0f * (float)PI)
                phaseC4 -= 2.0f * (float)PI;
            if (phaseE4 >= 2.0f * (float)PI)
                phaseE4 -= 2.0f * (float)PI;

            if (subStep == 0 || subStep == 4)
                melodyFreq = fA4;
            else if (subStep == 1 || subStep == 3 || subStep == 6)
                melodyFreq = fC5;
            else
                melodyFreq = fE5;
        }
        else if (chord == 1)
        {
            padSample = (sinf(phaseE4) + sinf(phaseG4) + sinf(phaseB3) + sinf(phaseD4)) * 0.25f;

            phaseE4 += wE4;
            phaseG4 += wG4;
            phaseB3 += wB3;
            phaseD4 += wD4;

            if (phaseE4 >= 2.0f * (float)PI)
                phaseE4 -= 2.0f * (float)PI;
            if (phaseG4 >= 2.0f * (float)PI)
                phaseG4 -= 2.0f * (float)PI;
            if (phaseB3 >= 2.0f * (float)PI)
                phaseB3 -= 2.0f * (float)PI;
            if (phaseD4 >= 2.0f * (float)PI)
                phaseD4 -= 2.0f * (float)PI;

            if (subStep == 0 || subStep == 4)
                melodyFreq = fE5;
            else if (subStep == 1 || subStep == 6)
                melodyFreq = fG5;
            else if (subStep == 2 || subStep == 5)
                melodyFreq = fB4;
            else
                melodyFreq = fD5;
        }
        else if (chord == 2)
        {
            padSample = (sinf(phaseG4) + sinf(phaseB3) + sinf(phaseD4)) / 3.0f;

            phaseG4 += wG4;
            phaseB3 += wB3;
            phaseD4 += wD4;

            if (phaseG4 >= 2.0f * (float)PI)
                phaseG4 -= 2.0f * (float)PI;
            if (phaseB3 >= 2.0f * (float)PI)
                phaseB3 -= 2.0f * (float)PI;
            if (phaseD4 >= 2.0f * (float)PI)
                phaseD4 -= 2.0f * (float)PI;

            if (subStep == 0 || subStep == 4)
                melodyFreq = fG5;
            else if (subStep == 1 || subStep == 3 || subStep == 6)
                melodyFreq = fB4;
            else
                melodyFreq = fD5;
        }
        else if (chord == 3)
        {
            padSample = (sinf(phaseC4) + sinf(phaseE4) + sinf(phaseG4)) / 3.0f;

            phaseC4 += wC4;
            phaseE4 += wE4;
            phaseG4 += wG4;

            if (phaseC4 >= 2.0f * (float)PI)
                phaseC4 -= 2.0f * (float)PI;
            if (phaseE4 >= 2.0f * (float)PI)
                phaseE4 -= 2.0f * (float)PI;
            if (phaseG4 >= 2.0f * (float)PI)
                phaseG4 -= 2.0f * (float)PI;

            if (subStep == 0 || subStep == 4)
                melodyFreq = fC5;
            else if (subStep == 1 || subStep == 3 || subStep == 6)
                melodyFreq = fE5;
            else
                melodyFreq = fG5;
        }

        phaseLead += (2.0f * (float)PI * melodyFreq) / 48000.0f;
        if (phaseLead >= 2.0f * (float)PI)
            phaseLead -= 2.0f * (float)PI;

        leadSample = sinf(phaseLead);
        sampleFloat = 0.68f * padSample + 0.32f * leadSample;

        {
            float t = (float)sampleCount / (float)chordSamples;
            float env = 1.0f;

            if (t < 0.08f)
                env = t / 0.08f;
            else if (t > 0.85f)
                env = (1.0f - t) / 0.15f;

            if (env < 0.0f)
                env = 0.0f;

            short sample = (short)(12000.0f * sampleFloat * env * _gain);
            gBuffer[z] = sample;
            output_left_sample(gBuffer[z]);

            z++;
            if (z >= BUFFSIZE)
                z = 0;
        }

        sampleCount++;
        if (sampleCount >= chordSamples)
        {
            sampleCount = 0;
            chordIndex++;
            if (chordIndex >= 8)
                chordIndex = 0;
        }
    }
}
