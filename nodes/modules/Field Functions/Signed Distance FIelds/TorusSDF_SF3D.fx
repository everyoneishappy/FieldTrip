
#ifndef SDF_FXH
#include <packs\happy.fxh\sdf.fxh>
#endif

////////////////////////////////////////////////////////////////////////////////////////////////
//
//		3D Torus Distance Function
//
////////////////////////////////////////////////////////////////////////////////////////////////
// This token will be replaced with function name via RegExpr: "FN_"

#ifndef SF3D
// Paramaters
StructuredBuffer<float4x4> FN_invTransform : FN_INVTRANSFORM;
StructuredBuffer<float2> FN_size : FN_SIZE;

int FN_count : FN_COUNT;

float FN_ (float3 p)
{
	float d = 999999;
	for(int i = 0; i< FN_count; i++)
	{
		float3 tp = mul(float4(p, 1), FN_invTransform[i]).xyz;
		d = min (d, fTorus(tp, FN_size[i].x, FN_size[i].y));
	}
	return d;
}

#define SF3D FN_
#endif
////////////////////////////////////////////////////////////////////////////////////////////////

technique11 RemoveMe{}

