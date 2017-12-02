
////////////////////////////////////////////////////////////////////////////////////////////////
//
//		3D Scalar Domain Distortion Function
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

// Input VF3D function placeholder
#ifndef FN_DISTORTION
#define FN_DISTORTION normalize
#endif

// Parameters
float FN_Strength : FN_STRENGTH = 1.0;

float FN_ (float3 p)
{
	p += FN_DISTORTION(p) * FN_Strength;
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

