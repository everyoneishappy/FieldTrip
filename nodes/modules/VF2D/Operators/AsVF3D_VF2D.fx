
////////////////////////////////////////////////////////////////////////////////////////////////
//
//		2D Vector Field to 3D Vector Field
//
////////////////////////////////////////////////////////////////////////////////////////////////
// This token will be replaced with function name via RegExpr: "FN_"

// ensures the function is defined only once per instance
#ifndef FN_BODY 
#define FN_BODY


// DEFINES // preprocessor options from patch inserted here

//Projection Mode
#ifndef FN_Swizzle 
#define FN_Swizzle xy
#endif


#if FN_USEMAT==1
float4x4 FN_Mat : FN_MAT;
#endif


// Input VF2D function placeholder
#ifndef FN_INPUT
#define FN_INPUT normalize
#endif

float3 FN_ (float3 p)
{
	#if FN_USEMAT==1
	p = mul(float4(p, 1), FN_Mat).xyz;
	#endif
	
	float2 input = FN_INPUT(p.FN_Swizzle);
	float3 result = 0;
	result.FN_Swizzle = input;
	return result; 
}
// end of the function body
#endif 

////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef VF3D
#define VF3D FN_
#endif
////////////////////////////////////////////////////////////////////////////////////////////////



technique11 RemoveMe{}

