uint threadCount;
StructuredBuffer<float2> bInput;
RWStructuredBuffer<float2> Output : BACKBUFFER;
uint indexOffset;
float reset;
uint pathSize;
uint pathCount;

//GROUPSIZE
[numthreads(64, 1, 1)]
void CS_StreakLineIndex( uint3 dtid : SV_DispatchThreadID )
{
	if (dtid.x >= threadCount) { return; }
	uint seedIndex = floor(dtid.x / pathSize)* pathSize;
	uint reverseIndex = pathSize - (dtid.x + indexOffset)% pathSize;
	//reverseIndex = (reverseIndex + indexOffset) % pathSize;
	Output[dtid.x] = bInput[reverseIndex+seedIndex-1];
	//Output[dtid.x] = bInput[test];
}


technique11 StreakLineIndex
{
	pass P0
	{
		SetComputeShader( CompileShader( cs_5_0, CS_StreakLineIndex() ) );
	}
}

