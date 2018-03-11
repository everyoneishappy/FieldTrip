
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
#ifndef FN_2DMode 
#define FN_2DMode XY
#endif

// Parameters


// Input SF2D function placeholder
#ifndef FN_INPUT
#define FN_INPUT length
#endif

float FN_ (float3 p)
{
	float input = FN_INPUT(p.xz);
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

