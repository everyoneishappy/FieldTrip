
////////////////////////////////////////////////////////////////////////////////////////////////
//
//		3D Domain Distortion Class
//
////////////////////////////////////////////////////////////////////////////////////////////////
// This token will be replaced with function name via RegExpr: "FN_"
#ifndef VF3D


#ifndef CALC_FXH
#include <packs\happy.fxh\calc.fxh>
#endif


// Input function placeholder
#ifndef FN_INPUT
#define FN_INPUT placeHolderV3
#endif


// Paramaters
float4x4 FN_Transform : FN_TRANSFORM = { 	1, 0, 0, 0, 
 										0, 1, 0, 0, 
 										0, 0, 1, 0, 
  										0, 0, 0, 1  };

float3 FN_ (float3 p)
{
	p = mul(float4(p,1), FN_Transform).xyz;
	return FN_INPUT(p);
}

#define VF3D FN_
#endif
////////////////////////////////////////////////////////////////////////////////////////////////

technique11 RemoveMe{}

