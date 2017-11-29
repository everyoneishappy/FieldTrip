#ifndef CALC_FXH
#include <packs\happy.fxh\calc.fxh>
#endif

////////////////////////////////////////////////////////////////////////////////////////////////
//
//		Morph between two 2D Vector Field functions by a third function (or defualt value)
//
////////////////////////////////////////////////////////////////////////////////////////////////
// This token will be replaced with function name via RegExpr: "FN_"
#ifndef VF2D



// Paramaters
float FN_Default : FN_DEFAULT = 0.5;

// Input function placeholder
#ifndef FN_INPUT1
#define FN_INPUT1 placeHolderV2
#endif

// Input function placeholder
#ifndef FN_INPUT2
#define FN_INPUT2 placeHolderV2
#endif

// morph defualt
#ifndef FN_BLEND
float FN_DefualtBlend (float2 p)
{
	return FN_Default; // if a blend field class is not provided defualt to value semantic
}
#define FN_BLEND FN_DefualtBlend
#endif


float2 FN_ (float2 p)
{
	return lerp(FN_INPUT1(p), FN_INPUT2(p), saturate(FN_BLEND(p))); //
}


#define VF2D FN_
#endif
////////////////////////////////////////////////////////////////////////////////////////////////



technique11 RemoveMe{}

