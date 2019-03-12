
////////////////////////////////////////////////////////////////////////////////////////////////
//
//		2D Scalar Domain Reflection Function
//
////////////////////////////////////////////////////////////////////////////////////////////////
// This token will be replaced with function name via RegExpr: "FN_"

// ensures the function is defined only once per instance
#ifndef FN_BODY 
#define FN_BODY

#ifndef SDF_FXH
#include <packs\happy.fxh\sdf.fxh>
#endif

// Input SF2D function placeholder
#ifndef FN_INPUT
#define FN_INPUT length
#endif

// Parameters
float FN_offset : FN_OFFSET;
float2 FN_normal : FN_NORMAL;

float FN_ (float2 p)
{
	float side = pReflect(p, FN_normal, FN_offset);
	return FN_INPUT(p);
}
// end of the function body
#endif 

////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef SF2D
#define SF2D FN_
#endif
////////////////////////////////////////////////////////////////////////////////////////////////

technique11 RemoveMe{}

