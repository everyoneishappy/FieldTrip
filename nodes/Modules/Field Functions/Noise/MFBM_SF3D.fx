#ifndef CALC_FXH
#include <packs\happy.fxh\calc.fxh>
#endif

////////////////////////////////////////////////////////////////////////////////////////////////
//
//		3D Scalar FBM Fractal Sum
//
////////////////////////////////////////////////////////////////////////////////////////////////
// This token will be replaced with function name via RegExpr: "FN_"
#ifndef SF3D

// Input function placeholder
#ifndef FN_INPUT
#define FN_INPUT placeHolderS3
#endif



// DEFINES

#ifndef NOISE_FXH
#include <packs\happy.fxh\noise.fxh>
#endif


// paramaters
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

#define SF3D FN_

#endif
////////////////////////////////////////////////////////////////////////////////////////////////



technique11 RemoveMe{}

