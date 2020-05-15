
////////////////////////////////////////////////////////////////////////////////////////////////
//
//		2D Scalar Falloff op
//
////////////////////////////////////////////////////////////////////////////////////////////////
// This token will be replaced with function name via RegExpr: "FN_"

// ensures the function is defined only once per instance
#ifndef FN_BODY 
#define FN_BODY

// Input SF2D function placeholder
#ifndef FN_INPUT
#define FN_INPUT length
#endif

// DEFINES
#ifndef MAP_FXH
#include <packs\happy.fxh\map.fxh>
#endif

#ifndef FN_MAPMODE
#define FN_MAPMODE map
#endif


// parameters

float FN_falloffDist : FN_FALLOFFDIST;
float FN_bias : FN_BIAS;


float FN_ (float2 p)
{  
	float dist = FN_INPUT(p);
	return bias(1.0 - mapClamp(FN_INPUT(p), 0, FN_falloffDist, 0, 1), FN_bias);
}
// end of the function body
#endif 

////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef SF2D
#define SF2D FN_
#endif
////////////////////////////////////////////////////////////////////////////////////////////////



technique11 RemoveMe{}

