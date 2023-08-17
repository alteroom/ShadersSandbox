Shader "Shader Sandbox Samples/Game Of Life"
{
    Properties
    {
     }

    SubShader
    {
        Lighting Off
        Blend One Zero

        Pass
        {
            CGPROGRAM
            #include "UnityCustomRenderTexture.cginc"
            #pragma vertex CustomRenderTextureVertexShader
            #pragma fragment frag
            #pragma target 3.0

            float4 getPixel(v2f_customrendertexture IN, int x, int y) : COLOR{
                return tex2D(_SelfTexture2D, IN.localTexcoord.xy + fixed2(x/_CustomRenderTextureWidth, y/_CustomRenderTextureHeight));
            }
            
            float4 frag(v2f_customrendertexture IN) : COLOR
            {
                float self = getPixel(IN, 0, 0).r;

                int n = int(
                    getPixel(IN, -1, -1).r +
                    getPixel(IN, -1, 0).r +
                    getPixel(IN, -1, 1).r +
                    getPixel(IN, 0, 1).r +
                    getPixel(IN, 0, -1).r +
                    getPixel(IN, 1, -1).r +
                    getPixel(IN, 1, 0).r +
                    getPixel(IN, 1, 1).r
                );

                if (self > 0.5 && n >= 2 && n <= 3)
                {
                    return float4(1, 1, 1, 1);
                }
                if (self <= 0.5 && n == 3)
                {
                    return float4(1, 1, 1, 1);
                }
                return float4(0, 0, 0, 1);
            }
            ENDCG
        }
    }
}
