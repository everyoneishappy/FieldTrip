


////////////////////////////////////////////////////////////////////////////////////////////////
//
//		2D Scalar Field Texture Sample Function
//
////////////////////////////////////////////////////////////////////////////////////////////////
// This token will be replaced with function name via RegExpr: "FN_"
#ifndef SF2D

// Paramaters
float4x4 FN_InvMat : FN_INVMAT =  { 1, 0, 0,  0, 
 									0, 1, 0,  0, 
 									0, 0, 1,  0, 
  									0, 0, 0,  1  };
Texture2D FN_vfTex : FN_VFTEX;
SamplerState FN_Samp : Immutable;


float FN_ (float2 p)
{
	p = mul(float4(p, 0, 1), FN_InvMat).xy; 
	p.y = -p.y;
	p += .5;
	float v = FN_vfTex.SampleLevel(FN_Samp, p, 0).x;
	return v;
}

#define SF2D FN_
#endif
////////////////////////////////////////////////////////////////////////////////////////////////



technique11 RemoveMe{}

