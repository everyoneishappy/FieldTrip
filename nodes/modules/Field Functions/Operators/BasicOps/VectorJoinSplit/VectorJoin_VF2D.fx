#ifndef CALC_FXH
#include <packs\happy.fxh\calc.fxh>
#endif


////////////////////////////////////////////////////////////////////////////////////////////////
//
//		2D Vector Field from two 2D Scaler Field Functions
//
////////////////////////////////////////////////////////////////////////////////////////////////
// This token will be replaced with function name via RegExpr: "FN_"
#ifndef VF2D

// Input Function placeholder
#ifndef FN_INPUT_X
#define FN_INPUT_X placeHolderS2
#endif

#ifndef FN_INPUT_Y
#define FN_INPUT_Y placeHolderS2
#endif


float2 FN_ (float2 p)
{
	return float2(FN_INPUT_X(p), FN_INPUT_Y(p) );
	
}

#define VF2D FN_
#endif
////////////////////////////////////////////////////////////////////////////////////////////////



technique11 RemoveMe{}

