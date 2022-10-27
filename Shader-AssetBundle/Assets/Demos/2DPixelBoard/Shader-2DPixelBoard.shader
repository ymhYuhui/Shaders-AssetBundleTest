Shader "Demos/Shader-2DPixelBoard" {
    Properties {
        // ���� һ�� Color ���� �� ����
        _Color ("ColorTint", Color) = (1.0, 1.0, 1.0, 1.0)
    }


    SubShader {
        Pass {

            CGPROGRAM

            
            #pragma vertex vert
            #pragma fragment frag

            fixed4 _Color;

            struct a2v {
                float4 vertex : POSITION; //POSITION�������Unity����ģ�Ϳռ�Ķ����������vertex����
                float3 normal : NORMAL; // NORMAL�������Unity����ģ�Ϳռ�ķ��߷������ normal ����
                float4 texcoord : TEXCOORD0;//TEXCOORD0�������Unity����ģ�͵ĵ�һ�������������texcoord����

            };

            struct v2f {
                
                float4 pos : SV_POSITION;// SV_POSITION�������Unity,pos������˶����ڲü��ռ��е�λ����Ϣ
                fixed3 color : COLOR0; // COLOR0����������ڴ洢��ɫ��Ϣ

            };
            
            
            void vert(in a2v v, out v2f o) {
                //return UnityObjectToClipPos(v);
                o.pos = UnityObjectToClipPos(v.vertex);
                o.color = v.normal * 0.5 + fixed3(1.0, 1.0, 1.0);
            }
            

            fixed4 frag(v2f i) : SV_Target {
                fixed3 c = i.color;
                c *= _Color.rgb;
                return fixed4(c, 1.0);
            }

            ENDCG

        }
    }
}