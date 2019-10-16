
////////////////////////////////////////////////////////////////////////////////////////////////
//
//		Only calculate an SDF if a 2nd bounding SDF returns less then 0
//
////////////////////////////////////////////////////////////////////////////////////////////////
// This token will be replaced with function name via RegExpr: "FN_"

// ensures the function is defined only once per instance
#ifndef FN_BODY 
#define FN_BODY

// Parameters
float FN_padding : FN_PADDING;
// Input function placeholder
#ifndef FN_INPUT1
#define FN_INPUT1 length
#endif

// Input function placeholder
#ifndef FN_INPUT2
#define FN_INPUT2 length
#endif


float FN_ (float3 p)
{
	float test = FN_INPUT2(p);
	if ((test - FN_padding) > 0) return test;
	else return FN_INPUT1(p);
}


#endif 

////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef SF3D
#define SF3D FN_
#endif
////////////////////////////////////////////////////////////////////////////////////////////////



technique11 RemoveMe{}

