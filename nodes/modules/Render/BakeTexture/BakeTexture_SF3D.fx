//@author: Everyoneishappy
//@help: Render WorldPos to uv layout
//@tags: UV
//@credits: 


#ifndef CALC_FXH
#include <packs\happy.fxh\calc.fxh>
#endif

#ifndef SF3D
#define SF3D placeHolderS3 // Just a place holder
#endif

#ifndef VF3D
#define VF3D placeHolderV3 // Just a place holder
#endif



cbuffer cbPerDraw : register( b0 )
{
	float4x4 tP : PROJECTION;
	float4x4 tW : WORLD;

};



struct VS_IN
{
	float4 Pos : POSITION;
	float4 Norm : NORMAL;
	float4 UV : TEXCOORD0;

};


struct vs2ps
{
    float4 pPos: SV_POSITION;
	float4 Norm : NORMAL;
    float4 UV: TEXCOORD0;
	float4 PosW: TEXCOORD01;
};


vs2ps VS(VS_IN input)
{
    vs2ps Out = (vs2ps)0;
  
	//transform position to UV
	Out.pPos = mul((input.UV-.5), tP);
	Out.pPos.y *= -1.0f;
	Out.pPos.z=0;
	
	Out.Norm = normalize(mul(input.Norm,tW));
	
    Out.UV = input.UV;
	Out.PosW  = mul(input.Pos,tW);

	
    return Out;
}




float4 PS_Scalar(vs2ps In): SV_Target
{
    float4 col = 1;
	float3 p = In.PosW.xyz;
	
	col.rgb = SF3D(p);
    return col;
}

float4 PS_Vector(vs2ps In): SV_Target
{
    float4 col = 1;
	float3 p = In.PosW.xyz;
	
	col.rgb = VF3D(p);
    return col;
}






technique11 BakeScalarTexture
{
	pass P0
	{
		SetVertexShader( CompileShader( vs_5_0, VS() ) );
		SetPixelShader( CompileShader( ps_5_0, PS_Scalar() ) );
	}
}

technique11 BakeVectorTexture
{
	pass P0
	{
		SetVertexShader( CompileShader( vs_5_0, VS() ) );
		SetPixelShader( CompileShader( ps_5_0, PS_Vector() ) );
	}
}



