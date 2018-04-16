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

uint pathSize <string uiname="Points Per Seed";> = 32;
uint indexOffset;

float stepSizeDefault <string uiname="Step Size Defualt";> = 0.01666;
StructuredBuffer<float> stepSizeBuffer <string uiname="Step Size Buffer";>;
float resetAll <string uiname="Reset All";>;
StructuredBuffer<float> resetBuffer <string uiname="Reset Buffer";>;


//GROUPSIZE
[numthreads(128, 1, 1)]
void CS_StreakLine( uint3 dtid : SV_DispatchThreadID )
{

	if (dtid.x >= threadCount) { return; }
	uint offset = (dtid.x + indexOffset) % pathSize;
	uint seedIndex = floor(dtid.x / pathSize);
	
	float reset = max(resetAll, resetBuffer[seedIndex % sbSize(resetBuffer)]);
	
	if (reset || offset == 0)
	Output[dtid.x] = bPos[seedIndex];
	else 
	{
	float stepSize = sbLoad(stepSizeBuffer, stepSizeDefault, dtid.x);
	integrate(VF3D, Output[dtid.x], stepSize);
	}

}


technique11 StreakLine
{
	pass P0
	{
		SetComputeShader( CompileShader( cs_5_0, CS_StreakLine() ) );
	}
}

