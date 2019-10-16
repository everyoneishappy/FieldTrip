#ifndef RAYMARCH_FXH
#include <packs\happy.fxh\raymarch.fxh>
#endif

#ifndef CALC_FXH
#include <packs\happy.fxh\calc.fxh>
#endif

#ifndef SBUFFER_FXH
#include <packs\happy.fxh\sbuffer.fxh>
#endif

#ifndef SF2D
#define SF2D length
#endif

float2 rayMarch(float2 rayPos, float2 rayDir, float stepLength = .9, float minDist = 0.1, float maxDist = 200.0, int maxIter = 120)
{
	float2 startPos = rayPos + rayDir * minDist;
	float2 p = startPos;
	float z = minDist;
	maxDist -= minDist;
	for(int i=0; i<maxIter; i++)
	{
		float dist = SF2D(p);
		float rayStep = stepLength * dist;
		p += rayDir * rayStep;	
		z += rayStep;
		if(abs(dist) < 0.0001 * z || z > maxDist) break;
	}
	return p;
}

uint threadCount;

float stepLength = .9;
float minDist = 0.1;
float maxDist = 200.0; 
int maxIter = 120;
float offset = 0;
StructuredBuffer<float2> bPos <string uiname="Sample Position 2D Buffer";>;
StructuredBuffer<float2> bDir <string uiname="Sample Direction 2D Buffer";>;
float2 posDefualt;
float2 dirDefualt;

RWStructuredBuffer<float2> Output : BACKBUFFER;

//GROUPSIZE
[numthreads(64, 1, 1)]
void CS_ProjectPoint( uint3 dtid : SV_DispatchThreadID )
{
	if (dtid.x >= threadCount) { return; }
	float2 ro = sbLoad(bPos, posDefualt, dtid.x);
	float2 rd = sbLoad(bDir, dirDefualt, dtid.x);
	float2 p = rayMarch( ro, normalize(rd), stepLength, minDist, maxDist,  maxIter);
	float2 n = calcNormS2(SF2D, p, 0.001);
    Output[dtid.x] = p + n * offset; 
}


technique11 ProjectPoint
{
	pass P0
	{
		SetComputeShader( CompileShader( cs_5_0, CS_ProjectPoint() ) );
	}
}

