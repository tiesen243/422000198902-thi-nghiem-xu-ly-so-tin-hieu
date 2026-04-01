//  ======== block_sine.c =================================
//  The coefficient A and the three initial values
//  generate a 500Hz tone (sine wave) when running
//  at a sample rate of 48KHz.
//
//  Even though the calculations are done in floating
//  point, this function returns a short value since
//  this is what's needed by a 16-bit codec (DAC).

//  ======== Prototypes ===================================
#include <math.h>
void blockSine(short *buf, int len);
short sineGen(void);

// fton=500;
// fs=4800;
// aaa=fton/fs;
//   ======== Definitions ==================================
//  Initial values
#define Y1 0.065403129230143066815315558775175 // sin(aaa)  // = sin((f_tone/f_samp) * 360)
// #define Y1 -0.5
// = sin((500Hz / 48KHz) * 360)
// = sin (3.75)
#define AA 1.9957178464772070134761395825456 // = 2 * cos(3.75)
// #define AA 1.7320508075688772

//	======== Globals =====================================
static float y[3] = {0, Y1, 0};
static float A = AA;

//	======== sineGen ======================================
//  Generate a single element of sine data

short sineGen(void)
{
    y[0] = y[1] * A - y[2];
    y[2] = y[1];
    y[1] = y[0];

    // To scale full 16-bit range we would multiply y[0]
    //   by 32768 using a number slightly less than this
    //   (such as 32000) helps to prevent overflow.
    y[0] *= 32000;

    // We recast the result to a short value upon returning it
    //  since the D/A converter is programmed to accept 16-bit
    //  signed values.
    return ((short)y[0]);
}

//	======== squareGen ======================================
//  Generate a single element of SQUARE wave (unipolar)
//  Based on sine value: if sin >= 0, output high; else low

short squareGen(void)
{
    // Use sineGen to get phase progression
    float sinVal = y[1] * A - y[2]; // Calculate without updating y
    y[0] = sinVal;
    y[2] = y[1];
    y[1] = y[0];

    // Square wave: high (16000) if sin >= 0, low (0) if sin < 0
    if (sinVal >= 0)
        return 16000; // High level
    else
        return 0; // Low level (unipolar)
}

//	======== triangleGen ======================================
//  Generate a single element of TRIANGLE wave
//  Peak at 16000, valley at -16000, linear slopes

static int trianglePhase = 0; // Phase counter 0 to 4*len-1
#define TRIANGLE_PERIOD 256   // Samples per period (tune to match sine period)

short triangleGen(void)
{
    short output;
    int phase = trianglePhase % TRIANGLE_PERIOD;

    // Triangle ramp: 4 quarters
    if (phase < TRIANGLE_PERIOD / 4)
        output = (short)(16000 * phase / (TRIANGLE_PERIOD / 4)); // Rising
    else if (phase < TRIANGLE_PERIOD / 2)
        output = (short)(16000 - 16000 * (phase - TRIANGLE_PERIOD / 4) / (TRIANGLE_PERIOD / 4)); // Falling
    else if (phase < 3 * TRIANGLE_PERIOD / 4)
        output = (short)(-16000 * (phase - TRIANGLE_PERIOD / 2) / (TRIANGLE_PERIOD / 4)); // Falling to -16000
    else
        output = (short)(-16000 + 16000 * (phase - 3 * TRIANGLE_PERIOD / 4) / (TRIANGLE_PERIOD / 4)); // Rising back

    trianglePhase++;
    return output;
}

//	======== blockGenerate ======================================
//  Generate a block of waveform data
//  waveType: 0=sine, 1=square, 2=triangle

void blockGenerate(short *buf, int len, int waveType)
{
    int i = 0;
    for (i = 0; i < len; i++)
    {
        if (waveType == 0)
            buf[i] = sineGen(); // Sine wave
        else if (waveType == 1)
            buf[i] = squareGen(); // Square wave
        else if (waveType == 2)
            buf[i] = triangleGen(); // Triangle wave
        else
            buf[i] = sineGen(); // Default to sine
    }
}

//	======== blockSine ========
//  Generate a block of sine data using sineGen
void blockSine(short *buf, int len)
{

    int i = 0;
    for (i = 0; i < len; i++)
    {
        buf[i] = squareGen();
    }
}
