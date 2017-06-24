#ifndef CALC_FXH
#include <packs\happy.fxh\calc.fxh>
#endif


////////////////////////////////////////////////////////////////////////////////////////////////
//
//		2D SDF Outline Function
//
////////////////////////////////////////////////////////////////////////////////////////////////
// This token will be replaced with function name via RegExpr: "FN_"
#ifndef SF2D

#ifndef SDF_FXH
#include <packs\happy.fxh\sdf.fxh>
#endif

// Paramaters
float FN_width : FN_WIDTH = 0.01;

// Input function placeholder
#ifndef FN_INPUT
#define FN_INPUT placeHolderS2
#endif


float FN_ (float2 p)
{
	return fOpOutline(FN_INPUT(p), FN_width); //
}

#define SF2D FN_
#endif
////////////////////////////////////////////////////////////////////////////////////////////////



technique11 RemoveMe{}

