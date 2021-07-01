
////////////////////////////////////////////////////////////////////////////////////////////////
//
//		Revolve a 2D signed distance field in to a third dimension
//
////////////////////////////////////////////////////////////////////////////////////////////////
// This token will be replaced with function name via RegExpr: "FN_"


#ifndef SDF_FXH
#include <packs\happy.fxh\sdf.fxh>
#endif

// ensures the function is defined only once per instance
#ifndef FN_BODY 
#define FN_BODY


// DEFINES // preprocessor options from patch inserted here


float FN_Width : FN_WIDTH;

// Input SF2D function placeholder
#ifndef FN_INPUT
#define FN_INPUT length
#endif

float FN_ (float3 p)
{
	return FN_INPUT(pRevolution(p, FN_Width));
}
// end of the function body
#endif 

////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef SF3D
#define SF3D FN_
#endif
////////////////////////////////////////////////////////////////////////////////////////////////



technique11 RemoveMe{}

