#include "Lighting.cginc"

Shader "Unity Shaders Book/ Chapter 6/ Diffuse Vertex- Level" {
    Properties {
        _Diffuse ("Diffuse", Color) = (1, 1, 1, 1)
    }
    SubShader {
        Pass {
            Tags { "LightMode" = "ForwardBase" }

            CGPROGRAM

            #pragma vertex vert
            #pragma fragment frag

            fixed4 _Diffuse
            struct a2v {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            }
            struct v2f {
                float4 pos : SV_POSITION;
                float3 color : COLOR;
            }

            v2f vert(a2v v){
            v2f o;
            o.pos = mul()
            
            } 




            ENDCG

        }
    }
}