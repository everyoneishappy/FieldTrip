
#ifndef CALC_FXH
#include <packs\happy.fxh\calc.fxh>
#endif

#ifndef SBUFFER_FXH
#include <packs\happy.fxh\sbuffer.fxh>
#endif


////////////////////////////////////////////////////////////////////////////////////////////////
// vector field function placeholder
#ifndef VF3D
#define VF3D placeHolderV3
#endif
////////////////////////////////////////////////////////////////////////////////////////////////



uint threadCount;
StructuredBuffer<float3> bPos <string uiname="Seed Position 3D Buffer";>;
RWStructuredBuffer<float3> Output : BACKBUFFER;

float stepSizeDefault = 0.01666;
StructuredBuffer<float> stepSizeBuffer;
float maxDistDefualt <string uiname="Maximum Distance from Seed Position";> = 5;
StructuredBuffer<float> maxDistBuffer;
float resetAll;
StructuredBuffer<float> resetBuffer;

//GROUPSIZE
[numthreads(128, 1, 1)]
void CS_SimpleAgent( uint3 dtid : SV_DispatchThreadID )
{
	if (dtid.x >= threadCount) { return; }
	
	float reset = max(resetAll, resetBuffer[dtid.x % sbSize(resetBuffer)]);

	float maxDist = sbLoad(maxDistBuffer, maxDistDefualt, dtid.x);
	if (reset || maxDist < distance(Output[dtid.x], bPos[dtid.x])) 
	{ Output[dtid.x] = bPos[dtid.x]; }
	
	float stepSize = sbLoad(stepSizeBuffer, stepSizeDefault, dtid.x);
	
	#if (INTEGRATIONMODE==1) 
	calcRK2V3(VF3D, Output[dtid.x], stepSize);
	#elif (INTEGRATIONMODE==2) 
	calcRK4V3(VF3D, Output[dtid.x], stepSize);
	#else 
	calcEulerV3(VF3D, Output[dtid.x], stepSize);
	#endif
}


technique11 SimpleAgent
{
	pass P0
	{
		SetComputeShader( CompileShader( cs_5_0, CS_SimpleAgent() ) );
	}
}

