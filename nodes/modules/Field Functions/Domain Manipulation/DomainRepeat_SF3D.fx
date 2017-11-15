

////////////////////////////////////////////////////////////////////////////////////////////////
//
//		3D Domain Wraping Function
//
////////////////////////////////////////////////////////////////////////////////////////////////
// This token will be replaced with function name via RegExpr: "FN_"
#ifndef SF3D


#ifndef CALC_FXH
#include <packs\happy.fxh\calc.fxh>
#endif

#ifndef SDF_FXH
#include <packs\happy.fxh\sdf.fxh>
#endif


// DEFINES
#ifndef FN_DOMAINOP 
#define FN_DOMAINOP pMod3
#endif

#ifndef FN_SWIZZLE 
#define FN_SWIZZLE xyz
#endif

// Input function placeholder
#ifndef FN_INPUT
#define FN_INPUT placeHolderS3
#endif


// Paramaters
float3 FN_size : FN_SIZE = 1;

float FN_ (float3 p)
{
	p.FN_SWIZZLE+=9999; // just to get rid of flipping at zero
	FN_DOMAINOP(p.FN_SWIZZLE, FN_size);
	return FN_INPUT(p);
}

#define SF3D FN_
#endif
////////////////////////////////////////////////////////////////////////////////////////////////

technique11 RemoveMe{}

