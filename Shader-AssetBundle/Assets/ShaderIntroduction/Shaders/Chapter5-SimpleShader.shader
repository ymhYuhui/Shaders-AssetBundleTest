
Shader "Unity Shaders Book/ Chapter 5/ Simple Shader" { 
	Properties { 
		// 声明 一个 Color 类型 的 属性 
		_Color ("Color Tint",Color) = (1.0, 1.0, 1.0, 1.0) 
	}


	SubShader{ 
		Pass { 
			CGPROGRAM
			
			#pragma vertex vert 
			#pragma fragment frag

			fixed4 _Color;

			struct a2v{
				float4 vertex : POSITION; //POSITION语义告诉Unity，用模型空间的顶点坐标填充vertex变量

				float3 normal : NORMAL; // NORMAL语义告诉Unity，用模型空间的法线方向填充 normal 变量

				float4 texcoord : TEXCOORD0;//TEXCOORD0语义告诉Unity，用模型的第一套纹理坐标填充texcoord变量
			};

			struct v2f {
				
				float4 pos : SV_POSITION;// SV_POSITION语义告诉Unity,pos里包含了顶点在裁剪空间中的位置信息 
				fixed3 color : COLOR0; // COLOR0语义可以用于存储颜色信息
			};


			
			// v2f vert(a2v v) : SV_POSITION { 
				// 	v2f o;
				// 	o.pos = UnityObjectToClipPos(v.vertex);
				// 	// v.normal包含了顶点的法线方向，其分量范围在[- 1. 0, 1. 0] 
				// 	// 下面的代码把分量范围映射到了[ 0. 0, 1. 0] 
				// 	// 存储到o.color中传递给片元着色器
				// 	o.color = v.normal * 0.5 + fixed3(0.5,0.5,0.5);
				// 	return o;
			// } 
			
			//Shader入门精要中使用的是Unity5x版本这里需要改成下述代码
			
			void vert(in a2v v, out v2f o){
				//return UnityObjectToClipPos(v);
				o.pos = UnityObjectToClipPos(v.vertex);
				o.color = v.normal * 0.5 + fixed3(1.0,1.0,1.0);
			}
	

			fixed4 frag(v2f i) : SV_Target {
				fixed3 c = i.color;
				c*= _Color.rgb;
				return fixed4 (c, 1.0);
			}

			ENDCG 
		} 
	} 
}
