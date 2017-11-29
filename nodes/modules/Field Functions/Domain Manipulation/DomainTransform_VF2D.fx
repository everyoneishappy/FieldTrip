
#ifndef CALC_FXH
#include <packs\happy.fxh\calc.fxh>
#endif

////////////////////////////////////////////////////////////////////////////////////////////////
//
//		2D Domain Distortion Class
//
////////////////////////////////////////////////////////////////////////////////////////////////
// This token will be replaced with function name via RegExpr: "FN_"
#ifndef VF2D

// Input function placeholder
#ifndef FN_INPUT
#define FN_INPUT placeHolderV2
#endif


// Paramaters
float4x4 FN_Transform : FN_TRANSFORM = { 	1, 0, 0, 0, 
 										0, 1, 0, 0, 
 										0, 0, 1, 0, 
  										0, 0, 0, 1  };

float2 FN_ (float2 p)
{
	p = mul(float4(p,0,1), FN_Transform).xy;
	return FN_INPUT(p);
}

#define VF2D FN_
#endif
////////////////////////////////////////////////////////////////////////////////////////////////

technique11 RemoveMe{}

