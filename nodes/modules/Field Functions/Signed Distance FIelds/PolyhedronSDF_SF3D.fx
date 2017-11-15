

#ifndef SDF_FXH
#include <packs\happy.fxh\sdf.fxh>
#endif

////////////////////////////////////////////////////////////////////////////////////////////////
//
//		Simple Sphere Distance Class
//
////////////////////////////////////////////////////////////////////////////////////////////////
// This token will be replaced with function name via RegExpr: "FN_"

// DEFINES


#ifndef SF3D

#ifndef FN_SHAPE
#define FN_SHAPE  fOctahedron
#endif

// Paramaters
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

#define SF3D FN_
#endif
////////////////////////////////////////////////////////////////////////////////////////////////

technique11 RemoveMe{}

