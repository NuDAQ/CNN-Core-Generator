//Numpy array shape [7]
//Min -0.875000000000
//Max 0.375000000000
//Number of zeros 0

#ifndef B4_H_
#define B4_H_

#ifndef __SYNTHESIS__
q_conv2d_bias_t b4[7];
#else
q_conv2d_bias_t b4[7] = {-0.8125, -0.6250, -0.3750, -0.8750, -0.8750, 0.3750, -0.2500};

#endif

#endif
