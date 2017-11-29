#ifndef CALC_FXH
#include <packs\happy.fxh\calc.fxh>
#endif

////////////////////////////////////////////////////////////////////////////////////////////////
//
//		Pre Curl Vortex Function
//
////////////////////////////////////////////////////////////////////////////////////////////////
// This token will be replaced with function name via RegExpr: "FN_"
#ifndef VF3D

// Paramaters
float3 FN_direction : FN_DIRECTION = float3(1.0, 0.0, 0.0);
float3 FN_pos : FN_POS;
float FN_radius : FN_RADIUS = 0.15;
	



float3 FN_ (float3 p)
{
	return preCurlVortex(p, FN_pos, FN_direction, FN_radius);
}

#define VF3D FN_
#endif
////////////////////////////////////////////////////////////////////////////////////////////////



technique11 RemoveMe{}

