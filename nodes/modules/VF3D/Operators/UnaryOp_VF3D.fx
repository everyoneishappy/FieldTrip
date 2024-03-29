
////////////////////////////////////////////////////////////////////////////////////////////////
//
//		3D Vector Field Unaray Ops 
//
////////////////////////////////////////////////////////////////////////////////////////////////
// This token will be replaced with function name via RegExpr: "FN_"

// ensures the function is defined only once per instance
#ifndef FN_BODY 
#define FN_BODY

// DEFINES // preprocessor options from patch inserted here

#ifndef FN_OP
#define FN_OP sqrt
#endif


// Input VF3D function placeholder
#ifndef FN_INPUT
#define FN_INPUT normalize
#endif



float3 FN_ (float3 p)
{
	return FN_OP(FN_INPUT(p)); 
}
// end of the function body
#endif 

////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef VF3D
#define VF3D FN_
#endif
////////////////////////////////////////////////////////////////////////////////////////////////



technique11 RemoveMe{}

