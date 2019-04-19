
////////////////////////////////////////////////////////////////////////////////////////////////
//
//		Polar Coordiantes from a 2D Vector Field Function
//
////////////////////////////////////////////////////////////////////////////////////////////////
// This token will be replaced with function name via RegExpr: "FN_"

// ensures the function is defined only once per instance
#ifndef FN_BODY 
#define FN_BODY

// Input VF2D Function placeholder
#ifndef FN_INPUT
#define FN_INPUT normalize
#endif


float2 FN_ (float2 p)
{
	float2 v = FN_INPUT(p);
	float2 result;
	float r;
	//r = length(v);
	r = v.x * v.x + v.y * v.y;
	
	if (r > 0)
	{
		r = sqrt(r);
		float angle = atan2(v.y, v.x);
    	angle = -(angle+1.57079633)/6.28319;
		result = float2(angle,r);		
	}
	else
	{
		result = 0;
	}
	return result;
	
}
// end of the function body
#endif 

////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef VF2D
#define VF2D FN_
#endif
////////////////////////////////////////////////////////////////////////////////////////////////



technique11 RemoveMe{}

