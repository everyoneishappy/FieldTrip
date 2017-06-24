struct LineSegment
{
	float3 pos;
	float size;
	float prog;
	float id;
};

RWStructuredBuffer<LineSegment> Outbuf : BACKBUFFER;

StructuredBuffer<float3> posBuffer;
StructuredBuffer<float> widthBuffer;
float widthDefualt;

StructuredBuffer<float2> InBinSize;
StructuredBuffer<float2> OutBinSize;

struct csin
{
	uint3 DTID : SV_DispatchThreadID;
	uint3 GTID : SV_GroupThreadID;
	uint3 GID : SV_GroupID;
};

[numthreads(1, 1, 1)]
void CS(csin input)
{
	uint did = input.DTID.x;
	
	uint OutStartID = OutBinSize[did].x;
	uint InStartID = InBinSize[did].x;
	uint InNextID = InBinSize[did].x + 1;
	uint InPrevID = InBinSize[did].x + InBinSize[did].y - 2;
	uint InEndID = InBinSize[did].x + InBinSize[did].y - 1;
	uint OutEndID = OutBinSize[did].x + OutBinSize[did].y - 1;
	
	LineSegment start = (LineSegment)0;
	LineSegment end = (LineSegment)0;
	
	start.pos = posBuffer[InStartID] * 2 - posBuffer[InNextID];
	start.prog = 0;
	start.id = did;
	Outbuf[OutStartID] = start;
	
	end.pos = posBuffer[InEndID] * 2 - posBuffer[InPrevID];
	end.prog = 1;
	end.id = did;
	Outbuf[OutEndID] = end;
	
	uint wCount, dummy;
	widthBuffer.GetDimensions(wCount, dummy);
	if (wCount > 0) 
	{
		start.size = widthBuffer[InStartID % wCount];
		end.size = widthBuffer[InEndID % wCount];
	}
	else 
	{
		start.size = widthDefualt;
		end.size = widthDefualt;
	}
}
technique11 cst { pass P0{SetComputeShader( CompileShader( cs_5_0, CS() ) );} }