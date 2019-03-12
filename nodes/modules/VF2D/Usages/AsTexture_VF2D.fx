
#ifndef VF2D
float2 f(float2 p)
{
	return p;
}
#define VF2D f // Just a place holder
#endif



float4x4 tVP:LAYERVIEWPROJECTION;
float4x4 tW : WORLD;

struct vsInput
{
    float4 posObject : POSITION;
	float4 uv: TEXCOORD0;
};

struct psInput
{
    float4 posScreen : SV_Position;
    float4 uv: TEXCOORD0;
};


psInput VS(vsInput input)
{
	psInput output;
	output.posScreen = mul(input.posObject, tVP);
	output.uv = input.uv;
	return output;
}

float2 PS(psInput input): SV_Target
{
	float2 p = input.uv.xy;
	p = p*2-1;
	p.y *=-1;
	p = mul(float4(p,0,1), tW).xy;
	return VF2D(p);
}




technique11 AsTexture
{
	pass P0 <string format="R32_G32_Float";>
	{
		SetVertexShader(CompileShader(vs_5_0,VS()));
		SetPixelShader(CompileShader(ps_5_0,PS()));
	}
}






