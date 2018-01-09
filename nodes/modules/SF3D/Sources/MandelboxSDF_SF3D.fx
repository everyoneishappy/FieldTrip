
////////////////////////////////////////////////////////////////////////////////////////////////
//
//		Mandelbox Fractal Distance Field
//
////////////////////////////////////////////////////////////////////////////////////////////////
// This token will be replaced with function name via RegExpr: "FN_"

// ensures the function is defined only once per instance
#ifndef FN_BODY 
#define FN_BODY

///////////////////////////////////////////////////////////////////////////////////////
// Mandelbox Distance Estimator (Rrrola's version).
///////////////////////////////////////////////////////////////////////////////////////
#ifndef TRANSFORM_FXH
#include <packs\happy.fxh\transform.fxh>
#endif
float FN_fMandelbox(float3 pos, float MinRad2, float Scale, float3 Trans, float3 Julia, float3 PYR, int Iterations = 16) 
{
	float4 p = float4(pos,1); 
	float4 p0 = float4(Julia,1);  // p.w is the distance estimate
	float4 scale = float4(Scale, Scale, Scale, abs(Scale)) / MinRad2;
	float absScalem1 = abs(Scale - 1.0);
	float AbsScaleRaisedTo1mIters = pow(abs(Scale), float(1-Iterations));
	float3x3 rot = rot3x3(PYR);
	
	for (int i=0; i<Iterations; i++) {
		p.xyz = mul(p.xyz, rot);
		p.xyz=abs(p.xyz)+Trans;
		float r2 = dot(p.xyz, p.xyz);
		p *= clamp(max(MinRad2/r2, MinRad2), 0.0, 1.0);  // dp3,div,max.sat,mul
		p = p*scale + p0;
	
	}
	return ((length(p.xyz) - absScalem1) / p.w - AbsScaleRaisedTo1mIters);
}
///////////////////////////////////////////////////////////////////////////////////////





#ifndef SDF_FXH
#include <packs\happy.fxh\sdf.fxh>
#endif

// Parameters
float FN_MinRad2 : FN_MINRAD2;
float FN_Scale : FN_SCALE;
float3 FN_Trans : FN_TRANS; 
float3 FN_Julia : FN_JULIA; 
float3 FN_PYR : FN_ROT;
int FN_iter : FN_ITER;


float FN_(float3 p)
{
	return FN_fMandelbox(p, FN_MinRad2, FN_Scale, FN_Trans, FN_Julia, FN_PYR, FN_iter);
}
// end of the function body
#endif 

////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef SF3D
#define SF3D FN_
#endif
////////////////////////////////////////////////////////////////////////////////////////////////

technique11 RemoveMe{}

