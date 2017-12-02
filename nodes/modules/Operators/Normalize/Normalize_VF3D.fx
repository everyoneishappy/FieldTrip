
////////////////////////////////////////////////////////////////////////////////////////////////
//
//		Normalize a 3D Vector Field 
//
////////////////////////////////////////////////////////////////////////////////////////////////
// This token will be replaced with function name via RegExpr: "FN_"
// ensures the function is defined only once per instance
#ifndef FN_BODY 
#define FN_BODY


// Input Function VF3D placeholder
#ifndef FN_INPUT
#define FN_INPUT normalize
#endif


float3 FN_ (float3 p)
{
	return normalize(FN_INPUT(p));
}
// end of the function body
#endif 

////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef VF3D
#define VF3D FN_
#endif
////////////////////////////////////////////////////////////////////////////////////////////////



technique11 RemoveMe{}
