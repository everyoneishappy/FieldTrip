////////////////////////////////////////////////////////////////////////////////////////////////
//
//		2D Vector Noise Basis Functions
//
////////////////////////////////////////////////////////////////////////////////////////////////
// This token will be replaced with function name via RegExpr: "FN_"

// ensures the function is defined only once per instance
#ifndef FN_BODY 
#define FN_BODY

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

// parameters
float2 FN_freq : FN_FREQ = 2; 
float2 FN_amp : FN_AMP = .1; 
float2 FN_center : FN_CENTER; 
float2 FN_bias : FN_BIAS = 0.5;
float2 FN_domainOffset : FN_DOMAINOFFSET;
	


float2 FN_ (float2 p)
{
	p = p * FN_freq + FN_domainOffset;
	
	float2 noise = FN_NOISEBASIS(p FN_WORLEYOPTIONS);
	noise.x = sign(noise.x) * bias(abs(noise.x), FN_bias.x);
	noise.y = sign(noise.y) * bias(abs(noise.y), FN_bias.y);
	#if FN_INFLECTION == 1
	// Billow
	noise = abs(noise);
	#elif FN_INFLECTION == 2
	//Ridge
	noise = 1 - abs(noise);
	#endif
	return noise * FN_amp + FN_center;
}
// end of the function body
#endif 

////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef VF2D
#define VF2D FN_
#endif
////////////////////////////////////////////////////////////////////////////////////////////////



technique11 RemoveMe{}

