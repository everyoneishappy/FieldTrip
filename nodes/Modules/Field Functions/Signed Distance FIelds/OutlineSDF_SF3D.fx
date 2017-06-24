#ifndef CALC_FXH
#include <packs\happy.fxh\calc.fxh>
#endif

#ifndef SDF_FXH
#include <packs\happy.fxh\sdf.fxh>
#endif


////////////////////////////////////////////////////////////////////////////////////////////////
//
//		3D SDF Outline Function
//
////////////////////////////////////////////////////////////////////////////////////////////////
// This token will be replaced with function name via RegExpr: "FN_"
#ifndef SF3D

// Paramaters
float FN_width : FN_WIDTH;

// Input function placeholder
#ifndef FN_INPUT
#define FN_INPUT placeHolderS3
#endif

float FN_ (float3 p)
{
	return fOpOutline(FN_INPUT(p), FN_width); //
}
#define SF3D FN_
#endif
////////////////////////////////////////////////////////////////////////////////////////////////



technique11 RemoveMe{}

