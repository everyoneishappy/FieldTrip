
////////////////////////////////////////////////////////////////////////////////////////////////
//
//		Creates a ramp in 0-1 range around a level set from a 3D scalar field 
//
////////////////////////////////////////////////////////////////////////////////////////////////
// This token will be replaced with class name: FN_

// ensures the function is defined only once per instance
#ifndef FN_BODY 
#define FN_BODY

#ifndef MAP_FXH
#include <packs\happy.fxh\map.fxh>
#endif


// Input SF3D placeholder
#ifndef FN_INPUT
#define FN_INPUT length
#endif

// Paramaters
float3 FN_control : FN_CONTROL; // float center, float slopeWidth, float centerWidth

float FN_ (float3 p)
{
	return pulse(FN_INPUT(p), FN_control.x, FN_control.y, FN_control.z);
}
// end of the function body
#endif 

////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef SF3D
#define SF3D FN_
#endif
////////////////////////////////////////////////////////////////////////////////////////////////



technique11 RemoveMe{}

