#ifndef CALC_FXH
#include <packs\happy.fxh\calc.fxh>
#endif

////////////////////////////////////////////////////////////////////////////////////////////////
//
//		2D Scalar Field Basic Ops Functions + - * /
//
////////////////////////////////////////////////////////////////////////////////////////////////
// This token will be replaced with function name via RegExpr: "FN_"
#ifndef SF2D

// DEFINES
#ifndef FN_OP
#define FN_OP +
#endif

// Paramaters
float FN_Default : FN_DEFAULT;
float FN_reverseOrder : FN_REVERSEORDER;

// Input function placeholder
#ifndef FN_INPUT1
#define FN_INPUT1 placeHolderS2
#endif

// Input 2 Defualt option
#ifndef FN_INPUT2
float FN_singleValue (float2 p)
{
	return FN_Default; // if a second input class is not provided defualt to semantic
}
#define FN_INPUT2 FN_singleValue
#endif

float FN_ (float2 p)
{
	#if(FN_REVERSE==1) 
	return FN_INPUT2(p) FN_OP FN_INPUT1(p);
	#else
	return FN_INPUT1(p) FN_OP FN_INPUT2(p); 
	#endif
}

#define SF2D FN_
#endif
////////////////////////////////////////////////////////////////////////////////////////////////



technique11 RemoveMe{}

