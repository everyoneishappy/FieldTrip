
#ifndef SDF_FXH
#include <packs\happy.fxh\sdf.fxh>
#endif

////////////////////////////////////////////////////////////////////////////////////////////////
//
//		3D Triangle Distance Function
//
////////////////////////////////////////////////////////////////////////////////////////////////
// This token will be replaced with function name via RegExpr: "FN_"




float dot2( in float3 v ) { return dot(v,v); }

//Unsigned
float fTriangle( float3 p, float3 a, float3 b, float3 c )
{
    float3 ba = b - a; float3 pa = p - a;
    float3 cb = c - b; float3 pb = p - b;
    float3 ac = a - c; float3 pc = p - c;
    float3 nor = cross( ba, ac );

    return sqrt(
    (sign(dot(cross(ba,nor),pa)) +
     sign(dot(cross(cb,nor),pb)) +
     sign(dot(cross(ac,nor),pc))<2.0)
     ?
     min( min(
     dot2(ba*clamp(dot(ba,pa)/dot2(ba),0.0,1.0)-pa),
     dot2(cb*clamp(dot(cb,pb)/dot2(cb),0.0,1.0)-pb) ),
     dot2(ac*clamp(dot(ac,pc)/dot2(ac),0.0,1.0)-pc) )
     :
     dot(nor,pa)*dot(nor,pa)/dot2(nor) );
}

#ifndef SF3D
// Paramaters
StructuredBuffer<float3> FN_a : FN_A;
StructuredBuffer<float3> FN_b : FN_B;
StructuredBuffer<float3> FN_c : FN_C;

int FN_count : FN_COUNT;

float FN_ (float3 p)
{
	float d = 999999;
	for(int i = 0; i< FN_count; i++)
	{
		d = min (d, fTriangle(p, FN_a[i], FN_b[i], FN_c[i]));
	}
	return d;
}


#define SF3D FN_
#endif
////////////////////////////////////////////////////////////////////////////////////////////////

technique11 RemoveMe{}

