#ifndef CALC_FXH
#include <packs\happy.fxh\calc.fxh>
#endif

#ifndef SBUFFER_FXH
#include <packs\happy.fxh\sbuffer.fxh>
#endif

////////////////////////////////////////////////////////////////////////////////////////////////
// Input placeholder
#ifndef VF2D
#define VF2D normalize
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
float maxDist <string uiname="Maximum Distance from Seed Position";> = .2;

float stepSizeDefault <string uiname="Step Size Defualt";> = 0.01666;
StructuredBuffer<float> stepSizeBuffer <string uiname="Step Size Buffer";>;

float resetAll <string uiname="Reset All";>;
StructuredBuffer<float> resetBuffer <string uiname="Reset Buffer";>;

//GROUPSIZE
[numthreads(64, 1, 1)]
void CS_SimpleAgent( uint3 dtid : SV_DispatchThreadID )
{

	if (dtid.x >= threadCount) { return; }

	float reset = max(resetAll, resetBuffer[dtid.x % sbSize(resetBuffer)]);
	if (reset || maxDist < distance(Output[dtid.x], bPos[dtid.x])) 
	{ Output[dtid.x] = bPos[dtid.x]; }
	
	float stepSize = sbLoad(stepSizeBuffer, stepSizeDefault, dtid.x);
	integrate(VF2D, Output[dtid.x], stepSize);
	
}


technique11 SimpleAgent
{
	pass P0
	{
		SetComputeShader( CompileShader( cs_5_0, CS_SimpleAgent() ) );
	}
}

