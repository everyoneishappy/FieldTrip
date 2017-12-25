
////////////////////////////////////////////////////////////////////////////////////////////////
//
//		Point Force Field Function
//
////////////////////////////////////////////////////////////////////////////////////////////////
// This token will be replaced with function name via RegExpr: "FN_"

// ensures the function is defined only once per instance
#ifndef FN_BODY 
#define FN_BODY

// Parameters
StructuredBuffer<float3> FN_pointPosBuffer : FN_POINTPOSBUFFER;
StructuredBuffer<float3> FN_controlDirBuffer : FN_CONTROLDIRBUFFER; 
StructuredBuffer<float> FN_radiusBuffer : FN_RADIUSBUFFER; 
StructuredBuffer<float> FN_strengthBuffer :  FN_STRENGTHBUFFER;
int FN_pointCount : FN_POINTCOUNT;



float FN_distFallOff(float dist, float radius)
{
	return smoothstep(0.2, 0.8, saturate((radius-dist)/radius));
}



// buffered version.  Returned vector is control vector in TBN frame
float3 FN_pointForceField(float3 p, StructuredBuffer<float3> pointPosBuffer, StructuredBuffer<float3> controlDirBuffer, StructuredBuffer<float> radiusBuffer, StructuredBuffer<float> strengthBuffer, uint pointCount)
{
	float3 force = 0;
	for (uint i = 0; i < pointCount; i++)
	{
		float3 gradient = p-pointPosBuffer[i];
		float dist = length(gradient);
		float ramp = FN_distFallOff(dist, radiusBuffer[i]);
		float3 normal = normalize(gradient);
		float3 tangent = float3(normal.x, -normal.z, normal.y); //rotate 90 degrees
		float3 biTangent = cross (tangent, -normal);
		float3x3 TBN = float3x3(tangent, biTangent, normal);
		force +=  normalize(mul(controlDirBuffer[i], TBN)) * strengthBuffer[i] * ramp;
	}
	return force; 
}


float3 FN_ (float3 p)
{
	return FN_pointForceField(p, FN_pointPosBuffer, FN_controlDirBuffer, FN_radiusBuffer, FN_strengthBuffer, (uint)FN_pointCount);
}
// end of the function body
#endif 

////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef VF3D
#define VF3D FN_
#endif
////////////////////////////////////////////////////////////////////////////////////////////////



technique11 RemoveMe{}

