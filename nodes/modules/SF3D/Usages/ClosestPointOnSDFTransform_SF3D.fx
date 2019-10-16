

#ifndef CALC_FXH
#include <packs\happy.fxh\calc.fxh>
#endif

#ifndef TRANSFORM_FXH
#include <packs\happy.fxh\transform.fxh>
#endif

////////////////////////////////////////////////////////////////
//
//             place holder SDF
//
////////////////////////////////////////////////////////////////
#ifndef SF3D
float placeHolderSDF(float3 p)
{
		float d=9999999;
	d=min(d,length(p)-.25);
	d=min(d,dot(p, float3(0,1,0)));
	return d;
	//return float2 (d, 0);  // distance, optional matID
}
#define SF3D placeHolderSDF
#endif

////////////////////////////////////////////////////////////////



uint threadCount;
uint iterations = 2;
float offset = 0;
float3 lookup = float3(0,1,0);
StructuredBuffer<float3> bPos <string uiname="Sample Position 3D Buffer";>;
RWStructuredBuffer<float4x4> Output : BACKBUFFER;

//GROUPSIZE
[numthreads(64, 1, 1)]
void CS_ClosestPoint( uint3 dtid : SV_DispatchThreadID )
{
	if (dtid.x >= threadCount) { return; }
	float3 p = bPos[dtid.x];
	float3 g;
	for (uint i = 0; i < iterations; i++)
	{	g = calcNormS3(SF3D, p, 0.001);
		float v = SF3D(p) - offset;
		p -= g * v;
	}
	
	float4x4 m = identity4x4();
	m = translateM (p, m);
	m = mul(lookat4x4(g, lookup), m);
	Output[dtid.x] = m;
}


technique11 ClosestPoint
{
	pass P0
	{
		SetComputeShader( CompileShader( cs_5_0, CS_ClosestPoint() ) );
	}
}

