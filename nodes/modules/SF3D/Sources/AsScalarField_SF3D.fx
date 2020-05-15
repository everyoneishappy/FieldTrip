

////////////////////////////////////////////////////////////////////////////////////////////////
//
//		3D Scalar Field Volume Sample Function
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
Texture3D FN_vfTex : FN_VFTEX;
SamplerState FN_Samp : Immutable;

float3 FN_ (float3 p)
{
	p = mul(float4(p, 1), FN_InvMat).xyz; 
	p.y = -p.y;
	p += .5;
	float v = FN_vfTex.SampleLevel(FN_Samp, p, 0).x;
	return v;
}
// end of the function body
#endif 

////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef SF3D
#define SF3D FN_
#endif
////////////////////////////////////////////////////////////////////////////////////////////////



technique11 RemoveMe{}

