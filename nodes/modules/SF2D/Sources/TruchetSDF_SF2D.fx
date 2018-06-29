
////////////////////////////////////////////////////////////////////////////////////////////////
//
//		2D Truchet Tile Distance Function
//
////////////////////////////////////////////////////////////////////////////////////////////////
// This token will be replaced with function name via RegExpr: "FN_"

// ensures the function is defined only once per instance
#ifndef FN_BODY 
#define FN_BODY

#ifndef SDF_FXH
#include <packs\happy.fxh\sdf.fxh>
#endif

// DEFINES
#ifndef LATTICEFUNC
#define LATTICEFUNC fLineTruchet
#endif

#ifndef FN_INPUT	
#define FN_INPUT length
#endif

// parameters
float FN_freq : FN_FREQ = 2; 
float FN_width : FN_WIDTH = .1; 
float2 FN_offset : FN_OFFSET;



float FN_Custom (float2 p, float width)
{
	float rnd = frac(sin(dot(floor(p), float2(21.98, 19.37))) * 4231.73);
	float flip = frac(rnd * 13.8273) > 0.5 ? 1 : -1;
	rnd = floor(rnd * 2)  * flip / 2;
	float phi = PI * rnd;
	float2 pf = frac(p) -.5;
	p.x = (pf.x * cos(phi)) + (pf.y * (-sin(phi)));
	p.y = (pf.x * sin(phi)) + (pf.y * cos(phi));
	return FN_INPUT(p) - width * .5 ;

}


float FN_ (float2 p)
{
	return LATTICEFUNC(p * FN_freq + FN_offset, FN_width) / FN_freq;
}
// end of the function body




#endif 

////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef SF2D
#define SF2D FN_
#endif
////////////////////////////////////////////////////////////////////////////////////////////////

technique11 RemoveMe{}

