

////////////////////////////////////////////////////////////////////////////////////////////////
//
//		Make a 2D scalar field flow around the boundries of a SDF once Curl is applied
//
////////////////////////////////////////////////////////////////////////////////////////////////
// This token will be replaced with function name via RegExpr: "FN_"

// ensures the function is defined only once per instance
#ifndef FN_BODY 
#define FN_BODY

#ifndef CALC_FXH
#include <packs\happy.fxh\calc.fxh>
#endif

// Parameters
float FN_radius : FN_RADIUS;

// Input SF2D function placeholder
#ifndef FN_INPUT
#define FN_INPUT length
#endif

// SDF SF2D function placeholder
#ifndef FN_SDF
#define FN_SDF length
#endif



float FN_ (float2 p)
{
	//if(FN_SDF(p) < 0) return 0;  // Prevents movment inside SDF
	return FN_INPUT(p) * ( PRECURLRAMP(FN_SDF(p)/FN_radius));
}
// end of the function body
#endif 

////////////////////////////////////////////////////////////////////////////////////////////////

#ifndef SF2D
#define SF2D FN_
#endif
////////////////////////////////////////////////////////////////////////////////////////////////



technique11 RemoveMe{}

