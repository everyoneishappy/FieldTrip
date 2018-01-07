


// VF3D function placeholder
#ifndef VF3D
#define VF3D normalize
#endif


// for lookat functiom
#ifndef TRANSFORM_FXH
#include <packs\happy.fxh\transform.fxh>
#endif

float amount = 1.0;
float eps = 0.01;

// displace position along with smooth normals.  From the UNC the holy
float3 displaceNorm(inout float3 pos, float3 n, float amount = 1.0, float eps = 0.01)
{

	float3x3 lkt=lookat(n);

	float3 v1=float3(1,0,0);
	float3 v2=float3(0,0,1);
	v1=normalize(mul(v1,(lkt)));
	v2=normalize(cross(n,v1));

	float3 p0 = pos;
	float3 p1 = p0 + v1 * eps;
	float3 p2 = p0 + v2 * eps;

	p0 += VF3D(p0) * amount;
	p1 += VF3D(p1) * amount;
	p2 += VF3D(p2) * amount;

	v1=normalize(p1-p0);
	v2=normalize(p2-p0);

	pos.xyz=p0;							// pass out the displaced position
	return normalize(cross(v1,v2));  	// normals perturbed by the function
}





float4x4 transform;

struct VSin
{
	float4 pos : POSITION;
	float3 norm : NORMAL;
	float4 TexCd: TEXCOORD0;
};

struct GSin
{
	float4 pos : POSITION;
	float3 norm : NORMAL;
	float4 TexCd: TEXCOORD0;
};

GSin VS(VSin input)
{
    GSin output;

	float4 p = input.pos;
	float3 n = input.norm.xyz;
	
	n = displaceNorm(p.xyz, n, amount, eps);
	
	p = mul(p, transform);
	n = mul(float4(n, 0), transform).xyz;
	
	output.pos = p;
	output.norm = n;
	output.TexCd = input.TexCd;

	
    return output;
}
[maxvertexcount(3)]
void GS(triangle GSin input[3], inout TriangleStream<GSin>GSOut)
{
	GSin v = (GSin)0;
	GSOut.RestartStrip();

	for(uint i=0;i<3;i++)
	{
		v=input[i];
		GSOut.Append(v);
	}
	GSOut.RestartStrip();
}

GeometryShader StreamOutGS = ConstructGSWithSO( CompileShader( gs_5_0, GS() ),
	"POSITION.xyz; NORMAL.xyz; TEXCOORD.xy", NULL, NULL, NULL, -1);

technique11 Layout
{
	pass P0
	{
		
		SetVertexShader( CompileShader( vs_5_0, VS() ) );
		//SetGeometryShader( CompileShader( gs_5_0, GS() ) );
	    SetGeometryShader( StreamOutGS );

	}
}