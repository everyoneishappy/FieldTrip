//#define AO
//#define SHADOW
//#define SSS

#ifndef RAYMARCH_FXH
#include<packs\happy.fxh\raymarch.fxh>
#endif




cbuffer cbControls:register(b0)
{
	float4x4 tVP:VIEWPROJECTION;
	float alpha;
};

float4 color  = { 1.0f,1.0f,1.0f,1.0f };
#ifndef INPUTRGB
float3 defaultColor(float3 p)
{
	return color.rgb;
}
#define INPUTRGB defaultColor
#endif


struct VS_IN{float4 PosO:POSITION;float4 TexCd:TEXCOORD0;};
struct VS_OUT{float4 PosWVP:SV_POSITION;float4 TexCd:TEXCOORD0;};
VS_OUT VS(VS_IN In){VS_OUT Out=(VS_OUT)0;Out.TexCd=In.TexCd;Out.PosWVP=float4(In.PosO.xy,0,1);return Out;}

struct PS_OUT
{
	float4 Color:SV_TARGET;
	float Depth:SV_DEPTH;
};

PS_OUT PS_Constant(VS_OUT In)
{
	// Raymarch 
	////////////////////////////////////////////////////////////////
	float3 ro, rd, p, n;   	// origin, direction, position, normal
	float z;				// depth
	float2 uv=In.TexCd.xy;
	rayMarch(uv, ro, rd, p, n, z);
	////////////////////////////////////////////////////////////////
	
	float4 c;
	c.rgb = INPUTRGB(p);
	c.a = alpha;
	
	float4 PosWVP=mul(float4(p.xyz,1),tVP);
	PS_OUT Out;
	Out.Color=c;
	Out.Depth=PosWVP.z/PosWVP.w;
	return Out;
}


PS_OUT PS_Grad(VS_OUT In)
{
	// Raymarch 
	////////////////////////////////////////////////////////////////
	float3 ro, rd, p, n;   	// origin, direction, position, normal
	float z;				// depth
	float2 uv=In.TexCd.xy;
	rayMarch(uv, ro, rd, p, n, z);
	////////////////////////////////////////////////////////////////
	
	float4 c=1;
	float g = saturate(dot(rd,n));
	c.rgb = g;
	c.rgb *= INPUTRGB(p);
	c.a = alpha;
	
	float4 PosWVP=mul(float4(p.xyz,1),tVP);
	PS_OUT Out;
	Out.Color=c;
	Out.Depth=PosWVP.z/PosWVP.w;
	return Out;
}

PS_OUT PS_Norm(VS_OUT In)
{
	// Raymarch 
	////////////////////////////////////////////////////////////////
	float3 ro, rd, p, n;
	float z;
	float2 uv=In.TexCd.xy;
	rayMarch(uv, ro, rd, p, n, z);
	////////////////////////////////////////////////////////////////
	
	float4 c=1;
	c.rgb = n*0.5+0.5; // remap normals to 0-1
	c.rgb *= INPUTRGB(p);
	c.a = alpha;
	
	float4 PosWVP=mul(float4(p.xyz,1),tVP);
	PS_OUT Out;
	Out.Color=c;
	Out.Depth=PosWVP.z/PosWVP.w;
	return Out;
}

technique11 RayMarchConstant
{
	pass P0
	{
		SetVertexShader(CompileShader(vs_5_0,VS()));
		SetPixelShader(CompileShader(ps_5_0,PS_Constant()));
	}
}


technique11 RayMarchGradient
{
	pass P0
	{
		SetVertexShader(CompileShader(vs_5_0,VS()));
		SetPixelShader(CompileShader(ps_5_0,PS_Grad()));
	}
}

technique11 RayMarchNormals
{
	pass P0
	{
		SetVertexShader(CompileShader(vs_5_0,VS()));
		SetPixelShader(CompileShader(ps_5_0,PS_Norm()));
	}
}




