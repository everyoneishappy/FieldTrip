
////////////////////////////////////////////////////////////////////////////////////////////////
//
//		2D Circle Distance Function
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
StructuredBuffer<float2> FN_pos : FN_POS;
StructuredBuffer<float> FN_radius : FN_RADIUS;

int FN_count : FN_COUNT;

float FN_ (float2 p)
{
	float d = 999999;
	for(int i = 0; i< FN_count; i++)
	{
		d = min (d, fCircle(p-FN_pos[i], FN_radius[i]));
	}
	return d;
}
// end of the function body
#endif 

////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef SF2D
#define SF2D FN_
#endif
////////////////////////////////////////////////////////////////////////////////////////////////

technique11 RemoveMe{}

