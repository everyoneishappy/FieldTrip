#ifndef CALC_FXH
#include <packs\happy.fxh\calc.fxh>
#endif

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

// Input function placeholder
#ifndef FN_INPUT
#define FN_INPUT placeHolderS2
#endif

// Paramaters
float3 FN_orientation : FN_ORIENTATION = float3(0,1,0);
float FN_amp : FN_AMPLITUDE = 1;

float FN_ (float3 p)
{
	return fPlane(p, FN_INPUT(p.xz) * -FN_amp, FN_orientation);
}

#define SF3D FN_
#endif
////////////////////////////////////////////////////////////////////////////////////////////////

technique11 RemoveMe{}

