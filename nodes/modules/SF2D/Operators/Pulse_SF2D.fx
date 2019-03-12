
////////////////////////////////////////////////////////////////////////////////////////////////
//
//		Creates a ramp in 0-1 range around a level set from a 2D scalar field 
//
////////////////////////////////////////////////////////////////////////////////////////////////
// This token will be replaced with class name: FN_

// ensures the function is defined only once per instance
#ifndef FN_BODY 
#define FN_BODY

#ifndef MAP_FXH
#include <packs\happy.fxh\map.fxh>
#endif


// Input SF2D placeholder
#ifndef FN_INPUT
#define FN_INPUT length
#endif

// Paramaters
float3 FN_control : FN_CONTROL; // float center, float slopeWidth, float centerWidth

float FN_ (float2 p)
{
	return pulse(FN_INPUT(p), FN_control.x, FN_control.y, FN_control.z);
}
// end of the function body
#endif 

////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef SF2D
#define SF2D FN_
#endif
////////////////////////////////////////////////////////////////////////////////////////////////



technique11 RemoveMe{}

