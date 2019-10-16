
////////////////////////////////////////////////////////////////////////////////////////////////
//
//		2D Point Force Field Function
//
////////////////////////////////////////////////////////////////////////////////////////////////
// This token will be replaced with function name via RegExpr: "FN_"

// ensures the function is defined only once per instance
#ifndef FN_BODY 
#define FN_BODY

// Parameters
StructuredBuffer<float2> FN_pointPosBuffer : FN_POINTPOSBUFFER;
StructuredBuffer<float> FN_controlDirBuffer : FN_CONTROLDIRBUFFER; 
StructuredBuffer<float> FN_radiusBuffer : FN_RADIUSBUFFER; 
StructuredBuffer<float> FN_strengthBuffer :  FN_STRENGTHBUFFER;
int FN_pointCount : FN_POINTCOUNT;



float FN_distFallOff(float dist, float radius)
{
	return smoothstep(0.2, 0.8, saturate((radius-dist)/radius));
}



// buffered version.  
float2 FN_pointForceField(float2 p, StructuredBuffer<float2> pointPosBuffer, StructuredBuffer<float> controlDirBuffer, StructuredBuffer<float> radiusBuffer, StructuredBuffer<float> strengthBuffer, uint pointCount)
{
	float2 force = 0;
	for (uint i = 0; i < FN_pointCount; i++)
	{
		float2 gradient = p-pointPosBuffer[i];
		float dist = length(gradient);
		float ramp = FN_distFallOff(dist, radiusBuffer[i]);
		float rot = FN_controlDirBuffer[i];
		float2 dir = normalize(gradient);

		// rotate the vectors
		float sinA = sin(rot);
		float cosA = cos(rot);
		dir = float2( (dir.x * cosA) + (dir.y * (-sinA)), (dir.x * sinA) + (dir.y * cosA) );
		
		force +=  dir * strengthBuffer[i] * ramp;
	}
	return force; 
}


float2 FN_ (float2 p)
{
	return FN_pointForceField(p, FN_pointPosBuffer, FN_controlDirBuffer, FN_radiusBuffer, FN_strengthBuffer, (uint)FN_pointCount);
}
// end of the function body
#endif 

////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef VF2D
#define VF2D FN_
#endif
////////////////////////////////////////////////////////////////////////////////////////////////



technique11 RemoveMe{}

