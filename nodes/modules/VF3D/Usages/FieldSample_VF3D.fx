#ifndef CALC_FXH
#include <packs\happy.fxh\calc.fxh>
#endif


// vectorField class instance placeholder
#ifndef VF3D
#define VF3D placeHolderV3
#endif



uint threadCount;
StructuredBuffer<float3> bPos <string uiname="Sample Position 3D Buffer";>;
RWStructuredBuffer<float3> Output : BACKBUFFER;

//GROUPSIZE
[numthreads(64, 1, 1)]
void CS_SimpleAgent( uint3 dtid : SV_DispatchThreadID )
{
	if (dtid.x >= threadCount) { return; }
    Output[dtid.x] = VF3D(bPos[dtid.x]); 
}


technique11 SimpleAgent
{
	pass P0
	{
		SetComputeShader( CompileShader( cs_5_0, CS_SimpleAgent() ) );
	}
}

