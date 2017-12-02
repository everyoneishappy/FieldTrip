



////////////////////////////////////////////////////////////////////////////////////////////////
//
//		Simple Sphere Distance Class
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
// end of the function body
#endif 

////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef SF3D
#define SF3D FN_
#endif
////////////////////////////////////////////////////////////////////////////////////////////////

technique11 RemoveMe{}

