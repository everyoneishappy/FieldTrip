

////////////////////////////////////////////////////////////////////////////////////////////////
//
//		3D Vector Field with Scalar Field/Defualt Operand Basic Ops Functions + - * /
//
////////////////////////////////////////////////////////////////////////////////////////////////
// This token will be replaced with function name via RegExpr: "FN_"

// ensures the function is defined only once per instance
#ifndef FN_BODY 
#define FN_BODY


// DEFINES
#ifndef FN_OP
#define FN_OP FN_INPUT1(p) + FN_INPUT2(p); 
#endif

// Parameters
float FN_Default : FN_DEFAULT;
float FN_reverseOrder : FN_REVERSEORDER;

// Input VF3D function placeholder
#ifndef FN_INPUT1
#define FN_INPUT1 normalize
#endif

// Input 2 Defualt option
#ifndef FN_INPUT2
float FN_singleValue (float3 p)
{
	return FN_Default; // if a second input class is not provided defualt to semantic
}
#define FN_INPUT2 FN_singleValue
#endif

float3 FN_ (float3 p)
{
	return FN_OP; 
}
// end of the function body
#endif 

////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef VF3D
#define VF3D FN_
#endif
////////////////////////////////////////////////////////////////////////////////////////////////



technique11 RemoveMe{}

