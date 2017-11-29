#ifndef CALC_FXH
#include <packs\happy.fxh\calc.fxh>
#endif


// input function placeholder
#ifndef VF2D
#define VF2D placeHolderV2
#endif


uint threadCount;
StructuredBuffer<float2> bPos <string uiname="Sample Position 2D Buffer";>;
RWStructuredBuffer<float2> Output : BACKBUFFER;

//GROUPSIZE
[numthreads(64, 1, 1)]
void CS_SimpleAgent( uint3 dtid : SV_DispatchThreadID )
{
	if (dtid.x >= threadCount) { return; }
    Output[dtid.x] = VF2D(bPos[dtid.x]); 
}


technique11 SimpleAgent
{
	pass P0
	{
		SetComputeShader( CompileShader( cs_5_0, CS_SimpleAgent() ) );
	}
}

