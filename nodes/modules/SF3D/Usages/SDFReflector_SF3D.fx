/* The following includes are mandatory! */
#include <packs\dx11.particles\nodes\modules\Core\fxh\Core.fxh>
#include <packs\dx11.particles\nodes\modules\Core\fxh\IndexFunctions_Particles.fxh>
#include <packs\dx11.particles\nodes\modules\Core\fxh\IndexFunctions_DynBuffer.fxh>
/* Have a look at the packs\dx11.particles\nodes\modules\Core\ directory for more helper functions */

#ifndef CALC_FXH
#include <packs\happy.fxh\calc.fxh>
#endif

#ifndef SF3D
#define SF3D placeHolderS3
#endif


/* Like described in the template patch, the attribute(s) for the particlesystem is registered here*/ 
struct Particle {
	#if defined(COMPOSITESTRUCT)
  		COMPOSITESTRUCT
 	#else
		float3 position;
		float3 velocity;
	#endif
};

/* The ParticleBuffer and the UseSelectionIndex variable are mandatory*/
RWStructuredBuffer<Particle> ParticleBuffer : PARTICLEBUFFER;

float eps = 0.001;
float damping = 0.9;

struct csin
{
	uint3 DTID : SV_DispatchThreadID;
	uint3 GTID : SV_GroupThreadID;
	uint3 GID : SV_GroupID;
};

[numthreads(XTHREADS, YTHREADS, ZTHREADS)]
void CSReflect(csin input)
{
	uint particleIndex = GetParticleIndex( input.DTID.x );
	if (particleIndex == -1 ) return;
	float3 p = ParticleBuffer[particleIndex].position;
	float d = SF3D(p);
	
	if (d < .0) // particle has gone inside surface
	{
		float3 n = calcGradS3(SF3D, p, eps);
		n = normalize(n);
		
		ParticleBuffer[particleIndex].position -= 1.01 * d * n;	// move particle back outside
		ParticleBuffer[particleIndex].velocity = reflect(ParticleBuffer[particleIndex].velocity * damping, n); // bounce off of normal
	}
}

[numthreads(XTHREADS, YTHREADS, ZTHREADS)]
void CSReflect_Inside(csin input)
{
	uint particleIndex = GetParticleIndex( input.DTID.x );
	if (particleIndex == -1 ) return;
	float3 p = ParticleBuffer[particleIndex].position;
	float d = -SF3D(p);
	
	if (d < .0) // particle has gone inside surface
	{
		float3 n = -calcGradS3(SF3D, p, eps);
		n = normalize(n);
		
		ParticleBuffer[particleIndex].position -= 1.01 * d * n;	// move particle back outside
		ParticleBuffer[particleIndex].velocity = reflect(ParticleBuffer[particleIndex].velocity * damping, n); // bounce off of normal
	}
}


technique11 SDFReflect { pass P0{SetComputeShader( CompileShader( cs_5_0, CSReflect() ) );} }
technique11 SDFReflectInside { pass P0{SetComputeShader( CompileShader( cs_5_0, CSReflect_Inside() ) );} }