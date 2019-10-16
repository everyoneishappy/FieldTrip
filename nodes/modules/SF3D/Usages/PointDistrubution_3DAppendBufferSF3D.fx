

#ifndef NOISE_FXH
#include <packs\happy.fxh\noise.fxh>
#endif

// vectorField class instance placeholder
#ifndef SF3D
#define SF3D length
#endif


StructuredBuffer<float3> posBuffer;

AppendStructuredBuffer<float3> Output : BACKBUFFER;

float3 seed;
[numthreads(128, 1, 1)]
void appendFromBuffer( uint3 DTid : SV_DispatchThreadID )
{	
	float3 p = posBuffer[DTid.x];
	float input = SF3D(p);
	if(input < 0.0)
	{
		Output.Append(p);		
	}

}


technique11 appendPointFromBuffer
{
	pass P0
	{
		SetComputeShader( CompileShader( cs_5_0, appendFromBuffer() ) );
	}
}
