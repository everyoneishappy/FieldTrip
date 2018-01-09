
////////////////////////////////////////////////////////////////////////////////////////////////
//
//		Fold and cut regular polyhedra Distance Estimator (knighty 2012)
//
////////////////////////////////////////////////////////////////////////////////////////////////
// This token will be replaced with function name via RegExpr: "FN_"

// ensures the function is defined only once per instance
#ifndef FN_BODY 
#define FN_BODY

#ifndef PI
#define PI 3.1415926535897932
#endif


// DEFINES

// Parameters
int FN_Type : FN_TYPE = 5;// Symmetry group type (3-5).
int FN_Iter : FN_ITER = 1;
float3 FN_uvw : FN_UVW = float3(1.0,0,0);// U 'barycentric' coordinate for the 'principal' node
float FN_VRadius : FN_VRADIUS = 0.05; //vertex radius 
float FN_SRadius : FN_SRADIUS = 0.01; //segments radius 
float FN_Scale : FN_SCALE = 1.1;


float FN_ (float3 pos)
{
	pos*=FN_Scale;
	
	float cospin=cos(PI/float(FN_Type)), scospin=sqrt(0.75-cospin*cospin);
	float3 nc = float3(-0.5,-cospin,scospin);
	float3 pab = float3(0.,0.,1.);
	float3 pbc = normalize(float3(scospin,0.,0.5));
	float3 pca = normalize(float3(0.,scospin,cospin));
	float3 p = normalize((FN_uvw.x * pab + FN_uvw.y * pbc + FN_uvw.z * pca));
	float d = 99999;
	
	for (int i = 0; i < FN_Iter; i++) 
	{
		//pos=fold(pos);
		for(int j=0;j<FN_Type;j++)
		{
			pos.xyz=abs(pos.xyz);
			float t=-2.*min(0.,dot(pos,nc));
			pos+=t*nc;
		}
		
		#if FN_VERT == 1
		{
			float vertex = length(pos-p)-FN_VRadius;
			d=min(d, vertex * pow(FN_Scale, float(-i)));
		}
		#endif
		
		#if FN_FACE == 1
		{
			float d0=dot(pos,pab)-dot(pab,p);
			float d1=dot(pos,pbc)-dot(pbc,p);
			float d2=dot(pos,pca)-dot(pca,p);
			float face = max(max(d0,d1),d2);
			
			d=min(d, face * pow(FN_Scale, float(-i)));
		}
		#endif
		
		#if FN_EDGE == 1
		{
			pos-=p;
			//pos += 0.0025*cnoise(150.0*pos);
			float dla=length(pos-min(0.,pos.x)*float3(1.,0.,0.));
			float dlb=length(pos-min(0.,pos.y)*float3(0.,1.,0.));
			float dlc=length(pos-min(0.,dot(pos,nc))*nc);
			float segment = min(min(dla,dlb),dlc)-FN_SRadius;//max(max(dla,dlb),max(dlc,dlp))-SRadius;
			
			d=min(d, segment * pow(FN_Scale, float(-i)));
		}
		#endif
	}
	return d / FN_Scale;
}
// end of the function body
#endif 

////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef SF3D
#define SF3D FN_
#endif
////////////////////////////////////////////////////////////////////////////////////////////////

technique11 RemoveMe{}

