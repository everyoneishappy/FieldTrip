


////////////////////////////////////////////////////////////////////////////////////////////////
//
//		2D SDF Surface Force Field Function
//
////////////////////////////////////////////////////////////////////////////////////////////////
// This token will be replaced with function name via RegExpr: "FN_"

// ensures the function is defined only once per instance
#ifndef FN_BODY 
#define FN_BODY

// Input SF2D Function placeholder
#ifndef FN_INPUT
#define FN_INPUT length
#endif

#ifndef CALC_FXH
#include <packs\happy.fxh\calc.fxh>
#endif



// Parameters
float FN_controlDir : FN_CONTROLDIR;
float FN_radius : FN_RADIUS = 0.2;
float FN_strength : FN_STRENGTH= 1;
float FN_surfaceMode : FN_SURFACEMODE= 0;

float2 FN_ (float2 p)
{
	float2 gradient = calcGradS2(FN_INPUT, p, 0.001);
	float dist = FN_INPUT(p);
	if (FN_surfaceMode==0) // mirror signs if 'Symmetrical' mode
	{
		if (dist < 0) gradient = -gradient;
		dist = abs(dist);
	}
	if (FN_surfaceMode==2) //  flip signs if 'Inside' mode
	{
		gradient = -gradient;
		dist = -dist;
	}
	
	float ramp = smoothstep(0.2, 0.8, saturate((FN_radius-dist)/FN_radius));
	float2 normal = normalize(gradient);
	normal = cos(FN_controlDir) * normal + sin(FN_controlDir)*float2(normal.y, -normal.x);
	//pR(normal, FN_controlDir.x);
	float2 force = normal * FN_strength * ramp;
	
	//push outside or inside sureface if needed
	if (FN_surfaceMode == 1 && dist < 0 || FN_surfaceMode == 2 && dist < 0) force = abs(dist) *  normalize(gradient); 
	return force;
}
// end of the function body
#endif 

////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef VF2D
#define VF2D FN_
#endif
////////////////////////////////////////////////////////////////////////////////////////////////



technique11 RemoveMe{}

