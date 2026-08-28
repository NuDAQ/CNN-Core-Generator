//Numpy array shape [7]
//Min -0.562500000000
//Max 0.312500000000
//Number of zeros 0

#ifndef B4_H_
#define B4_H_

#ifndef __SYNTHESIS__
q_conv2d_bias_t b4[7];
#else
q_conv2d_bias_t b4[7] = {-0.4375, 0.3125, -0.4375, -0.5000, 0.2500, 0.2500, -0.5625};

#endif

#endif
