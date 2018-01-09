
////////////////////////////////////////////////////////////////////////////////////////////////
//
//		Fractal Qube 3D distance field ported from Fragmentarium 'BioCube' example by Darkbeam 
//
////////////////////////////////////////////////////////////////////////////////////////////////
// This token will be replaced with function name via RegExpr: "FN_"

// ensures the function is defined only once per instance
#ifndef FN_BODY 
#define FN_BODY

#ifndef SDF_FXH
#include <packs\happy.fxh\sdf.fxh>
#endif

// Parameters

float3 FN_Offset : FN_OFFSET  = float3(0, 1, 1); 
float3 FN_Offset2 : FN_OFFSET2 = float3(1,-0.3,-0.3);
float3 FN_Rot : FN_ROT;
float FN_Scale : FN_SCALE = 1.5; 
float FN_Qube : FN_QUBE = 0.1;
int FN_Iterations : FN_ITER= 12; 


float FN_(float3 p)
{
	return fFractalQube(p, FN_Scale, FN_Offset, FN_Offset2, FN_Rot, FN_Qube, FN_Iterations);
}
// end of the function body
#endif 

////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef SF3D
#define SF3D FN_
#endif
////////////////////////////////////////////////////////////////////////////////////////////////

technique11 RemoveMe{}

