#ifndef CALC_FXH
#include <packs\happy.fxh\calc.fxh>
#endif


////////////////////////////////////////////////////////////////////////////////////////////////
//
//		Make a 3D vector field flow around the boundries of an SDF once Curl is applied
//
////////////////////////////////////////////////////////////////////////////////////////////////
// This token will be replaced with function name via RegExpr: "FN_"
#ifndef VF3D



// Input function placeholder
#ifndef FN_INPUT
#define FN_INPUT placeHolderV3
#endif

// SDF function placeholder
#ifndef FN_SDF
#define FN_SDF placeHolderS3
#endif



// Paramaters
float FN_radius : FN_RADIUS;
float FN_eps : FN_EPS = 0.001;

float3 FN_ (float3 p)
{
	float3 pf = FN_INPUT(p);
	float3 normal = calcNormS3(FN_SDF, p, FN_eps);
	float d = FN_SDF(p);
	float ramp = abs(PRECURLRAMP(d/FN_radius));
	return ramp * pf + (1 - ramp) * normal * dot(normal, pf);
}
#define VF3D FN_
#endif
////////////////////////////////////////////////////////////////////////////////////////////////



technique11 RemoveMe{}

