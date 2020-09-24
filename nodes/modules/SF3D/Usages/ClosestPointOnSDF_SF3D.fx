#ifndef SBUFFER_FXH
#include <packs\happy.fxh\sbuffer.fxh>
#endif

#ifndef CALC_FXH
#include <packs\happy.fxh\calc.fxh>
#endif


#ifndef SF3D
#define SF3D placeHolderS3
#endif





uint threadCount;
uint iterations = 2;

float eps = 0.001;
StructuredBuffer<float3> bPos <string uiname="Sample Position 3D Buffer";>;

float offsetDefault = 0;
StructuredBuffer<float> offsetBuffer;
RWStructuredBuffer<float3> Output : BACKBUFFER;

//GROUPSIZE
[numthreads(128, 1, 1)]
void CS_ClosestPoint( uint3 dtid : SV_DispatchThreadID )
{
	if (dtid.x >= threadCount) { return; }
	
	float offset = sbLoad(offsetBuffer, offsetDefault, dtid.x);
	float3 p = bPos[dtid.x];
	for (uint i = 0; i < iterations; i++)
	{
		float3 g;
		g = calcNormS3(SF3D, p, eps);
		float v = SF3D(p) - offset;
		p -= g * v;
	}
	
    Output[dtid.x] = p; 
}


technique11 ClosestPoint
{
	pass P0
	{
		SetComputeShader( CompileShader( cs_5_0, CS_ClosestPoint() ) );
	}
}

