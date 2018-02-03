
////////////////////////////////////////////////////////////////////////////////////////////////
//
//		2D SDF Outline Function
//
////////////////////////////////////////////////////////////////////////////////////////////////
// This token will be replaced with function name via RegExpr: "FN_"

// ensures the function is defined only once per instance
#ifndef FN_BODY 
#define FN_BODY

//////////////////////////////////////////////////////////////////////////////////////////////////
// From "Texturing and Modeling. A Procedural Approach" Chapter 6 by STEVEN WORLEY
//////////////////////////////////////////////////////////////////////////////////////////////////

// returns height bevel from a distance function
float ridgeBump(float dist, float depth = 1.0, float bevelWidth = 0.1, float2 bevelControl = 0.0)
{
	float mu = saturate(dist / bevelWidth); 
	float mu2 = mu * mu;
	float mu3 = mu2 * mu;
	
	float p1 = 2 * mu3 - 3 * mu2 + 1;
	float r1 = mu3 - 2 * mu2 + mu;
	float r4 = mu3 - mu2;
	float height =  p1 + bevelControl.x * r1 + bevelControl.y * r4;

	return height * depth;
}


#ifndef SDF_FXH
#include <packs\happy.fxh\sdf.fxh>
#endif

// Parameters
float4 FN_dwb : FN_DWB; // depth, width, bevel controls XY

// Input SF2D function placeholder
#ifndef FN_INPUT
#define FN_INPUT length
#endif


float FN_ (float2 p)
{
	float d = FN_INPUT(p);
	return ridgeBump(d, FN_dwb.x, FN_dwb.y, FN_dwb.zw); //
}
// end of the function body
#endif 

////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef SF2D
#define SF2D FN_
#endif
////////////////////////////////////////////////////////////////////////////////////////////////



technique11 RemoveMe{}

