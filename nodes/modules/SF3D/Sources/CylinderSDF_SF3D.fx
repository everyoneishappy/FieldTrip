
////////////////////////////////////////////////////////////////////////////////////////////////
//
//		3D Cylinder Distance Function
//
////////////////////////////////////////////////////////////////////////////////////////////////
// This token will be replaced with function name via RegExpr: "FN_"

// ensures the function is defined only once per instance
#ifndef FN_BODY 
#define FN_BODY

#ifndef SDF_FXH
#include <packs\happy.fxh\sdf.fxh>
#endif


// Parameters
StructuredBuffer<float4x4> FN_invTransform : FN_INVTRANSFORM;
StructuredBuffer<float2> FN_size : FN_SIZE;

int FN_count : FN_COUNT;

float FN_ (float3 p)
{
	float d = 999999;
	for(int i = 0; i< FN_count; i++)
	{
		float3 tp = mul(float4(p, 1), FN_invTransform[i]).xyz;
		d = min (d, fCylinder(tp, FN_size[i].x, FN_size[i].y));
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

