//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Niantic/Sky/StarTwinkle" {
Properties {
_MainTex ("Texture", 2D) = "white" { }
_Color ("Tint", Color) = (1,1,1,1)
_TwinkleSpeed ("Twinkle Speed", Range(0, 10)) = 1
_TwinkleIntensity ("Twinkle Intensity", Range(0, 1)) = 0.5
_HorizonFade ("Horizon Fade Height", Range(0, 100)) = 40
_Scale ("Noise Scale", Range(4, 256)) = 32
[Enum(UnityEngine.Rendering.BlendMode)] _SrcBlend ("Source Blend", Float) = 1
[Enum(UnityEngine.Rendering.BlendMode)] _DstBlend ("Destination Blend", Float) = 1
}
SubShader {
 Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Sphere" "QUEUE" = "Background" }
 Pass {
  Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Sphere" "QUEUE" = "Background" }
  Blend Zero Zero, Zero Zero
  ZWrite Off
  Cull Off
  GpuProgramID 33163
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _HorizonFade;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[3].y * in_POSITION0.w + u_xlat0.y;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.x = u_xlat1.x / _HorizonFade;
    u_xlat16_2 = sqrt(u_xlat1.x);
    u_xlat16_2 = min(u_xlat16_2, 1.0);
    vs_TEXCOORD1 = u_xlat16_2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec4 _Time;
uniform 	mediump vec4 _Color;
uniform 	int _Scale;
uniform 	float _TwinkleSpeed;
uniform 	mediump float _TwinkleIntensity;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
mediump vec3 u_xlat16_0;
mediump vec2 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
bvec2 u_xlatb2;
mediump vec4 u_xlat16_3;
bvec4 u_xlatb4;
mediump vec2 u_xlat16_5;
vec2 u_xlat7;
mediump vec2 u_xlat16_11;
bvec2 u_xlatb12;
mediump float u_xlat16_15;
void main()
{
    u_xlat16_0.x = float(_Scale);
    u_xlat16_5.xy = u_xlat16_0.xx * vs_TEXCOORD0.xy;
    u_xlat16_1.xy = floor(u_xlat16_5.xy);
    u_xlat16_5.xy = fract(u_xlat16_5.xy);
    u_xlat16_11.xy = u_xlat16_1.xy + vec2(1.0, 1.0);
    u_xlat16_11.xy = u_xlat16_11.xy / u_xlat16_0.xx;
    u_xlatb2.xy = greaterThanEqual(u_xlat16_11.xyxx, (-u_xlat16_11.xyxx)).xy;
    u_xlat16_11.xy = fract(abs(u_xlat16_11.xy));
    {
        vec2 hlslcc_movcTemp = u_xlat16_11;
        hlslcc_movcTemp.x = (u_xlatb2.x) ? u_xlat16_11.x : (-u_xlat16_11.x);
        hlslcc_movcTemp.y = (u_xlatb2.y) ? u_xlat16_11.y : (-u_xlat16_11.y);
        u_xlat16_11 = hlslcc_movcTemp;
    }
    u_xlat16_11.xy = u_xlat16_0.xx * u_xlat16_11.xy;
    u_xlat16_15 = dot(u_xlat16_11.xy, vec2(12.0, 1.61800003));
    u_xlat16_15 = sin(u_xlat16_15);
    u_xlat2.x = _Time.x * _TwinkleSpeed;
    u_xlat7.x = u_xlat16_15 * u_xlat2.x;
    u_xlat7.x = fract(u_xlat7.x);
    u_xlat16_15 = u_xlat7.x * u_xlat7.x;
    u_xlat16_15 = u_xlat7.x * u_xlat16_15;
    u_xlat16_15 = (-u_xlat16_15) * u_xlat7.x + 1.0;
    u_xlat16_3 = u_xlat16_1.xyxy + vec4(1.0, 0.0, 0.0, 1.0);
    u_xlat16_1.xy = u_xlat16_1.xy / u_xlat16_0.xx;
    u_xlat16_3 = u_xlat16_3 / u_xlat16_0.xxxx;
    u_xlatb4 = greaterThanEqual(u_xlat16_3, (-u_xlat16_3));
    u_xlat16_3 = fract(abs(u_xlat16_3));
    {
        vec4 hlslcc_movcTemp = u_xlat16_3;
        hlslcc_movcTemp.x = (u_xlatb4.x) ? u_xlat16_3.x : (-u_xlat16_3.x);
        hlslcc_movcTemp.y = (u_xlatb4.y) ? u_xlat16_3.y : (-u_xlat16_3.y);
        hlslcc_movcTemp.z = (u_xlatb4.z) ? u_xlat16_3.z : (-u_xlat16_3.z);
        hlslcc_movcTemp.w = (u_xlatb4.w) ? u_xlat16_3.w : (-u_xlat16_3.w);
        u_xlat16_3 = hlslcc_movcTemp;
    }
    u_xlat16_3 = u_xlat16_0.xxxx * u_xlat16_3;
    u_xlat16_11.x = dot(u_xlat16_3.zw, vec2(12.0, 1.61800003));
    u_xlat16_11.y = dot(u_xlat16_3.xy, vec2(12.0, 1.61800003));
    u_xlat16_11.xy = sin(u_xlat16_11.xy);
    u_xlat7.xy = u_xlat16_11.yx * u_xlat2.xx;
    u_xlat7.xy = fract(u_xlat7.xy);
    u_xlat16_11.x = u_xlat7.y * u_xlat7.y;
    u_xlat16_11.x = u_xlat7.y * u_xlat16_11.x;
    u_xlat16_11.x = (-u_xlat16_11.x) * u_xlat7.y + 1.0;
    u_xlat16_15 = u_xlat16_15 + (-u_xlat16_11.x);
    u_xlat16_3.xy = u_xlat16_5.xy * u_xlat16_5.xy;
    u_xlat16_5.xy = (-u_xlat16_5.xy) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat16_5.xy = u_xlat16_5.xy * u_xlat16_3.xy;
    u_xlat16_15 = u_xlat16_5.x * u_xlat16_15 + u_xlat16_11.x;
    u_xlatb12.xy = greaterThanEqual(u_xlat16_1.xyxy, (-u_xlat16_1.xyxy)).xy;
    u_xlat16_1.xy = fract(abs(u_xlat16_1.xy));
    {
        vec2 hlslcc_movcTemp = u_xlat16_1;
        hlslcc_movcTemp.x = (u_xlatb12.x) ? u_xlat16_1.x : (-u_xlat16_1.x);
        hlslcc_movcTemp.y = (u_xlatb12.y) ? u_xlat16_1.y : (-u_xlat16_1.y);
        u_xlat16_1 = hlslcc_movcTemp;
    }
    u_xlat16_1.xy = u_xlat16_0.xx * u_xlat16_1.xy;
    u_xlat16_0.x = dot(u_xlat16_1.xy, vec2(12.0, 1.61800003));
    u_xlat16_0.x = sin(u_xlat16_0.x);
    u_xlat2.x = u_xlat16_0.x * u_xlat2.x;
    u_xlat2.x = fract(u_xlat2.x);
    u_xlat16_0.x = u_xlat2.x * u_xlat2.x;
    u_xlat16_0.x = u_xlat2.x * u_xlat16_0.x;
    u_xlat16_0.x = (-u_xlat16_0.x) * u_xlat2.x + 1.0;
    u_xlat16_1.x = u_xlat7.x * u_xlat7.x;
    u_xlat16_1.x = u_xlat7.x * u_xlat16_1.x;
    u_xlat16_1.x = (-u_xlat16_1.x) * u_xlat7.x + 1.0;
    u_xlat16_1.x = (-u_xlat16_0.x) + u_xlat16_1.x;
    u_xlat16_0.x = u_xlat16_5.x * u_xlat16_1.x + u_xlat16_0.x;
    u_xlat16_5.x = (-u_xlat16_0.x) + u_xlat16_15;
    u_xlat16_0.x = u_xlat16_5.y * u_xlat16_5.x + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_0.x * _TwinkleIntensity;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_5.x = u_xlat10_1.w * 1.5;
    u_xlat16_0.xyz = u_xlat16_5.xxx * u_xlat16_0.xxx + u_xlat10_1.xyz;
    u_xlat2.xyz = u_xlat16_0.xyz * vec3(vs_TEXCOORD1);
    SV_Target0.xyz = u_xlat2.xyz * _Color.xyz;
    SV_Target0.w = _Color.w;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _HorizonFade;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[3].y * in_POSITION0.w + u_xlat0.y;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.x = u_xlat1.x / _HorizonFade;
    u_xlat16_2 = sqrt(u_xlat1.x);
    u_xlat16_2 = min(u_xlat16_2, 1.0);
    vs_TEXCOORD1 = u_xlat16_2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec4 _Time;
uniform 	mediump vec4 _Color;
uniform 	int _Scale;
uniform 	float _TwinkleSpeed;
uniform 	mediump float _TwinkleIntensity;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
mediump vec3 u_xlat16_0;
mediump vec2 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
bvec2 u_xlatb2;
mediump vec4 u_xlat16_3;
bvec4 u_xlatb4;
mediump vec2 u_xlat16_5;
vec2 u_xlat7;
mediump vec2 u_xlat16_11;
bvec2 u_xlatb12;
mediump float u_xlat16_15;
void main()
{
    u_xlat16_0.x = float(_Scale);
    u_xlat16_5.xy = u_xlat16_0.xx * vs_TEXCOORD0.xy;
    u_xlat16_1.xy = floor(u_xlat16_5.xy);
    u_xlat16_5.xy = fract(u_xlat16_5.xy);
    u_xlat16_11.xy = u_xlat16_1.xy + vec2(1.0, 1.0);
    u_xlat16_11.xy = u_xlat16_11.xy / u_xlat16_0.xx;
    u_xlatb2.xy = greaterThanEqual(u_xlat16_11.xyxx, (-u_xlat16_11.xyxx)).xy;
    u_xlat16_11.xy = fract(abs(u_xlat16_11.xy));
    {
        vec2 hlslcc_movcTemp = u_xlat16_11;
        hlslcc_movcTemp.x = (u_xlatb2.x) ? u_xlat16_11.x : (-u_xlat16_11.x);
        hlslcc_movcTemp.y = (u_xlatb2.y) ? u_xlat16_11.y : (-u_xlat16_11.y);
        u_xlat16_11 = hlslcc_movcTemp;
    }
    u_xlat16_11.xy = u_xlat16_0.xx * u_xlat16_11.xy;
    u_xlat16_15 = dot(u_xlat16_11.xy, vec2(12.0, 1.61800003));
    u_xlat16_15 = sin(u_xlat16_15);
    u_xlat2.x = _Time.x * _TwinkleSpeed;
    u_xlat7.x = u_xlat16_15 * u_xlat2.x;
    u_xlat7.x = fract(u_xlat7.x);
    u_xlat16_15 = u_xlat7.x * u_xlat7.x;
    u_xlat16_15 = u_xlat7.x * u_xlat16_15;
    u_xlat16_15 = (-u_xlat16_15) * u_xlat7.x + 1.0;
    u_xlat16_3 = u_xlat16_1.xyxy + vec4(1.0, 0.0, 0.0, 1.0);
    u_xlat16_1.xy = u_xlat16_1.xy / u_xlat16_0.xx;
    u_xlat16_3 = u_xlat16_3 / u_xlat16_0.xxxx;
    u_xlatb4 = greaterThanEqual(u_xlat16_3, (-u_xlat16_3));
    u_xlat16_3 = fract(abs(u_xlat16_3));
    {
        vec4 hlslcc_movcTemp = u_xlat16_3;
        hlslcc_movcTemp.x = (u_xlatb4.x) ? u_xlat16_3.x : (-u_xlat16_3.x);
        hlslcc_movcTemp.y = (u_xlatb4.y) ? u_xlat16_3.y : (-u_xlat16_3.y);
        hlslcc_movcTemp.z = (u_xlatb4.z) ? u_xlat16_3.z : (-u_xlat16_3.z);
        hlslcc_movcTemp.w = (u_xlatb4.w) ? u_xlat16_3.w : (-u_xlat16_3.w);
        u_xlat16_3 = hlslcc_movcTemp;
    }
    u_xlat16_3 = u_xlat16_0.xxxx * u_xlat16_3;
    u_xlat16_11.x = dot(u_xlat16_3.zw, vec2(12.0, 1.61800003));
    u_xlat16_11.y = dot(u_xlat16_3.xy, vec2(12.0, 1.61800003));
    u_xlat16_11.xy = sin(u_xlat16_11.xy);
    u_xlat7.xy = u_xlat16_11.yx * u_xlat2.xx;
    u_xlat7.xy = fract(u_xlat7.xy);
    u_xlat16_11.x = u_xlat7.y * u_xlat7.y;
    u_xlat16_11.x = u_xlat7.y * u_xlat16_11.x;
    u_xlat16_11.x = (-u_xlat16_11.x) * u_xlat7.y + 1.0;
    u_xlat16_15 = u_xlat16_15 + (-u_xlat16_11.x);
    u_xlat16_3.xy = u_xlat16_5.xy * u_xlat16_5.xy;
    u_xlat16_5.xy = (-u_xlat16_5.xy) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat16_5.xy = u_xlat16_5.xy * u_xlat16_3.xy;
    u_xlat16_15 = u_xlat16_5.x * u_xlat16_15 + u_xlat16_11.x;
    u_xlatb12.xy = greaterThanEqual(u_xlat16_1.xyxy, (-u_xlat16_1.xyxy)).xy;
    u_xlat16_1.xy = fract(abs(u_xlat16_1.xy));
    {
        vec2 hlslcc_movcTemp = u_xlat16_1;
        hlslcc_movcTemp.x = (u_xlatb12.x) ? u_xlat16_1.x : (-u_xlat16_1.x);
        hlslcc_movcTemp.y = (u_xlatb12.y) ? u_xlat16_1.y : (-u_xlat16_1.y);
        u_xlat16_1 = hlslcc_movcTemp;
    }
    u_xlat16_1.xy = u_xlat16_0.xx * u_xlat16_1.xy;
    u_xlat16_0.x = dot(u_xlat16_1.xy, vec2(12.0, 1.61800003));
    u_xlat16_0.x = sin(u_xlat16_0.x);
    u_xlat2.x = u_xlat16_0.x * u_xlat2.x;
    u_xlat2.x = fract(u_xlat2.x);
    u_xlat16_0.x = u_xlat2.x * u_xlat2.x;
    u_xlat16_0.x = u_xlat2.x * u_xlat16_0.x;
    u_xlat16_0.x = (-u_xlat16_0.x) * u_xlat2.x + 1.0;
    u_xlat16_1.x = u_xlat7.x * u_xlat7.x;
    u_xlat16_1.x = u_xlat7.x * u_xlat16_1.x;
    u_xlat16_1.x = (-u_xlat16_1.x) * u_xlat7.x + 1.0;
    u_xlat16_1.x = (-u_xlat16_0.x) + u_xlat16_1.x;
    u_xlat16_0.x = u_xlat16_5.x * u_xlat16_1.x + u_xlat16_0.x;
    u_xlat16_5.x = (-u_xlat16_0.x) + u_xlat16_15;
    u_xlat16_0.x = u_xlat16_5.y * u_xlat16_5.x + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_0.x * _TwinkleIntensity;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_5.x = u_xlat10_1.w * 1.5;
    u_xlat16_0.xyz = u_xlat16_5.xxx * u_xlat16_0.xxx + u_xlat10_1.xyz;
    u_xlat2.xyz = u_xlat16_0.xyz * vec3(vs_TEXCOORD1);
    SV_Target0.xyz = u_xlat2.xyz * _Color.xyz;
    SV_Target0.w = _Color.w;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _HorizonFade;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[3].y * in_POSITION0.w + u_xlat0.y;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.x = u_xlat1.x / _HorizonFade;
    u_xlat16_2 = sqrt(u_xlat1.x);
    u_xlat16_2 = min(u_xlat16_2, 1.0);
    vs_TEXCOORD1 = u_xlat16_2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec4 _Time;
uniform 	mediump vec4 _Color;
uniform 	int _Scale;
uniform 	float _TwinkleSpeed;
uniform 	mediump float _TwinkleIntensity;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp float vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
mediump vec3 u_xlat16_0;
mediump vec2 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
bvec2 u_xlatb2;
mediump vec4 u_xlat16_3;
bvec4 u_xlatb4;
mediump vec2 u_xlat16_5;
vec2 u_xlat7;
mediump vec2 u_xlat16_11;
bvec2 u_xlatb12;
mediump float u_xlat16_15;
void main()
{
    u_xlat16_0.x = float(_Scale);
    u_xlat16_5.xy = u_xlat16_0.xx * vs_TEXCOORD0.xy;
    u_xlat16_1.xy = floor(u_xlat16_5.xy);
    u_xlat16_5.xy = fract(u_xlat16_5.xy);
    u_xlat16_11.xy = u_xlat16_1.xy + vec2(1.0, 1.0);
    u_xlat16_11.xy = u_xlat16_11.xy / u_xlat16_0.xx;
    u_xlatb2.xy = greaterThanEqual(u_xlat16_11.xyxx, (-u_xlat16_11.xyxx)).xy;
    u_xlat16_11.xy = fract(abs(u_xlat16_11.xy));
    {
        vec2 hlslcc_movcTemp = u_xlat16_11;
        hlslcc_movcTemp.x = (u_xlatb2.x) ? u_xlat16_11.x : (-u_xlat16_11.x);
        hlslcc_movcTemp.y = (u_xlatb2.y) ? u_xlat16_11.y : (-u_xlat16_11.y);
        u_xlat16_11 = hlslcc_movcTemp;
    }
    u_xlat16_11.xy = u_xlat16_0.xx * u_xlat16_11.xy;
    u_xlat16_15 = dot(u_xlat16_11.xy, vec2(12.0, 1.61800003));
    u_xlat16_15 = sin(u_xlat16_15);
    u_xlat2.x = _Time.x * _TwinkleSpeed;
    u_xlat7.x = u_xlat16_15 * u_xlat2.x;
    u_xlat7.x = fract(u_xlat7.x);
    u_xlat16_15 = u_xlat7.x * u_xlat7.x;
    u_xlat16_15 = u_xlat7.x * u_xlat16_15;
    u_xlat16_15 = (-u_xlat16_15) * u_xlat7.x + 1.0;
    u_xlat16_3 = u_xlat16_1.xyxy + vec4(1.0, 0.0, 0.0, 1.0);
    u_xlat16_1.xy = u_xlat16_1.xy / u_xlat16_0.xx;
    u_xlat16_3 = u_xlat16_3 / u_xlat16_0.xxxx;
    u_xlatb4 = greaterThanEqual(u_xlat16_3, (-u_xlat16_3));
    u_xlat16_3 = fract(abs(u_xlat16_3));
    {
        vec4 hlslcc_movcTemp = u_xlat16_3;
        hlslcc_movcTemp.x = (u_xlatb4.x) ? u_xlat16_3.x : (-u_xlat16_3.x);
        hlslcc_movcTemp.y = (u_xlatb4.y) ? u_xlat16_3.y : (-u_xlat16_3.y);
        hlslcc_movcTemp.z = (u_xlatb4.z) ? u_xlat16_3.z : (-u_xlat16_3.z);
        hlslcc_movcTemp.w = (u_xlatb4.w) ? u_xlat16_3.w : (-u_xlat16_3.w);
        u_xlat16_3 = hlslcc_movcTemp;
    }
    u_xlat16_3 = u_xlat16_0.xxxx * u_xlat16_3;
    u_xlat16_11.x = dot(u_xlat16_3.zw, vec2(12.0, 1.61800003));
    u_xlat16_11.y = dot(u_xlat16_3.xy, vec2(12.0, 1.61800003));
    u_xlat16_11.xy = sin(u_xlat16_11.xy);
    u_xlat7.xy = u_xlat16_11.yx * u_xlat2.xx;
    u_xlat7.xy = fract(u_xlat7.xy);
    u_xlat16_11.x = u_xlat7.y * u_xlat7.y;
    u_xlat16_11.x = u_xlat7.y * u_xlat16_11.x;
    u_xlat16_11.x = (-u_xlat16_11.x) * u_xlat7.y + 1.0;
    u_xlat16_15 = u_xlat16_15 + (-u_xlat16_11.x);
    u_xlat16_3.xy = u_xlat16_5.xy * u_xlat16_5.xy;
    u_xlat16_5.xy = (-u_xlat16_5.xy) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat16_5.xy = u_xlat16_5.xy * u_xlat16_3.xy;
    u_xlat16_15 = u_xlat16_5.x * u_xlat16_15 + u_xlat16_11.x;
    u_xlatb12.xy = greaterThanEqual(u_xlat16_1.xyxy, (-u_xlat16_1.xyxy)).xy;
    u_xlat16_1.xy = fract(abs(u_xlat16_1.xy));
    {
        vec2 hlslcc_movcTemp = u_xlat16_1;
        hlslcc_movcTemp.x = (u_xlatb12.x) ? u_xlat16_1.x : (-u_xlat16_1.x);
        hlslcc_movcTemp.y = (u_xlatb12.y) ? u_xlat16_1.y : (-u_xlat16_1.y);
        u_xlat16_1 = hlslcc_movcTemp;
    }
    u_xlat16_1.xy = u_xlat16_0.xx * u_xlat16_1.xy;
    u_xlat16_0.x = dot(u_xlat16_1.xy, vec2(12.0, 1.61800003));
    u_xlat16_0.x = sin(u_xlat16_0.x);
    u_xlat2.x = u_xlat16_0.x * u_xlat2.x;
    u_xlat2.x = fract(u_xlat2.x);
    u_xlat16_0.x = u_xlat2.x * u_xlat2.x;
    u_xlat16_0.x = u_xlat2.x * u_xlat16_0.x;
    u_xlat16_0.x = (-u_xlat16_0.x) * u_xlat2.x + 1.0;
    u_xlat16_1.x = u_xlat7.x * u_xlat7.x;
    u_xlat16_1.x = u_xlat7.x * u_xlat16_1.x;
    u_xlat16_1.x = (-u_xlat16_1.x) * u_xlat7.x + 1.0;
    u_xlat16_1.x = (-u_xlat16_0.x) + u_xlat16_1.x;
    u_xlat16_0.x = u_xlat16_5.x * u_xlat16_1.x + u_xlat16_0.x;
    u_xlat16_5.x = (-u_xlat16_0.x) + u_xlat16_15;
    u_xlat16_0.x = u_xlat16_5.y * u_xlat16_5.x + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_0.x * _TwinkleIntensity;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_5.x = u_xlat10_1.w * 1.5;
    u_xlat16_0.xyz = u_xlat16_5.xxx * u_xlat16_0.xxx + u_xlat10_1.xyz;
    u_xlat2.xyz = u_xlat16_0.xyz * vec3(vs_TEXCOORD1);
    SV_Target0.xyz = u_xlat2.xyz * _Color.xyz;
    SV_Target0.w = _Color.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _HorizonFade;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[3].y * in_POSITION0.w + u_xlat0.y;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.x = u_xlat1.x / _HorizonFade;
    u_xlat16_2 = sqrt(u_xlat1.x);
    u_xlat16_2 = min(u_xlat16_2, 1.0);
    vs_TEXCOORD1 = u_xlat16_2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	mediump vec4 _Color;
uniform 	int _Scale;
uniform 	float _TwinkleSpeed;
uniform 	mediump float _TwinkleIntensity;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
bvec2 u_xlatb2;
mediump vec4 u_xlat16_3;
bvec4 u_xlatb4;
mediump vec2 u_xlat16_5;
vec2 u_xlat7;
mediump vec2 u_xlat16_11;
bvec2 u_xlatb12;
mediump float u_xlat16_15;
void main()
{
    u_xlat16_0.x = float(_Scale);
    u_xlat16_5.xy = u_xlat16_0.xx * vs_TEXCOORD0.xy;
    u_xlat16_1.xy = floor(u_xlat16_5.xy);
    u_xlat16_5.xy = fract(u_xlat16_5.xy);
    u_xlat16_11.xy = u_xlat16_1.xy + vec2(1.0, 1.0);
    u_xlat16_11.xy = u_xlat16_11.xy / u_xlat16_0.xx;
    u_xlatb2.xy = greaterThanEqual(u_xlat16_11.xyxx, (-u_xlat16_11.xyxx)).xy;
    u_xlat16_11.xy = fract(abs(u_xlat16_11.xy));
    {
        vec2 hlslcc_movcTemp = u_xlat16_11;
        hlslcc_movcTemp.x = (u_xlatb2.x) ? u_xlat16_11.x : (-u_xlat16_11.x);
        hlslcc_movcTemp.y = (u_xlatb2.y) ? u_xlat16_11.y : (-u_xlat16_11.y);
        u_xlat16_11 = hlslcc_movcTemp;
    }
    u_xlat16_11.xy = u_xlat16_0.xx * u_xlat16_11.xy;
    u_xlat16_15 = dot(u_xlat16_11.xy, vec2(12.0, 1.61800003));
    u_xlat16_15 = sin(u_xlat16_15);
    u_xlat2.x = _Time.x * _TwinkleSpeed;
    u_xlat7.x = u_xlat16_15 * u_xlat2.x;
    u_xlat7.x = fract(u_xlat7.x);
    u_xlat16_15 = u_xlat7.x * u_xlat7.x;
    u_xlat16_15 = u_xlat7.x * u_xlat16_15;
    u_xlat16_15 = (-u_xlat16_15) * u_xlat7.x + 1.0;
    u_xlat16_3 = u_xlat16_1.xyxy + vec4(1.0, 0.0, 0.0, 1.0);
    u_xlat16_1.xy = u_xlat16_1.xy / u_xlat16_0.xx;
    u_xlat16_3 = u_xlat16_3 / u_xlat16_0.xxxx;
    u_xlatb4 = greaterThanEqual(u_xlat16_3, (-u_xlat16_3));
    u_xlat16_3 = fract(abs(u_xlat16_3));
    {
        vec4 hlslcc_movcTemp = u_xlat16_3;
        hlslcc_movcTemp.x = (u_xlatb4.x) ? u_xlat16_3.x : (-u_xlat16_3.x);
        hlslcc_movcTemp.y = (u_xlatb4.y) ? u_xlat16_3.y : (-u_xlat16_3.y);
        hlslcc_movcTemp.z = (u_xlatb4.z) ? u_xlat16_3.z : (-u_xlat16_3.z);
        hlslcc_movcTemp.w = (u_xlatb4.w) ? u_xlat16_3.w : (-u_xlat16_3.w);
        u_xlat16_3 = hlslcc_movcTemp;
    }
    u_xlat16_3 = u_xlat16_0.xxxx * u_xlat16_3;
    u_xlat16_11.x = dot(u_xlat16_3.zw, vec2(12.0, 1.61800003));
    u_xlat16_11.y = dot(u_xlat16_3.xy, vec2(12.0, 1.61800003));
    u_xlat16_11.xy = sin(u_xlat16_11.xy);
    u_xlat7.xy = u_xlat16_11.yx * u_xlat2.xx;
    u_xlat7.xy = fract(u_xlat7.xy);
    u_xlat16_11.x = u_xlat7.y * u_xlat7.y;
    u_xlat16_11.x = u_xlat7.y * u_xlat16_11.x;
    u_xlat16_11.x = (-u_xlat16_11.x) * u_xlat7.y + 1.0;
    u_xlat16_15 = u_xlat16_15 + (-u_xlat16_11.x);
    u_xlat16_3.xy = u_xlat16_5.xy * u_xlat16_5.xy;
    u_xlat16_5.xy = (-u_xlat16_5.xy) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat16_5.xy = u_xlat16_5.xy * u_xlat16_3.xy;
    u_xlat16_15 = u_xlat16_5.x * u_xlat16_15 + u_xlat16_11.x;
    u_xlatb12.xy = greaterThanEqual(u_xlat16_1.xyxy, (-u_xlat16_1.xyxy)).xy;
    u_xlat16_1.xy = fract(abs(u_xlat16_1.xy));
    {
        vec4 hlslcc_movcTemp = u_xlat16_1;
        hlslcc_movcTemp.x = (u_xlatb12.x) ? u_xlat16_1.x : (-u_xlat16_1.x);
        hlslcc_movcTemp.y = (u_xlatb12.y) ? u_xlat16_1.y : (-u_xlat16_1.y);
        u_xlat16_1 = hlslcc_movcTemp;
    }
    u_xlat16_1.xy = u_xlat16_0.xx * u_xlat16_1.xy;
    u_xlat16_0.x = dot(u_xlat16_1.xy, vec2(12.0, 1.61800003));
    u_xlat16_0.x = sin(u_xlat16_0.x);
    u_xlat2.x = u_xlat16_0.x * u_xlat2.x;
    u_xlat2.x = fract(u_xlat2.x);
    u_xlat16_0.x = u_xlat2.x * u_xlat2.x;
    u_xlat16_0.x = u_xlat2.x * u_xlat16_0.x;
    u_xlat16_0.x = (-u_xlat16_0.x) * u_xlat2.x + 1.0;
    u_xlat16_1.x = u_xlat7.x * u_xlat7.x;
    u_xlat16_1.x = u_xlat7.x * u_xlat16_1.x;
    u_xlat16_1.x = (-u_xlat16_1.x) * u_xlat7.x + 1.0;
    u_xlat16_1.x = (-u_xlat16_0.x) + u_xlat16_1.x;
    u_xlat16_0.x = u_xlat16_5.x * u_xlat16_1.x + u_xlat16_0.x;
    u_xlat16_5.x = (-u_xlat16_0.x) + u_xlat16_15;
    u_xlat16_0.x = u_xlat16_5.y * u_xlat16_5.x + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_0.x * _TwinkleIntensity;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_5.x = u_xlat16_1.w * 1.5;
    u_xlat16_0.xyz = u_xlat16_5.xxx * u_xlat16_0.xxx + u_xlat16_1.xyz;
    u_xlat2.xyz = u_xlat16_0.xyz * vec3(vs_TEXCOORD1);
    SV_Target0.xyz = u_xlat2.xyz * _Color.xyz;
    SV_Target0.w = _Color.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _HorizonFade;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[3].y * in_POSITION0.w + u_xlat0.y;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.x = u_xlat1.x / _HorizonFade;
    u_xlat16_2 = sqrt(u_xlat1.x);
    u_xlat16_2 = min(u_xlat16_2, 1.0);
    vs_TEXCOORD1 = u_xlat16_2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	mediump vec4 _Color;
uniform 	int _Scale;
uniform 	float _TwinkleSpeed;
uniform 	mediump float _TwinkleIntensity;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
bvec2 u_xlatb2;
mediump vec4 u_xlat16_3;
bvec4 u_xlatb4;
mediump vec2 u_xlat16_5;
vec2 u_xlat7;
mediump vec2 u_xlat16_11;
bvec2 u_xlatb12;
mediump float u_xlat16_15;
void main()
{
    u_xlat16_0.x = float(_Scale);
    u_xlat16_5.xy = u_xlat16_0.xx * vs_TEXCOORD0.xy;
    u_xlat16_1.xy = floor(u_xlat16_5.xy);
    u_xlat16_5.xy = fract(u_xlat16_5.xy);
    u_xlat16_11.xy = u_xlat16_1.xy + vec2(1.0, 1.0);
    u_xlat16_11.xy = u_xlat16_11.xy / u_xlat16_0.xx;
    u_xlatb2.xy = greaterThanEqual(u_xlat16_11.xyxx, (-u_xlat16_11.xyxx)).xy;
    u_xlat16_11.xy = fract(abs(u_xlat16_11.xy));
    {
        vec2 hlslcc_movcTemp = u_xlat16_11;
        hlslcc_movcTemp.x = (u_xlatb2.x) ? u_xlat16_11.x : (-u_xlat16_11.x);
        hlslcc_movcTemp.y = (u_xlatb2.y) ? u_xlat16_11.y : (-u_xlat16_11.y);
        u_xlat16_11 = hlslcc_movcTemp;
    }
    u_xlat16_11.xy = u_xlat16_0.xx * u_xlat16_11.xy;
    u_xlat16_15 = dot(u_xlat16_11.xy, vec2(12.0, 1.61800003));
    u_xlat16_15 = sin(u_xlat16_15);
    u_xlat2.x = _Time.x * _TwinkleSpeed;
    u_xlat7.x = u_xlat16_15 * u_xlat2.x;
    u_xlat7.x = fract(u_xlat7.x);
    u_xlat16_15 = u_xlat7.x * u_xlat7.x;
    u_xlat16_15 = u_xlat7.x * u_xlat16_15;
    u_xlat16_15 = (-u_xlat16_15) * u_xlat7.x + 1.0;
    u_xlat16_3 = u_xlat16_1.xyxy + vec4(1.0, 0.0, 0.0, 1.0);
    u_xlat16_1.xy = u_xlat16_1.xy / u_xlat16_0.xx;
    u_xlat16_3 = u_xlat16_3 / u_xlat16_0.xxxx;
    u_xlatb4 = greaterThanEqual(u_xlat16_3, (-u_xlat16_3));
    u_xlat16_3 = fract(abs(u_xlat16_3));
    {
        vec4 hlslcc_movcTemp = u_xlat16_3;
        hlslcc_movcTemp.x = (u_xlatb4.x) ? u_xlat16_3.x : (-u_xlat16_3.x);
        hlslcc_movcTemp.y = (u_xlatb4.y) ? u_xlat16_3.y : (-u_xlat16_3.y);
        hlslcc_movcTemp.z = (u_xlatb4.z) ? u_xlat16_3.z : (-u_xlat16_3.z);
        hlslcc_movcTemp.w = (u_xlatb4.w) ? u_xlat16_3.w : (-u_xlat16_3.w);
        u_xlat16_3 = hlslcc_movcTemp;
    }
    u_xlat16_3 = u_xlat16_0.xxxx * u_xlat16_3;
    u_xlat16_11.x = dot(u_xlat16_3.zw, vec2(12.0, 1.61800003));
    u_xlat16_11.y = dot(u_xlat16_3.xy, vec2(12.0, 1.61800003));
    u_xlat16_11.xy = sin(u_xlat16_11.xy);
    u_xlat7.xy = u_xlat16_11.yx * u_xlat2.xx;
    u_xlat7.xy = fract(u_xlat7.xy);
    u_xlat16_11.x = u_xlat7.y * u_xlat7.y;
    u_xlat16_11.x = u_xlat7.y * u_xlat16_11.x;
    u_xlat16_11.x = (-u_xlat16_11.x) * u_xlat7.y + 1.0;
    u_xlat16_15 = u_xlat16_15 + (-u_xlat16_11.x);
    u_xlat16_3.xy = u_xlat16_5.xy * u_xlat16_5.xy;
    u_xlat16_5.xy = (-u_xlat16_5.xy) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat16_5.xy = u_xlat16_5.xy * u_xlat16_3.xy;
    u_xlat16_15 = u_xlat16_5.x * u_xlat16_15 + u_xlat16_11.x;
    u_xlatb12.xy = greaterThanEqual(u_xlat16_1.xyxy, (-u_xlat16_1.xyxy)).xy;
    u_xlat16_1.xy = fract(abs(u_xlat16_1.xy));
    {
        vec4 hlslcc_movcTemp = u_xlat16_1;
        hlslcc_movcTemp.x = (u_xlatb12.x) ? u_xlat16_1.x : (-u_xlat16_1.x);
        hlslcc_movcTemp.y = (u_xlatb12.y) ? u_xlat16_1.y : (-u_xlat16_1.y);
        u_xlat16_1 = hlslcc_movcTemp;
    }
    u_xlat16_1.xy = u_xlat16_0.xx * u_xlat16_1.xy;
    u_xlat16_0.x = dot(u_xlat16_1.xy, vec2(12.0, 1.61800003));
    u_xlat16_0.x = sin(u_xlat16_0.x);
    u_xlat2.x = u_xlat16_0.x * u_xlat2.x;
    u_xlat2.x = fract(u_xlat2.x);
    u_xlat16_0.x = u_xlat2.x * u_xlat2.x;
    u_xlat16_0.x = u_xlat2.x * u_xlat16_0.x;
    u_xlat16_0.x = (-u_xlat16_0.x) * u_xlat2.x + 1.0;
    u_xlat16_1.x = u_xlat7.x * u_xlat7.x;
    u_xlat16_1.x = u_xlat7.x * u_xlat16_1.x;
    u_xlat16_1.x = (-u_xlat16_1.x) * u_xlat7.x + 1.0;
    u_xlat16_1.x = (-u_xlat16_0.x) + u_xlat16_1.x;
    u_xlat16_0.x = u_xlat16_5.x * u_xlat16_1.x + u_xlat16_0.x;
    u_xlat16_5.x = (-u_xlat16_0.x) + u_xlat16_15;
    u_xlat16_0.x = u_xlat16_5.y * u_xlat16_5.x + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_0.x * _TwinkleIntensity;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_5.x = u_xlat16_1.w * 1.5;
    u_xlat16_0.xyz = u_xlat16_5.xxx * u_xlat16_0.xxx + u_xlat16_1.xyz;
    u_xlat2.xyz = u_xlat16_0.xyz * vec3(vs_TEXCOORD1);
    SV_Target0.xyz = u_xlat2.xyz * _Color.xyz;
    SV_Target0.w = _Color.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _HorizonFade;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp float vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[3].y * in_POSITION0.w + u_xlat0.y;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.x = u_xlat1.x / _HorizonFade;
    u_xlat16_2 = sqrt(u_xlat1.x);
    u_xlat16_2 = min(u_xlat16_2, 1.0);
    vs_TEXCOORD1 = u_xlat16_2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	mediump vec4 _Color;
uniform 	int _Scale;
uniform 	float _TwinkleSpeed;
uniform 	mediump float _TwinkleIntensity;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp float vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
bvec2 u_xlatb2;
mediump vec4 u_xlat16_3;
bvec4 u_xlatb4;
mediump vec2 u_xlat16_5;
vec2 u_xlat7;
mediump vec2 u_xlat16_11;
bvec2 u_xlatb12;
mediump float u_xlat16_15;
void main()
{
    u_xlat16_0.x = float(_Scale);
    u_xlat16_5.xy = u_xlat16_0.xx * vs_TEXCOORD0.xy;
    u_xlat16_1.xy = floor(u_xlat16_5.xy);
    u_xlat16_5.xy = fract(u_xlat16_5.xy);
    u_xlat16_11.xy = u_xlat16_1.xy + vec2(1.0, 1.0);
    u_xlat16_11.xy = u_xlat16_11.xy / u_xlat16_0.xx;
    u_xlatb2.xy = greaterThanEqual(u_xlat16_11.xyxx, (-u_xlat16_11.xyxx)).xy;
    u_xlat16_11.xy = fract(abs(u_xlat16_11.xy));
    {
        vec2 hlslcc_movcTemp = u_xlat16_11;
        hlslcc_movcTemp.x = (u_xlatb2.x) ? u_xlat16_11.x : (-u_xlat16_11.x);
        hlslcc_movcTemp.y = (u_xlatb2.y) ? u_xlat16_11.y : (-u_xlat16_11.y);
        u_xlat16_11 = hlslcc_movcTemp;
    }
    u_xlat16_11.xy = u_xlat16_0.xx * u_xlat16_11.xy;
    u_xlat16_15 = dot(u_xlat16_11.xy, vec2(12.0, 1.61800003));
    u_xlat16_15 = sin(u_xlat16_15);
    u_xlat2.x = _Time.x * _TwinkleSpeed;
    u_xlat7.x = u_xlat16_15 * u_xlat2.x;
    u_xlat7.x = fract(u_xlat7.x);
    u_xlat16_15 = u_xlat7.x * u_xlat7.x;
    u_xlat16_15 = u_xlat7.x * u_xlat16_15;
    u_xlat16_15 = (-u_xlat16_15) * u_xlat7.x + 1.0;
    u_xlat16_3 = u_xlat16_1.xyxy + vec4(1.0, 0.0, 0.0, 1.0);
    u_xlat16_1.xy = u_xlat16_1.xy / u_xlat16_0.xx;
    u_xlat16_3 = u_xlat16_3 / u_xlat16_0.xxxx;
    u_xlatb4 = greaterThanEqual(u_xlat16_3, (-u_xlat16_3));
    u_xlat16_3 = fract(abs(u_xlat16_3));
    {
        vec4 hlslcc_movcTemp = u_xlat16_3;
        hlslcc_movcTemp.x = (u_xlatb4.x) ? u_xlat16_3.x : (-u_xlat16_3.x);
        hlslcc_movcTemp.y = (u_xlatb4.y) ? u_xlat16_3.y : (-u_xlat16_3.y);
        hlslcc_movcTemp.z = (u_xlatb4.z) ? u_xlat16_3.z : (-u_xlat16_3.z);
        hlslcc_movcTemp.w = (u_xlatb4.w) ? u_xlat16_3.w : (-u_xlat16_3.w);
        u_xlat16_3 = hlslcc_movcTemp;
    }
    u_xlat16_3 = u_xlat16_0.xxxx * u_xlat16_3;
    u_xlat16_11.x = dot(u_xlat16_3.zw, vec2(12.0, 1.61800003));
    u_xlat16_11.y = dot(u_xlat16_3.xy, vec2(12.0, 1.61800003));
    u_xlat16_11.xy = sin(u_xlat16_11.xy);
    u_xlat7.xy = u_xlat16_11.yx * u_xlat2.xx;
    u_xlat7.xy = fract(u_xlat7.xy);
    u_xlat16_11.x = u_xlat7.y * u_xlat7.y;
    u_xlat16_11.x = u_xlat7.y * u_xlat16_11.x;
    u_xlat16_11.x = (-u_xlat16_11.x) * u_xlat7.y + 1.0;
    u_xlat16_15 = u_xlat16_15 + (-u_xlat16_11.x);
    u_xlat16_3.xy = u_xlat16_5.xy * u_xlat16_5.xy;
    u_xlat16_5.xy = (-u_xlat16_5.xy) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
    u_xlat16_5.xy = u_xlat16_5.xy * u_xlat16_3.xy;
    u_xlat16_15 = u_xlat16_5.x * u_xlat16_15 + u_xlat16_11.x;
    u_xlatb12.xy = greaterThanEqual(u_xlat16_1.xyxy, (-u_xlat16_1.xyxy)).xy;
    u_xlat16_1.xy = fract(abs(u_xlat16_1.xy));
    {
        vec4 hlslcc_movcTemp = u_xlat16_1;
        hlslcc_movcTemp.x = (u_xlatb12.x) ? u_xlat16_1.x : (-u_xlat16_1.x);
        hlslcc_movcTemp.y = (u_xlatb12.y) ? u_xlat16_1.y : (-u_xlat16_1.y);
        u_xlat16_1 = hlslcc_movcTemp;
    }
    u_xlat16_1.xy = u_xlat16_0.xx * u_xlat16_1.xy;
    u_xlat16_0.x = dot(u_xlat16_1.xy, vec2(12.0, 1.61800003));
    u_xlat16_0.x = sin(u_xlat16_0.x);
    u_xlat2.x = u_xlat16_0.x * u_xlat2.x;
    u_xlat2.x = fract(u_xlat2.x);
    u_xlat16_0.x = u_xlat2.x * u_xlat2.x;
    u_xlat16_0.x = u_xlat2.x * u_xlat16_0.x;
    u_xlat16_0.x = (-u_xlat16_0.x) * u_xlat2.x + 1.0;
    u_xlat16_1.x = u_xlat7.x * u_xlat7.x;
    u_xlat16_1.x = u_xlat7.x * u_xlat16_1.x;
    u_xlat16_1.x = (-u_xlat16_1.x) * u_xlat7.x + 1.0;
    u_xlat16_1.x = (-u_xlat16_0.x) + u_xlat16_1.x;
    u_xlat16_0.x = u_xlat16_5.x * u_xlat16_1.x + u_xlat16_0.x;
    u_xlat16_5.x = (-u_xlat16_0.x) + u_xlat16_15;
    u_xlat16_0.x = u_xlat16_5.y * u_xlat16_5.x + u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_0.x * _TwinkleIntensity;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_5.x = u_xlat16_1.w * 1.5;
    u_xlat16_0.xyz = u_xlat16_5.xxx * u_xlat16_0.xxx + u_xlat16_1.xyz;
    u_xlat2.xyz = u_xlat16_0.xyz * vec3(vs_TEXCOORD1);
    SV_Target0.xyz = u_xlat2.xyz * _Color.xyz;
    SV_Target0.w = _Color.w;
    return;
}

#endif
"
}
}
}
}
}