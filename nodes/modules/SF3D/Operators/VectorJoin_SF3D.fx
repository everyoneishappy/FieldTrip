#ifndef CALC_FXH
#include <packs\happy.fxh\calc.fxh>
#endif


////////////////////////////////////////////////////////////////////////////////////////////////
//
//		3D Vector Field from three 3D Scaler Field Functions
//
////////////////////////////////////////////////////////////////////////////////////////////////
// This token will be replaced with function name via RegExpr: "FN_"

// ensures the function is defined only once per instance
#ifndef FN_BODY 
#define FN_BODY

float defualt(float3 p)
{
	return 0.0;
}

// Input Function placeholders
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
// end of the function body
#endif 

////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef VF3D
#define VF3D FN_
#endif
////////////////////////////////////////////////////////////////////////////////////////////////



technique11 RemoveMe{}

