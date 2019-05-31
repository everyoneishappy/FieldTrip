
#ifndef SF3D
#define SF3D length // Just a place holder
#endif



RWTexture3D<float4> OUTPUT : BACKBUFFER;

float4x4 InvTransform;
float3 InvVolumeSize : INVTARGETSIZE;
//float3 VolumeSize : TARGETSIZE;





[numthreads(8, 8, 8)]
void CS_Vol( uint3 ti : SV_DispatchThreadID)
{ 
	float3 p = ti;
	p *= InvVolumeSize;
	p -= 0.5f;
	float3 tp = mul(float4(p,1),InvTransform).xyz;
	OUTPUT[ti] = SF3D(tp);
}

bool invertSDF;
[numthreads(8, 8, 8)]
void CS_SDF( uint3 ti : SV_DispatchThreadID)
{ 
	float3 p = ti;
	p *= InvVolumeSize;
	p -= 0.5f;
	float3 tp = mul(float4(p,1),InvTransform).xyz;
	if (invertSDF) OUTPUT[ti] = SF3D(tp) >= 0;
	else OUTPUT[ti] = SF3D(tp) <= 0;
}


technique11 AsVolume
{
	pass P0
	{
		SetComputeShader( CompileShader( cs_5_0, CS_Vol() ) );
	}
}


technique11 ThresholdSDF
{
	pass P0
	{
		SetComputeShader( CompileShader( cs_5_0, CS_SDF() ) );
	}
}



