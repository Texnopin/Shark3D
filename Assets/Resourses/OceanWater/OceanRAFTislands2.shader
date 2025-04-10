// Made with Amplify Shader Editor v1.9.1.5
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "CustomPR/OceanRAFTislands123"
{
    Properties
    {
        _Size("Size", Range(0, 10)) = 1
        _SpecColor("Specular Color", Color) = (1, 1, 1, 1)
        _Gloss("Gloss", Range(0, 10)) = 0
        _Specular("Specular", Range(0, 1)) = 0
        _BumpMap("BumpMap", 2D) = "bump" {}
        _Wave1Dir("Wave1 Direction", Range(0, 1)) = 1
        _Wave2Dir("Wave2 Direction", Range(0, 1)) = 1
        _Wave3Dir("Wave3 Direction", Range(0, 1)) = 1
        _Wave1Size("Wave1 Size", Range(0.1, 10)) = 0
        _Wave2Size("Wave2 Size", Range(0.1, 10)) = 0
        _Wave3Size("Wave3 Size", Range(0.1, 10)) = 0
        _FresnelPower("Fresnel Power", Range(1, 16)) = 0
        _HorizonBend("Horizon Bend", Range(0, 1)) = 0.2
        [HideInInspector] _texcoord("", 2D) = "white" {}
        [HideInInspector] __dirty("", Int) = 1
    }

    SubShader
    {
        Tags { "RenderType" = "Transparent" "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true" }
        Cull Back
        CGPROGRAM
        #include "UnityShaderVariables.cginc"
        #include "UnityStandardUtils.cginc"
        #pragma target 3.0
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
        uniform half _Wave1Size;
        uniform float _Size;
        uniform half _Wave1Dir;
        uniform half _Wave2Dir;
        uniform half _Wave3Dir;
        uniform half _Wave2Size;
        uniform half _Wave3Size;
        uniform half _HorizonBend;
        uniform half _FresnelPower;
        uniform half _Specular;
        uniform half _Gloss;

        void surf(Input i, inout SurfaceOutput o)
        {
            // Calculate UV coordinates for bump mapping
            float2 uv_BumpMap = i.uv_texcoord * _BumpMap_ST.xy + _BumpMap_ST.zw;

            // Wave1 calculations
            half2 wave1UV = (uv_BumpMap * _Wave1Size) / _Size;
            half3 waveDirections = half3(_Wave1Dir, _Wave2Dir, _Wave3Dir) * 6.28318548202515;
            half3 waveSin = sin(waveDirections);
            half3 waveCos = cos(waveDirections);
            half2 wave1Direction = half2(waveSin.x, waveCos.x);

            half timeWave1 = _Time.y * 0.2;
            half2 wave1Offset1 = wave1UV - (wave1Direction * frac(timeWave1));
            half2 wave1Offset2 = wave1UV - (wave1Direction * frac(timeWave1 + 0.5));
            half3 wave1Normal1 = UnpackScaleNormal(tex2D(_BumpMap, wave1Offset1), 1.0);
            half3 wave1Normal2 = UnpackScaleNormal(tex2D(_BumpMap, wave1Offset2), 1.0);
            half3 blendedWave1 = lerp(wave1Normal1, wave1Normal2, abs(frac(timeWave1) - 0.5) / 0.5);

            // Wave2 calculations
            half2 wave2UV = (uv_BumpMap * _Wave2Size) / _Size;
            half2 wave2Direction = half2(waveSin.y, waveCos.y);

            half timeWave2 = _Time.y * 0.2;
            half2 wave2Offset1 = wave2UV - (wave2Direction * frac(timeWave2));
            half2 wave2Offset2 = wave2UV - (wave2Direction * frac(timeWave2 + 0.5));
            half3 wave2Normal1 = UnpackScaleNormal(tex2D(_BumpMap, wave2Offset1), 1.0) * half3(-1, -1, 1);
            half3 wave2Normal2 = UnpackScaleNormal(tex2D(_BumpMap, wave2Offset2), 1.0) * half3(-1, -1, 1);
            half3 blendedWave2 = lerp(wave2Normal1, wave2Normal2, abs(frac(timeWave2) - 0.5) / 0.5);

            // Combine Wave1 and Wave2
            half wave1DotWave2 = dot(blendedWave1, blendedWave2);
            half3 combinedNormal1 = normalize(((wave1DotWave2 * blendedWave1) / blendedWave1.z) - blendedWave2);

            // Wave3 calculations
            half2 wave3UV = (uv_BumpMap * _Wave3Size) / _Size;
            half2 wave3Direction = half2(waveSin.z, waveCos.z);

            half timeWave3 = _Time.y * 0.2;
            half2 wave3Offset1 = wave3UV - (wave3Direction * frac(timeWave3));
            half2 wave3Offset2 = wave3UV - (wave3Direction * frac(timeWave3 + 0.5));
            half3 wave3Normal1 = UnpackScaleNormal(tex2D(_BumpMap, wave3Offset1), 1.0) * half3(-1, -1, 1);
            half3 wave3Normal2 = UnpackScaleNormal(tex2D(_BumpMap, wave3Offset2), 1.0) * half3(-1, -1, 1);
            half3 blendedWave3 = lerp(wave3Normal1, wave3Normal2, abs(frac(timeWave3) - 0.5) / 0.5);

            // Combine all three wave normals
            half wave2DotWave3 = dot(combinedNormal1, blendedWave3);
            half3 finalNormal = normalize(((wave2DotWave3 * combinedNormal1) / combinedNormal1.z) - blendedWave3);
            half3 bentNormal = lerp(finalNormal, i.viewDir, _HorizonBend);
            o.Normal = bentNormal;

            // Fresnel and emission calculations
            half3 worldNormal = WorldNormalVector(i, bentNormal);
            half3 viewDirWorld = normalize(UnityWorldSpaceViewDir(i.worldPos));
            half fresnelDot = dot(worldNormal, viewDirWorld);
            half fresnelTerm = pow(1.0 - abs(fresnelDot), _FresnelPower);
            half fresnelAlpha = clamp(fresnelTerm + 0.1, 0.0, 0.9);

            half4 fresnelColor = lerp(unity_AmbientSky, unity_FogColor, fresnelAlpha);
            o.Emission = (fresnelColor * fresnelAlpha).rgb;

            // Specular and gloss
            o.Specular = lerp(_Specular, 0.0, fresnelTerm);
            o.Gloss = _Gloss;

            // Alpha transparency
            o.Alpha = fresnelAlpha;
        }

        ENDCG
    }
    CustomEditor "ASEMaterialInspector"
}