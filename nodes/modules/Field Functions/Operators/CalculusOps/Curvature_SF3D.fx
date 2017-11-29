#ifndef CALC_FXH
#include <packs\happy.fxh\calc.fxh>
#endif


////////////////////////////////////////////////////////////////////////////////////////////////
//
//		Mean Curvature scalar from a 3d scalar field Function
//
////////////////////////////////////////////////////////////////////////////////////////////////
// This token will be replaced with function name via RegExpr: "FN_"
#ifndef SF3D


// Input function placeholder
#ifndef FN_INPUT
#define FN_INPUT placeHolderS3
#endif

// Paramaters
float FN_eps : FN_EPS = 0.001;

float3 FN_norm (float3 p)
{
	return calcNormS3(FN_INPUT, p, FN_eps);
}

float FN_ (float3 p)
{
	return calcDivV3(FN_norm, p, FN_eps*10) * -.5; 

}

#define SF3D FN_
#endif
////////////////////////////////////////////////////////////////////////////////////////////////



technique11 RemoveMe{}

