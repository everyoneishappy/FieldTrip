

 
cbuffer cbPerDraw : register( b0 )
{
	float4x4 tVP : VIEWPROJECTION;
	float4x4 tVI : VIEWINVERSE;
	float4x4 tWV : WORLDVIEW;
	float4x4 tV : VIEW;
};


cbuffer cbPerObj : register( b1 )
{
	float4x4 tW : WORLD;
	float4x4 tWI:WORLDINVERSE;
};

struct VS_IN
{
    float4 Pos  : POSITION;
};

struct vs2ps
{
    float4 PosWVP: SV_POSITION;
	float4 Pos : TEXCOORD1;
};

vs2ps VS(VS_IN input)
{
    vs2ps Out = (vs2ps)0;
    Out.PosWVP  = mul(input.Pos,mul(tW,tVP));
	Out.Pos  = mul(input.Pos, tW);
    return Out;
}



float4 PSpos(vs2ps In): SV_Target
{
    float4 col = In.Pos;
	col.a=1;
	
    return col;
}







technique10 WorldPosition
{
	pass P0
	{
		SetVertexShader( CompileShader( vs_4_0, VS() ) );
		SetPixelShader( CompileShader( ps_4_0, PSpos() ) );
	}
}



