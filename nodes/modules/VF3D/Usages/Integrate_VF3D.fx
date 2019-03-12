#ifndef CALC_FXH
#include <packs\happy.fxh\calc.fxh>
#endif

#ifndef SBUFFER_FXH
#include <packs\happy.fxh\sbuffer.fxh>
#endif


// vectorField class instance placeholder
#ifndef VF3D
#define VF3D placeHolderV3
#endif



uint threadCount;
float stepSizeDefault = 0.01666;
StructuredBuffer<float> stepSizeBuffer;
StructuredBuffer<float3> bPos <string uiname="Sample Position 3D Buffer";>;
RWStructuredBuffer<float3> Output : BACKBUFFER;

//GROUPSIZE
[numthreads(128, 1, 1)]
void CS_SimpleAgent( uint3 dtid : SV_DispatchThreadID )
{
	if (dtid.x >= threadCount) { return; }
	float stepSize = sbLoad(stepSizeBuffer, stepSizeDefault, dtid.x);
	float3 p = bPos[dtid.x];
	#if (INTEGRATIONMODE==1) 
	calcRK2V3(VF3D, p, stepSize);
	#elif (INTEGRATIONMODE==2) 
	calcRK4V3(VF3D, p, stepSize);
	#else 
	calcEulerV3(VF3D, p, stepSize);
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

