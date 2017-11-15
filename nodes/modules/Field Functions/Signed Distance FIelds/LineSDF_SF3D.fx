

////////////////////////////////////////////////////////////////////////////////////////////////
//
//		3D Line Distance Function
//
////////////////////////////////////////////////////////////////////////////////////////////////
// This token will be replaced with function name via RegExpr: "FN_"

#ifndef SF3D


#ifndef SDF_FXH
#include <packs\happy.fxh\sdf.fxh>
#endif


// Paramaters
StructuredBuffer<float3> FN_from : FN_FROM;
StructuredBuffer<float3> FN_to : FN_TO;
StructuredBuffer<float> FN_radius : FN_RADIUS;

int FN_count : FN_COUNT;

float FN_ (float3 p)
{
	float d = 999999;
	for(int i = 0; i< FN_count; i++)
	{
		d = min (d, fCapsule(p, FN_from[i], FN_to[i], FN_radius[i]));
	}
	return d;
}


#define SF3D FN_
#endif
////////////////////////////////////////////////////////////////////////////////////////////////

technique11 RemoveMe{}

