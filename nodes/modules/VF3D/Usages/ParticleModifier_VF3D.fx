/* The following includes are mandatory! */
#include <packs\dx11.particles\nodes\modules\Core\fxh\Core.fxh>
#include <packs\dx11.particles\nodes\modules\Core\fxh\IndexFunctions_Particles.fxh>
#include <packs\dx11.particles\nodes\modules\Core\fxh\IndexFunctions_DynBuffer.fxh>
/* Have a look at the packs\dx11.particles\nodes\modules\Core\ directory for more helper functions */



/* Like described in the template patch, the attribute(s) for the particlesystem is registered here*/ 
struct Particle {
	#if defined(COMPOSITESTRUCT)
  		COMPOSITESTRUCT
 	#else
		float3 position;
		float3 velocity;
		float3 force;
	#endif
};

/* The ParticleBuffer and the UseSelectionIndex variable are mandatory*/
RWStructuredBuffer<Particle> ParticleBuffer : PARTICLEBUFFER;


struct csin
{
	uint3 DTID : SV_DispatchThreadID;
	uint3 GTID : SV_GroupThreadID;
	uint3 GID : SV_GroupID;
};



#ifndef CALC_FXH
#include <packs\happy.fxh\calc.fxh>
#endif
// vectorField class instance placeholder
#ifndef VF3D
#define VF3D placeHolderV3
#endif

#ifndef TARGETATTRIBUTE
#define TARGETATTRIBUTE velocity
#endif



[numthreads(XTHREADS, YTHREADS, ZTHREADS)]
void CSSet(csin input)
{
	uint particleIndex = GetParticleIndex( input.DTID.x );
	if (particleIndex == -1 ) return;
	
	ParticleBuffer[particleIndex].TARGETATTRIBUTE.xyz = VF3D(ParticleBuffer[particleIndex].position);
}

[numthreads(XTHREADS, YTHREADS, ZTHREADS)]
void CSAdd(csin input)
{
	uint particleIndex = GetParticleIndex( input.DTID.x );
	if (particleIndex == -1 ) return;
	
	ParticleBuffer[particleIndex].TARGETATTRIBUTE.xyz += VF3D(ParticleBuffer[particleIndex].position);
}

[numthreads(XTHREADS, YTHREADS, ZTHREADS)]
void CSMul(csin input)
{
	uint particleIndex = GetParticleIndex( input.DTID.x );
	if (particleIndex == -1 ) return;
	
	ParticleBuffer[particleIndex].TARGETATTRIBUTE.xyz *= VF3D(ParticleBuffer[particleIndex].position);
}




technique11 Set { pass P0{SetComputeShader( CompileShader( cs_5_0, CSSet() ) );} }
technique11 Add { pass P0{SetComputeShader( CompileShader( cs_5_0, CSAdd() ) );} }
technique11 Mul { pass P0{SetComputeShader( CompileShader( cs_5_0, CSMul() ) );} }