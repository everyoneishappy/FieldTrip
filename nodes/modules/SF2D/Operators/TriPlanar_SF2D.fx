
////////////////////////////////////////////////////////////////////////////////////////////////
//
//		2D Scalar Field to 3D Scalar Field Tri Planar projection
//
////////////////////////////////////////////////////////////////////////////////////////////////
// This token will be replaced with function name via RegExpr: "FN_"

// ensures the function is defined only once per instance
#ifndef FN_BODY 
#define FN_BODY

#ifndef CALC_FXH
#include <packs\happy.fxh\calc.fxh>
#endif

// DEFINES // preprocessor options from patch inserted here

// Input SF2D function placeholder
#ifndef FN_INPUT
#define FN_INPUT length
#endif

// Input VF3D function placeholder
#ifndef FN_NORMAL
#define FN_NORMAL normalize
#endif


// Parameters
float FN_power : FN_POWER;

#if FN_USEMAT
float4x4 FN_Mat : FN_MAT;
#endif




float FN_ (float3 p)
{
	#if FN_USEMAT==1
	p = mul(float4(p, 1), FN_Mat).xyz;
	#endif
	float3 n = normalize(FN_NORMAL(p));
	float3 m = pow( abs( n ), FN_power);
    float x = FN_INPUT(p.yz);
    float y = FN_INPUT(p.zx);
    float z = FN_INPUT(p.xy);
    return (x*m.x + y*m.y + z*m.z) / (m.x + m.y + m.z);
}
// end of the function body
#endif 

////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef SF3D
#define SF3D FN_
#endif
////////////////////////////////////////////////////////////////////////////////////////////////



technique11 RemoveMe{}

