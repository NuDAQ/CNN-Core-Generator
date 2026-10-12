//Numpy array shape [12]
//Min -0.312500000000
//Max 0.312500000000
//Number of zeros 0

#ifndef B3_H_
#define B3_H_

#ifndef __SYNTHESIS__
q_conv2d_bias_t b3[12];
#else
q_conv2d_bias_t b3[12] = {0.3125, -0.2500, -0.3125, 0.1875, -0.2500, -0.1875, 0.2500, -0.2500, 0.2500, -0.2500, 0.1875, 0.1875};

#endif

#endif
