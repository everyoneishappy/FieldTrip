
////////////////////////////////////////////////////////////////////////////////////////////////
//
//		Polyhedron Distance Functions
//
////////////////////////////////////////////////////////////////////////////////////////////////
// This token will be replaced with function name via RegExpr: "FN_"

// ensures the function is defined only once per instance
#ifndef FN_BODY 
#define FN_BODY

#ifndef SDF_FXH
#include <packs\happy.fxh\sdf.fxh>
#endif

// DEFINES
#ifndef FN_SHAPE
#define FN_SHAPE  fOctahedron
#endif

// Parameters
StructuredBuffer<float4x4> FN_invTransform : FN_INVTRANSFORM;
StructuredBuffer<float> FN_radius : FN_RADIUS;
int FN_count : FN_COUNT = 1 ;

float FN_ (float3 p)
{
	float d = 999999;
	for(int i = 0; i< FN_count; i++)
	{
		float3 tp = mul(float4(p, 1), FN_invTransform[i]).xyz;
		d = min (d, FN_SHAPE(tp, FN_radius[i]));
	}
	return d;
}
// end of the function body
#endif 

////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef SF3D
#define SF3D FN_
#endif
////////////////////////////////////////////////////////////////////////////////////////////////

technique11 RemoveMe{}

