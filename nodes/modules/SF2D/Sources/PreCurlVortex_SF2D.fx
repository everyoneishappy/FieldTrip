
////////////////////////////////////////////////////////////////////////////////////////////////
//
//		Pre Curl Vortex Function
//
////////////////////////////////////////////////////////////////////////////////////////////////
// This token will be replaced with function name via RegExpr: "FN_"

// ensures the function is defined only once per instance
#ifndef FN_BODY 
#define FN_BODY

#ifndef CALC_FXH
#include <packs\happy.fxh\calc.fxh>
#endif

// Parameters
StructuredBuffer<float2> FN_pointPosBuffer : FN_POINTPOSBUFFER;
StructuredBuffer<float> FN_radiusBuffer : FN_RADIUSBUFFER; 
StructuredBuffer<float> FN_strengthBuffer :  FN_STRENGTHBUFFER;
int FN_pointCount : FN_POINTCOUNT;

	

float FN_ (float2 p)
{
	float force = 0;
	
	for (uint i = 0; i < FN_pointCount; i++)
	{
		force += preCurlVortex(p, FN_pointPosBuffer[i], FN_strengthBuffer[i], FN_radiusBuffer[i]);
	}
	
	return force;  
}
// end of the function body
#endif 

////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef SF2D
#define SF2D FN_
#endif
////////////////////////////////////////////////////////////////////////////////////////////////



technique11 RemoveMe{}

