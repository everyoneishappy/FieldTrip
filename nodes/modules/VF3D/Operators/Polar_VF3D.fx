
////////////////////////////////////////////////////////////////////////////////////////////////
//
//		Polar Coordiantes from a 3D Vector Field Function
//
////////////////////////////////////////////////////////////////////////////////////////////////
// This token will be replaced with function name via RegExpr: "FN_"

// ensures the function is defined only once per instance
#ifndef FN_BODY 
#define FN_BODY

// Input VF3D Function placeholder
#ifndef FN_INPUT
#define FN_INPUT normalize
#endif


float3 FN_ (float3 p)
{
	float3 v = FN_INPUT(p);
	float3 result;
	float r;
	//r = length(v);
	r = v.x * v.x + v.y * v.y + v.z * v.z;
	
	if (r > 0)
	{
		r = sqrt(r);
		float p, y;
		p = asin(v.y/r) / 6.28318531;
		y = 0;
		if (v.z != 0) y = atan2(-v.x, -v.z);
		else if (v.x > 0) y = -3.14159265 / 2;
        else y = 3.14159265 / 2;
		y /=  6.28318531;
		result = float3(p,y,r);		
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
#ifndef VF3D
#define VF3D FN_
#endif
////////////////////////////////////////////////////////////////////////////////////////////////



technique11 RemoveMe{}

