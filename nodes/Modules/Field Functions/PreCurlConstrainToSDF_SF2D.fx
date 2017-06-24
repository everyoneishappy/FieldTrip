#ifndef CALC_FXH
#include <packs\happy.fxh\calc.fxh>
#endif

////////////////////////////////////////////////////////////////////////////////////////////////
//
//		Make a 2D scalar field flow around the boundries of a SDF once Curl is applied
//
////////////////////////////////////////////////////////////////////////////////////////////////
// This token will be replaced with function name via RegExpr: "FN_"
#ifndef SF2D



// Paramaters
float FN_radius : FN_RADIUS;

// Input function placeholder
#ifndef FN_INPUT
#define FN_INPUT placeHolderS2
#endif

// SDF function placeholder
#ifndef FN_SDF
#define FN_SDF placeHolderS2
#endif



float FN_ (float2 p)
{
	//if(FN_SDF(p) < 0) return 0;  // Prevents movment inside SDF
	return FN_INPUT(p) * ( PRECURLRAMP(FN_SDF(p)/FN_radius));
}

#define SF2D FN_
#endif
////////////////////////////////////////////////////////////////////////////////////////////////



technique11 RemoveMe{}

