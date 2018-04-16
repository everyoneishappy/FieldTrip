#ifndef CALC_FXH
#include <packs\happy.fxh\calc.fxh>
#endif

#ifndef SBUFFER_FXH
#include <packs\happy.fxh\sbuffer.fxh>
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
uint stepCount = 12;

float stepSizeDefault <string uiname="Step Size Defualt";> = 0.01666;
StructuredBuffer<float> stepSizeBuffer <string uiname="Step Size Buffer";>;

//GROUPSIZE
[numthreads(64, 1, 1)]
void CS_StreamLine( uint3 dtid : SV_DispatchThreadID )
{

	if (dtid.x >= threadCount) { return; }

	Output[dtid.x] = bPos[dtid.x];
	float2 p = bPos[dtid.x];
	float stepSize = sbLoad(stepSizeBuffer, stepSizeDefault, dtid.x);
	for (uint i = 0; i < stepCount; i++)
	{
		uint index = dtid.x * stepCount + i;
		integrate(VF2D, p, stepSize); 
		Output[index] =  p;
	}
}


technique11 StreamLine
{
	pass P0
	{
		SetComputeShader( CompileShader( cs_5_0, CS_StreamLine() ) );
	}
}

