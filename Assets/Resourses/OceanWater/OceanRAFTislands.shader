// Made with Amplify Shader Editor v1.9.1.5
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "CustomPR/OceanRAFTislands"
{
	Properties
	{
		_Size("Size", Range( 0 , 10)) = 1
		_SpecColor("Specular Color",Color)=(1,1,1,1)
		_Gloss("Gloss", Range( 0 , 10)) = 0
		_Specular("Specular", Range( 0 , 1)) = 0
		_BumpMap("BumpMap", 2D) = "bump" {}
		_wawe1Dir("wawe1Dir", Range( 0 , 1)) = 1
		_wawe2Dir("wawe2Dir", Range( 0 , 1)) = 1
		_wawe3Dir("wawe3Dir", Range( 0 , 1)) = 1
		_wave1Size("wave1Size", Range( 0.1 , 10)) = 0
		_wave2Size("wave2Size", Range( 0.1 , 10)) = 0
		_wave3Size("wave3Size", Range( 0.1 , 10)) = 0
		_FresnelPower("FresnelPower", Range( 1 , 16)) = 0
		_HorizonBend("HorizonBend", Range( 0 , 1)) = 0.2
		_AmbientColor("AmbientColor", Color) = (0.2509804,0.5137255,0.9333333,1)
		_HorizonColor("HorizonColor", Color) = (0.6862745,0.8117647,1,0.5019608)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#include "UnityStandardUtils.cginc"
		#pragma target 2.0
		#pragma surface surf BlinnPhong alpha:fade keepalpha noshadow noforwardadd 
		struct Input
		{
			float2 uv_texcoord;
			half3 viewDir;
			INTERNAL_DATA
			half3 worldNormal;
			float3 worldPos;
		};

		uniform sampler2D _BumpMap;
		uniform float4 _BumpMap_ST;
		uniform half _wave1Size;
		uniform float _Size;
		uniform half _wawe1Dir;
		uniform half _wawe2Dir;
		uniform half _wawe3Dir;
		uniform half _wave2Size;
		uniform half _wave3Size;
		uniform half _HorizonBend;
		uniform half4 _AmbientColor;
		uniform half4 _HorizonColor;
		uniform half _FresnelPower;
		uniform half _Specular;
		uniform half _Gloss;

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 uv_BumpMap = i.uv_texcoord * _BumpMap_ST.xy + _BumpMap_ST.zw;
			half2 Wave1UV225 = ( uv_BumpMap * _wave1Size );
			half2 temp_output_4_0_g18 = (( Wave1UV225 / _Size )).xy;
			half3 appendResult257 = (half3(_wawe1Dir , _wawe2Dir , _wawe3Dir));
			half3 temp_output_258_0 = ( appendResult257 * 6.28318548202515 );
			half3 break262 = sin( temp_output_258_0 );
			half3 break263 = cos( temp_output_258_0 );
			half2 appendResult264 = (half2(break262.x , break263.x));
			half2 Wave1Dir217 = appendResult264;
			half2 temp_output_17_0_g18 = float2( 1,1 );
			half mulTime22_g18 = _Time.y * 0.2;
			half temp_output_27_0_g18 = frac( mulTime22_g18 );
			half2 temp_output_11_0_g18 = ( temp_output_4_0_g18 + ( -(Wave1Dir217*2.0 + -1.0) * temp_output_17_0_g18 * temp_output_27_0_g18 ) );
			half temp_output_55_0_g18 = 1.0;
			half2 temp_output_12_0_g18 = ( temp_output_4_0_g18 + ( -(Wave1Dir217*2.0 + -1.0) * temp_output_17_0_g18 * frac( ( mulTime22_g18 + 0.5 ) ) ) );
			half3 lerpResult9_g18 = lerp( UnpackScaleNormal( tex2D( _BumpMap, temp_output_11_0_g18 ), temp_output_55_0_g18 ) , UnpackScaleNormal( tex2D( _BumpMap, temp_output_12_0_g18 ), temp_output_55_0_g18 ) , ( abs( ( temp_output_27_0_g18 - 0.5 ) ) / 0.5 ));
			half3 temp_output_3_0_g19 = ( lerpResult9_g18 + half3(0,0,1) );
			half2 Wave2UV224 = ( uv_BumpMap * _wave2Size );
			half2 temp_output_4_0_g17 = (( Wave2UV224 / _Size )).xy;
			half2 appendResult265 = (half2(break262.y , break263.y));
			half2 Wave2Dir218 = appendResult265;
			half2 temp_output_17_0_g17 = float2( 1,1 );
			half mulTime22_g17 = _Time.y * 0.2;
			half temp_output_27_0_g17 = frac( mulTime22_g17 );
			half2 temp_output_11_0_g17 = ( temp_output_4_0_g17 + ( -(Wave2Dir218*2.0 + -1.0) * temp_output_17_0_g17 * temp_output_27_0_g17 ) );
			half temp_output_55_0_g17 = 1.0;
			half2 temp_output_12_0_g17 = ( temp_output_4_0_g17 + ( -(Wave2Dir218*2.0 + -1.0) * temp_output_17_0_g17 * frac( ( mulTime22_g17 + 0.5 ) ) ) );
			half3 lerpResult9_g17 = lerp( UnpackScaleNormal( tex2D( _BumpMap, temp_output_11_0_g17 ), temp_output_55_0_g17 ) , UnpackScaleNormal( tex2D( _BumpMap, temp_output_12_0_g17 ), temp_output_55_0_g17 ) , ( abs( ( temp_output_27_0_g17 - 0.5 ) ) / 0.5 ));
			half3 temp_output_5_0_g19 = ( lerpResult9_g17 * half3(-1,-1,1) );
			half dotResult8_g19 = dot( temp_output_3_0_g19 , temp_output_5_0_g19 );
			half3 normalizeResult13_g19 = normalize( ( ( ( dotResult8_g19 * temp_output_3_0_g19 ) / temp_output_3_0_g19.z ) - temp_output_5_0_g19 ) );
			half3 temp_output_3_0_g20 = ( normalizeResult13_g19 + half3(0,0,1) );
			half2 Wave3UV223 = ( uv_BumpMap * _wave3Size );
			half2 temp_output_4_0_g16 = (( Wave3UV223 / _Size )).xy;
			half2 appendResult266 = (half2(break262.z , break263.z));
			half2 Wave3Dir219 = appendResult266;
			half2 temp_output_17_0_g16 = float2( 1,1 );
			half mulTime22_g16 = _Time.y * 0.2;
			half temp_output_27_0_g16 = frac( mulTime22_g16 );
			half2 temp_output_11_0_g16 = ( temp_output_4_0_g16 + ( -(Wave3Dir219*2.0 + -1.0) * temp_output_17_0_g16 * temp_output_27_0_g16 ) );
			half temp_output_55_0_g16 = 1.0;
			half2 temp_output_12_0_g16 = ( temp_output_4_0_g16 + ( -(Wave3Dir219*2.0 + -1.0) * temp_output_17_0_g16 * frac( ( mulTime22_g16 + 0.5 ) ) ) );
			half3 lerpResult9_g16 = lerp( UnpackScaleNormal( tex2D( _BumpMap, temp_output_11_0_g16 ), temp_output_55_0_g16 ) , UnpackScaleNormal( tex2D( _BumpMap, temp_output_12_0_g16 ), temp_output_55_0_g16 ) , ( abs( ( temp_output_27_0_g16 - 0.5 ) ) / 0.5 ));
			half3 temp_output_5_0_g20 = ( lerpResult9_g16 * half3(-1,-1,1) );
			half dotResult8_g20 = dot( temp_output_3_0_g20 , temp_output_5_0_g20 );
			half3 normalizeResult13_g20 = normalize( ( ( ( dotResult8_g20 * temp_output_3_0_g20 ) / temp_output_3_0_g20.z ) - temp_output_5_0_g20 ) );
			half3 lerpResult200 = lerp( normalizeResult13_g20 , i.viewDir , _HorizonBend);
			half3 TangentNormal214 = lerpResult200;
			o.Normal = TangentNormal214;
			half3 temp_cast_0 = (0.0).xxx;
			o.Albedo = temp_cast_0;
			half4 lerpResult270 = lerp( unity_AmbientSky , _AmbientColor , _AmbientColor.a);
			half4 lerpResult272 = lerp( unity_FogColor , _HorizonColor , _HorizonColor.a);
			half3 WorldNormal241 = (WorldNormalVector( i , TangentNormal214 ));
			float3 ase_worldPos = i.worldPos;
			half3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			half dotResult157 = dot( WorldNormal241 , ase_worldViewDir );
			half Fresnel239 = pow( ( 1.0 - abs( dotResult157 ) ) , _FresnelPower );
			half clampResult160 = clamp( ( Fresnel239 + 0.1 ) , 0.0 , 0.9 );
			half4 lerpResult29 = lerp( lerpResult270 , lerpResult272 , clampResult160);
			half fresnelNdotV77 = dot( WorldNormal241, ase_worldViewDir );
			half ior77 = 1.3;
			ior77 = pow( ( 1 - ior77 ) / ( 1 + ior77 ), 2 );
			half fresnelNode77 = ( ior77 + ( 1.0 - ior77 ) * pow( 1.0 - fresnelNdotV77, 5 ) );
			half clampResult139 = clamp( abs( fresnelNode77 ) , 0.0 , 1.0 );
			half Fresnel2243 = clampResult139;
			o.Emission = ( lerpResult29 * Fresnel2243 ).rgb;
			half lerpResult184 = lerp( _Specular , 0.0 , Fresnel239);
			half clampResult185 = clamp( lerpResult184 , 0.2 , 1.0 );
			half Specular236 = clampResult185;
			o.Specular = Specular236;
			o.Gloss = _Gloss;
			o.Alpha = clampResult160;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=19105
Node;AmplifyShaderEditor.CommentaryNode;267;-4096,-2304;Inherit;False;1186;377;;16;44;50;116;257;259;260;261;258;263;264;265;266;217;262;218;219;Wave 1, 2, 3 Directions;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;256;-2688,-3328;Inherit;False;1685;816;;18;212;213;228;222;210;227;221;211;206;226;220;205;203;204;200;214;201;202;TangentNormals;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;255;-512,-2336;Inherit;False;902.9008;279.084;;5;236;238;10;184;185;Specular;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;254;-512,-2688;Inherit;False;898;209;;5;243;180;139;77;245;Fresnel 2;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;253;-512,-3072;Inherit;False;1090;318;;8;159;178;157;173;161;239;242;158;Fresnel 1;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;252;-512,-3456;Inherit;False;634;233;;3;241;138;215;Tangent Normals To World Normals;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;251;-4096,-2816;Inherit;False;858.2473;431.1997;;11;120;223;224;225;121;108;107;102;109;106;235;Wave 1, 2, 3 UV's;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;250;-4096,-3200;Inherit;False;492;280;;2;11;97;WaterNormalTex;1,1,1,1;0;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;7;2059.394,-2617.198;Half;False;True;-1;0;ASEMaterialInspector;0;0;BlinnPhong;CustomPR/OceanRAFTislands;False;False;False;False;False;False;False;False;False;False;False;True;False;False;True;False;False;False;False;False;False;Back;0;False;;0;False;;False;0;False;;0;False;;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;12;all;True;True;True;True;0;False;;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;2;15;10;25;False;0.5;False;2;5;False;;10;False;;0;0;False;;0;False;;0;False;;0;False;;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;;3;0;False;;0;0;0;False;0.1;False;;0;False;;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.RangedFloatNode;183;1899.223,-2816.537;Inherit;False;Constant;_Float2;Float 2;25;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;216;1810.749,-2731.769;Inherit;False;214;TangentNormal;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;140;1536,-2688;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;29;1280,-2688;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;244;1344,-2560;Inherit;False;243;Fresnel2;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;237;1792,-2528;Inherit;False;236;Specular;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;11;-4064,-3136;Inherit;True;Property;_BumpMap;BumpMap;6;0;Create;True;0;0;0;False;0;False;None;4cfe28dc08e9683488fdc2b11c77e27a;True;bump;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.RegisterLocalVarNode;97;-3840,-3136;Inherit;False;WaterNormalTex;-1;True;1;0;SAMPLER2D;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.RangedFloatNode;9;1674.862,-2449.128;Inherit;False;Property;_Gloss;Gloss;4;0;Create;True;0;0;0;False;0;False;0;1.96;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;240;768,-2304;Inherit;False;239;Fresnel;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;182;768,-2224;Inherit;False;Constant;_Float1;Float 1;25;0;Create;True;0;0;0;False;0;False;0.1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;181;928,-2304;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;160;1056,-2304;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0.9;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;95;-1684.591,-1399.053;Inherit;True;Property;_TextureSample1;Texture Sample 0;11;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;57;-2210.525,-1567.793;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;99;-2122.882,-1417.769;Inherit;False;97;WaterNormalTex;1;0;OBJECT;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.SimpleTimeNode;42;-2427.875,-1317.277;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;56;-2104.313,-1269.151;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;123;-1862.679,-983.8722;Inherit;False;3;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;94;-1666.364,-1624.102;Inherit;True;Property;_TextureSample0;Texture Sample 0;11;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;129;-1342.414,-1750.135;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;130;-1153.33,-1748.909;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;133;-1357.538,-1443.222;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;134;-1168.454,-1441.996;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;135;-1348.942,-1336.404;Inherit;False;Property;_wave2to3;wave2to3;17;0;Create;True;0;0;0;False;0;False;0;0.367;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;132;-1631.818,-1722.317;Inherit;False;Property;_wave1to2;wave1to2;16;0;Create;True;0;0;0;False;0;False;0;0.196;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;103;-1856.191,-1617.933;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;104;-1896.345,-1333.209;Inherit;False;3;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FunctionNode;128;-673.1165,-1173.37;Inherit;False;BlendNormalsOrient;-1;;11;331f7329426aa734497bbee747c38370;0;2;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;122;-2151.343,-948.2661;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;41;-2701.973,-1334.677;Inherit;False;Property;_wawe2Speed;wawe2Speed;11;0;Create;True;0;0;0;False;0;False;1;0.364;0.1;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;233;-2119.986,-1336.988;Inherit;False;224;Wave2UV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;98;-2066.565,-1698.26;Inherit;False;97;WaterNormalTex;1;0;OBJECT;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.GetLocalVarNode;232;-2275.505,-1671.584;Inherit;False;225;Wave1UV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;234;-2072.083,-1013.854;Inherit;False;223;Wave3UV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;230;-2329.709,-1199.269;Inherit;False;218;Wave2Dir;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleTimeNode;119;-2375.651,-1057.082;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;118;-2690.102,-1091.877;Inherit;False;Property;_wawe3Speed;wawe3Speed;12;0;Create;True;0;0;0;False;0;False;1;0.473;0.1;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;231;-2387.152,-926.4152;Inherit;False;219;Wave3Dir;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleTimeNode;37;-2457.548,-1609.848;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;40;-2744.584,-1614.248;Inherit;False;Property;_wawe1Speed;wawe1Speed;10;0;Create;True;0;0;0;False;0;False;1;0.194;0.1;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;229;-2459.224,-1490.734;Inherit;False;217;Wave1Dir;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FunctionNode;127;-1021.387,-1630.272;Inherit;False;BlendNormalsOrient;-1;;12;331f7329426aa734497bbee747c38370;0;2;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;96;-1638.979,-982.6971;Inherit;True;Property;_TextureSample2;Texture Sample 0;11;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;100;-1921.164,-814.5156;Inherit;False;97;WaterNormalTex;1;0;OBJECT;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.GetLocalVarNode;235;-4064,-2752;Inherit;False;97;WaterNormalTex;1;0;OBJECT;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;106;-3584,-2752;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;109;-3584,-2624;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;102;-3840,-2752;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;107;-3840,-2624;Inherit;False;Property;_wave1Size;wave1Size;13;0;Create;True;0;0;0;False;0;False;0;0.39;0.1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;108;-3840,-2560;Inherit;False;Property;_wave2Size;wave2Size;14;0;Create;True;0;0;0;False;0;False;0;0.68;0.1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;121;-3840,-2496;Inherit;False;Property;_wave3Size;wave3Size;15;0;Create;True;0;0;0;False;0;False;0;0.96;0.1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;225;-3456,-2752;Inherit;False;Wave1UV;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;224;-3456,-2624;Inherit;False;Wave2UV;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;223;-3456,-2512;Inherit;False;Wave3UV;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;120;-3584,-2512;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;50;-4064,-2160;Inherit;False;Property;_wawe2Dir;wawe2Dir;8;0;Create;True;0;0;0;False;0;False;1;0.209;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;116;-4064,-2080;Inherit;False;Property;_wawe3Dir;wawe3Dir;9;0;Create;True;0;0;0;False;0;False;1;0.419;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;44;-4064,-2240;Inherit;False;Property;_wawe1Dir;wawe1Dir;7;0;Create;True;0;0;0;False;0;False;1;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;257;-3776,-2240;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TauNode;259;-3776,-2128;Inherit;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;260;-3520,-2240;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CosOpNode;261;-3520,-2176;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;258;-3648,-2240;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.BreakToComponentsNode;263;-3392,-2112;Inherit;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.DynamicAppendNode;264;-3280,-2240;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;265;-3280,-2144;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;266;-3280,-2048;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;217;-3152,-2240;Inherit;False;Wave1Dir;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.BreakToComponentsNode;262;-3392,-2240;Inherit;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RegisterLocalVarNode;218;-3152,-2160;Inherit;False;Wave2Dir;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;219;-3152,-2080;Inherit;False;Wave3Dir;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FunctionNode;212;-2400,-2752;Inherit;False;Flow;0;;16;acad10cc8145e1f4eb8042bebe2d9a42;2,50,1,51,1;6;5;SAMPLER2D;;False;2;FLOAT2;0,0;False;55;FLOAT;1;False;18;FLOAT2;0,0;False;17;FLOAT2;1,1;False;24;FLOAT;0.2;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;213;-2656,-2752;Inherit;False;97;WaterNormalTex;1;0;OBJECT;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.GetLocalVarNode;228;-2656,-2688;Inherit;False;223;Wave3UV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;222;-2656,-2624;Inherit;False;219;Wave3Dir;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FunctionNode;210;-2400,-3008;Inherit;False;Flow;0;;17;acad10cc8145e1f4eb8042bebe2d9a42;2,50,1,51,1;6;5;SAMPLER2D;;False;2;FLOAT2;0,0;False;55;FLOAT;1;False;18;FLOAT2;0,0;False;17;FLOAT2;1,1;False;24;FLOAT;0.2;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;227;-2656,-2944;Inherit;False;224;Wave2UV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;221;-2656,-2880;Inherit;False;218;Wave2Dir;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;211;-2656,-3008;Inherit;False;97;WaterNormalTex;1;0;OBJECT;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.GetLocalVarNode;206;-2656,-3264;Inherit;False;97;WaterNormalTex;1;0;OBJECT;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.GetLocalVarNode;226;-2656,-3200;Inherit;False;225;Wave1UV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;220;-2656,-3136;Inherit;False;217;Wave1Dir;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FunctionNode;205;-2400,-3264;Inherit;False;Flow;0;;18;acad10cc8145e1f4eb8042bebe2d9a42;2,50,1,51,1;6;5;SAMPLER2D;;False;2;FLOAT2;0,0;False;55;FLOAT;1;False;18;FLOAT2;0,0;False;17;FLOAT2;1,1;False;24;FLOAT;0.2;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;203;-2016,-3264;Inherit;False;BlendNormalsOrient;-1;;19;331f7329426aa734497bbee747c38370;0;2;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;204;-1744,-3264;Inherit;False;BlendNormalsOrient;-1;;20;331f7329426aa734497bbee747c38370;0;2;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;200;-1408,-3264;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;214;-1248,-3264;Inherit;False;TangentNormal;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;201;-1632,-3136;Inherit;False;Tangent;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;202;-1728,-2976;Inherit;False;Property;_HorizonBend;HorizonBend;19;0;Create;True;0;0;0;False;0;False;0.2;0.1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;215;-480,-3392;Inherit;False;214;TangentNormal;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WorldNormalVector;138;-288,-3392;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RegisterLocalVarNode;241;-96,-3392;Inherit;False;WorldNormal;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.OneMinusNode;159;0,-3008;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.AbsOpNode;178;-128,-3008;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;157;-288,-3008;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;173;-160,-2944;Inherit;False;Property;_FresnelPower;FresnelPower;18;0;Create;True;0;0;0;False;0;False;0;14.59;1;16;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;161;160,-3008;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;8;False;1;FLOAT;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;158;-480,-2928;Inherit;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.AbsOpNode;180;-96,-2624;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;139;16,-2624;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;77;-304,-2624;Inherit;False;SchlickIOR;WorldNormal;ViewDir;False;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;1;False;2;FLOAT;1.3;False;3;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;243;144,-2624;Inherit;False;Fresnel2;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;185;0,-2272;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0.2;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;184;-144,-2272;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;10;-480,-2272;Inherit;False;Property;_Specular;Specular;5;0;Create;True;0;0;0;False;0;False;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;236;176,-2256;Inherit;False;Specular;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;238;-368,-2192;Inherit;False;239;Fresnel;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;242;-480,-3008;Inherit;False;241;WorldNormal;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;245;-480,-2624;Inherit;False;241;WorldNormal;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;239;336,-3008;Inherit;False;Fresnel;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FogAndAmbientColorsNode;30;1024,-2688;Inherit;False;unity_AmbientSky;0;1;COLOR;0
Node;AmplifyShaderEditor.FogAndAmbientColorsNode;28;1024,-2624;Inherit;False;unity_FogColor;0;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;270;1299.097,-2949.187;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;272;1186.841,-2800.966;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;271;914.9698,-2894.031;Inherit;False;Property;_HorizonColor;HorizonColor;21;0;Create;True;0;0;0;False;0;False;0.6862745,0.8117647,1,0.5019608;0.6862745,0.8117648,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;269;1027.226,-3042.252;Inherit;False;Property;_AmbientColor;AmbientColor;20;0;Create;True;0;0;0;False;0;False;0.2509804,0.5137255,0.9333333,1;0.2511125,0.5143797,0.9339623,0.5019608;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
WireConnection;7;0;183;0
WireConnection;7;1;216;0
WireConnection;7;2;140;0
WireConnection;7;3;237;0
WireConnection;7;4;9;0
WireConnection;7;9;160;0
WireConnection;140;0;29;0
WireConnection;140;1;244;0
WireConnection;29;0;270;0
WireConnection;29;1;272;0
WireConnection;29;2;160;0
WireConnection;97;0;11;0
WireConnection;181;0;240;0
WireConnection;181;1;182;0
WireConnection;160;0;181;0
WireConnection;95;0;99;0
WireConnection;95;1;104;0
WireConnection;57;0;37;0
WireConnection;57;1;229;0
WireConnection;42;0;41;0
WireConnection;56;0;42;0
WireConnection;56;1;230;0
WireConnection;123;0;234;0
WireConnection;123;1;122;0
WireConnection;123;2;134;0
WireConnection;94;0;98;0
WireConnection;94;1;103;0
WireConnection;129;0;94;1
WireConnection;129;1;94;2
WireConnection;130;0;129;0
WireConnection;130;1;132;0
WireConnection;133;0;95;1
WireConnection;133;1;95;2
WireConnection;134;0;133;0
WireConnection;134;1;135;0
WireConnection;103;0;232;0
WireConnection;103;1;57;0
WireConnection;104;0;233;0
WireConnection;104;1;56;0
WireConnection;104;2;130;0
WireConnection;128;1;127;0
WireConnection;128;2;96;0
WireConnection;122;0;119;0
WireConnection;122;1;231;0
WireConnection;119;0;118;0
WireConnection;37;0;40;0
WireConnection;127;1;94;0
WireConnection;127;2;95;0
WireConnection;96;0;100;0
WireConnection;96;1;123;0
WireConnection;106;0;102;0
WireConnection;106;1;107;0
WireConnection;109;0;102;0
WireConnection;109;1;108;0
WireConnection;102;2;235;0
WireConnection;225;0;106;0
WireConnection;224;0;109;0
WireConnection;223;0;120;0
WireConnection;120;0;102;0
WireConnection;120;1;121;0
WireConnection;257;0;44;0
WireConnection;257;1;50;0
WireConnection;257;2;116;0
WireConnection;260;0;258;0
WireConnection;261;0;258;0
WireConnection;258;0;257;0
WireConnection;258;1;259;0
WireConnection;263;0;261;0
WireConnection;264;0;262;0
WireConnection;264;1;263;0
WireConnection;265;0;262;1
WireConnection;265;1;263;1
WireConnection;266;0;262;2
WireConnection;266;1;263;2
WireConnection;217;0;264;0
WireConnection;262;0;260;0
WireConnection;218;0;265;0
WireConnection;219;0;266;0
WireConnection;212;5;213;0
WireConnection;212;2;228;0
WireConnection;212;18;222;0
WireConnection;210;5;211;0
WireConnection;210;2;227;0
WireConnection;210;18;221;0
WireConnection;205;5;206;0
WireConnection;205;2;226;0
WireConnection;205;18;220;0
WireConnection;203;1;205;0
WireConnection;203;2;210;0
WireConnection;204;1;203;0
WireConnection;204;2;212;0
WireConnection;200;0;204;0
WireConnection;200;1;201;0
WireConnection;200;2;202;0
WireConnection;214;0;200;0
WireConnection;138;0;215;0
WireConnection;241;0;138;0
WireConnection;159;0;178;0
WireConnection;178;0;157;0
WireConnection;157;0;242;0
WireConnection;157;1;158;0
WireConnection;161;0;159;0
WireConnection;161;1;173;0
WireConnection;180;0;77;0
WireConnection;139;0;180;0
WireConnection;77;0;245;0
WireConnection;243;0;139;0
WireConnection;185;0;184;0
WireConnection;184;0;10;0
WireConnection;184;2;238;0
WireConnection;236;0;185;0
WireConnection;239;0;161;0
WireConnection;270;0;30;0
WireConnection;270;1;269;0
WireConnection;270;2;269;4
WireConnection;272;0;28;0
WireConnection;272;1;271;0
WireConnection;272;2;271;4
ASEEND*/
//CHKSM=3201A52F91176CED6B2BE4B24E290F8B132F639E