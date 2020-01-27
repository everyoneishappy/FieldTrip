#ifndef CALC_FXH
#include <packs\happy.fxh\calc.fxh>
#endif

#ifndef SBUFFER_FXH
#include <packs\happy.fxh\sbuffer.fxh>
#endif


// vectorField class instance placeholder
#ifndef VF2D
#define VF2D placeHolderV2
#endif



uint threadCount;
float stepSizeDefault = 0.01666;
StructuredBuffer<float> stepSizeBuffer;
StructuredBuffer<float2> bPos <string uiname="Sample Position 2D Buffer";>;
RWStructuredBuffer<float2> Output : BACKBUFFER;

//GROUPSIZE
[numthreads(128, 1, 1)]
void CS_SimpleAgent( uint3 dtid : SV_DispatchThreadID )
{
	if (dtid.x >= threadCount) { return; }
	float stepSize = sbLoad(stepSizeBuffer, stepSizeDefault, dtid.x);
	float2 p = bPos[dtid.x % sbSize(bPos)];
	#if (INTEGRATIONMODE==1) 
	calcRK2V2(VF2D, p, stepSize);
	#elif (INTEGRATIONMODE==2) 
	calcRK4V2(VF2D, p, stepSize);
	#else 
	calcEulerV2(VF2D, p, stepSize);
	#endif
	
	Output[dtid.x] = p;
}


technique11 SimpleAgent
{
	pass P0
	{
		SetComputeShader( CompileShader( cs_5_0, CS_SimpleAgent() ) );
	}
}

