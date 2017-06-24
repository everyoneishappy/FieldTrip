#ifndef CALC_FXH
#include <packs\happy.fxh\calc.fxh>
#endif

////////////////////////////////////////////////////////////////////////////////////////////////
// Input placeholder
#ifndef VF2D
#define VF2D placeHolderV2
#endif
////////////////////////////////////////////////////////////////////////////////////////////////

// integration method selector
    #if (INTEGRATIONMODE==1) 
	#define integrate calcRK2V2
	#elif (INTEGRATIONMODE==2) 
	#define integrate calcRK4V2
	#else 
	#define integrate calcEulerV2
	#endif

uint threadCount;
StructuredBuffer<float2> bPos <string uiname="Seed Position 2D Buffer";>;
RWStructuredBuffer<float2> Output : BACKBUFFER;
float stepSize = 0.01666;
uint pathSize <string uiname="Points Per Seed";> = 32;
uint indexOffset;
float reset;

//GROUPSIZE
[numthreads(128, 1, 1)]
void CS_StreakLine( uint3 dtid : SV_DispatchThreadID )
{

	if (dtid.x >= threadCount) { return; }
	uint offset = (dtid.x + indexOffset) % pathSize;
	uint seedIndex = floor(dtid.x / pathSize);
	
	if (reset || offset == 0)
	Output[dtid.x] = bPos[seedIndex];
	else 
	{
	integrate(VF2D, Output[dtid.x], stepSize);
	}
	

}


technique11 StreakLine
{
	pass P0
	{
		SetComputeShader( CompileShader( cs_5_0, CS_StreakLine() ) );
	}
}

