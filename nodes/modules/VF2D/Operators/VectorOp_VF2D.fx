////////////////////////////////////////////////////////////////////////////////////////////////
//
//		2D Vector Field Basic Ops Functions + - * /
//
////////////////////////////////////////////////////////////////////////////////////////////////
// This token will be replaced with function name via RegExpr: "FN_"

// ensures the function is defined only once per instance
#ifndef FN_BODY 
#define FN_BODY

// DEFINES // preprocessor options from patch inserted here
#ifndef FN_OP
#define FN_OP FN_INPUT1(p) + FN_INPUT2(p); 
#endif

// Parameters
float2 FN_Default : FN_DEFAULT;

// Input function placeholder
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

float2 FN_ (float2 p)
{
	return FN_OP; 
}
// end of the function body
#endif 

////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef VF2D
#define VF2D FN_
#endif
////////////////////////////////////////////////////////////////////////////////////////////////



technique11 RemoveMe{}

