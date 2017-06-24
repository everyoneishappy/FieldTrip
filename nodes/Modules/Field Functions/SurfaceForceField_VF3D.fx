#ifndef CALC_FXH
#include <packs\happy.fxh\calc.fxh>
#endif


////////////////////////////////////////////////////////////////////////////////////////////////
//
//		SDF Surface Force Field Function
//
////////////////////////////////////////////////////////////////////////////////////////////////
// This token will be replaced with function name via RegExpr: "FN_"
#ifndef VF3D

// Input Function placeholder
#ifndef FN_INPUT
#define FN_INPUT placeHolderS3
#endif


// Paramaters
float3 FN_controlDir : FN_CONTROLDIR = float3(1,0,0);
float FN_radius : FN_RADIUS = 0.2;
float FN_strength : FN_STRENGTH= 1;
float FN_surfaceMode : FN_SURFACEMODE= 0;





float3 FN_ (float3 p)
{
	float3 gradient = calcGradS3(FN_INPUT, p, 0.001);
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
	float3 normal = -normalize(gradient);
	float3 tangent = float3(normal.x, -normal.z, normal.y); //rotate 90 degrees
	float3 biTangent = cross (tangent, -normal);
	float3x3 TBN = float3x3(tangent, biTangent, normal);
	float3 force = normalize(mul(FN_controlDir, TBN));
	force *= FN_strength * ramp;
	
	//push outside or inside sureface if needed
	if (FN_surfaceMode == 1 && dist < 0 || FN_surfaceMode == 2 && dist < 0) force = abs(dist) *  normalize(gradient); 
	return force;
}

#define VF3D FN_
#endif
////////////////////////////////////////////////////////////////////////////////////////////////



technique11 RemoveMe{}

