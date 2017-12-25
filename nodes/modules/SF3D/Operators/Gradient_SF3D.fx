
////////////////////////////////////////////////////////////////////////////////////////////////
//
//		Gradient from 3D Scaler Field Function
//
////////////////////////////////////////////////////////////////////////////////////////////////
// This token will be replaced with function name via RegExpr: "FN_"

// ensures the function is defined only once per instance
#ifndef FN_BODY 
#define FN_BODY

#ifndef CALC_FXH
#include <packs\happy.fxh\calc.fxh>
#endif

// Input SF3D Function placeholder
#ifndef FN_INPUT
#define FN_INPUT length
#endif

// Parameters
float FN_invert : FN_INVERT;
float FN_normalize : FN_NORMALIZE;
float FN_eps : FN_EPS = 0.001;

float3 FN_ (float3 p)
{
	float3 g = calcGradS3(FN_INPUT, p, FN_eps);
	if(FN_normalize) g = normalize(g);
	if(FN_invert) g = -g;
	return g;
}
// end of the function body
#endif 

////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef VF3D
#define VF3D FN_
#endif
////////////////////////////////////////////////////////////////////////////////////////////////



technique11 RemoveMe{}

