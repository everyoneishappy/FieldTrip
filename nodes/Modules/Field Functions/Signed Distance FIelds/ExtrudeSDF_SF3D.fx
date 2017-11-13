#ifndef CALC_FXH
#include <packs\happy.fxh\calc.fxh>
#endif


////////////////////////////////////////////////////////////////////////////////////////////////
//
//		Extrude a 2D SDF to 3D
//
////////////////////////////////////////////////////////////////////////////////////////////////
// This token will be replaced with function name via RegExpr: "FN_"
#ifndef SF3D

#ifndef SDF_FXH
#include <packs\happy.fxh\sdf.fxh>
#endif

// Input Function placeholder
#ifndef FN_INPUT
#define FN_INPUT placeHolderS2
#endif

  
// Paramaters
float FN_depth : FN_DEPTH;
float FN_radius : FN_RADIUS;


// DEFINES

#ifndef FN_OP 
#define FN_OP fOpExtrude(p.z, FN_INPUT(p.xy), FN_depth)
#endif



float FN_ (float3 p)
{
		return FN_OP;
 
}
#define SF3D FN_
#endif
////////////////////////////////////////////////////////////////////////////////////////////////



technique11 RemoveMe{}

