#ifndef CALC_FXH
#include <packs\happy.fxh\calc.fxh>
#endif


////////////////////////////////////////////////////////////////////////////////////////////////
//
//		Laplacian Scalar from a 2D Scalar Field Class
//
////////////////////////////////////////////////////////////////////////////////////////////////
// This token will be replaced with function name via RegExpr: "FN_"
#ifndef SF2D

// Paramaters
float FN_epsilon : FN_EPSILON = 0.01;

// Input function placeholder
#ifndef FN_INPUT
#define FN_INPUT placeHolderS2
#endif


float FN_ (float2 p)
{
	return calcLapS2(FN_INPUT, p, FN_epsilon);
}

#define SF2D FN_
#endif
////////////////////////////////////////////////////////////////////////////////////////////////



technique11 RemoveMe{}

