
#ifndef CALC_FXH
#include <packs\happy.fxh\calc.fxh>
#endif

#ifndef SDF_FXH
#include <packs\happy.fxh\sdf.fxh>
#endif

////////////////////////////////////////////////////////////////////////////////////////////////
//
//		2D Domain Wraping Function
//
////////////////////////////////////////////////////////////////////////////////////////////////
// This token will be replaced with function name via RegExpr: "FN_"
#ifndef SF2D




// DEFINES
#ifndef FN_DOMAINOP 
#define FN_DOMAINOP pMod2
#endif

#ifndef FN_SWIZZLE 
#define FN_SWIZZLE xy
#endif

// Input function placeholder
#ifndef FN_INPUT
#define FN_INPUT placeHolderS2
#endif


// Paramaters
float2 FN_size : FN_SIZE = 1;

float FN_ (float2 p)
{
	//p.FN_SWIZZLE+=9999; // just to get rid of flipping at zero
	FN_DOMAINOP(p.FN_SWIZZLE, FN_size);
	return FN_INPUT(p);
}

#define SF2D FN_
#endif
////////////////////////////////////////////////////////////////////////////////////////////////

technique11 RemoveMe{}

