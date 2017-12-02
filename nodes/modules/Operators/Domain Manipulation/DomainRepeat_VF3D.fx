
////////////////////////////////////////////////////////////////////////////////////////////////
//
//		3D Domain Wraping Function
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
#define FN_DOMAINOP pMod3
#endif

#ifndef FN_SWIZZLE 
#define FN_SWIZZLE xyz
#endif

// Input VF3D function placeholder
#ifndef FN_INPUT
#define FN_INPUT normalize
#endif


// Paramaters
float3 FN_size : FN_SIZE = 1;

float3 FN_ (float3 p)
{
	FN_DOMAINOP(p.FN_SWIZZLE, FN_size);
	return FN_INPUT(p);
}
// end of the function body
#endif 

////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef VF3D
#define VF3D FN_
#endif
////////////////////////////////////////////////////////////////////////////////////////////////

technique11 RemoveMe{}

