#ifndef CALC_FXH
#include <packs\happy.fxh\calc.fxh>
#endif

#ifndef SBUFFER_FXH
#include <packs\happy.fxh\sbuffer.fxh>
#endif

////////////////////////////////////////////////////////////////////////////////////////////////
// Input placeholder
#ifndef VF3D
#define VF3D placeHolderV3
#endif
////////////////////////////////////////////////////////////////////////////////////////////////
// integration method selector
    #if (INTEGRATIONMODE==1) 
	#define integrate calcRK2V3
	#elif (INTEGRATIONMODE==2) 
	#define integrate calcRK4V3
	#else 
	#define integrate calcEulerV3
	#endif



uint threadCount;
StructuredBuffer<float3> bPos <string uiname="Seed Position 3D Buffer";>;
RWStructuredBuffer<float3> Output : BACKBUFFER;

float stepSizeDefault = 0.01666;
StructuredBuffer<float> stepSizeBuffer;
uint pathSize <string uiname="Points Per Path";> = 32;
float maxDist <string uiname="Maximum Distance from Seed Position";> = 5;
float resetAll;
StructuredBuffer<float> resetBuffer;

//GROUPSIZE
[numthreads(64, 1, 1)]
void CS_PathLine( uint3 dtid : SV_DispatchThreadID )
{

	if (dtid.x >= threadCount) { return; }
	uint pathIndex = dtid.x % pathSize;
	uint seedIndex = floor(dtid.x / pathSize);
	
	float reset = max(resetAll, resetBuffer[seedIndex % sbSize(resetBuffer)]);
	
	if (pathIndex != 0) // not leader
	{
		uint leaderIndex = dtid.x - pathIndex;
		if (reset || maxDist < distance(Output[leaderIndex], bPos[seedIndex])) 
		Output[dtid.x] = bPos[seedIndex];
		else 
		Output[dtid.x] = Output[dtid.x-1];
	}
	
	else // leader
	{
		if (reset || maxDist < distance(Output[dtid.x], bPos[seedIndex])) 
		Output[dtid.x] = bPos[seedIndex];
		else 
		{
			float stepSize = sbLoad(stepSizeBuffer, stepSizeDefault, seedIndex);
			integrate(VF3D, Output[dtid.x], stepSize);
		}
	}
	




}


technique11 PathLine
{
	pass P0
	{
		SetComputeShader( CompileShader( cs_5_0, CS_PathLine() ) );
	}
}

