

////////////////////////////////////////////////////////////////////////////////////////////////
//
//		2D Domain Wraping Function
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
#ifndef FN_DOMAINOP 
#define FN_DOMAINOP pMod2
#endif

#ifndef FN_SWIZZLE 
#define FN_SWIZZLE xy
#endif

// Input SF2D function placeholder
#ifndef FN_INPUT
#define FN_INPUT length
#endif


// Parameters
float2 FN_size : FN_SIZE = 1;

float FN_ (float2 p)
{
	FN_DOMAINOP(p.FN_SWIZZLE, FN_size);
	return FN_INPUT(p);
}
// end of the function body
#endif 

////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef SF2D
#define SF2D FN_
#endif
////////////////////////////////////////////////////////////////////////////////////////////////

technique11 RemoveMe{}

