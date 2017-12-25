

////////////////////////////////////////////////////////////////////////////////////////////////
//
//		2D Vector Field Texture Sample Function
//
////////////////////////////////////////////////////////////////////////////////////////////////
// This token will be replaced with function name via RegExpr: "FN_"

// ensures the function is defined only once per instance
#ifndef FN_BODY 
#define FN_BODY

// Parameters
float4x4 FN_InvMat : FN_INVMAT=  { 1, 0, 0,  0, 
 									0, 1, 0,  0, 
 									0, 0, 1,  0, 
  									0, 0, 0,  1  };
Texture2D FN_vfTex : FN_VFTEX;
SamplerState FN_Samp : Immutable;

float2 FN_ (float2 p)
{
	p = mul(float4(p, 0, 1), FN_InvMat).xy; 
	p.y = -p.y;
	p += .5;
	float2 v = FN_vfTex.SampleLevel(FN_Samp, p, 0).xy;
	return v;
}
// end of the function body
#endif 

////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef VF2D
#define VF2D FN_
#endif
////////////////////////////////////////////////////////////////////////////////////////////////



technique11 RemoveMe{}

