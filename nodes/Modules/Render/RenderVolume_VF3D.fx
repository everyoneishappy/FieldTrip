
#ifndef VF3D
#define VF3D length // Just a place holder
#endif



RWTexture3D<float4> OUTPUT : BACKBUFFER;

float4x4 InvTransform;
float3 InvVolumeSize : INVTARGETSIZE;
uint tranformCount, radCount, maxCount;
//float3 VolumeSize : TARGETSIZE;





[numthreads(8, 8, 8)]
void CS_Vol( uint3 ti : SV_DispatchThreadID)
{ 
	float3 p = ti;
	p *= InvVolumeSize;
	p -= 0.5f;
	float3 tp = mul(float4(p,1),InvTransform).xyz;
	OUTPUT[ti] = VF3D(tp);
}




technique11 AsVolume
{
	pass P0
	{
		SetComputeShader( CompileShader( cs_5_0, CS_Vol() ) );
	}
}






