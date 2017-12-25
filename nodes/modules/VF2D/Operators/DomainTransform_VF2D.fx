
////////////////////////////////////////////////////////////////////////////////////////////////
//
//		2D Domain Transformation Function
//
////////////////////////////////////////////////////////////////////////////////////////////////
// This token will be replaced with function name via RegExpr: "FN_"

// ensures the function is defined only once per instance
#ifndef FN_BODY 
#define FN_BODY


// Input VF2D function placeholder
#ifndef FN_INPUT
#define FN_INPUT normalize
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
// end of the function body
#endif 

////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef VF2D
#define VF2D FN_
#endif
////////////////////////////////////////////////////////////////////////////////////////////////

technique11 RemoveMe{}

