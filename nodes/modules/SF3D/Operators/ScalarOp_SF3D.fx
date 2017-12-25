
////////////////////////////////////////////////////////////////////////////////////////////////
//
//		3D Scalar Field Basic Ops Functions + - * /
//
////////////////////////////////////////////////////////////////////////////////////////////////
// This token will be replaced with function name via RegExpr: "FN_"

// ensures the function is defined only once per instance
#ifndef FN_BODY 
#define FN_BODY

// DEFINES // preprocessor options from patch inserted here
#ifndef FN_OP
#define FN_OP +
#endif

// Parameters
float FN_Default : FN_DEFAULT;
float FN_reverseOrder : FN_REVERSEORDER;

// Input function placeholder
#ifndef FN_INPUT1
#define FN_INPUT1 length
#endif

// Input 2 Defualt option
#ifndef FN_INPUT2
float FN_singleValue (float3 p)
{
	return FN_Default; // if a second input class is not provided defualt to semantic
}
#define FN_INPUT2 FN_singleValue
#endif

float FN_ (float3 p)
{
	#if(FN_REVERSE==1) 
	return FN_INPUT2(p) FN_OP FN_INPUT1(p);
	#else
	return FN_INPUT1(p) FN_OP FN_INPUT2(p); 
	#endif
}
// end of the function body
#endif 

////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef SF3D
#define SF3D FN_
#endif
////////////////////////////////////////////////////////////////////////////////////////////////



technique11 RemoveMe{}

