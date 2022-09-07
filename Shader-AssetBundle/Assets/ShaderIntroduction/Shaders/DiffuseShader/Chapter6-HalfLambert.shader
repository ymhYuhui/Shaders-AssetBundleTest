// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'
// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'
// ��������ģ���𶥵�������
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
                
                //�����������ռ�ת����ͶӰ�ռ�
                o.pos = UnityObjectToClipPos(v.vertex);
                //�����ߴ�����ռ�ת��������ռ�
                o.worldNormal = mul(v.normal, (float3x3)unity_WorldToObject);
                return o;
            }
            
            fixed4 frag(v2f i) : SV_Target {
                fixed3 ambient = UNITY_LIGHTMODEL_AMBIENT.xyz;

                //��ȡ����ռ䷨�߷���
                fixed3 worldNormal = normalize(i.worldNormal);
                //��ȡ����ռ���շ���
                fixed3 worldLightDir = normalize(_WorldSpaceLightPos0.xyz);

                //����������->��ʽ��
                //C diffuse = (C light * M diffuse) * max(0,n��l)
                //������ = ����ǿ * ���ʵ�������ϵ����* max�����淨�� �� ��Դ����

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