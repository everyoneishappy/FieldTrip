//#define AO
//#define SHADOW
//#define SSS
#define RAYMARCHER

#ifndef RAYMARCH_FXH
#include<packs\happy.fxh\raymarch.fxh>
#endif






#ifndef WRITEDEPTH
#define WRITEDEPTH 1
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
	#if WRITEDEPTH == 1
	float Depth:SV_DEPTH;
	#endif
};

PS_OUT PS_Constant(VS_OUT In)
{
	// Raymarcher 
	////////////////////////////////////////////////////////////////
	float2 uv = In.TexCd.xy; // Takes uv as input
	float3 rd, p, n;   	float z; // Outputs surface posistion(p) & normals(n), ray direction(rd) & length(z) 
	rayMarcher(uv, p, n, rd, z);
	////////////////////////////////////////////////////////////////
	
	float4 c;
	c.rgb = INPUTRGB(p);
	c.a = alpha;
	
	
	PS_OUT Out;
	Out.Color=c;
	
	#if WRITEDEPTH == 1
	float4 PosWVP=mul(float4(p.xyz,1),tVP);
	Out.Depth=PosWVP.z/PosWVP.w;
	#endif
	
	return Out;
}


PS_OUT PS_Grad(VS_OUT In)
{
	// Raymarcher 
	////////////////////////////////////////////////////////////////
	float2 uv = In.TexCd.xy; // Takes uv as input
	float3 rd, p, n;   	float z; // Outputs surface posistion(p) & normals(n), ray direction(rd) & length(z) 
	rayMarcher(uv, p, n, rd, z);
	////////////////////////////////////////////////////////////////
	
	float4 c=1;
	float g = saturate(dot(rd,-n));
	c.rgb = g;
	c.rgb *= INPUTRGB(p);
	c.a = alpha;
	

	PS_OUT Out;
	Out.Color=c;
	
	#if WRITEDEPTH == 1
	float4 PosWVP=mul(float4(p.xyz,1),tVP);
	Out.Depth=PosWVP.z/PosWVP.w;
	#endif
	
	return Out;
}

bool humanNormals;
PS_OUT PS_Norm(VS_OUT In)
{
	// Raymarcher 
	////////////////////////////////////////////////////////////////
	float2 uv = In.TexCd.xy; // Takes uv as input
	float3 rd, p, n;   	float z; // Outputs surface posistion(p) & normals(n), ray direction(rd) & length(z) 
	rayMarcher(uv, p, n, rd, z);
	////////////////////////////////////////////////////////////////
	
	float4 c=1;
	c.rgb = n;
	if (humanNormals) c.rgb = c.rgb *0.5 + 0.5; // remap normals to 0-1
	c.a = alpha;

	PS_OUT Out;
	Out.Color=c;
	
	#if WRITEDEPTH == 1
	float4 PosWVP=mul(float4(p.xyz,1),tVP);
	Out.Depth=PosWVP.z/PosWVP.w;
	#endif
	
	return Out;
}

PS_OUT PS_Pos(VS_OUT In)
{
	// Raymarcher 
	////////////////////////////////////////////////////////////////
	float2 uv = In.TexCd.xy; // Takes uv as input
	float3 rd, p, n;   	float z; // Outputs surface posistion(p) & normals(n), ray direction(rd) & length(z) 
	rayMarcher(uv, p, n, rd, z);
	////////////////////////////////////////////////////////////////
	
	float4 c=1;
	c.rgb = p;
	c.a = alpha;
	PS_OUT Out;
	Out.Color=c;
	
	#if WRITEDEPTH == 1
	float4 PosWVP=mul(float4(p.xyz,1),tVP);
	Out.Depth=PosWVP.z/PosWVP.w;
	#endif
	
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

technique11 RayMarchPosition
{
	pass P0
	{
		SetVertexShader(CompileShader(vs_5_0,VS()));
		SetPixelShader(CompileShader(ps_5_0,PS_Pos()));
	}
}



