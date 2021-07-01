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
uint stepCount = 12;

float stepSizeDefault <string uiname="Step Size Defualt";> = 0.01666;
StructuredBuffer<float> stepSizeBuffer <string uiname="Step Size Buffer";>;

//GROUPSIZE
[numthreads(128, 1, 1)]
void CS_StreamLine( uint3 dtid : SV_DispatchThreadID )
{

	if (dtid.x >= threadCount) { return; }

	uint index = dtid.x * stepCount;  // first point
	float3 p = bPos[dtid.x % sbSize(bPos)];
	Output[index] = p;
	float stepSize = sbLoad(stepSizeBuffer, stepSizeDefault, dtid.x);
	for (uint i = 1; i <= stepCount -1; i++)
	{

		integrate(VF3D, p, stepSize); 
		Output[index+i] =  p;
	}
}


technique11 StreamLine
{
	pass P0
	{
		SetComputeShader( CompileShader( cs_5_0, CS_StreamLine() ) );
	}
}

