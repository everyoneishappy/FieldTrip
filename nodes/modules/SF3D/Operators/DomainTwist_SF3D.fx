
////////////////////////////////////////////////////////////////////////////////////////////////
//
//		3D Scalar Domain Twist Function
//
////////////////////////////////////////////////////////////////////////////////////////////////
// This token will be replaced with function name via RegExpr: "FN_"

// ensures the function is defined only once per instance
#ifndef FN_BODY 
#define FN_BODY



// Input SF3D function placeholder
#ifndef FN_INPUT
#define FN_INPUT length
#endif


float3 pTwist(float3 p, float strength)
{
    float c = cos(strength * p.y);
    float s = sin(strength * p.y);
    float2x2  m = float2x2(c, s, -s, c);
    float3  q = float3(mul(p.xz, m), p.y);
    return q;
}



// Parameters
float FN_Strength : FN_STRENGTH = 1.0;

float FN_ (float3 p)
{
	p = pTwist(p, FN_Strength);
	return FN_INPUT(p);
}
// end of the function body
#endif 

////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef SF3D
#define SF3D FN_
#endif
////////////////////////////////////////////////////////////////////////////////////////////////

technique11 RemoveMe{}

