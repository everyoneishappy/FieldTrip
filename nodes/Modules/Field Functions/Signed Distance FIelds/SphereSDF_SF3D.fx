

#ifndef SDF_FXH
#include <packs\happy.fxh\sdf.fxh>
#endif

////////////////////////////////////////////////////////////////////////////////////////////////
//
//		Simple Sphere Distance Class
//
////////////////////////////////////////////////////////////////////////////////////////////////
// This token will be replaced with function name via RegExpr: "FN_"
#ifndef SF3D

// Paramaters
StructuredBuffer<float3> FN_pos : FN_POS;
StructuredBuffer<float> FN_radius : FN_RADIUS;
int FN_count : FN_COUNT = 1 ;

float FN_ (float3 p)
{
	float d = 999999;
	for(int i = 0; i< FN_count; i++)
	{
		d = min (d, fSphere(p-FN_pos[i], FN_radius[i]));
	}
	return d;
}

#define SF3D FN_
#endif
////////////////////////////////////////////////////////////////////////////////////////////////

technique11 RemoveMe{}

