Shader "Hidden/TextShader"
{
    Properties
    {
        [HideInInspector]
        _MainTex("Texture", 2D) = "white" {}
    }
    SubShader
    {
        Cull   Off
        ZWrite Off
        ZTest  Always

        Pass
        {
            CGPROGRAM

            #include "UnityCG.cginc"

            #pragma target 5.0
            #pragma vertex vert_img
            #pragma fragment frag

            static const float2 SUV_SIZE = float2(0.0625, 0.1666667);

            static const float2 SUV[96] =
            {
                float2(0,     0.8333334), float2(0.0625, 0.8333334), float2(0.125, 0.8333334), float2(0.1875, 0.8333334),
                float2(0.25,  0.8333334), float2(0.3125, 0.8333334), float2(0.375, 0.8333334), float2(0.4375, 0.8333334),
                float2(0.5,   0.8333334), float2(0.5625, 0.8333334), float2(0.625, 0.8333334), float2(0.6875, 0.8333334),
                float2(0.75,  0.8333334), float2(0.8125, 0.8333334), float2(0.875, 0.8333334), float2(0.9375, 0.8333334),
                float2(0,     0.6666667), float2(0.0625, 0.6666667), float2(0.125, 0.6666667), float2(0.1875, 0.6666667),
                float2(0.25,  0.6666667), float2(0.3125, 0.6666667), float2(0.375, 0.6666667), float2(0.4375, 0.6666667),
                float2(0.5,   0.6666667), float2(0.5625, 0.6666667), float2(0.625, 0.6666667), float2(0.6875, 0.6666667),
                float2(0.75,  0.6666667), float2(0.8125, 0.6666667), float2(0.875, 0.6666667), float2(0.9375, 0.6666667),
                float2(0,     0.5),       float2(0.0625, 0.5),       float2(0.125, 0.5),       float2(0.1875, 0.5),
                float2(0.25,  0.5),       float2(0.3125, 0.5),       float2(0.375, 0.5),       float2(0.4375, 0.5),
                float2(0.5,   0.5),       float2(0.5625, 0.5),       float2(0.625, 0.5),       float2(0.6875, 0.5),
                float2(0.75,  0.5),       float2(0.8125, 0.5),       float2(0.875, 0.5),       float2(0.9375, 0.5),
                float2(0,     0.3333333), float2(0.0625, 0.3333333), float2(0.125, 0.3333333), float2(0.1875, 0.3333333),
                float2(0.25,  0.3333333), float2(0.3125, 0.3333333), float2(0.375, 0.3333333), float2(0.4375, 0.3333333),
                float2(0.5,   0.3333333), float2(0.5625, 0.3333333), float2(0.625, 0.3333333), float2(0.6875, 0.3333333),
                float2(0.75,  0.3333333), float2(0.8125, 0.3333333), float2(0.875, 0.3333333), float2(0.9375, 0.3333333),
                float2(0,     0.1666667), float2(0.0625, 0.1666667), float2(0.125, 0.1666667), float2(0.1875, 0.1666667),
                float2(0.25,  0.1666667), float2(0.3125, 0.1666667), float2(0.375, 0.1666667), float2(0.4375, 0.1666667),
                float2(0.5,   0.1666667), float2(0.5625, 0.1666667), float2(0.625, 0.1666667), float2(0.6875, 0.1666667),
                float2(0.75,  0.1666667), float2(0.8125, 0.1666667), float2(0.875, 0.1666667), float2(0.9375, 0.1666667),
                float2(0,     0),         float2(0.0625, 0),         float2(0.125, 0),         float2(0.1875, 0),
                float2(0.25,  0),         float2(0.3125, 0),         float2(0.375, 0),         float2(0.4375, 0),
                float2(0.5,   0),         float2(0.5625, 0),         float2(0.625, 0),         float2(0.6875, 0),
                float2(0.75,  0),         float2(0.8125, 0),         float2(0.875, 0),         float2(0.9375, 0)
            };

            static const int RETURN_CODE    = 60;

            struct TextData
            {
                // NOTE:
                // index.x      = offset.
                // index.y      = length.
                // parameter.xy = position.
                // parameter.z  = charSize.

                float2 index;
                float3 parameter;
                float4 color;
            };

            StructuredBuffer<int>      _TextBuffer;
            StructuredBuffer<TextData> _TextDataBuffer;

            sampler2D _MainTex;
            sampler2D _FontTex;

            void DrawChar(float2 inputPos, float2 charPos, float2 charSize,
                          float4 charColor, int char, inout fixed4 dest)

            {
                bool draw = charPos.x  < inputPos.x
                         && charPos.y  < inputPos.y
                         && inputPos.x < (charPos.x + charSize.x)
                         && inputPos.y < (charPos.y + charSize.y);

                float2 suv      = SUV[char];
                float2 charUV   = (inputPos - charPos) / charSize;
                float2 spriteUV = lerp(suv, suv + SUV_SIZE, charUV);

                fixed4 color = tex2D(_FontTex, spriteUV) * charColor;

                dest = (draw && color.a != 0) ? color : dest;
            }

            fixed4 frag (v2f_img input) : SV_Target
            {
                float4 color = tex2D(_MainTex, input.uv);
                
                float aspect = _ScreenParams.x / _ScreenParams.y;

                int textDataBufferLength = (int)_TextDataBuffer.Length;

                TextData textData;

                int    char;
                int    charOffset;
                int    charLength;
                float2 charPos;
                float2 charSize;
                float4 charColor;

                for (int i = 0; i < textDataBufferLength; i++)
                {
                    textData = _TextDataBuffer[i];

                    charOffset = textData.index.x;
                    charLength = textData.index.y;
                    charPos    = textData.parameter.xy;
                    charSize   = float2(textData.parameter.z, textData.parameter.z * aspect);
                    charColor  = textData.color;

                    for(int j = 0; j < charLength; j++)
                    {
                        char = _TextBuffer[charOffset + j];

                        if(char == RETURN_CODE)
                        {
                            charPos.x = textData.parameter.x;
                            charPos.y -= charSize.y;
                            continue;
                        }

                        DrawChar(input.uv, charPos, charSize, charColor, char, color);
                        charPos.x += charSize.x;
                    }
                }

                return color;
            }

            ENDCG
        }
    }
}