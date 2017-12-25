
////////////////////////////////////////////////////////////////////////////////////////////////
//
//		2D Vector Field Dot Product Function
//
////////////////////////////////////////////////////////////////////////////////////////////////
// This token will be replaced with function name via RegExpr: "FN_"

// ensures the function is defined only once per instance
#ifndef FN_BODY 
#define FN_BODY

// Parameters
float2 FN_Default : FN_DEFAULT;

// Input VF3D function placeholder
#ifndef FN_INPUT1
#define FN_INPUT1 normalize
#endif

// Input 2 Defualt option
#ifndef FN_INPUT2
float2 FN_singleVector (float2 p)
{
	return FN_Default; // if a second input class is not provided defualt to semantic
}
#define FN_INPUT2 FN_singleVector
#endif

float FN_ (float2 p)
{
	return dot(FN_INPUT1(p), FN_INPUT2(p)); //
}
// end of the function body
#endif 

////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef SF2D
#define SF2D FN_
#endif
////////////////////////////////////////////////////////////////////////////////////////////////



technique11 RemoveMe{}

