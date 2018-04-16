//@author: Everyoneishappy
//@help: 
//@tags: UV
//@credits: 




#ifndef VF3D
#define VF3D normalize // Just a place holder
#endif



cbuffer cbPerDraw : register( b0 )
{
float4x4 tVP:LAYERVIEWPROJECTION;

};

SamplerState linearSampler : Immutable
{
    Filter = MIN_MAG_MIP_LINEAR;
    AddressU = WRAP;
    AddressV = WRAP;
};

Texture2D DomainTexture <string uiname="Domain Texture"; >;


struct VS_IN
{
	float4 pos : POSITION;
	float4 uv : TEXCOORD0;

};


struct PS_IN
{
    float4 pos : SV_Position;
    float4 uv: TEXCOORD0;
};

PS_IN VS(VS_IN input)
{
	PS_IN output;
	output.pos = mul(input.pos, tVP);
	output.uv = input.uv;
	return output;
}



float4 PS_Vector(PS_IN In): SV_Target
{
    float4 col = 1;
	float4 p = DomainTexture.SampleLevel(linearSampler, In.uv.xy, 0);
	clip(p.a-.001);
	col.rgb = VF3D(p.xyz);
    return col;
}








technique11 DeferredTexture
{
	pass P0
	{
		SetVertexShader( CompileShader( vs_5_0, VS() ) );
		SetPixelShader( CompileShader( ps_5_0, PS_Vector() ) );
	}
}



