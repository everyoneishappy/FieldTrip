
////////////////////////////////////////////////////////////////////////////////////////////////
//
//		2D SDF Combination Functions
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
#ifndef FN_OP 
#define FN_OP U(FN_INPUT1(p), FN_INPUT2(p))
#endif

// Input SF2D Function placeholder
#ifndef FN_INPUT1
#define FN_INPUT1 length
#endif

// Input SF2D Function placeholder
#ifndef FN_INPUT2
#define FN_INPUT2 length
#endif

// Parameters
float FN_p1 : FN_P1;
float FN_p2 : FN_P2;

float FN_ (float2 p)
{
		return FN_OP; // #defined in patch
}
// end of the function body
#endif 

////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef SF2D
#define SF2D FN_
#endif
////////////////////////////////////////////////////////////////////////////////////////////////

technique11 RemoveMe{}

