Shader "Custom/TransparentEmissionMaterial"
{
    Properties
    {
        _Color ("Base Color", Color) = (1, 1, 0, 0.5) // Желтый цвет с 50% прозрачности
        _EmissionColor ("Emission Color", Color) = (1, 1, 0, 1) // Желтый цвет свечения
        _EmissionStrength ("Emission Strength", Range(0, 10)) = 1.0 // Интенсивность свечения
    }
    SubShader
    {
        Tags { "Queue"="Transparent" "RenderType"="Transparent" }
        LOD 200

        Blend SrcAlpha OneMinusSrcAlpha // Прозрачность
        ZWrite Off                     // Отключаем запись в буфер глубины для прозрачности

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
            };

            struct v2f
            {
                float4 pos : SV_POSITION;
            };

            float4 _Color;
            float4 _EmissionColor;
            float _EmissionStrength;

            v2f vert (appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // Основной цвет (с прозрачностью)
                fixed4 baseColor = _Color;

                // Эмиссионный цвет
                fixed4 emissionColor = _EmissionColor * _EmissionStrength;

                // Финальный цвет (основной + свечение)
                return baseColor + emissionColor;
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}
