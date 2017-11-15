#ifndef RAYMARCH_FXH
#include <packs\happy.fxh\raymarch.fxh>
#endif

#ifndef CALC_FXH
#include <packs\happy.fxh\calc.fxh>
#endif

#ifndef SBUFFER_FXH
#include <packs\happy.fxh\sbuffer.fxh>
#endif

#ifndef SF3D
#define SF3D length
#endif



uint threadCount;

float stepLength = .9;
float minDist = 0.1;
float maxDist = 200.0; 
int maxIter = 120;
float offset = 0;
StructuredBuffer<float3> bPos <string uiname="Sample Position 3D Buffer";>;
StructuredBuffer<float3> bDir <string uiname="Sample Direction 3D Buffer";>;
float3 posDefualt;
float3 dirDefualt;

RWStructuredBuffer<float3> Output : BACKBUFFER;

//GROUPSIZE
[numthreads(64, 1, 1)]
void CS_ProjectPoint( uint3 dtid : SV_DispatchThreadID )
{
	if (dtid.x >= threadCount) { return; }
	float3 ro = sbLoad(bPos, posDefualt, dtid.x);
	float3 rd = sbLoad(bDir, dirDefualt, dtid.x);
	float3 p = rayMarch( ro, rd, stepLength, minDist, maxDist,  maxIter);
	float3 n = calcNormS3(SF3D, p, 0.001);
    Output[dtid.x] = p + n * offset; 
}


technique11 ProjectPoint
{
	pass P0
	{
		SetComputeShader( CompileShader( cs_5_0, CS_ProjectPoint() ) );
	}
}

