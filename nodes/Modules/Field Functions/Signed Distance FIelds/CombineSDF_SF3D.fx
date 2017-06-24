#ifndef CALC_FXH
#include <packs\happy.fxh\calc.fxh>
#endif

#ifndef SDF_FXH
#include <packs\happy.fxh\sdf.fxh>
#endif

////////////////////////////////////////////////////////////////////////////////////////////////
//
//		3D SDF Combination Functions
//
////////////////////////////////////////////////////////////////////////////////////////////////
// This token will be replaced with function name via RegExpr: "FN_"
#ifndef SF3D


// DEFINES
#ifndef FN_OP 
#define FN_OP U(FN_INPUT1(p), FN_INPUT2(p))
#endif

// Input function placeholder
#ifndef FN_INPUT1
#define FN_INPUT1 placeHolderS3
#endif

// Input class placeholder
#ifndef FN_INPUT2
#define FN_INPUT2 placeHolderS3
#endif

// Paramaters
float FN_p1 : FN_P1;
float FN_p2 : FN_P2;

float FN_ (float3 p)
{
		return FN_OP; // #defined in patch
}

#define SF3D FN_
#endif
////////////////////////////////////////////////////////////////////////////////////////////////

technique11 RemoveMe{}

