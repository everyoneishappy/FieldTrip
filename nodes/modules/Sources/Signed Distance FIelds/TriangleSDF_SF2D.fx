
////////////////////////////////////////////////////////////////////////////////////////////////
//
//		2D Triangle Distance Function
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
StructuredBuffer<float2> FN_a : FN_A;
StructuredBuffer<float2> FN_b : FN_B;
StructuredBuffer<float2> FN_c : FN_C;

int FN_count : FN_COUNT;

float FN_ (float2 p)
{
	float d = 999999;
	for(int i = 0; i< FN_count; i++)
	{
		d = min (d, fTriangle(p, FN_a[i], FN_b[i], FN_c[i]));
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

