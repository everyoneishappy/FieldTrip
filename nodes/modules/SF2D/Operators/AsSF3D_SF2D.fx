
////////////////////////////////////////////////////////////////////////////////////////////////
//
//		2D Scalar Field to 3D Scalar Field
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


#if FN_USEMAT
float4x4 FN_Mat : FN_MAT;
#endif

float FN_useProjection : FN_USEPROJECTION;

// Input SF2D function placeholder
#ifndef FN_INPUT
#define FN_INPUT length
#endif

float FN_ (float3 p)
{
	

	#if FN_USEMAT==1
	p = mul(float4(p, 1), FN_Mat).xyz;
	
	if(FN_useProjection) return FN_INPUT(p.xy / p.z);
	#endif
	
	float input = FN_INPUT(p.FN_Swizzle);
	return input; //
}
// end of the function body
#endif 

////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef SF3D
#define SF3D FN_
#endif
////////////////////////////////////////////////////////////////////////////////////////////////



technique11 RemoveMe{}

