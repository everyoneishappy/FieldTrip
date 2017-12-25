
////////////////////////////////////////////////////////////////////////////////////////////////
//
//		Laplacian Scalar from a 3D Scalar Field Function
//
////////////////////////////////////////////////////////////////////////////////////////////////
// This token will be replaced with function name via RegExpr: "FN_"

// ensures the function is defined only once per instance
#ifndef FN_BODY 
#define FN_BODY

#ifndef CALC_FXH
#include <packs\happy.fxh\calc.fxh>
#endif


// Input SF3D Function placeholder
#ifndef FN_INPUT
#define FN_INPUT length
#endif

// Parameters
float FN_eps : FN_EPS = 0.01;

float FN_ (float3 p)
{
	return calcLapS3(FN_INPUT, p, FN_eps);
	
}
// end of the function body
#endif 

/////////////////////////////////////////////////////////////////////////////
#ifndef SF3D
#define SF3D FN_
#endif
////////////////////////////////////////////////////////////////////////////////////////////////



technique11 RemoveMe{}

