
////////////////////////////////////////////////////////////////////////////////////////////////
//
//		3D Scalar Domain Reflection Function
//
////////////////////////////////////////////////////////////////////////////////////////////////
// This token will be replaced with function name via RegExpr: "FN_"

// ensures the function is defined only once per instance
#ifndef FN_BODY 
#define FN_BODY

#ifndef SDF_FXH
#include <packs\happy.fxh\sdf.fxh>
#endif

// Input SF3D function placeholder
#ifndef FN_INPUT
#define FN_INPUT length
#endif

// Parameters
float FN_offset : FN_OFFSET;
float3 FN_normal : FN_NORMAL = float3(1,0,0);

float FN_ (float3 p)
{
	float side = pReflect(p, FN_normal, FN_offset);
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

