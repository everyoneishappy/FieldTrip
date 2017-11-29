#ifndef CALC_FXH
#include <packs\happy.fxh\calc.fxh>
#endif


////////////////////////////////////////////////////////////////////////////////////////////////
//
//		2D Vector Gradient from 2D Scaler Field Function
//
////////////////////////////////////////////////////////////////////////////////////////////////
// This token will be replaced with function name via RegExpr: "FN_"
#ifndef VF2D

// Input Function placeholder
#ifndef FN_INPUT
#define FN_INPUT placeHolderS2
#endif

// Paramaters
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

#define VF2D FN_
#endif
////////////////////////////////////////////////////////////////////////////////////////////////



technique11 RemoveMe{}

