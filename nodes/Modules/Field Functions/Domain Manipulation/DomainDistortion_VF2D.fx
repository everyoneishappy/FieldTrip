
#ifndef CALC_FXH
#include <packs\happy.fxh\calc.fxh>
#endif

////////////////////////////////////////////////////////////////////////////////////////////////
//
//		2D Vector Domain Distortion Function
//
////////////////////////////////////////////////////////////////////////////////////////////////
// This token will be replaced with function name via RegExpr: "FN_"
#ifndef VF2D

// Input function placeholder
#ifndef FN_INPUT
#define FN_INPUT placeHolderV2
#endif

// Distortion function placeholder
#ifndef FN_DISTORTION
#define FN_DISTORTION placeHolderV2
#endif

// Paramaters
float FN_Strength : FN_STRENGTH = 1.0;

float2 FN_ (float2 p)
{
	p += FN_DISTORTION(p) * FN_Strength;
	return FN_INPUT(p);
}

#define VF2D FN_
#endif
////////////////////////////////////////////////////////////////////////////////////////////////

technique11 RemoveMe{}

