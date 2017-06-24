////////////////////////////////////////////////////////////////////////////////////////////////
//
//		3D Vector Noise Basis Functions
//
////////////////////////////////////////////////////////////////////////////////////////////////
// This token will be replaced with function name via RegExpr: "FN_"
#ifndef VF3D

#ifndef NOISE_FXH
#include <packs\happy.fxh\noise.fxh>
#endif

#ifndef MAP_FXH
#include <packs\happy.fxh\map.fxh>
#endif

// DEFINES
#ifndef FN_NOISEBASIS
#define FN_NOISEBASIS simplex3
#endif

#ifndef FN_WORLEYOPTIONS
#define FN_WORLEYOPTIONS
#endif

#ifndef FN_INFLECTION
#define FN_INFLECTION 0
#endif

// paramaters
float3 FN_freq : FN_FREQ = 2; 
float3 FN_amp : FN_AMP = .1; 
float3 FN_center : FN_CENTER; 
float3 FN_bias : FN_BIAS = 0.5;
float3 FN_domainOffset : FN_DOMAINOFFSET;

float3 FN_ (float3 p)
{
	p = p * FN_freq + FN_domainOffset;
	
	float3 noise = FN_NOISEBASIS(p  FN_WORLEYOPTIONS);
	noise.x = sign(noise.x) * bias(abs(noise.x), FN_bias.x);
	noise.y = sign(noise.y) * bias(abs(noise.y), FN_bias.y);
	noise.z = sign(noise.z) * bias(abs(noise.z), FN_bias.z);
	#if FN_INFLECTION == 1
	// Billow
	noise = abs(noise);
	#elif FN_INFLECTION == 2
	//Ridge
	noise = 1 - abs(noise);
	#endif
	return noise * FN_amp + FN_center;
}


#define VF3D FN_
#endif
////////////////////////////////////////////////////////////////////////////////////////////////



technique11 RemoveMe{}

