
////////////////////////////////////////////////////////////////////////////////////////////////
//
//		3D Vector Field Basic Ops Class + - * /
//
////////////////////////////////////////////////////////////////////////////////////////////////
// This token will be replaced with function name via RegExpr: "FN_"

// ensures the function is defined only once per instance
#ifndef FN_BODY 
#define FN_BODY

// Parameters
float3 FN_Default : FN_DEFAULT;

// Input VF3D function placeholder
#ifndef FN_INPUT1
#define FN_INPUT1 normalize
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
// end of the function body
#endif 

////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef VF3D
#define VF3D FN_
#endif
////////////////////////////////////////////////////////////////////////////////////////////////



technique11 RemoveMe{}

