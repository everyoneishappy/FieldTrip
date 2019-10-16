
////////////////////////////////////////////////////////////////////////////////////////////////
//
//		Extrude a 2D SDF to 3D
//
////////////////////////////////////////////////////////////////////////////////////////////////
// This token will be replaced with function name via RegExpr: "FN_"

// ensures the function is defined only once per instance
#ifndef FN_BODY 
#define FN_BODY

#ifndef SDF_FXH
#include <packs\happy.fxh\sdf.fxh>
#endif

// Input SF2D Function placeholder
#ifndef FN_INPUT
#define FN_INPUT length
#endif
  
// Parameters
float FN_depth : FN_DEPTH;
float FN_radius : FN_RADIUS;
float FN_axis : FN_AXIS;

// DEFINES
#ifndef FN_OP 
#define FN_OP fOpExtrude(p.z, FN_INPUT(p.xy), FN_depth)
#endif

float FN_ (float3 p)
{
	
		if (FN_axis == 1) p = p.xzy;
		if (FN_axis == 2) p = p.zyx;
		return FN_OP;
 
}
// end of the function body
#endif 

////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef SF3D
#define SF3D FN_
#endif
////////////////////////////////////////////////////////////////////////////////////////////////



technique11 RemoveMe{}

