// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'
// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'
// 基本光照模型逐顶点漫反射
Shader "Unity Shaders Book/Chapter 6/HalfLambert" {
    Properties {
        _Diffuse ("Diffuse", Color) = (1, 1, 1, 1)
    }
    SubShader {
        Pass {
            Tags { "LightMode" = "ForwardBase" }
            



            CGPROGRAM

            
            #pragma vertex vert
            #pragma fragment frag
            
            #include "Lighting.cginc"
            
            fixed4 _Diffuse;
            
            struct a2v {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };
            
            struct v2f {
                float4 pos : SV_POSITION;
                fixed3 worldNormal : TEXCOORD0;
            };
            
            v2f vert(a2v v) {
                v2f o;
                
                //将顶点从物体空间转换到投影空间
                o.pos = UnityObjectToClipPos(v.vertex);
                //将法线从物体空间转换至世界空间
                o.worldNormal = mul(v.normal, (float3x3)unity_WorldToObject);
                return o;
            }
            
            fixed4 frag(v2f i) : SV_Target {
                fixed3 ambient = UNITY_LIGHTMODEL_AMBIENT.xyz;

                //获取世界空间法线方向
                fixed3 worldNormal = normalize(i.worldNormal);
                //获取世界空间光照方向
                fixed3 worldLightDir = normalize(_WorldSpaceLightPos0.xyz);

                //计算漫反射->公式：
                //C diffuse = (C light * M diffuse) * max(0,n·l)
                //漫反射 = （光强 * 材质的漫反射系数）* max（表面法线 · 光源方向）

               fixed halfLambert = dot(worldNormal, worldLightDir) * 0.5 + 0.5;
                fixed3 diffuse = _LightColor0.rgb * _Diffuse.rgb * halfLambert;

                fixed3 color = ambient + diffuse;

                return fixed4(color, 1.0);
            }
            



            ENDCG

        }
    }
    FallBack "Diffuse"
}