
////////////////////////////////////////////////////////////////////////////////////////////////
//
//		Sample RGB from a texure given U/V 3D scalars
//
////////////////////////////////////////////////////////////////////////////////////////////////
// This token will be replaced with function name via RegExpr: "FN_"

// ensures the function is defined only once per instance
#ifndef FN_BODY 
#define FN_BODY

// DEFINES
#ifndef FN_SAMPLEMODE
#define FN_SAMPLEMODE Clamp
#endif

	
// Parameters
float2 FN_uv : FN_UV;
Texture2D FN_tex : FN_TEX;
SamplerState FN_Samp : Immutable
{
	Filter = MIN_MAG_MIP_LINEAR;
	AddressU = FN_SAMPLEMODE;
	AddressV = FN_SAMPLEMODE;
	AddressW = FN_SAMPLEMODE;
};





#ifndef FN_INPUT1
float defualtU(float3 p)
{
	return FN_uv.x;
}
#define FN_INPUT1 defualtU
#endif

#ifndef FN_INPUT2
float defualtV(float3 p)
{
	return FN_uv.y;
}
#define FN_INPUT2 defualtV
#endif



float3 FN_ (float3 p)
{
	float2 coords = float2(FN_INPUT1(p), FN_INPUT2(p));
	return FN_tex.SampleLevel(FN_Samp, coords, 0).xyz;
}

// end of the function body
#endif 

////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef VF3D
#define VF3D FN_
#endif
////////////////////////////////////////////////////////////////////////////////////////////////


technique11 RemoveMe{}

