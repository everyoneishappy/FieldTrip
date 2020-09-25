

#ifndef SF3D
#define SF3D length // Just a place holder
#endif

#define RAYMARCHER

#ifndef RAYMARCH_FXH
#include<packs\happy.fxh\raymarch.fxh>
#endif






cbuffer cbControls:register(b0)
{
	float4x4 tVP:VIEWPROJECTION;
	float4x4 tV:VIEW;
};


uint materialID;
float4 defualtColor = 1.0;




struct VS_IN{float4 PosO:POSITION;float4 TexCd:TEXCOORD0;};
struct VS_OUT{float4 PosWVP:SV_POSITION;float4 TexCd:TEXCOORD0;};
VS_OUT VS(VS_IN In){VS_OUT Out=(VS_OUT)0;Out.TexCd=In.TexCd;Out.PosWVP=float4(In.PosO.xy,0,1);return Out;}

struct PS_OUT
{
	float4 pos : SV_Target0;
	float4 norm : SV_Target1;
	float2 uv : SV_Target2;
	float Depth:SV_DEPTH;
};

#ifndef INPUTRGB
float3 defualtRGB(float3 p)
{
	return defualtColor.rgb;
}
#define INPUTRGB defualtRGB
#endif

#ifndef INPUTALPHA
float defualtAlpha(float3 p)
{
	return defualtColor.a;
}
#define INPUTALPHA defualtAlpha
#endif


PS_OUT PS_GBuffer(VS_OUT In)
{
	// Raymarcher 
	////////////////////////////////////////////////////////////////
	float2 uv = In.TexCd.xy; // Takes uv as input
	float3 rd, p, n;   	float z; // Outputs surface posistion(p) & normals(n), ray direction(rd) & length(z) 
	rayMarcher(uv, p, n, rd, z);
	////////////////////////////////////////////////////////////////
	
	
	PS_OUT Out;
	Out.pos = float4(p.xyz, 1);
	Out.norm = float4(n.xyz, (float) materialID * 0.001);
	Out.uv = uv;
	float4 PosWVP=mul(float4(p.xyz,1),tVP);
	Out.Depth=PosWVP.z/PosWVP.w;

	
	return Out;
}



#ifndef INPUTBUMP
float flat(float3 p)
{
	return 0.001;
}
#define INPUTBUMP flat
#endif



float bumpAmt = 1.0;

PS_OUT PS_GBufferBumped(VS_OUT In)
{
	// Raymarcher 
	////////////////////////////////////////////////////////////////
	float2 uv = In.TexCd.xy; // Takes uv as input
	float3 rd, p, n;   	float z; // Outputs surface posistion(p) & normals(n), ray direction(rd) & length(z) 
	rayMarcher(uv, p, n, rd, z);
	////////////////////////////////////////////////////////////////

	
	PS_OUT Out;
	float bump = INPUTBUMP(p);
	float3 pp = p + bump * n * bumpAmt;
	n += calcGradS3(INPUTBUMP, pp, 0.01)* bumpAmt;
	n = normalize(n);
	
	Out.pos = float4(p.xyz, 1);
	Out.norm = float4(n.xyz, (float) materialID * 0.001);
	Out.uv = uv;
	
	float4 PosWVP=mul(float4(p.xyz,1),tVP);
	Out.Depth=PosWVP.z/PosWVP.w;

	
	return Out;
}

float3 shadowCasterPos;

struct PS_OUT_VSM
{
	float2 Color:SV_TARGET;
	float Depth:SV_DEPTH;
};

PS_OUT_VSM PS_VSM(VS_OUT In)
{
	PS_OUT_VSM Out;
	// Raymarcher 
	////////////////////////////////////////////////////////////////
	float2 uv = In.TexCd.xy; // Takes uv as input
	float3 rd, p, n;   	float z; // Outputs surface posistion(p) & normals(n), ray direction(rd) & length(z) 
	rayMarcher(uv, p, n, rd, z);
	////////////////////////////////////////////////////////////////
	
	
	float4 PosWVP=mul(float4(p.xyz,1),tVP);
	float worldSpaceDistance = distance(shadowCasterPos, p.xyz);
	
	float2 depth;
	depth.x = (worldSpaceDistance / marchMaxDistance) + .001;
	depth.y = depth.x * depth.x;
	
	Out.Color = depth;
	Out.Depth = PosWVP.z/PosWVP.w;
	
	return Out;
}


technique11 RayMarchGBuffer
{
	pass P0
	{
		SetVertexShader(CompileShader(vs_4_0,VS()));
		SetPixelShader(CompileShader(ps_4_0,PS_GBuffer()));
	}
}


technique11 RayMarchGBufferBump
{
	pass P0
	{
		SetVertexShader(CompileShader(vs_4_0,VS()));
		SetPixelShader(CompileShader(ps_4_0,PS_GBufferBumped()));
	}
}

technique11 RayMarchVSMShadow
{
	pass P0
	{
		SetVertexShader(CompileShader(vs_4_0,VS()));
		SetPixelShader(CompileShader(ps_4_0,PS_VSM()));
	}
}