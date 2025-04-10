// Made with Amplify Shader Editor v1.9.1.5
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Underwater"
{
	Properties
	{
		_FogMin("FogMin", Float) = 0
		_FogMax("FogMax", Float) = 500
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGINCLUDE
		#include "UnityCG.cginc"
		#include "UnityShaderVariables.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 2.0
		struct Input
		{
			half3 worldNormal;
			float3 viewDir;
			float customSurfaceDepth74;
		};

		uniform half4 _underWaterColor2;
		uniform half4 _underWaterColor;
		uniform half _FogMin;
		uniform half _FogMax;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_vertex3Pos = v.vertex.xyz;
			half3 customSurfaceDepth74 = ase_vertex3Pos;
			o.customSurfaceDepth74 = -UnityObjectToViewPos( customSurfaceDepth74 ).z;
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			half3 gammaToLinear7 = GammaToLinearSpace( _underWaterColor2.rgb );
			half3 gammaToLinear4 = GammaToLinearSpace( _underWaterColor.rgb );
			half3 ase_worldNormal = i.worldNormal;
			half dotResult9 = dot( ase_worldNormal , i.viewDir );
			half3 lerpResult8 = lerp( gammaToLinear7 , gammaToLinear4 , saturate( pow( ( 1.0 - dotResult9 ) , 2.42 ) ));
			half cameraDepthFade74 = (( i.customSurfaceDepth74 -_ProjectionParams.y - 0.0 ) / 1.0);
			half temp_output_1_0_g1 = _FogMin;
			half clampResult102 = clamp( ( ( cameraDepthFade74 - temp_output_1_0_g1 ) / ( _FogMax - temp_output_1_0_g1 ) ) , 0.0 , 1.0 );
			half3 lerpResult89 = lerp( lerpResult8 , float3( 0,0,0 ) , clampResult102);
			o.Albedo = lerpResult89;
			half4 lerpResult101 = lerp( float4( 0,0,0,0 ) , unity_FogColor , clampResult102);
			o.Emission = lerpResult101.rgb;
			o.Alpha = 1;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Lambert keepalpha fullforwardshadows noshadow nofog vertex:vertexDataFunc 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 2.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float1 customPack1 : TEXCOORD1;
				float3 worldPos : TEXCOORD2;
				float3 worldNormal : TEXCOORD3;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				vertexDataFunc( v, customInputData );
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				o.worldNormal = worldNormal;
				o.customPack1.x = customInputData.customSurfaceDepth74;
				o.worldPos = worldPos;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.customSurfaceDepth74 = IN.customPack1.x;
				float3 worldPos = IN.worldPos;
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.viewDir = worldViewDir;
				surfIN.worldNormal = IN.worldNormal;
				SurfaceOutput o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutput, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=19105
Node;AmplifyShaderEditor.GammaToLinearNode;4;-335.2,82.59995;Inherit;False;0;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GammaToLinearNode;7;-397.1922,232.9691;Inherit;False;0;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WorldNormalVector;10;-624.6921,427.9692;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;11;-624.6932,586.5691;Inherit;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ColorNode;2;-556,29;Inherit;False;Global;_underWaterColor;_underWaterColor;5;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,0.246428,0.3764706,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DotProductOpNode;9;-413.9637,430.2991;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;6;-594.7917,239.4691;Inherit;False;Global;_underWaterColor2;_underWaterColor2;5;0;Create;True;0;0;0;False;0;False;0,0,0,0;0.0540566,0.0894352,0.2830189,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;89;1152.045,283.0399;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;92;1522.315,272.7314;Half;False;True;-1;0;ASEMaterialInspector;0;0;Lambert;Underwater;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;;0;False;;False;0;False;;0;False;;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;12;all;True;True;True;True;0;False;;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;2;15;10;25;False;0.5;False;0;0;False;;0;False;;0;0;False;;0;False;;0;False;;0;False;;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;;-1;0;False;;0;0;0;False;0.1;False;;0;False;;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.CustomExpressionNode;47;-42.60794,679.5776;Inherit;False;half4 fogCoord  = ApplyFog(col,worldPos)@$$return col@;3;Create;1;True;worldPos;FLOAT3;0,0,0;In;;Inherit;False;My Custom Expression;True;False;0;;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;98;572.3004,801.773;Inherit;False;Inverse Lerp;-1;;1;09cbe79402f023141a4dc1fddd4c9511;0;3;1;FLOAT;20;False;2;FLOAT;300;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;99;389.7928,763.6179;Inherit;False;Property;_FogMin;FogMin;0;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;100;343.7928,872.6188;Inherit;False;Property;_FogMax;FogMax;1;0;Create;True;0;0;0;False;0;False;500;500;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;58;154.7898,1013.235;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CameraDepthFade;74;358.0299,1013.491;Inherit;False;3;2;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FogAndAmbientColorsNode;79;662.2915,571.3198;Inherit;False;unity_FogColor;0;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;101;1137.743,534.9424;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ClampOpNode;102;862.104,873.4625;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;17;91.72118,431.7272;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;16;-320.378,431.7269;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;18;-138.0054,411.6379;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;2.42;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;8;259.0817,185.6456;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;1;182.2352,-76.22527;Inherit;False;Constant;_Color0;Color 0;0;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
WireConnection;4;0;2;0
WireConnection;7;0;6;0
WireConnection;9;0;10;0
WireConnection;9;1;11;0
WireConnection;89;0;8;0
WireConnection;89;2;102;0
WireConnection;92;0;89;0
WireConnection;92;2;101;0
WireConnection;98;1;99;0
WireConnection;98;2;100;0
WireConnection;98;3;74;0
WireConnection;74;2;58;0
WireConnection;101;1;79;0
WireConnection;101;2;102;0
WireConnection;102;0;98;0
WireConnection;17;0;18;0
WireConnection;16;0;9;0
WireConnection;18;0;16;0
WireConnection;8;0;7;0
WireConnection;8;1;4;0
WireConnection;8;2;17;0
ASEEND*/
//CHKSM=2BD52D4C8D37498472D67DD6399780D7A4305E48