#ifndef SBUFFER_FXH
#include <packs\happy.fxh\sbuffer.fxh>
#endif

float4x4 tVP : VIEWPROJECTION;
float4x4 tW : WORLD;
int instanceCount;
StructuredBuffer<float3> bPos;
StructuredBuffer<float3> bVector;
float3x3 lookat(float3 dir,float3 up=float3(0,1,0))
{
	float3 z=normalize(dir);float3 x=normalize(cross(up,z));float3 y=normalize(cross(z,x));return float3x3(x,y,z);
}
float4 cDefault <bool color=true;String uiname="Color Default";> = { 1.0f,1.0f,1.0f,1.0f };
StructuredBuffer<float4> vColBuffer;
float Alpha;




struct vsInput
{
	float4 Pos : POSITION;
	uint iid : SV_InstanceID;
		

};

struct psInput
{
    float4 PosWVP: SV_POSITION;
	float4 Vcol : COL0;
};




psInput VS_ColorByVector(vsInput input)
{
    psInput output;
	uint iid = input.iid;
	float4 p = input.Pos;
	float3 v = bVector[iid];
	
	p.z*= length(v);
	p = mul(p, tW);
	p.xyz = mul(p.xyz, lookat(v));
	p.xyz += bPos[iid];

	
    output.PosWVP  = mul(p, tVP);
	output.Vcol = float4(normalize(v)*.5+.5, 1);
    return output;
}


psInput VS_ColorByBuffer(vsInput input)
{
    psInput output;
	uint iid = input.iid;
	float4 p = input.Pos;
	float3 v = bVector[iid];
	p.z*= length(v);
	p = mul(p, tW);
	p.xyz = mul(p.xyz, lookat(v));
	p.xyz += bPos[iid];

    output.PosWVP  = mul(p ,tVP);
	output.Vcol = sbLoad(vColBuffer, cDefault, iid);
    return output;
}




float4 PS(psInput input): SV_Target
{
    float4 col = input.Vcol;
	col.a = Alpha;
    return col;
}




technique10 ColorByVector
{
	pass P0
	{
		SetVertexShader( CompileShader( vs_5_0, VS_ColorByVector() ) );
		SetPixelShader( CompileShader( ps_5_0, PS() ) );
	}
}

technique10 ColorByInput
{
	pass P0
	{
		SetVertexShader( CompileShader( vs_5_0, VS_ColorByBuffer() ) );
		SetPixelShader( CompileShader( ps_5_0, PS() ) );
	}
}




