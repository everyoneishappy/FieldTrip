

////////////////////////////////////////////////////////////////////////////////////////////////
//
//		3D Domain Transformation Function
//
////////////////////////////////////////////////////////////////////////////////////////////////
// This token will be replaced with function name via RegExpr: "FN_"

// ensures the function is defined only once per instance
#ifndef FN_BODY 
#define FN_BODY

// Input SF3D function placeholder
#ifndef FN_INPUT
#define FN_INPUT length
#endif


// Paramaters
float4x4 FN_Transform : FN_TRANSFORM = { 	1, 0, 0, 0, 
 										0, 1, 0, 0, 
 										0, 0, 1, 0, 
  										0, 0, 0, 1  };

float FN_ (float3 p)
{
	p = mul(float4(p,1), FN_Transform).xyz;
	return FN_INPUT(p);
}
// end of the function body
#endif 

////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef SF3D
#define SF3D FN_
#endif
////////////////////////////////////////////////////////////////////////////////////////////////

technique11 RemoveMe{}

