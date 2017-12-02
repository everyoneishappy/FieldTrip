
////////////////////////////////////////////////////////////////////////////////////////////////
//
//		Height Field 3D SDF
//
////////////////////////////////////////////////////////////////////////////////////////////////
// This token will be replaced with function name via RegExpr: "FN_"

// ensures the function is defined only once per instance
#ifndef FN_BODY 
#define FN_BODY

#ifndef SDF_FXH
#include <packs\happy.fxh\sdf.fxh>
#endif

// Input SF2D function placeholder
#ifndef FN_INPUT
#define FN_INPUT length
#endif

// Paramaters
float3 FN_orientation : FN_ORIENTATION = float3(0,1,0);
float FN_amp : FN_AMPLITUDE = 1;

float FN_ (float3 p)
{
	return fPlane(p, FN_INPUT(p.xz) * -FN_amp, FN_orientation);
}
// end of the function body
#endif 

////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef SF3D
#define SF3D FN_
#endif
////////////////////////////////////////////////////////////////////////////////////////////////

technique11 RemoveMe{}

