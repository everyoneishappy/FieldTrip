
////////////////////////////////////////////////////////////////////////////////////////////////
//
//		2D Scalar Mapping op
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
float4 FN_minMax : FN_MINMAX;  
 

float FN_ (float2 p)
{  
	return FN_MAPMODE(FN_INPUT(p), FN_minMax.x, FN_minMax.y, FN_minMax.z, FN_minMax.w);
}
// end of the function body
#endif 

////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef SF2D
#define SF2D FN_
#endif
////////////////////////////////////////////////////////////////////////////////////////////////



technique11 RemoveMe{}

