
////////////////////////////////////////////////////////////////////////////////////////////////
//
//		2D Vector Gradient from 2D Scaler Field Function
//
////////////////////////////////////////////////////////////////////////////////////////////////
// This token will be replaced with function name via RegExpr: "FN_"

// ensures the function is defined only once per instance
#ifndef FN_BODY 
#define FN_BODY

#ifndef CALC_FXH
#include <packs\happy.fxh\calc.fxh>
#endif

// Input Function placeholder
#ifndef FN_INPUT
#define FN_INPUT placeHolderS2
#endif

// Parameters
float FN_invert : FN_INVERT;
float FN_normalize : FN_NORMALIZE;
float FN_eps : FN_EPS = 0.001;

float2 FN_ (float2 p)
{
	float2 g = calcGradS2(FN_INPUT, p, FN_eps);
	if(FN_normalize) g = normalize(g);
	if(FN_invert) g = -g;
	return g;
}
// end of the function body
#endif 

////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef VF2D
#define VF2D FN_
#endif
////////////////////////////////////////////////////////////////////////////////////////////////



technique11 RemoveMe{}

