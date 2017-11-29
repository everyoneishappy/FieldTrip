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

float defualt(float3 p)
{
	return 0.0;
}

// Input Function placeholder
#ifndef FN_INPUT_X
#define FN_INPUT_X defualt
#endif

#ifndef FN_INPUT_Y
#define FN_INPUT_Y defualt
#endif

#ifndef FN_INPUT_Z
#define FN_INPUT_Z defualt
#endif

float3 FN_ (float3 p)
{
	return float3(FN_INPUT_X(p), FN_INPUT_Y(p), FN_INPUT_Z(p) );
	
}

#define VF3D FN_
#endif
////////////////////////////////////////////////////////////////////////////////////////////////



technique11 RemoveMe{}

