

////////////////////////////////////////////////////////////////////////////////////////////////
//
//		Mean Curvature scalar from a 2d scalar field Function
//
////////////////////////////////////////////////////////////////////////////////////////////////
// This token will be replaced with function name via RegExpr: "FN_"

// ensures the function is defined only once per instance
#ifndef FN_BODY 
#define FN_BODY

#ifndef CALC_FXH
#include <packs\happy.fxh\calc.fxh>
#endif


// Input SF2D function placeholder
#ifndef FN_INPUT
#define FN_INPUT length
#endif

// Parameters
float FN_eps : FN_EPS = 0.001;

float2 FN_norm (float2 p)
{
	return calcNormS2(FN_INPUT, p, FN_eps);
}

float FN_ (float2 p)
{
	return calcDivV2(FN_norm, p, FN_eps*10) * -.5; 

}
// end of the function body
#endif 

////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef SF2D
#define SF2D FN_
#endif
////////////////////////////////////////////////////////////////////////////////////////////////



technique11 RemoveMe{}

