
#ifndef CALC_FXH
#include <packs\happy.fxh\calc.fxh>
#endif

////////////////////////////////////////////////////////////////////////////////////////////////
//
//		2D Scalar Domain Distortion Function
//
////////////////////////////////////////////////////////////////////////////////////////////////
// This token will be replaced with function name via RegExpr: "FN_"
#ifndef SF2D

// Input function placeholder
#ifndef FN_INPUT
#define FN_INPUT placeHolderS2
#endif

// Distortion function placeholder
#ifndef FN_DISTORTION
#define FN_DISTORTION placeHolderV2
#endif

// Paramaters
float FN_Strength : FN_STRENGTH = 1.0;

float FN_ (float2 p)
{
	p += FN_DISTORTION(p) * FN_Strength;
	return FN_INPUT(p);
}

#define SF2D FN_
#endif
////////////////////////////////////////////////////////////////////////////////////////////////

technique11 RemoveMe{}

