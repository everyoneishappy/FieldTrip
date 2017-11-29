#ifndef CALC_FXH
#include <packs\happy.fxh\calc.fxh>
#endif


////////////////////////////////////////////////////////////////////////////////////////////////
//
//		3D Vector Field Basic Ops Class + - * /
//
////////////////////////////////////////////////////////////////////////////////////////////////
// This token will be replaced with function name via RegExpr: "FN_"
#ifndef VF3D


// Paramaters
float3 FN_Default : FN_DEFAULT;

// Input function placeholder
#ifndef FN_INPUT1
#define FN_INPUT1 placeHolderV3
#endif


#ifndef FN_INPUT2
float3 FN_singleVector (float3 p)
	{
		return FN_Default; // if a second input function is not provided defualt to vector semantic
	}
#define FN_INPUT2 FN_singleVector
#endif


float3 FN_ (float3 p)
{
	return cross(FN_INPUT1(p), FN_INPUT2(p)); //
}

#define VF3D FN_
#endif
////////////////////////////////////////////////////////////////////////////////////////////////



technique11 RemoveMe{}

