
////////////////////////////////////////////////////////////////////////////////////////////////
//
//		Morph between two 2D Scalar Field functions by a third function (or defualt value)
//
////////////////////////////////////////////////////////////////////////////////////////////////
// This token will be replaced with function name via RegExpr: "FN_"

// ensures the function is defined only once per instance
#ifndef FN_BODY 
#define FN_BODY

// Parameters
float FN_Default : FN_DEFAULT = 0.5;

// Input function placeholder
#ifndef FN_INPUT1
#define FN_INPUT1 length
#endif

// Input function placeholder
#ifndef FN_INPUT2
#define FN_INPUT2 length
#endif

// morph defualt
#ifndef FN_BLEND
float FN_DefualtBlend (float2 p)
{
	return FN_Default; // if a blend field class is not provided defualt to value semantic
}
#define FN_BLEND FN_DefualtBlend
#endif


float FN_ (float2 p)
{
	return lerp(FN_INPUT1(p), FN_INPUT2(p), saturate(FN_BLEND(p))); //
}
// end of the function body
#endif 

////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef SF2D
#define SF2D FN_
#endif
////////////////////////////////////////////////////////////////////////////////////////////////



technique11 RemoveMe{}

