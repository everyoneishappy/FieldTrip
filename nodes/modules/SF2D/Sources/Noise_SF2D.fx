////////////////////////////////////////////////////////////////////////////////////////////////
//
//		2D Noise Basis Functions
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

// DEFINES // preprocessor options from patch inserted here
#ifndef FN_NOISEBASIS
#define FN_NOISEBASIS perlin
#endif

#ifndef FN_WORLEYOPTIONS
#define FN_WORLEYOPTIONS
#endif

#ifndef FN_INFLECTION
#define FN_INFLECTION 0
#endif

#ifndef FN_USETIME
#define FN_USETIME 0
#endif

// Paramaters
float FN_freq : FN_FREQ = 2; 
float FN_amp : FN_AMP = .1; 
float FN_center : FN_CENTER; 
float FN_bias : FN_BIAS = 0.5;
float FN_time : FN_TIME; 
float2 FN_domainOffset : FN_DOMAINOFFSET;
	


float FN_ (float2 p)
{
	p = p * FN_freq + FN_domainOffset;
	
	#if FN_USETIME == 1
	float3 pt = float3(p, FN_time);
	float noise = FN_NOISEBASIS(pt FN_WORLEYOPTIONS);
	#else
	float noise = FN_NOISEBASIS(p FN_WORLEYOPTIONS);
	#endif
	
	noise = sign(noise) * bias(abs(noise), FN_bias);
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
#ifndef SF2D
#define SF2D FN_
#endif
////////////////////////////////////////////////////////////////////////////////////////////////



technique11 RemoveMe{}

