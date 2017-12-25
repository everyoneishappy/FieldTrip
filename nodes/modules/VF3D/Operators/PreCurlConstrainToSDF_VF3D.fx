

////////////////////////////////////////////////////////////////////////////////////////////////
//
//		Make a 3D vector field flow around the boundries of an SDF once Curl is applied
//
////////////////////////////////////////////////////////////////////////////////////////////////
// This token will be replaced with function name via RegExpr: "FN_"

// ensures the function is defined only once per instance
#ifndef FN_BODY 
#define FN_BODY

#ifndef CALC_FXH
#include <packs\happy.fxh\calc.fxh>
#endif

// Input VF3D function placeholder
#ifndef FN_INPUT
#define FN_INPUT normalize
#endif

// SDF function placeholder
#ifndef FN_SDF
#define FN_SDF length
#endif



// Parameters
float FN_radius : FN_RADIUS;
float FN_eps : FN_EPS = 0.001;

float3 FN_ (float3 p)
{
	float3 pf = FN_INPUT(p);
	float3 normal = calcNormS3(FN_SDF, p, FN_eps);
	float d = FN_SDF(p);
	float ramp = abs(PRECURLRAMP(d/FN_radius));
	ramp = saturate(ramp);
	return (ramp * pf) + ( (1 - ramp) * normal * dot(normal, pf) );
}
// end of the function body
#endif 

////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef VF3D
#define VF3D FN_
#endif
////////////////////////////////////////////////////////////////////////////////////////////////



technique11 RemoveMe{}

