#ifndef CALC_FXH
#include <packs\happy.fxh\calc.fxh>
#endif


#ifndef SF2D
#define SF2D length
#endif



uint threadCount;
uint iterations = 2;
float offset = 0;
StructuredBuffer<float2> bPos <string uiname="Sample Position 3D Buffer";>;
RWStructuredBuffer<float2> Output : BACKBUFFER;

//GROUPSIZE
[numthreads(64, 1, 1)]
void CS_ClosestPoint( uint3 dtid : SV_DispatchThreadID )
{
	if (dtid.x >= threadCount) { return; }
	float2 p = bPos[dtid.x];
	for (uint i = 0; i < iterations; i++)
	{
		float2 g;
		g = calcNormS2(SF2D, p, 0.001);
		float v = SF2D(p)+offset;
		p += g * v;
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

