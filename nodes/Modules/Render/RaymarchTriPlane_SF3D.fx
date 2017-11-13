#define AO
//#define SHADOW
//#define SSS
#ifndef SF3D
#define SF3D length // Just a place holder
#endif

#ifndef RAYMARCH_FXH
#include<packs\happy.fxh\raymarch.fxh>
#endif

#ifndef UV_FXH
#include<packs\happy.fxh\uv.fxh>
#endif

#ifndef WRITEDEPTH
#define WRITEDEPTH 1
#endif


Texture2D DNS_Textures[3];
SamplerState sTex <string uiname="Sampler State";>
{
    Filter = MIN_MAG_MIP_LINEAR;
    AddressU = Wrap;
    AddressV = Wrap;
};

TextureCube Dcube <string uiname="Diffuse Cubemap";>;
TextureCube Rcube <string uiname="Reflection Cubemap";>;
SamplerState SampCube
{
    Filter = MIN_MAG_MIP_LINEAR;
    AddressU = Clamp;
    AddressV = Clamp;
};

float Shine = 0.2;
float Gloss =0.5;

float FresnalBias = 0.2;
float FresnalPower = 0.5;

float alpha = 1;


// approximate Fresnel function
float fresnel(float NdotV, float bias, float power)
{
	return bias + (1.0-bias)*pow(1.0 - max(NdotV, 0), power);
}
float4 IblGrad(float3 N, float3 V, float4 cDiff, float4 cSpec)
{
	//calculate reflection 
	float3 ReflectUVW=reflect(V,N);
	
	float FresnelTerm = fresnel(dot(N, V), FresnalBias, FresnalPower);
	
	float4 SpecCubeShiny =  Rcube.SampleGrad(SampCube, ReflectUVW, ddx(ReflectUVW), ddy(ReflectUVW));
	float4 SpecCubeRough =  Dcube.SampleGrad(SampCube, ReflectUVW, ddx(ReflectUVW), ddy(ReflectUVW));
	float4 DiffuseCube = Dcube.SampleGrad(SampCube, N, ddx(N), ddy(N));
	
	float4 Spec = cSpec * lerp(SpecCubeShiny, SpecCubeRough,saturate(1-Gloss));
	
	//calculate Diffuse
	float4 Diffuse = cDiff * DiffuseCube;
	
	float4 FinalCol = lerp(Diffuse, Diffuse+Spec, saturate(Shine-1 + cSpec*FresnelTerm));
	
	FinalCol.a = cDiff.a;
	return FinalCol;

}


cbuffer cbControls:register(b0)
{
	float4x4 tVP:VIEWPROJECTION;
};

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


float texScale <string uiname="Texture Scale";> = 0.2;

PS_OUT PS_IBL(VS_OUT In)
{
	// Raymarch 
	////////////////////////////////////////////////////////////////
	float3 ro, rd, p, n;   	// origin, direction, position, normal
	float z;				// depth
	float2 uv=In.TexCd.xy;
	rayMarch(uv, ro, rd, p, n, z);
	////////////////////////////////////////////////////////////////

	float4 c=1;

	float4 DiffuseMap = triPlane(DNS_Textures[0], sTex, p, n, texScale, 2);
	float3 norm = triPlaneNormal(DNS_Textures[1], sTex, p, n, texScale, 2);
	float4 SpecMap = triPlane(DNS_Textures[2], sTex, p, n, texScale, 2);

	c =  IblGrad(norm, -rd, DiffuseMap, SpecMap);
	c.a = alpha;
	//c = DiffuseMap;
	
	//c = DNS_Textures[0].Sample(sTex, p.xz );

	#ifdef AO
	float ao = calcAO(p,norm);
	c.rgb *= ao;
	#endif
	
	#ifdef SHADOW
	float shadow = calcShadow(p);
	c.rgb *= shadow;
	#endif
	
	PS_OUT Out;
	Out.Color=c;
	
	#if WRITEDEPTH == 1
	float4 PosWVP=mul(float4(p.xyz,1),tVP);
	Out.Depth=PosWVP.z/PosWVP.w;
	#endif
	
	return Out;
}


technique11 RayMarchIBL
{
	pass P0
	{
		SetVertexShader(CompileShader(vs_5_0,VS()));
		SetPixelShader(CompileShader(ps_5_0,PS_IBL()));
	}
}





