
////////////////////////////////////////////////////////////////////////////////////////////////
//
//		Divergence Free Noise 3D Vector Field Function
//
////////////////////////////////////////////////////////////////////////////////////////////////
// This token will be replaced with function name via RegExpr: "FN_"

// ensures the function is defined only once per instance
#ifndef FN_BODY 
#define FN_BODY

// DEFINES
#ifndef FN_NOISEBASIS
#define FN_NOISEBASIS perlinDFV
#endif

#ifndef FN_WORLEYOPTIONS
#define FN_WORLEYOPTIONS
#endif

#ifndef NOISE_FXH
#include <packs\happy.fxh\noise.fxh>
#endif



// parameters
float3 FN_noiseFreq : FN_NOISEFREQ = 2; 
float3 FN_noiseAmp : FN_NOISEAMP = .1; 
float3 FN_noiseOffset : FN_NOISEOFFSET;
float3 FN_center : FN_CENTER;
	

float3 FN_ (float3 p)
{
	return FN_NOISEBASIS(p * FN_noiseFreq + FN_noiseOffset FN_WORLEYOPTIONS) * FN_noiseAmp + FN_center;
}
// end of the function body
#endif 

////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef VF3D
#define VF3D FN_
#endif
////////////////////////////////////////////////////////////////////////////////////////////////



technique11 RemoveMe{}

