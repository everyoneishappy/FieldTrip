
#ifndef SDF_FXH
#include <packs\happy.fxh\sdf.fxh>
#endif

////////////////////////////////////////////////////////////////////////////////////////////////
//
//		Circle Distance Function
//
////////////////////////////////////////////////////////////////////////////////////////////////
// This token will be replaced with function name via RegExpr: "FN_"

#ifndef SF2D
// Paramaters
StructuredBuffer<float2> FN_pos : FN_POS;
float FN_radius : FN_RADIUS;
float2 FN_p1 : FN_P1;
float2 FN_p2 : FN_P2;
float2 FN_p3 : FN_P3;





float FN_ (float2 p)
{

	return fBezier(p, FN_p1, FN_p2, FN_p3) - FN_radius;
}


#define SF2D FN_
#endif
////////////////////////////////////////////////////////////////////////////////////////////////

technique11 RemoveMe{}

