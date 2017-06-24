
#define ASP 1/(R/max(R.x,R.y))

struct LineSegment
{
	float3 pos;
	float size;
	float prog;
	float id;
};

StructuredBuffer<LineSegment> Inbuf;
StructuredBuffer<uint> Address;

Texture2DArray texture2d <string uiname="Texture";>;

SamplerState g_samLinear <string uiname="Sampler State";>
{
    Filter = MIN_MAG_MIP_LINEAR;
    AddressU = Clamp;
    AddressV = Clamp;
};

 
cbuffer cbPerDraw : register( b0 )
{
	float4x4 tVP : VIEWPROJECTION;
	float2 R : TARGETSIZE;
};


cbuffer cbPerObj : register( b1 )
{
	float4x4 tW : WORLD;
	float Alpha <float uimin=0.0; float uimax=1.0;> = 1; 
	float4 cAmb <bool color=true;String uiname="Color";> = { 1.0f,1.0f,1.0f,1.0f };
	float4x4 tTex <string uiname="Texture Transform"; bool uvspace=true; >;
	float4x4 tColor <string uiname="Color Transform";>;
	float Width = 0.2;
	float Center = 0.5;
	float MaxExtend = 0.5;
};


struct GSIn
{
	float4 cpoint : POSITION;
	float p : PROGRESS;
	nointerpolation float id : BINID;
};

struct GsOut
{
	float4 cpoint : SV_Position;
	float3 norm : NORMAL;
    float4 TexCd: TEXCOORD0;
	nointerpolation float id : BINID;
};

GSIn Vs(uint vid : SV_VertexID)
{
    GSIn o = (GSIn)0;
	LineSegment ins = Inbuf[Address[vid]];
	
	float4 outpos = mul(float4(ins.pos, 1), mul(tW, tVP));
	o.cpoint.xyz = outpos.xyz / outpos.w;
	o.cpoint.w = ins.size / outpos.w;
	o.cpoint.xy /= ASP;
	o.p = ins.prog;
	o.id = ins.id;
	
    return o;
}

#define PI 3.14159265358979

float Angle(float2 a, float2 b)
{
	return atan2(b.y, b.x)-atan2(a.y, a.x);
}

[maxvertexcount(4)]
void Gs(lineadj GSIn input[4], inout TriangleStream<GsOut>GSOut)
{
	bool domitter = false;
	bool valid = false;
	bool pointvalid[4];
	[unroll]
	for(uint i=0; i<4; i++)
	{
		pointvalid[i] = (input[i].cpoint.x < 1) && (input[i].cpoint.x > -1);
		pointvalid[i] = pointvalid[i] && (input[i].cpoint.y < 1) && (input[i].cpoint.y > -1);
		pointvalid[i] = pointvalid[i] && (input[i].cpoint.z < 1) && (input[i].cpoint.z > 0);
	}
	[unroll]
	for(uint i=0; i<4; i++)
	{
		valid = valid || pointvalid[i];
	}
	domitter = pointvalid[1] && pointvalid[2];
	if(valid)
	{
		float2 InAdjLead = input[0].cpoint.xy;
		float2 InAdjTrail = input[3].cpoint.xy;
		float3 InLead = input[1].cpoint.xyw;
		float3 InTrail = input[2].cpoint.xyw;
		float depth = saturate((input[1].cpoint.z + input[2].cpoint.z) / 2);
	
		float2 aLL = normalize(InLead.xy - InAdjLead);
		float2 LT = normalize(InTrail.xy - InLead.xy);
		float2 TaT = normalize(InAdjTrail - InTrail.xy);
	
		float2 inv = float2(-1, 1);
	
		float2 aLL_LT = normalize(lerp(aLL.yx * inv, LT.yx * inv, 0.5));
		float2 LT_TaT = normalize(lerp(LT.yx * inv, TaT.yx * inv, 0.5));
	
		float LeadMul = min(abs(1/cos(Angle(aLL, aLL_LT) - PI/2)), MaxExtend * InLead.z);
		float TrailMul = min(abs(1/cos(Angle(LT, LT_TaT) - PI/2)), MaxExtend * InTrail.z);
	
		float2 vert[4];
		float invCenter = 1-Center;
	
		if(domitter)
		{
			vert[0] = InLead.xy + aLL_LT * Width * InLead.z * invCenter * LeadMul * -1;
			vert[1] = InLead.xy + aLL_LT * Width * InLead.z * Center * LeadMul;
			vert[2] = InTrail.xy + LT_TaT * Width * InTrail.z * invCenter * TrailMul * -1;
			vert[3] = InTrail.xy + LT_TaT * Width * InTrail.z * Center * TrailMul;
		}
		else
		{
			vert[0] = InLead.xy + aLL_LT * Width * InLead.z * invCenter * -1;
			vert[1] = InLead.xy + aLL_LT * Width * InLead.z * Center;
			vert[2] = InTrail.xy + LT_TaT * Width * InTrail.z * invCenter * -1;
			vert[3] = InTrail.xy + LT_TaT * Width * InTrail.z * Center;
		}
	
		float2 txcd[4] = {{0,1}, {0,0}, {1,1}, {1,0}};
		txcd[0].x = input[1].p;
		txcd[1].x = input[1].p;
		txcd[2].x = input[2].p;
		txcd[3].x = input[2].p;
	
		GsOut v = (GsOut)0;
		v.id = input[0].id;
		
		for(uint i=0; i<4; i++)
		{
			float idepth = (i < 2) ? input[1].cpoint.z : input[2].cpoint.z;
			v.cpoint = float4(vert[i], idepth, 1);
			v.cpoint.xy *= ASP;
			v.norm = float3(0,0,1);
			v.TexCd = mul(float4(txcd[i], 0, 1), tTex);
			GSOut.Append(v);
		}
	}
}



float4 PS(GsOut In): SV_Target
{
    float4 col = texture2d.SampleLevel(g_samLinear,float3(In.TexCd.xy, In.id),0) * cAmb;
	col = mul(col, tColor);
	col.a *= Alpha;
    return col;
}





technique10 Constant
{
	pass P0
	{
		SetVertexShader( CompileShader( vs_5_0, Vs() ) );
		SetGeometryShader( CompileShader( gs_5_0, Gs() ) );
		SetPixelShader( CompileShader( ps_5_0, PS() ) );
	}
}




