////////////////////////////////////////////////////////////////////////////////////////////////
//
//		3D Noise Basis Functions
//
////////////////////////////////////////////////////////////////////////////////////////////////
// This token will be replaced with function name via RegExpr: "FN_"
#ifndef SF3D

#ifndef NOISE_FXH
#include <packs\happy.fxh\noise.fxh>
#endif

#ifndef MAP_FXH
#include <packs\happy.fxh\map.fxh>
#endif

// DEFINES
#ifndef FN_NOISEBASIS
#define FN_NOISEBASIS perlin
#endif

#ifndef FN_WORLEYOPTIONS
#define FN_WORLEYOPTIONS
#endif

#ifndef FN_INFLECTION
#define FN_INFLECTION 0
#endif

// paramaters
float FN_freq : FN_FREQ = 2; 
float FN_amp : FN_AMP = .1; 
float FN_center : FN_CENTER; 
float FN_bias : FN_BIAS = 0.5;
float3 FN_domainOffset : FN_DOMAINOFFSET;
	


float FN_ (float3 p)
{
	p = p * FN_freq + FN_domainOffset;
	float noise = FN_NOISEBASIS(p  FN_WORLEYOPTIONS);
	noise = sign(noise) * bias(abs(noise), FN_bias);
	#if FN_INFLECTION == 1
	// Billow
	noise = abs(noise);
	#elif FN_INFLECTION == 2
	//Ridge
	noise = 1 - abs(noise);
	#endif
	return noise * noise * FN_amp + FN_center;
}


#define SF3D FN_
#endif
////////////////////////////////////////////////////////////////////////////////////////////////



technique11 RemoveMe{}

