//@author: Everyoneishappy
//@help: Render WorldPos to uv layout
//@tags: UV
//@credits: 


#ifndef CALC_FXH
#include <packs\happy.fxh\calc.fxh>
#endif

////////////////////////////////////////////////////
#ifndef SF3D
#ifndef NOISE_FXH
#include<packs\happy.fxh\noise.fxh>
#endif

float defaultFunction(float3 p)
{
	float noise = valueNoise(p*16)*1.8;
	return noise;
}
#define SF3D defaultFunction
#endif
////////////////////////////////////////////////////


Texture2D texTransfer <string uiname="Transfer Function Texture";>;
float transferStart = 0.0;
float TransferEnd = 1.0;
Texture2D texBackFace;

SamplerState g_samLinear : IMMUTABLE
{
    Filter = MIN_MAG_MIP_LINEAR;
    AddressU = CLAMP;
    AddressV = CLAMP;
	AddressW = CLAMP;
};

 
cbuffer cbPerDraw : register( b0 )
{
	float4x4 tVP : VIEWPROJECTION;
	float alpha <float uimin=0.0; float uimax=1.0;> = 1; 
	uint maxSamples = 256;

};


cbuffer cbPerObj : register( b1 )
{
	float4x4 tW : WORLD;

};

struct VS_IN
{
    float4 Pos  : POSITION;
};

struct vs2ps
{
    float4 PosWVP: SV_POSITION;
	float4 PosW : TEXCOORD1;
};

vs2ps VS(VS_IN input)
{
    vs2ps Out = (vs2ps)0;
    Out.PosWVP  = mul(input.Pos,mul(tW,tVP));
	Out.PosW  = mul(input.Pos, tW);
    return Out;
}

struct PS_OUT
{
	float4 Color:SV_TARGET;
	#if WRITEDEPTH == 1
	float Depth:SV_DEPTH;
	#endif
};


float4x4 tVI:VIEWINVERSE;
float4x4 tPI:PROJECTIONINVERSE;
	// normal projection
		

float stepSize = 0.001;
float4x4 Modelview : VIEW;

float2 R : TARGETSIZE;

bool rayRange(float2 uv, out float t0, out float t1)
{
	texBackFace.Sample(g_samLinear, uv, 0);
}




PS_OUT PS_TransferTexture (vs2ps In)
{
	PS_OUT Out;
	
	float3 rayStart = In.PosW.xyz;
    float3 rayStop = texBackFace.Sample(g_samLinear, In.PosWVP.xy/R, 0).xyz;
    

    // Perform the ray marching:
    float3 pos = rayStart;
    float3 step = normalize(rayStop-rayStart) * stepSize;
    float travel = distance(rayStop, rayStart);
	float4 col = 0;
	#if WRITEDEPTH == 1
	Out.Depth=999999;
	#endif
	
    for (uint i=0; i < maxSamples && travel > 0.0; ++i, pos += step, travel -= stepSize) {
    
    	// Sample from the scalar function and map to 0-1
    	float volSample = SF3D(pos);
    	volSample = (volSample - transferStart) / (TransferEnd - transferStart);
    	
    	float4 colSample = texTransfer.SampleLevel(g_samLinear, float2(volSample, .5), 0);
    	colSample.a *= alpha;
    	colSample.rgb *= colSample.a;
        col = (1.0f - col.a) * colSample + col;     
     
        //break from the loop when alpha gets high enough
        if(col.a >= .95f)  
    	{
    		#if WRITEDEPTH == 1
			float4 PosWVP=mul(float4(pos.xyz,1),tVP);
			Out.Depth=PosWVP.z/PosWVP.w;
			#endif
    		break;
    	}

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


