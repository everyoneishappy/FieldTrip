
#ifndef SDF_FXH
#include <packs\happy.fxh\sdf.fxh>
#endif

#ifndef SF2D
#define SF2D length // Just a place holder
#endif


cbuffer cbControls:register(b0)
{
	float4x4 tVP:VIEWPROJECTION;
	float4 drawCol  = { 1.0f,1.0f,1.0f,1.0f };
	float2 apsectRatio = 1;
	float softness;
};

struct VS_IN{float4 PosO:POSITION;float4 TexCd:TEXCOORD0;};
struct VS_OUT{float4 PosWVP:SV_POSITION;float4 TexCd:TEXCOORD0;};
VS_OUT VS(VS_IN In){VS_OUT Out=(VS_OUT)0;Out.TexCd=In.TexCd;Out.PosWVP=float4(In.PosO.xy,0,1);return Out;}

float4 PS_SDF(VS_OUT In) : SV_TARGET
{
	float2 p = In.TexCd.xy;
	p = p*2-1;
	p.y *=-1;
	p *= apsectRatio; 
	float dist = SF2D(p);
	float4 c=1;
	c = draw2DSDF(dist, softness);
	return drawCol * draw2DSDF(dist, softness);
}

float4 PS_Dist(VS_OUT In) : SV_TARGET
{
	float2 p = In.TexCd.xy;
	p = p*2-1;
	p.y *=-1;
	p *= apsectRatio; 
	float dist = SF2D(p);
	return drawCol * dist;
}

technique11 DrawSDF
{
	pass P0
	{
		SetVertexShader(CompileShader(vs_5_0,VS()));
		SetPixelShader(CompileShader(ps_5_0,PS_SDF()));
	}
}

technique11 RawDistance
{
	pass P0
	{
		SetVertexShader(CompileShader(vs_5_0,VS()));
		SetPixelShader(CompileShader(ps_5_0,PS_Dist()));
	}
}







