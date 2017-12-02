#ifndef CALC_FXH
#include <packs\happy.fxh\calc.fxh>
#endif


// vectorField class instance placeholder
#ifndef SF2D
#define SF2D placeHolderS2
#endif

uint threadCount;
StructuredBuffer<float2> bPos <string uiname="Sample Position 2D Buffer";>;
RWStructuredBuffer<float> Output : BACKBUFFER;

//GROUPSIZE
[numthreads(64, 1, 1)]
void CS_SimpleAgent( uint3 dtid : SV_DispatchThreadID )
{
	if (dtid.x >= threadCount) { return; }
    Output[dtid.x] = SF2D(bPos[dtid.x]); 
}


technique11 SimpleAgent
{
	pass P0
	{
		SetComputeShader( CompileShader( cs_5_0, CS_SimpleAgent() ) );
	}
}

