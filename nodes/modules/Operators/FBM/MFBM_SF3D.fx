
////////////////////////////////////////////////////////////////////////////////////////////////
//
//		3D Scalar FBM Fractal Sum
//
////////////////////////////////////////////////////////////////////////////////////////////////
// This token will be replaced with function name via RegExpr: "FN_"

// ensures the function is defined only once per instance
#ifndef FN_BODY 
#define FN_BODY

#ifndef NOISE_FXH
#include <packs\happy.fxh\noise.fxh>
#endif

// Input SF3D function placeholder
#ifndef FN_INPUT
#define FN_INPUT length
#endif

// DEFINES

// parameters
float FN_persistence : FN_PERSISTENCE = 0.5;  
float FN_lacunarity : FN_LACUNARITY = 2;    
int FN_octaves: FN_OCTAVES = 4;  

// Persitance Defualt
#ifndef FN_PERSINPUT
float PERSDEFUALT(float3 p)
{
	return FN_persistence;
}
#define FN_PERSINPUT PERSDEFUALT
#endif

float FN_ (float3 p)
{
	MFBM(FN_noise, FN_INPUT, p, FN_persistence, FN_lacunarity, FN_octaves);     
	return FN_noise;
}
// end of the function body
#endif 

////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef SF3D
#define SF3D FN_
#endif
////////////////////////////////////////////////////////////////////////////////////////////////



technique11 RemoveMe{}

