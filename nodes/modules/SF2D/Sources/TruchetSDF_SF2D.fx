
////////////////////////////////////////////////////////////////////////////////////////////////
//
//		2D Truchet Tile Distance Function
//
////////////////////////////////////////////////////////////////////////////////////////////////
// This token will be replaced with function name via RegExpr: "FN_"

// ensures the function is defined only once per instance
#ifndef FN_BODY 
#define FN_BODY

#ifndef SDF_FXH
#include <packs\happy.fxh\sdf.fxh>
#endif

// DEFINES
#ifndef LATTICEFUNC
#define LATTICEFUNC fLineTruchet
#endif

// parameters
float FN_freq : FN_FREQ = 2; 
float FN_width : FN_WIDTH = .1; 
float2 FN_offset : FN_OFFSET;

int FN_count : FN_COUNT;

float FN_ (float2 p)
{
	return LATTICEFUNC(p * FN_freq + FN_offset, FN_width) / FN_freq;
}
// end of the function body
#endif 

////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef SF2D
#define SF2D FN_
#endif
////////////////////////////////////////////////////////////////////////////////////////////////

technique11 RemoveMe{}

