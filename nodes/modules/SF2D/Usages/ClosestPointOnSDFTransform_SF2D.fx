#ifndef CALC_FXH
#include <packs\happy.fxh\calc.fxh>
#endif


#ifndef SF2D
#define SF2D length
#endif

#ifndef TRANSFORM_FXH
#include <packs\happy.fxh\transform.fxh>
#endif

uint threadCount;
uint iterations = 2;
float offset = 0;
StructuredBuffer<float2> bPos <string uiname="Sample Position 3D Buffer";>;
RWStructuredBuffer<float4x4> Output : BACKBUFFER;

//GROUPSIZE
[numthreads(64, 1, 1)]
void CS_ClosestPoint( uint3 dtid : SV_DispatchThreadID )
{
	if (dtid.x >= threadCount) { return; }
	float2 p = bPos[dtid.x];
	float2 g;
	for (uint i = 0; i < iterations; i++)
	{
		g = calcNormS2(SF2D, p, 0.001);
		float v = SF2D(p)+offset;
		p += g * v;
	}
	float4x4 m = identity4x4();
	m = translateM (float3(p, 0), m);
	m = mul(lookat4x4(float3(g, 0)), m);

    Output[dtid.x] = m; 
}


technique11 ClosestPoint
{
	pass P0
	{
		SetComputeShader( CompileShader( cs_5_0, CS_ClosestPoint() ) );
	}
}

