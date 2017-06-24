
#ifndef SDF_FXH
#include <packs\happy.fxh\sdf.fxh>
#endif




////////////////////////////////////////////////////////////////////////////////////////////////
//
//		Circle Distance Function
//
////////////////////////////////////////////////////////////////////////////////////////////////
// This token will be replaced with function name via RegExpr: "FN_"

#ifndef SF2D

// DEFINES
#ifndef LATTICEFUNC
#define LATTICEFUNC fBoxGrid
#endif

// paramaters
float FN_freq : FN_FREQ = 2; 
float FN_width : FN_WIDTH = .1; 
float2 FN_offset : FN_OFFSET;

int FN_count : FN_COUNT;

float FN_ (float2 p)
{
	return LATTICEFUNC(p * FN_freq + FN_offset, FN_width) / FN_freq;
}


#define SF2D FN_
#endif
////////////////////////////////////////////////////////////////////////////////////////////////

technique11 RemoveMe{}

