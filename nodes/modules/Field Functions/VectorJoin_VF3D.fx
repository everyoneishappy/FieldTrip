#ifndef CALC_FXH
#include <packs\happy.fxh\calc.fxh>
#endif


////////////////////////////////////////////////////////////////////////////////////////////////
//
//		3D Vector Field from three 3D Scaler Field Functions
//
////////////////////////////////////////////////////////////////////////////////////////////////
// This token will be replaced with function name via RegExpr: "FN_"
#ifndef VF3D

// Input Function placeholder
#ifndef FN_INPUT_X
#define FN_INPUT_X placeHolderS3
#endif

#ifndef FN_INPUT_Y
#define FN_INPUT_Y placeHolderS3
#endif

#ifndef FN_INPUT_Z
#define FN_INPUT_Z placeHolderS3
#endif

float3 FN_ (float3 p)
{
	return float3(FN_INPUT_X(p), FN_INPUT_Y(p), FN_INPUT_Z(p) );
	
}

#define VF3D FN_
#endif
////////////////////////////////////////////////////////////////////////////////////////////////



technique11 RemoveMe{}

