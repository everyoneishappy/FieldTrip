#ifndef CALC_FXH
#include <packs\happy.fxh\calc.fxh>
#endif


////////////////////////////////////////////////////////////////////////////////////////////////
//
//		3D Vector Field Dot Product Function
//
////////////////////////////////////////////////////////////////////////////////////////////////
// This token will be replaced with function name via RegExpr: "FN_"
#ifndef SF3D


// Paramaters
float3 FN_Default : FN_DEFAULT;

// Input function placeholder
#ifndef FN_INPUT1
#define FN_INPUT1 placeHolderV3
#endif

// Input 2 Defualt option
#ifndef FN_INPUT2
float3 FN_singleVector (float3 p)
{
	return FN_Default; // if a second input class is not provided defualt to semantic
}
#define FN_INPUT2 FN_singleVector
#endif

float FN_ (float3 p)
{
	return dot(FN_INPUT1(p), FN_INPUT2(p)); //
}
#define SF3D FN_
#endif


////////////////////////////////////////////////////////////////////////////////////////////////



technique11 RemoveMe{}

