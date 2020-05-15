//@author: vux
//@help: standard constant shader
//@tags: color
//@credits: 

#ifndef SF3D

#ifndef NOISE_FXH
#include<packs\happy.fxh\noise.fxh>
#endif

float defaultFunction(float3 p)
{
	float noise = valueNoise(p*8)*1.8;
	return noise;
}
#define SF3D defaultFunction
#endif

Texture2D texTransfer <string uiname="Transfer Function Texture";>;
float transferStart = 0.0;
float TransferEnd = 1.0;
SamplerState g_samLinear : IMMUTABLE
{
    Filter = MIN_MAG_MIP_LINEAR;
    AddressU = CLAMP;
    AddressV = CLAMP;
	AddressW = CLAMP;
};
SamplerState g_samPoint : IMMUTABLE
{
    Filter = MIN_MAG_MIP_POINT;
    AddressU = CLAMP;
    AddressV = CLAMP;
	AddressW = CLAMP;
};
 
cbuffer cbPerDraw : register( b0 )
{
	float4x4 tVP : VIEWPROJECTION;


};


cbuffer cbPerObj : register( b1 )
{
	float4x4 tW : WORLD;

};

struct VS_IN{float4 PosO:POSITION;float4 TexCd:TEXCOORD0;};
struct VS_OUT{float4 PosWVP:SV_POSITION;float4 TexCd:TEXCOORD0;};
VS_OUT VS(VS_IN In){VS_OUT Out=(VS_OUT)0;Out.TexCd=In.TexCd;Out.PosWVP=float4(In.PosO.xy,0,1);return Out;}




float4x4 tVI:VIEWINVERSE;
float4x4 tPI:PROJECTIONINVERSE;
	// normal projection
		
float rayStart = 0.5;
float stepSize = 0.003;
float stepFactor = 0.5;
uint maxSamples = 256;
float alpha = 1.0;


float2 R : TARGETSIZE;



struct PS_OUT
{
	float4 Color:SV_TARGET;
	#if WRITEDEPTH == 1
	float Depth:SV_DEPTH;
	#endif
};


PS_OUT PS_TransferTexture (VS_OUT In)
{
	PS_OUT Out;
	
	// Setup ray
	float3 rd = normalize(mul(float4(mul(float4((In.PosWVP.xy / R*2-1)*float2(1,-1),0,1),tPI).xy,1,0),tVI).xyz);
	float3 ro = tVI[3].xyz;
	float3 pos = ro + rd * rayStart;; //minDist?
	float3 dpos =999999;
	float3 stepDir = rd*stepSize;
	float maxDist = 64.0;

	// Ray loop
	float4 col = 0;
    for (uint i=0; i < maxSamples; ++i) {
    
    	// Sample from the scalar function and map to 0-1
    	float volSample = SF3D(pos);
    	volSample = (volSample - transferStart) / (TransferEnd - transferStart);	
    	
    	// Sample from the transfer function
    	float4 colSample = texTransfer.SampleLevel(g_samLinear, float2(volSample, .5), 0);
    	colSample.a *= alpha;
    	colSample.rgb *= colSample.a;
        col = (1.0f - col.a) * colSample + col;      
     
        // Break from the loop when alpha gets high enough
        if(col.a >= .95f)  
    	{
    		#if WRITEDEPTH == 1
			float4 PosWVP=mul(float4(pos.xyz,1),tVP);
			Out.Depth=PosWVP.z/PosWVP.w;
			#endif
    		break;
    	}
    	
    	pos += stepDir; // TODO adapt by z?
    	pos += length(pos-ro) * rd * stepFactor;
    }
	

	Out.Color=col;

	
	return Out;
}






technique10 ScalarVolumeTransferTexture
{
	pass P0
	{
		SetVertexShader( CompileShader( vs_5_0, VS() ) );
		SetPixelShader( CompileShader( ps_5_0, PS_TransferTexture() ) );
	}
}


