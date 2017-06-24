#ifndef CALC_FXH
#include <packs\happy.fxh\calc.fxh>
#endif


////////////////////////////////////////////////////////////////////////////////////////////////
//
//		3D Scalar Domain Distortion Function
//
////////////////////////////////////////////////////////////////////////////////////////////////
// This token will be replaced with function name via RegExpr: "FN_"
#ifndef SF3D

// Input function placeholder
#ifndef FN_INPUT
#define FN_INPUT placeHolderS3
#endif

// Input function placeholder
#ifndef FN_DISTORTION
#define FN_DISTORTION placeHolderV3
#endif

// Paramaters
float FN_Strength : FN_STRENGTH = 1.0;

float FN_ (float3 p)
{
	p += FN_DISTORTION(p) * FN_Strength;
	return FN_INPUT(p);
}
#define SF3D FN_
#endif
////////////////////////////////////////////////////////////////////////////////////////////////

technique11 RemoveMe{}

