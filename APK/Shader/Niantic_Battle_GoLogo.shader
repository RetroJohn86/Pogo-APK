//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Niantic/Battle/GoLogo" {
Properties {
_MainTex ("Sprite Texture", 2D) = "white" { }
_Color ("Tint", Color) = (1,1,1,1)
_StencilComp ("Stencil Comparison", Float) = 8
_Stencil ("Stencil ID", Float) = 0
_StencilOp ("Stencil Operation", Float) = 0
_StencilWriteMask ("Stencil Write Mask", Float) = 255
_StencilReadMask ("Stencil Read Mask", Float) = 255
_ColorMask ("Color Mask", Float) = 15
_OutlineColor ("Outline Color", Color) = (1,1,1,1)
_GradientColor1 ("Gradient Color 1", Color) = (1,1,1,1)
_GradientColor2 ("Gradient Color 2", Color) = (1,1,1,1)
_GradientScale ("Gradient Scale", Float) = 2
_GradientOffset ("Gradient Offset", Float) = 0.5
_ShadowColor ("Shadow Color", Color) = (1,1,1,1)
_ShadowDistance ("Shadow Distance", Float) = 0.01
_InnerThreshold ("Inner Threshold", Float) = 0.59
_CenterThreshold ("Center Threshold", Float) = 0.5
_OuterThreshold ("Outer Threshold", Float) = 0.3
_StripeColor ("Stripe Color", Color) = (1,1,1,1)
_StripeOffset ("Stripe Offset", Float) = 0
_StripeWidth ("Stripe Width", Float) = 0.5
_Blur ("Blur", Range(0.001, 1)) = 0
[Toggle(UNITY_UI_ALPHACLIP)] _UseUIAlphaClip ("Use Alpha Clip", Float) = 0
}
SubShader {
 Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Name "Default"
  Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
  ColorMask 0 0
  ZTest Off
  ZWrite Off
  Cull Off
  Stencil {
   ReadMask 0
   WriteMask 0
   Comp Disabled
   Pass Keep
   Fail Keep
   ZFail Keep
  }
  GpuProgramID 18769
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
    return;
}

#endif
#ifdef FRAGMENT
#version 100
#ifdef GL_OES_standard_derivatives
#extension GL_OES_standard_derivatives : enable
#endif

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	mediump vec4 _OutlineColor;
uniform 	mediump vec4 _GradientColor1;
uniform 	mediump vec4 _GradientColor2;
uniform 	mediump vec4 _StripeColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump float _GradientScale;
uniform 	mediump float _GradientOffset;
uniform 	mediump float _StripeOffset;
uniform 	mediump float _StripeWidth;
uniform 	mediump float _ShadowDistance;
uniform 	mediump float _InnerThreshold;
uniform 	mediump float _CenterThreshold;
uniform 	mediump float _OuterThreshold;
uniform 	mediump float _Blur;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat4;
mediump float u_xlat16_5;
mediump float u_xlat16_9;
mediump float u_xlat16_13;
void main()
{
    u_xlat0.x = vs_TEXCOORD0.x + vs_TEXCOORD0.y;
    u_xlat0.x = u_xlat0.x + _StripeOffset;
    u_xlatb0 = _StripeWidth>=abs(u_xlat0.x);
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat4 = vs_TEXCOORD0.y * _GradientScale + (-_GradientOffset);
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
    u_xlat16_1.xyz = _GradientColor1.xyz + (-_GradientColor2.xyz);
    u_xlat16_1.xyz = vec3(u_xlat4) * u_xlat16_1.xyz + _GradientColor2.xyz;
    u_xlat16_1.xyz = _StripeColor.xyz * u_xlat0.xxx + u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz + (-_OutlineColor.xyz);
    u_xlat0.x = texture2D(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat16_13 = dFdx(u_xlat0.x);
    u_xlat16_2.x = dFdy(u_xlat0.x);
    u_xlat16_13 = abs(u_xlat16_13) + abs(u_xlat16_2.x);
    u_xlat16_2.x = (-u_xlat16_13) + 1.0;
    u_xlat16_13 = _Blur * u_xlat16_2.x + u_xlat16_13;
    u_xlat16_2.xyz = (-vec3(_InnerThreshold, _CenterThreshold, _OuterThreshold)) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = vec3(_Blur) * u_xlat16_2.xyz + vec3(_InnerThreshold, _CenterThreshold, _OuterThreshold);
    u_xlat16_2.xy = (-u_xlat0.xx) + u_xlat16_2.xy;
    u_xlat16_2.xy = clamp(u_xlat16_2.xy, 0.0, 1.0);
    u_xlat16_2.xy = u_xlat16_2.yx / vec2(u_xlat16_13);
    u_xlat16_13 = (-u_xlat16_2.y) + 1.0;
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
    u_xlat16_2.x = u_xlat16_2.x;
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat16_1.xyz = vec3(u_xlat16_13) * u_xlat16_1.xyz + _OutlineColor.xyz;
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) + _ShadowColor.xyz;
    SV_Target0.xyz = u_xlat16_2.xxx * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat0.x = vs_TEXCOORD0.x;
    u_xlat0.y = vs_TEXCOORD0.y + _ShadowDistance;
    u_xlat0.x = texture2D(_MainTex, u_xlat0.xy).x;
    u_xlat16_1.x = dFdx(u_xlat0.x);
    u_xlat16_5 = dFdy(u_xlat0.x);
    u_xlat16_9 = (-u_xlat0.x) + u_xlat16_2.z;
    u_xlat16_9 = clamp(u_xlat16_9, 0.0, 1.0);
    u_xlat16_1.x = abs(u_xlat16_5) + abs(u_xlat16_1.x);
    u_xlat16_5 = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = _Blur * u_xlat16_5 + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_9 / u_xlat16_1.x;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
    SV_Target0.w = u_xlat16_1.x * vs_COLOR0.w;
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
uniform 	mediump vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
    return;
}

#endif
#ifdef FRAGMENT
#version 100
#ifdef GL_OES_standard_derivatives
#extension GL_OES_standard_derivatives : enable
#endif

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	mediump vec4 _OutlineColor;
uniform 	mediump vec4 _GradientColor1;
uniform 	mediump vec4 _GradientColor2;
uniform 	mediump vec4 _StripeColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump float _GradientScale;
uniform 	mediump float _GradientOffset;
uniform 	mediump float _StripeOffset;
uniform 	mediump float _StripeWidth;
uniform 	mediump float _ShadowDistance;
uniform 	mediump float _InnerThreshold;
uniform 	mediump float _CenterThreshold;
uniform 	mediump float _OuterThreshold;
uniform 	mediump float _Blur;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat4;
mediump float u_xlat16_5;
mediump float u_xlat16_9;
mediump float u_xlat16_13;
void main()
{
    u_xlat0.x = vs_TEXCOORD0.x + vs_TEXCOORD0.y;
    u_xlat0.x = u_xlat0.x + _StripeOffset;
    u_xlatb0 = _StripeWidth>=abs(u_xlat0.x);
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat4 = vs_TEXCOORD0.y * _GradientScale + (-_GradientOffset);
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
    u_xlat16_1.xyz = _GradientColor1.xyz + (-_GradientColor2.xyz);
    u_xlat16_1.xyz = vec3(u_xlat4) * u_xlat16_1.xyz + _GradientColor2.xyz;
    u_xlat16_1.xyz = _StripeColor.xyz * u_xlat0.xxx + u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz + (-_OutlineColor.xyz);
    u_xlat0.x = texture2D(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat16_13 = dFdx(u_xlat0.x);
    u_xlat16_2.x = dFdy(u_xlat0.x);
    u_xlat16_13 = abs(u_xlat16_13) + abs(u_xlat16_2.x);
    u_xlat16_2.x = (-u_xlat16_13) + 1.0;
    u_xlat16_13 = _Blur * u_xlat16_2.x + u_xlat16_13;
    u_xlat16_2.xyz = (-vec3(_InnerThreshold, _CenterThreshold, _OuterThreshold)) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = vec3(_Blur) * u_xlat16_2.xyz + vec3(_InnerThreshold, _CenterThreshold, _OuterThreshold);
    u_xlat16_2.xy = (-u_xlat0.xx) + u_xlat16_2.xy;
    u_xlat16_2.xy = clamp(u_xlat16_2.xy, 0.0, 1.0);
    u_xlat16_2.xy = u_xlat16_2.yx / vec2(u_xlat16_13);
    u_xlat16_13 = (-u_xlat16_2.y) + 1.0;
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
    u_xlat16_2.x = u_xlat16_2.x;
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat16_1.xyz = vec3(u_xlat16_13) * u_xlat16_1.xyz + _OutlineColor.xyz;
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) + _ShadowColor.xyz;
    SV_Target0.xyz = u_xlat16_2.xxx * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat0.x = vs_TEXCOORD0.x;
    u_xlat0.y = vs_TEXCOORD0.y + _ShadowDistance;
    u_xlat0.x = texture2D(_MainTex, u_xlat0.xy).x;
    u_xlat16_1.x = dFdx(u_xlat0.x);
    u_xlat16_5 = dFdy(u_xlat0.x);
    u_xlat16_9 = (-u_xlat0.x) + u_xlat16_2.z;
    u_xlat16_9 = clamp(u_xlat16_9, 0.0, 1.0);
    u_xlat16_1.x = abs(u_xlat16_5) + abs(u_xlat16_1.x);
    u_xlat16_5 = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = _Blur * u_xlat16_5 + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_9 / u_xlat16_1.x;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
    SV_Target0.w = u_xlat16_1.x * vs_COLOR0.w;
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
uniform 	mediump vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
    return;
}

#endif
#ifdef FRAGMENT
#version 100
#ifdef GL_OES_standard_derivatives
#extension GL_OES_standard_derivatives : enable
#endif

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	mediump vec4 _OutlineColor;
uniform 	mediump vec4 _GradientColor1;
uniform 	mediump vec4 _GradientColor2;
uniform 	mediump vec4 _StripeColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump float _GradientScale;
uniform 	mediump float _GradientOffset;
uniform 	mediump float _StripeOffset;
uniform 	mediump float _StripeWidth;
uniform 	mediump float _ShadowDistance;
uniform 	mediump float _InnerThreshold;
uniform 	mediump float _CenterThreshold;
uniform 	mediump float _OuterThreshold;
uniform 	mediump float _Blur;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat4;
mediump float u_xlat16_5;
mediump float u_xlat16_9;
mediump float u_xlat16_13;
void main()
{
    u_xlat0.x = vs_TEXCOORD0.x + vs_TEXCOORD0.y;
    u_xlat0.x = u_xlat0.x + _StripeOffset;
    u_xlatb0 = _StripeWidth>=abs(u_xlat0.x);
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat4 = vs_TEXCOORD0.y * _GradientScale + (-_GradientOffset);
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
    u_xlat16_1.xyz = _GradientColor1.xyz + (-_GradientColor2.xyz);
    u_xlat16_1.xyz = vec3(u_xlat4) * u_xlat16_1.xyz + _GradientColor2.xyz;
    u_xlat16_1.xyz = _StripeColor.xyz * u_xlat0.xxx + u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz + (-_OutlineColor.xyz);
    u_xlat0.x = texture2D(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat16_13 = dFdx(u_xlat0.x);
    u_xlat16_2.x = dFdy(u_xlat0.x);
    u_xlat16_13 = abs(u_xlat16_13) + abs(u_xlat16_2.x);
    u_xlat16_2.x = (-u_xlat16_13) + 1.0;
    u_xlat16_13 = _Blur * u_xlat16_2.x + u_xlat16_13;
    u_xlat16_2.xyz = (-vec3(_InnerThreshold, _CenterThreshold, _OuterThreshold)) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = vec3(_Blur) * u_xlat16_2.xyz + vec3(_InnerThreshold, _CenterThreshold, _OuterThreshold);
    u_xlat16_2.xy = (-u_xlat0.xx) + u_xlat16_2.xy;
    u_xlat16_2.xy = clamp(u_xlat16_2.xy, 0.0, 1.0);
    u_xlat16_2.xy = u_xlat16_2.yx / vec2(u_xlat16_13);
    u_xlat16_13 = (-u_xlat16_2.y) + 1.0;
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
    u_xlat16_2.x = u_xlat16_2.x;
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat16_1.xyz = vec3(u_xlat16_13) * u_xlat16_1.xyz + _OutlineColor.xyz;
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) + _ShadowColor.xyz;
    SV_Target0.xyz = u_xlat16_2.xxx * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat0.x = vs_TEXCOORD0.x;
    u_xlat0.y = vs_TEXCOORD0.y + _ShadowDistance;
    u_xlat0.x = texture2D(_MainTex, u_xlat0.xy).x;
    u_xlat16_1.x = dFdx(u_xlat0.x);
    u_xlat16_5 = dFdy(u_xlat0.x);
    u_xlat16_9 = (-u_xlat0.x) + u_xlat16_2.z;
    u_xlat16_9 = clamp(u_xlat16_9, 0.0, 1.0);
    u_xlat16_1.x = abs(u_xlat16_5) + abs(u_xlat16_1.x);
    u_xlat16_5 = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = _Blur * u_xlat16_5 + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_9 / u_xlat16_1.x;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
    SV_Target0.w = u_xlat16_1.x * vs_COLOR0.w;
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
uniform 	mediump vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
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
uniform 	mediump vec4 _OutlineColor;
uniform 	mediump vec4 _GradientColor1;
uniform 	mediump vec4 _GradientColor2;
uniform 	mediump vec4 _StripeColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump float _GradientScale;
uniform 	mediump float _GradientOffset;
uniform 	mediump float _StripeOffset;
uniform 	mediump float _StripeWidth;
uniform 	mediump float _ShadowDistance;
uniform 	mediump float _InnerThreshold;
uniform 	mediump float _CenterThreshold;
uniform 	mediump float _OuterThreshold;
uniform 	mediump float _Blur;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat4;
mediump float u_xlat16_5;
mediump float u_xlat16_9;
mediump float u_xlat16_13;
void main()
{
    u_xlat0.x = vs_TEXCOORD0.x + vs_TEXCOORD0.y;
    u_xlat0.x = u_xlat0.x + _StripeOffset;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_StripeWidth>=abs(u_xlat0.x));
#else
    u_xlatb0 = _StripeWidth>=abs(u_xlat0.x);
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat4 = vs_TEXCOORD0.y * _GradientScale + (-_GradientOffset);
#ifdef UNITY_ADRENO_ES3
    u_xlat4 = min(max(u_xlat4, 0.0), 1.0);
#else
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = _GradientColor1.xyz + (-_GradientColor2.xyz);
    u_xlat16_1.xyz = vec3(u_xlat4) * u_xlat16_1.xyz + _GradientColor2.xyz;
    u_xlat16_1.xyz = _StripeColor.xyz * u_xlat0.xxx + u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz + (-_OutlineColor.xyz);
    u_xlat0.x = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat16_13 = dFdx(u_xlat0.x);
    u_xlat16_2.x = dFdy(u_xlat0.x);
    u_xlat16_13 = abs(u_xlat16_13) + abs(u_xlat16_2.x);
    u_xlat16_2.x = (-u_xlat16_13) + 1.0;
    u_xlat16_13 = _Blur * u_xlat16_2.x + u_xlat16_13;
    u_xlat16_2.xyz = (-vec3(_InnerThreshold, _CenterThreshold, _OuterThreshold)) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = vec3(_Blur) * u_xlat16_2.xyz + vec3(_InnerThreshold, _CenterThreshold, _OuterThreshold);
    u_xlat16_2.xy = (-u_xlat0.xx) + u_xlat16_2.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.xy = min(max(u_xlat16_2.xy, 0.0), 1.0);
#else
    u_xlat16_2.xy = clamp(u_xlat16_2.xy, 0.0, 1.0);
#endif
    u_xlat16_2.xy = u_xlat16_2.yx / vec2(u_xlat16_13);
    u_xlat16_13 = (-u_xlat16_2.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    u_xlat16_2.x = u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = vec3(u_xlat16_13) * u_xlat16_1.xyz + _OutlineColor.xyz;
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) + _ShadowColor.xyz;
    SV_Target0.xyz = u_xlat16_2.xxx * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat0.x = vs_TEXCOORD0.x;
    u_xlat0.y = vs_TEXCOORD0.y + _ShadowDistance;
    u_xlat0.x = texture(_MainTex, u_xlat0.xy).x;
    u_xlat16_1.x = dFdx(u_xlat0.x);
    u_xlat16_5 = dFdy(u_xlat0.x);
    u_xlat16_9 = (-u_xlat0.x) + u_xlat16_2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_9 = min(max(u_xlat16_9, 0.0), 1.0);
#else
    u_xlat16_9 = clamp(u_xlat16_9, 0.0, 1.0);
#endif
    u_xlat16_1.x = abs(u_xlat16_5) + abs(u_xlat16_1.x);
    u_xlat16_5 = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = _Blur * u_xlat16_5 + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_9 / u_xlat16_1.x;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat16_1.x * vs_COLOR0.w;
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
uniform 	mediump vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
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
uniform 	mediump vec4 _OutlineColor;
uniform 	mediump vec4 _GradientColor1;
uniform 	mediump vec4 _GradientColor2;
uniform 	mediump vec4 _StripeColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump float _GradientScale;
uniform 	mediump float _GradientOffset;
uniform 	mediump float _StripeOffset;
uniform 	mediump float _StripeWidth;
uniform 	mediump float _ShadowDistance;
uniform 	mediump float _InnerThreshold;
uniform 	mediump float _CenterThreshold;
uniform 	mediump float _OuterThreshold;
uniform 	mediump float _Blur;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat4;
mediump float u_xlat16_5;
mediump float u_xlat16_9;
mediump float u_xlat16_13;
void main()
{
    u_xlat0.x = vs_TEXCOORD0.x + vs_TEXCOORD0.y;
    u_xlat0.x = u_xlat0.x + _StripeOffset;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_StripeWidth>=abs(u_xlat0.x));
#else
    u_xlatb0 = _StripeWidth>=abs(u_xlat0.x);
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat4 = vs_TEXCOORD0.y * _GradientScale + (-_GradientOffset);
#ifdef UNITY_ADRENO_ES3
    u_xlat4 = min(max(u_xlat4, 0.0), 1.0);
#else
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = _GradientColor1.xyz + (-_GradientColor2.xyz);
    u_xlat16_1.xyz = vec3(u_xlat4) * u_xlat16_1.xyz + _GradientColor2.xyz;
    u_xlat16_1.xyz = _StripeColor.xyz * u_xlat0.xxx + u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz + (-_OutlineColor.xyz);
    u_xlat0.x = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat16_13 = dFdx(u_xlat0.x);
    u_xlat16_2.x = dFdy(u_xlat0.x);
    u_xlat16_13 = abs(u_xlat16_13) + abs(u_xlat16_2.x);
    u_xlat16_2.x = (-u_xlat16_13) + 1.0;
    u_xlat16_13 = _Blur * u_xlat16_2.x + u_xlat16_13;
    u_xlat16_2.xyz = (-vec3(_InnerThreshold, _CenterThreshold, _OuterThreshold)) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = vec3(_Blur) * u_xlat16_2.xyz + vec3(_InnerThreshold, _CenterThreshold, _OuterThreshold);
    u_xlat16_2.xy = (-u_xlat0.xx) + u_xlat16_2.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.xy = min(max(u_xlat16_2.xy, 0.0), 1.0);
#else
    u_xlat16_2.xy = clamp(u_xlat16_2.xy, 0.0, 1.0);
#endif
    u_xlat16_2.xy = u_xlat16_2.yx / vec2(u_xlat16_13);
    u_xlat16_13 = (-u_xlat16_2.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    u_xlat16_2.x = u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = vec3(u_xlat16_13) * u_xlat16_1.xyz + _OutlineColor.xyz;
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) + _ShadowColor.xyz;
    SV_Target0.xyz = u_xlat16_2.xxx * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat0.x = vs_TEXCOORD0.x;
    u_xlat0.y = vs_TEXCOORD0.y + _ShadowDistance;
    u_xlat0.x = texture(_MainTex, u_xlat0.xy).x;
    u_xlat16_1.x = dFdx(u_xlat0.x);
    u_xlat16_5 = dFdy(u_xlat0.x);
    u_xlat16_9 = (-u_xlat0.x) + u_xlat16_2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_9 = min(max(u_xlat16_9, 0.0), 1.0);
#else
    u_xlat16_9 = clamp(u_xlat16_9, 0.0, 1.0);
#endif
    u_xlat16_1.x = abs(u_xlat16_5) + abs(u_xlat16_1.x);
    u_xlat16_5 = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = _Blur * u_xlat16_5 + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_9 / u_xlat16_1.x;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat16_1.x * vs_COLOR0.w;
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
uniform 	mediump vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
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
uniform 	mediump vec4 _OutlineColor;
uniform 	mediump vec4 _GradientColor1;
uniform 	mediump vec4 _GradientColor2;
uniform 	mediump vec4 _StripeColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump float _GradientScale;
uniform 	mediump float _GradientOffset;
uniform 	mediump float _StripeOffset;
uniform 	mediump float _StripeWidth;
uniform 	mediump float _ShadowDistance;
uniform 	mediump float _InnerThreshold;
uniform 	mediump float _CenterThreshold;
uniform 	mediump float _OuterThreshold;
uniform 	mediump float _Blur;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
bool u_xlatb0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat4;
mediump float u_xlat16_5;
mediump float u_xlat16_9;
mediump float u_xlat16_13;
void main()
{
    u_xlat0.x = vs_TEXCOORD0.x + vs_TEXCOORD0.y;
    u_xlat0.x = u_xlat0.x + _StripeOffset;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_StripeWidth>=abs(u_xlat0.x));
#else
    u_xlatb0 = _StripeWidth>=abs(u_xlat0.x);
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat4 = vs_TEXCOORD0.y * _GradientScale + (-_GradientOffset);
#ifdef UNITY_ADRENO_ES3
    u_xlat4 = min(max(u_xlat4, 0.0), 1.0);
#else
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = _GradientColor1.xyz + (-_GradientColor2.xyz);
    u_xlat16_1.xyz = vec3(u_xlat4) * u_xlat16_1.xyz + _GradientColor2.xyz;
    u_xlat16_1.xyz = _StripeColor.xyz * u_xlat0.xxx + u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz + (-_OutlineColor.xyz);
    u_xlat0.x = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat16_13 = dFdx(u_xlat0.x);
    u_xlat16_2.x = dFdy(u_xlat0.x);
    u_xlat16_13 = abs(u_xlat16_13) + abs(u_xlat16_2.x);
    u_xlat16_2.x = (-u_xlat16_13) + 1.0;
    u_xlat16_13 = _Blur * u_xlat16_2.x + u_xlat16_13;
    u_xlat16_2.xyz = (-vec3(_InnerThreshold, _CenterThreshold, _OuterThreshold)) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = vec3(_Blur) * u_xlat16_2.xyz + vec3(_InnerThreshold, _CenterThreshold, _OuterThreshold);
    u_xlat16_2.xy = (-u_xlat0.xx) + u_xlat16_2.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.xy = min(max(u_xlat16_2.xy, 0.0), 1.0);
#else
    u_xlat16_2.xy = clamp(u_xlat16_2.xy, 0.0, 1.0);
#endif
    u_xlat16_2.xy = u_xlat16_2.yx / vec2(u_xlat16_13);
    u_xlat16_13 = (-u_xlat16_2.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    u_xlat16_2.x = u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = vec3(u_xlat16_13) * u_xlat16_1.xyz + _OutlineColor.xyz;
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) + _ShadowColor.xyz;
    SV_Target0.xyz = u_xlat16_2.xxx * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat0.x = vs_TEXCOORD0.x;
    u_xlat0.y = vs_TEXCOORD0.y + _ShadowDistance;
    u_xlat0.x = texture(_MainTex, u_xlat0.xy).x;
    u_xlat16_1.x = dFdx(u_xlat0.x);
    u_xlat16_5 = dFdy(u_xlat0.x);
    u_xlat16_9 = (-u_xlat0.x) + u_xlat16_2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_9 = min(max(u_xlat16_9, 0.0), 1.0);
#else
    u_xlat16_9 = clamp(u_xlat16_9, 0.0, 1.0);
#endif
    u_xlat16_1.x = abs(u_xlat16_5) + abs(u_xlat16_1.x);
    u_xlat16_5 = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = _Blur * u_xlat16_5 + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_9 / u_xlat16_1.x;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat16_1.x * vs_COLOR0.w;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "UNITY_UI_ALPHACLIP" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
    return;
}

#endif
#ifdef FRAGMENT
#version 100
#ifdef GL_OES_standard_derivatives
#extension GL_OES_standard_derivatives : enable
#endif

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	mediump vec4 _OutlineColor;
uniform 	mediump vec4 _GradientColor1;
uniform 	mediump vec4 _GradientColor2;
uniform 	mediump vec4 _StripeColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump float _GradientScale;
uniform 	mediump float _GradientOffset;
uniform 	mediump float _StripeOffset;
uniform 	mediump float _StripeWidth;
uniform 	mediump float _ShadowDistance;
uniform 	mediump float _InnerThreshold;
uniform 	mediump float _CenterThreshold;
uniform 	mediump float _OuterThreshold;
uniform 	mediump float _Blur;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
bool u_xlatb0;
mediump vec2 u_xlat16_1;
mediump vec3 u_xlat16_2;
float u_xlat3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_10;
void main()
{
    u_xlat0.x = vs_TEXCOORD0.x;
    u_xlat0.y = vs_TEXCOORD0.y + _ShadowDistance;
    u_xlat0.x = texture2D(_MainTex, u_xlat0.xy).x;
    u_xlat16_1.x = dFdx(u_xlat0.x);
    u_xlat16_4.x = dFdy(u_xlat0.x);
    u_xlat16_1.x = abs(u_xlat16_4.x) + abs(u_xlat16_1.x);
    u_xlat16_4.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = _Blur * u_xlat16_4.x + u_xlat16_1.x;
    u_xlat16_4.xyz = (-vec3(_InnerThreshold, _CenterThreshold, _OuterThreshold)) + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = vec3(_Blur) * u_xlat16_4.xyz + vec3(_InnerThreshold, _CenterThreshold, _OuterThreshold);
    u_xlat16_10 = (-u_xlat0.x) + u_xlat16_4.z;
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
    u_xlat16_1.x = u_xlat16_10 / u_xlat16_1.x;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
    u_xlat16_10 = u_xlat16_1.x * vs_COLOR0.w + -0.00100000005;
    u_xlat16_1.x = u_xlat16_1.x * vs_COLOR0.w;
    SV_Target0.w = u_xlat16_1.x;
    u_xlatb0 = u_xlat16_10<0.0;
    if(u_xlatb0){discard;}
    u_xlat0.x = texture2D(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat16_1.x = dFdx(u_xlat0.x);
    u_xlat16_10 = dFdy(u_xlat0.x);
    u_xlat16_4.xy = (-u_xlat0.xx) + u_xlat16_4.xy;
    u_xlat16_4.xy = clamp(u_xlat16_4.xy, 0.0, 1.0);
    u_xlat16_1.x = abs(u_xlat16_10) + abs(u_xlat16_1.x);
    u_xlat16_10 = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = _Blur * u_xlat16_10 + u_xlat16_1.x;
    u_xlat16_1.xy = u_xlat16_4.yx / u_xlat16_1.xx;
    u_xlat16_1.x = u_xlat16_1.x;
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
    u_xlat16_4.x = (-u_xlat16_1.y) + 1.0;
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
    u_xlat0.x = vs_TEXCOORD0.x + vs_TEXCOORD0.y;
    u_xlat0.x = u_xlat0.x + _StripeOffset;
    u_xlatb0 = _StripeWidth>=abs(u_xlat0.x);
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat3 = vs_TEXCOORD0.y * _GradientScale + (-_GradientOffset);
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
    u_xlat16_2.xyz = _GradientColor1.xyz + (-_GradientColor2.xyz);
    u_xlat16_2.xyz = vec3(u_xlat3) * u_xlat16_2.xyz + _GradientColor2.xyz;
    u_xlat16_2.xyz = _StripeColor.xyz * u_xlat0.xxx + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz + (-_OutlineColor.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xxx * u_xlat16_2.xyz + _OutlineColor.xyz;
    u_xlat16_2.xyz = (-u_xlat16_4.xyz) + _ShadowColor.xyz;
    SV_Target0.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + u_xlat16_4.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "UNITY_UI_ALPHACLIP" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
    return;
}

#endif
#ifdef FRAGMENT
#version 100
#ifdef GL_OES_standard_derivatives
#extension GL_OES_standard_derivatives : enable
#endif

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	mediump vec4 _OutlineColor;
uniform 	mediump vec4 _GradientColor1;
uniform 	mediump vec4 _GradientColor2;
uniform 	mediump vec4 _StripeColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump float _GradientScale;
uniform 	mediump float _GradientOffset;
uniform 	mediump float _StripeOffset;
uniform 	mediump float _StripeWidth;
uniform 	mediump float _ShadowDistance;
uniform 	mediump float _InnerThreshold;
uniform 	mediump float _CenterThreshold;
uniform 	mediump float _OuterThreshold;
uniform 	mediump float _Blur;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
bool u_xlatb0;
mediump vec2 u_xlat16_1;
mediump vec3 u_xlat16_2;
float u_xlat3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_10;
void main()
{
    u_xlat0.x = vs_TEXCOORD0.x;
    u_xlat0.y = vs_TEXCOORD0.y + _ShadowDistance;
    u_xlat0.x = texture2D(_MainTex, u_xlat0.xy).x;
    u_xlat16_1.x = dFdx(u_xlat0.x);
    u_xlat16_4.x = dFdy(u_xlat0.x);
    u_xlat16_1.x = abs(u_xlat16_4.x) + abs(u_xlat16_1.x);
    u_xlat16_4.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = _Blur * u_xlat16_4.x + u_xlat16_1.x;
    u_xlat16_4.xyz = (-vec3(_InnerThreshold, _CenterThreshold, _OuterThreshold)) + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = vec3(_Blur) * u_xlat16_4.xyz + vec3(_InnerThreshold, _CenterThreshold, _OuterThreshold);
    u_xlat16_10 = (-u_xlat0.x) + u_xlat16_4.z;
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
    u_xlat16_1.x = u_xlat16_10 / u_xlat16_1.x;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
    u_xlat16_10 = u_xlat16_1.x * vs_COLOR0.w + -0.00100000005;
    u_xlat16_1.x = u_xlat16_1.x * vs_COLOR0.w;
    SV_Target0.w = u_xlat16_1.x;
    u_xlatb0 = u_xlat16_10<0.0;
    if(u_xlatb0){discard;}
    u_xlat0.x = texture2D(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat16_1.x = dFdx(u_xlat0.x);
    u_xlat16_10 = dFdy(u_xlat0.x);
    u_xlat16_4.xy = (-u_xlat0.xx) + u_xlat16_4.xy;
    u_xlat16_4.xy = clamp(u_xlat16_4.xy, 0.0, 1.0);
    u_xlat16_1.x = abs(u_xlat16_10) + abs(u_xlat16_1.x);
    u_xlat16_10 = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = _Blur * u_xlat16_10 + u_xlat16_1.x;
    u_xlat16_1.xy = u_xlat16_4.yx / u_xlat16_1.xx;
    u_xlat16_1.x = u_xlat16_1.x;
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
    u_xlat16_4.x = (-u_xlat16_1.y) + 1.0;
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
    u_xlat0.x = vs_TEXCOORD0.x + vs_TEXCOORD0.y;
    u_xlat0.x = u_xlat0.x + _StripeOffset;
    u_xlatb0 = _StripeWidth>=abs(u_xlat0.x);
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat3 = vs_TEXCOORD0.y * _GradientScale + (-_GradientOffset);
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
    u_xlat16_2.xyz = _GradientColor1.xyz + (-_GradientColor2.xyz);
    u_xlat16_2.xyz = vec3(u_xlat3) * u_xlat16_2.xyz + _GradientColor2.xyz;
    u_xlat16_2.xyz = _StripeColor.xyz * u_xlat0.xxx + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz + (-_OutlineColor.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xxx * u_xlat16_2.xyz + _OutlineColor.xyz;
    u_xlat16_2.xyz = (-u_xlat16_4.xyz) + _ShadowColor.xyz;
    SV_Target0.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + u_xlat16_4.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "UNITY_UI_ALPHACLIP" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
    return;
}

#endif
#ifdef FRAGMENT
#version 100
#ifdef GL_OES_standard_derivatives
#extension GL_OES_standard_derivatives : enable
#endif

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	mediump vec4 _OutlineColor;
uniform 	mediump vec4 _GradientColor1;
uniform 	mediump vec4 _GradientColor2;
uniform 	mediump vec4 _StripeColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump float _GradientScale;
uniform 	mediump float _GradientOffset;
uniform 	mediump float _StripeOffset;
uniform 	mediump float _StripeWidth;
uniform 	mediump float _ShadowDistance;
uniform 	mediump float _InnerThreshold;
uniform 	mediump float _CenterThreshold;
uniform 	mediump float _OuterThreshold;
uniform 	mediump float _Blur;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
bool u_xlatb0;
mediump vec2 u_xlat16_1;
mediump vec3 u_xlat16_2;
float u_xlat3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_10;
void main()
{
    u_xlat0.x = vs_TEXCOORD0.x;
    u_xlat0.y = vs_TEXCOORD0.y + _ShadowDistance;
    u_xlat0.x = texture2D(_MainTex, u_xlat0.xy).x;
    u_xlat16_1.x = dFdx(u_xlat0.x);
    u_xlat16_4.x = dFdy(u_xlat0.x);
    u_xlat16_1.x = abs(u_xlat16_4.x) + abs(u_xlat16_1.x);
    u_xlat16_4.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = _Blur * u_xlat16_4.x + u_xlat16_1.x;
    u_xlat16_4.xyz = (-vec3(_InnerThreshold, _CenterThreshold, _OuterThreshold)) + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = vec3(_Blur) * u_xlat16_4.xyz + vec3(_InnerThreshold, _CenterThreshold, _OuterThreshold);
    u_xlat16_10 = (-u_xlat0.x) + u_xlat16_4.z;
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
    u_xlat16_1.x = u_xlat16_10 / u_xlat16_1.x;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
    u_xlat16_10 = u_xlat16_1.x * vs_COLOR0.w + -0.00100000005;
    u_xlat16_1.x = u_xlat16_1.x * vs_COLOR0.w;
    SV_Target0.w = u_xlat16_1.x;
    u_xlatb0 = u_xlat16_10<0.0;
    if(u_xlatb0){discard;}
    u_xlat0.x = texture2D(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat16_1.x = dFdx(u_xlat0.x);
    u_xlat16_10 = dFdy(u_xlat0.x);
    u_xlat16_4.xy = (-u_xlat0.xx) + u_xlat16_4.xy;
    u_xlat16_4.xy = clamp(u_xlat16_4.xy, 0.0, 1.0);
    u_xlat16_1.x = abs(u_xlat16_10) + abs(u_xlat16_1.x);
    u_xlat16_10 = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = _Blur * u_xlat16_10 + u_xlat16_1.x;
    u_xlat16_1.xy = u_xlat16_4.yx / u_xlat16_1.xx;
    u_xlat16_1.x = u_xlat16_1.x;
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
    u_xlat16_4.x = (-u_xlat16_1.y) + 1.0;
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
    u_xlat0.x = vs_TEXCOORD0.x + vs_TEXCOORD0.y;
    u_xlat0.x = u_xlat0.x + _StripeOffset;
    u_xlatb0 = _StripeWidth>=abs(u_xlat0.x);
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat3 = vs_TEXCOORD0.y * _GradientScale + (-_GradientOffset);
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
    u_xlat16_2.xyz = _GradientColor1.xyz + (-_GradientColor2.xyz);
    u_xlat16_2.xyz = vec3(u_xlat3) * u_xlat16_2.xyz + _GradientColor2.xyz;
    u_xlat16_2.xyz = _StripeColor.xyz * u_xlat0.xxx + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz + (-_OutlineColor.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xxx * u_xlat16_2.xyz + _OutlineColor.xyz;
    u_xlat16_2.xyz = (-u_xlat16_4.xyz) + _ShadowColor.xyz;
    SV_Target0.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + u_xlat16_4.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "UNITY_UI_ALPHACLIP" }
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
uniform 	mediump vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
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
uniform 	mediump vec4 _OutlineColor;
uniform 	mediump vec4 _GradientColor1;
uniform 	mediump vec4 _GradientColor2;
uniform 	mediump vec4 _StripeColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump float _GradientScale;
uniform 	mediump float _GradientOffset;
uniform 	mediump float _StripeOffset;
uniform 	mediump float _StripeWidth;
uniform 	mediump float _ShadowDistance;
uniform 	mediump float _InnerThreshold;
uniform 	mediump float _CenterThreshold;
uniform 	mediump float _OuterThreshold;
uniform 	mediump float _Blur;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
bool u_xlatb0;
mediump vec2 u_xlat16_1;
mediump vec3 u_xlat16_2;
float u_xlat3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_10;
void main()
{
    u_xlat0.x = vs_TEXCOORD0.x;
    u_xlat0.y = vs_TEXCOORD0.y + _ShadowDistance;
    u_xlat0.x = texture(_MainTex, u_xlat0.xy).x;
    u_xlat16_1.x = dFdx(u_xlat0.x);
    u_xlat16_4.x = dFdy(u_xlat0.x);
    u_xlat16_1.x = abs(u_xlat16_4.x) + abs(u_xlat16_1.x);
    u_xlat16_4.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = _Blur * u_xlat16_4.x + u_xlat16_1.x;
    u_xlat16_4.xyz = (-vec3(_InnerThreshold, _CenterThreshold, _OuterThreshold)) + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = vec3(_Blur) * u_xlat16_4.xyz + vec3(_InnerThreshold, _CenterThreshold, _OuterThreshold);
    u_xlat16_10 = (-u_xlat0.x) + u_xlat16_4.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat16_10 / u_xlat16_1.x;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_10 = u_xlat16_1.x * vs_COLOR0.w + -0.00100000005;
    u_xlat16_1.x = u_xlat16_1.x * vs_COLOR0.w;
    SV_Target0.w = u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_10<0.0);
#else
    u_xlatb0 = u_xlat16_10<0.0;
#endif
    if(u_xlatb0){discard;}
    u_xlat0.x = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat16_1.x = dFdx(u_xlat0.x);
    u_xlat16_10 = dFdy(u_xlat0.x);
    u_xlat16_4.xy = (-u_xlat0.xx) + u_xlat16_4.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.xy = min(max(u_xlat16_4.xy, 0.0), 1.0);
#else
    u_xlat16_4.xy = clamp(u_xlat16_4.xy, 0.0, 1.0);
#endif
    u_xlat16_1.x = abs(u_xlat16_10) + abs(u_xlat16_1.x);
    u_xlat16_10 = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = _Blur * u_xlat16_10 + u_xlat16_1.x;
    u_xlat16_1.xy = u_xlat16_4.yx / u_xlat16_1.xx;
    u_xlat16_1.x = u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_4.x = (-u_xlat16_1.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat0.x = vs_TEXCOORD0.x + vs_TEXCOORD0.y;
    u_xlat0.x = u_xlat0.x + _StripeOffset;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_StripeWidth>=abs(u_xlat0.x));
#else
    u_xlatb0 = _StripeWidth>=abs(u_xlat0.x);
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat3 = vs_TEXCOORD0.y * _GradientScale + (-_GradientOffset);
#ifdef UNITY_ADRENO_ES3
    u_xlat3 = min(max(u_xlat3, 0.0), 1.0);
#else
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = _GradientColor1.xyz + (-_GradientColor2.xyz);
    u_xlat16_2.xyz = vec3(u_xlat3) * u_xlat16_2.xyz + _GradientColor2.xyz;
    u_xlat16_2.xyz = _StripeColor.xyz * u_xlat0.xxx + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz + (-_OutlineColor.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xxx * u_xlat16_2.xyz + _OutlineColor.xyz;
    u_xlat16_2.xyz = (-u_xlat16_4.xyz) + _ShadowColor.xyz;
    SV_Target0.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + u_xlat16_4.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "UNITY_UI_ALPHACLIP" }
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
uniform 	mediump vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
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
uniform 	mediump vec4 _OutlineColor;
uniform 	mediump vec4 _GradientColor1;
uniform 	mediump vec4 _GradientColor2;
uniform 	mediump vec4 _StripeColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump float _GradientScale;
uniform 	mediump float _GradientOffset;
uniform 	mediump float _StripeOffset;
uniform 	mediump float _StripeWidth;
uniform 	mediump float _ShadowDistance;
uniform 	mediump float _InnerThreshold;
uniform 	mediump float _CenterThreshold;
uniform 	mediump float _OuterThreshold;
uniform 	mediump float _Blur;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
bool u_xlatb0;
mediump vec2 u_xlat16_1;
mediump vec3 u_xlat16_2;
float u_xlat3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_10;
void main()
{
    u_xlat0.x = vs_TEXCOORD0.x;
    u_xlat0.y = vs_TEXCOORD0.y + _ShadowDistance;
    u_xlat0.x = texture(_MainTex, u_xlat0.xy).x;
    u_xlat16_1.x = dFdx(u_xlat0.x);
    u_xlat16_4.x = dFdy(u_xlat0.x);
    u_xlat16_1.x = abs(u_xlat16_4.x) + abs(u_xlat16_1.x);
    u_xlat16_4.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = _Blur * u_xlat16_4.x + u_xlat16_1.x;
    u_xlat16_4.xyz = (-vec3(_InnerThreshold, _CenterThreshold, _OuterThreshold)) + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = vec3(_Blur) * u_xlat16_4.xyz + vec3(_InnerThreshold, _CenterThreshold, _OuterThreshold);
    u_xlat16_10 = (-u_xlat0.x) + u_xlat16_4.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat16_10 / u_xlat16_1.x;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_10 = u_xlat16_1.x * vs_COLOR0.w + -0.00100000005;
    u_xlat16_1.x = u_xlat16_1.x * vs_COLOR0.w;
    SV_Target0.w = u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_10<0.0);
#else
    u_xlatb0 = u_xlat16_10<0.0;
#endif
    if(u_xlatb0){discard;}
    u_xlat0.x = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat16_1.x = dFdx(u_xlat0.x);
    u_xlat16_10 = dFdy(u_xlat0.x);
    u_xlat16_4.xy = (-u_xlat0.xx) + u_xlat16_4.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.xy = min(max(u_xlat16_4.xy, 0.0), 1.0);
#else
    u_xlat16_4.xy = clamp(u_xlat16_4.xy, 0.0, 1.0);
#endif
    u_xlat16_1.x = abs(u_xlat16_10) + abs(u_xlat16_1.x);
    u_xlat16_10 = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = _Blur * u_xlat16_10 + u_xlat16_1.x;
    u_xlat16_1.xy = u_xlat16_4.yx / u_xlat16_1.xx;
    u_xlat16_1.x = u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_4.x = (-u_xlat16_1.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat0.x = vs_TEXCOORD0.x + vs_TEXCOORD0.y;
    u_xlat0.x = u_xlat0.x + _StripeOffset;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_StripeWidth>=abs(u_xlat0.x));
#else
    u_xlatb0 = _StripeWidth>=abs(u_xlat0.x);
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat3 = vs_TEXCOORD0.y * _GradientScale + (-_GradientOffset);
#ifdef UNITY_ADRENO_ES3
    u_xlat3 = min(max(u_xlat3, 0.0), 1.0);
#else
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = _GradientColor1.xyz + (-_GradientColor2.xyz);
    u_xlat16_2.xyz = vec3(u_xlat3) * u_xlat16_2.xyz + _GradientColor2.xyz;
    u_xlat16_2.xyz = _StripeColor.xyz * u_xlat0.xxx + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz + (-_OutlineColor.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xxx * u_xlat16_2.xyz + _OutlineColor.xyz;
    u_xlat16_2.xyz = (-u_xlat16_4.xyz) + _ShadowColor.xyz;
    SV_Target0.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + u_xlat16_4.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "UNITY_UI_ALPHACLIP" }
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
uniform 	mediump vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
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
uniform 	mediump vec4 _OutlineColor;
uniform 	mediump vec4 _GradientColor1;
uniform 	mediump vec4 _GradientColor2;
uniform 	mediump vec4 _StripeColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump float _GradientScale;
uniform 	mediump float _GradientOffset;
uniform 	mediump float _StripeOffset;
uniform 	mediump float _StripeWidth;
uniform 	mediump float _ShadowDistance;
uniform 	mediump float _InnerThreshold;
uniform 	mediump float _CenterThreshold;
uniform 	mediump float _OuterThreshold;
uniform 	mediump float _Blur;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
bool u_xlatb0;
mediump vec2 u_xlat16_1;
mediump vec3 u_xlat16_2;
float u_xlat3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_10;
void main()
{
    u_xlat0.x = vs_TEXCOORD0.x;
    u_xlat0.y = vs_TEXCOORD0.y + _ShadowDistance;
    u_xlat0.x = texture(_MainTex, u_xlat0.xy).x;
    u_xlat16_1.x = dFdx(u_xlat0.x);
    u_xlat16_4.x = dFdy(u_xlat0.x);
    u_xlat16_1.x = abs(u_xlat16_4.x) + abs(u_xlat16_1.x);
    u_xlat16_4.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = _Blur * u_xlat16_4.x + u_xlat16_1.x;
    u_xlat16_4.xyz = (-vec3(_InnerThreshold, _CenterThreshold, _OuterThreshold)) + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = vec3(_Blur) * u_xlat16_4.xyz + vec3(_InnerThreshold, _CenterThreshold, _OuterThreshold);
    u_xlat16_10 = (-u_xlat0.x) + u_xlat16_4.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat16_10 / u_xlat16_1.x;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_10 = u_xlat16_1.x * vs_COLOR0.w + -0.00100000005;
    u_xlat16_1.x = u_xlat16_1.x * vs_COLOR0.w;
    SV_Target0.w = u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_10<0.0);
#else
    u_xlatb0 = u_xlat16_10<0.0;
#endif
    if(u_xlatb0){discard;}
    u_xlat0.x = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat16_1.x = dFdx(u_xlat0.x);
    u_xlat16_10 = dFdy(u_xlat0.x);
    u_xlat16_4.xy = (-u_xlat0.xx) + u_xlat16_4.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.xy = min(max(u_xlat16_4.xy, 0.0), 1.0);
#else
    u_xlat16_4.xy = clamp(u_xlat16_4.xy, 0.0, 1.0);
#endif
    u_xlat16_1.x = abs(u_xlat16_10) + abs(u_xlat16_1.x);
    u_xlat16_10 = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = _Blur * u_xlat16_10 + u_xlat16_1.x;
    u_xlat16_1.xy = u_xlat16_4.yx / u_xlat16_1.xx;
    u_xlat16_1.x = u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_4.x = (-u_xlat16_1.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat0.x = vs_TEXCOORD0.x + vs_TEXCOORD0.y;
    u_xlat0.x = u_xlat0.x + _StripeOffset;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_StripeWidth>=abs(u_xlat0.x));
#else
    u_xlatb0 = _StripeWidth>=abs(u_xlat0.x);
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat3 = vs_TEXCOORD0.y * _GradientScale + (-_GradientOffset);
#ifdef UNITY_ADRENO_ES3
    u_xlat3 = min(max(u_xlat3, 0.0), 1.0);
#else
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = _GradientColor1.xyz + (-_GradientColor2.xyz);
    u_xlat16_2.xyz = vec3(u_xlat3) * u_xlat16_2.xyz + _GradientColor2.xyz;
    u_xlat16_2.xyz = _StripeColor.xyz * u_xlat0.xxx + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz + (-_OutlineColor.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xxx * u_xlat16_2.xyz + _OutlineColor.xyz;
    u_xlat16_2.xyz = (-u_xlat16_4.xyz) + _ShadowColor.xyz;
    SV_Target0.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + u_xlat16_4.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "UNITY_UI_CLIP_RECT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
    return;
}

#endif
#ifdef FRAGMENT
#version 100
#ifdef GL_OES_standard_derivatives
#extension GL_OES_standard_derivatives : enable
#endif

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec4 _ClipRect;
uniform 	mediump vec4 _OutlineColor;
uniform 	mediump vec4 _GradientColor1;
uniform 	mediump vec4 _GradientColor2;
uniform 	mediump vec4 _StripeColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump float _GradientScale;
uniform 	mediump float _GradientOffset;
uniform 	mediump float _StripeOffset;
uniform 	mediump float _StripeWidth;
uniform 	mediump float _ShadowDistance;
uniform 	mediump float _InnerThreshold;
uniform 	mediump float _CenterThreshold;
uniform 	mediump float _OuterThreshold;
uniform 	mediump float _Blur;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
bvec4 u_xlatb0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat4;
mediump float u_xlat16_5;
mediump float u_xlat16_9;
mediump float u_xlat16_13;
void main()
{
    u_xlat0.x = vs_TEXCOORD0.x + vs_TEXCOORD0.y;
    u_xlat0.x = u_xlat0.x + _StripeOffset;
    u_xlatb0.x = _StripeWidth>=abs(u_xlat0.x);
    u_xlat0.x = u_xlatb0.x ? 1.0 : float(0.0);
    u_xlat4 = vs_TEXCOORD0.y * _GradientScale + (-_GradientOffset);
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
    u_xlat16_1.xyz = _GradientColor1.xyz + (-_GradientColor2.xyz);
    u_xlat16_1.xyz = vec3(u_xlat4) * u_xlat16_1.xyz + _GradientColor2.xyz;
    u_xlat16_1.xyz = _StripeColor.xyz * u_xlat0.xxx + u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz + (-_OutlineColor.xyz);
    u_xlat0.x = texture2D(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat16_13 = dFdx(u_xlat0.x);
    u_xlat16_2.x = dFdy(u_xlat0.x);
    u_xlat16_13 = abs(u_xlat16_13) + abs(u_xlat16_2.x);
    u_xlat16_2.x = (-u_xlat16_13) + 1.0;
    u_xlat16_13 = _Blur * u_xlat16_2.x + u_xlat16_13;
    u_xlat16_2.xyz = (-vec3(_InnerThreshold, _CenterThreshold, _OuterThreshold)) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = vec3(_Blur) * u_xlat16_2.xyz + vec3(_InnerThreshold, _CenterThreshold, _OuterThreshold);
    u_xlat16_2.xy = (-u_xlat0.xx) + u_xlat16_2.xy;
    u_xlat16_2.xy = clamp(u_xlat16_2.xy, 0.0, 1.0);
    u_xlat16_2.xy = u_xlat16_2.yx / vec2(u_xlat16_13);
    u_xlat16_13 = (-u_xlat16_2.y) + 1.0;
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
    u_xlat16_2.x = u_xlat16_2.x;
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat16_1.xyz = vec3(u_xlat16_13) * u_xlat16_1.xyz + _OutlineColor.xyz;
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) + _ShadowColor.xyz;
    SV_Target0.xyz = u_xlat16_2.xxx * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat0.x = vs_TEXCOORD0.x;
    u_xlat0.y = vs_TEXCOORD0.y + _ShadowDistance;
    u_xlat0.x = texture2D(_MainTex, u_xlat0.xy).x;
    u_xlat16_1.x = dFdx(u_xlat0.x);
    u_xlat16_5 = dFdy(u_xlat0.x);
    u_xlat16_9 = (-u_xlat0.x) + u_xlat16_2.z;
    u_xlat16_9 = clamp(u_xlat16_9, 0.0, 1.0);
    u_xlat16_1.x = abs(u_xlat16_5) + abs(u_xlat16_1.x);
    u_xlat16_5 = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = _Blur * u_xlat16_5 + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_9 / u_xlat16_1.x;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
    u_xlat16_1.x = u_xlat16_1.x * vs_COLOR0.w;
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
;
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_1.x;
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "UNITY_UI_CLIP_RECT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
    return;
}

#endif
#ifdef FRAGMENT
#version 100
#ifdef GL_OES_standard_derivatives
#extension GL_OES_standard_derivatives : enable
#endif

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec4 _ClipRect;
uniform 	mediump vec4 _OutlineColor;
uniform 	mediump vec4 _GradientColor1;
uniform 	mediump vec4 _GradientColor2;
uniform 	mediump vec4 _StripeColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump float _GradientScale;
uniform 	mediump float _GradientOffset;
uniform 	mediump float _StripeOffset;
uniform 	mediump float _StripeWidth;
uniform 	mediump float _ShadowDistance;
uniform 	mediump float _InnerThreshold;
uniform 	mediump float _CenterThreshold;
uniform 	mediump float _OuterThreshold;
uniform 	mediump float _Blur;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
bvec4 u_xlatb0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat4;
mediump float u_xlat16_5;
mediump float u_xlat16_9;
mediump float u_xlat16_13;
void main()
{
    u_xlat0.x = vs_TEXCOORD0.x + vs_TEXCOORD0.y;
    u_xlat0.x = u_xlat0.x + _StripeOffset;
    u_xlatb0.x = _StripeWidth>=abs(u_xlat0.x);
    u_xlat0.x = u_xlatb0.x ? 1.0 : float(0.0);
    u_xlat4 = vs_TEXCOORD0.y * _GradientScale + (-_GradientOffset);
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
    u_xlat16_1.xyz = _GradientColor1.xyz + (-_GradientColor2.xyz);
    u_xlat16_1.xyz = vec3(u_xlat4) * u_xlat16_1.xyz + _GradientColor2.xyz;
    u_xlat16_1.xyz = _StripeColor.xyz * u_xlat0.xxx + u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz + (-_OutlineColor.xyz);
    u_xlat0.x = texture2D(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat16_13 = dFdx(u_xlat0.x);
    u_xlat16_2.x = dFdy(u_xlat0.x);
    u_xlat16_13 = abs(u_xlat16_13) + abs(u_xlat16_2.x);
    u_xlat16_2.x = (-u_xlat16_13) + 1.0;
    u_xlat16_13 = _Blur * u_xlat16_2.x + u_xlat16_13;
    u_xlat16_2.xyz = (-vec3(_InnerThreshold, _CenterThreshold, _OuterThreshold)) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = vec3(_Blur) * u_xlat16_2.xyz + vec3(_InnerThreshold, _CenterThreshold, _OuterThreshold);
    u_xlat16_2.xy = (-u_xlat0.xx) + u_xlat16_2.xy;
    u_xlat16_2.xy = clamp(u_xlat16_2.xy, 0.0, 1.0);
    u_xlat16_2.xy = u_xlat16_2.yx / vec2(u_xlat16_13);
    u_xlat16_13 = (-u_xlat16_2.y) + 1.0;
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
    u_xlat16_2.x = u_xlat16_2.x;
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat16_1.xyz = vec3(u_xlat16_13) * u_xlat16_1.xyz + _OutlineColor.xyz;
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) + _ShadowColor.xyz;
    SV_Target0.xyz = u_xlat16_2.xxx * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat0.x = vs_TEXCOORD0.x;
    u_xlat0.y = vs_TEXCOORD0.y + _ShadowDistance;
    u_xlat0.x = texture2D(_MainTex, u_xlat0.xy).x;
    u_xlat16_1.x = dFdx(u_xlat0.x);
    u_xlat16_5 = dFdy(u_xlat0.x);
    u_xlat16_9 = (-u_xlat0.x) + u_xlat16_2.z;
    u_xlat16_9 = clamp(u_xlat16_9, 0.0, 1.0);
    u_xlat16_1.x = abs(u_xlat16_5) + abs(u_xlat16_1.x);
    u_xlat16_5 = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = _Blur * u_xlat16_5 + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_9 / u_xlat16_1.x;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
    u_xlat16_1.x = u_xlat16_1.x * vs_COLOR0.w;
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
;
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_1.x;
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "UNITY_UI_CLIP_RECT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
    return;
}

#endif
#ifdef FRAGMENT
#version 100
#ifdef GL_OES_standard_derivatives
#extension GL_OES_standard_derivatives : enable
#endif

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec4 _ClipRect;
uniform 	mediump vec4 _OutlineColor;
uniform 	mediump vec4 _GradientColor1;
uniform 	mediump vec4 _GradientColor2;
uniform 	mediump vec4 _StripeColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump float _GradientScale;
uniform 	mediump float _GradientOffset;
uniform 	mediump float _StripeOffset;
uniform 	mediump float _StripeWidth;
uniform 	mediump float _ShadowDistance;
uniform 	mediump float _InnerThreshold;
uniform 	mediump float _CenterThreshold;
uniform 	mediump float _OuterThreshold;
uniform 	mediump float _Blur;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
bvec4 u_xlatb0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat4;
mediump float u_xlat16_5;
mediump float u_xlat16_9;
mediump float u_xlat16_13;
void main()
{
    u_xlat0.x = vs_TEXCOORD0.x + vs_TEXCOORD0.y;
    u_xlat0.x = u_xlat0.x + _StripeOffset;
    u_xlatb0.x = _StripeWidth>=abs(u_xlat0.x);
    u_xlat0.x = u_xlatb0.x ? 1.0 : float(0.0);
    u_xlat4 = vs_TEXCOORD0.y * _GradientScale + (-_GradientOffset);
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
    u_xlat16_1.xyz = _GradientColor1.xyz + (-_GradientColor2.xyz);
    u_xlat16_1.xyz = vec3(u_xlat4) * u_xlat16_1.xyz + _GradientColor2.xyz;
    u_xlat16_1.xyz = _StripeColor.xyz * u_xlat0.xxx + u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz + (-_OutlineColor.xyz);
    u_xlat0.x = texture2D(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat16_13 = dFdx(u_xlat0.x);
    u_xlat16_2.x = dFdy(u_xlat0.x);
    u_xlat16_13 = abs(u_xlat16_13) + abs(u_xlat16_2.x);
    u_xlat16_2.x = (-u_xlat16_13) + 1.0;
    u_xlat16_13 = _Blur * u_xlat16_2.x + u_xlat16_13;
    u_xlat16_2.xyz = (-vec3(_InnerThreshold, _CenterThreshold, _OuterThreshold)) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = vec3(_Blur) * u_xlat16_2.xyz + vec3(_InnerThreshold, _CenterThreshold, _OuterThreshold);
    u_xlat16_2.xy = (-u_xlat0.xx) + u_xlat16_2.xy;
    u_xlat16_2.xy = clamp(u_xlat16_2.xy, 0.0, 1.0);
    u_xlat16_2.xy = u_xlat16_2.yx / vec2(u_xlat16_13);
    u_xlat16_13 = (-u_xlat16_2.y) + 1.0;
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
    u_xlat16_2.x = u_xlat16_2.x;
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
    u_xlat16_1.xyz = vec3(u_xlat16_13) * u_xlat16_1.xyz + _OutlineColor.xyz;
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) + _ShadowColor.xyz;
    SV_Target0.xyz = u_xlat16_2.xxx * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat0.x = vs_TEXCOORD0.x;
    u_xlat0.y = vs_TEXCOORD0.y + _ShadowDistance;
    u_xlat0.x = texture2D(_MainTex, u_xlat0.xy).x;
    u_xlat16_1.x = dFdx(u_xlat0.x);
    u_xlat16_5 = dFdy(u_xlat0.x);
    u_xlat16_9 = (-u_xlat0.x) + u_xlat16_2.z;
    u_xlat16_9 = clamp(u_xlat16_9, 0.0, 1.0);
    u_xlat16_1.x = abs(u_xlat16_5) + abs(u_xlat16_1.x);
    u_xlat16_5 = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = _Blur * u_xlat16_5 + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_9 / u_xlat16_1.x;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
    u_xlat16_1.x = u_xlat16_1.x * vs_COLOR0.w;
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
;
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_1.x;
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "UNITY_UI_CLIP_RECT" }
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
uniform 	mediump vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
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
uniform 	vec4 _ClipRect;
uniform 	mediump vec4 _OutlineColor;
uniform 	mediump vec4 _GradientColor1;
uniform 	mediump vec4 _GradientColor2;
uniform 	mediump vec4 _StripeColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump float _GradientScale;
uniform 	mediump float _GradientOffset;
uniform 	mediump float _StripeOffset;
uniform 	mediump float _StripeWidth;
uniform 	mediump float _ShadowDistance;
uniform 	mediump float _InnerThreshold;
uniform 	mediump float _CenterThreshold;
uniform 	mediump float _OuterThreshold;
uniform 	mediump float _Blur;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat4;
mediump float u_xlat16_5;
mediump float u_xlat16_9;
mediump float u_xlat16_13;
void main()
{
    u_xlat0.x = vs_TEXCOORD0.x + vs_TEXCOORD0.y;
    u_xlat0.x = u_xlat0.x + _StripeOffset;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_StripeWidth>=abs(u_xlat0.x));
#else
    u_xlatb0.x = _StripeWidth>=abs(u_xlat0.x);
#endif
    u_xlat0.x = u_xlatb0.x ? 1.0 : float(0.0);
    u_xlat4 = vs_TEXCOORD0.y * _GradientScale + (-_GradientOffset);
#ifdef UNITY_ADRENO_ES3
    u_xlat4 = min(max(u_xlat4, 0.0), 1.0);
#else
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = _GradientColor1.xyz + (-_GradientColor2.xyz);
    u_xlat16_1.xyz = vec3(u_xlat4) * u_xlat16_1.xyz + _GradientColor2.xyz;
    u_xlat16_1.xyz = _StripeColor.xyz * u_xlat0.xxx + u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz + (-_OutlineColor.xyz);
    u_xlat0.x = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat16_13 = dFdx(u_xlat0.x);
    u_xlat16_2.x = dFdy(u_xlat0.x);
    u_xlat16_13 = abs(u_xlat16_13) + abs(u_xlat16_2.x);
    u_xlat16_2.x = (-u_xlat16_13) + 1.0;
    u_xlat16_13 = _Blur * u_xlat16_2.x + u_xlat16_13;
    u_xlat16_2.xyz = (-vec3(_InnerThreshold, _CenterThreshold, _OuterThreshold)) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = vec3(_Blur) * u_xlat16_2.xyz + vec3(_InnerThreshold, _CenterThreshold, _OuterThreshold);
    u_xlat16_2.xy = (-u_xlat0.xx) + u_xlat16_2.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.xy = min(max(u_xlat16_2.xy, 0.0), 1.0);
#else
    u_xlat16_2.xy = clamp(u_xlat16_2.xy, 0.0, 1.0);
#endif
    u_xlat16_2.xy = u_xlat16_2.yx / vec2(u_xlat16_13);
    u_xlat16_13 = (-u_xlat16_2.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    u_xlat16_2.x = u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = vec3(u_xlat16_13) * u_xlat16_1.xyz + _OutlineColor.xyz;
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) + _ShadowColor.xyz;
    SV_Target0.xyz = u_xlat16_2.xxx * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat0.x = vs_TEXCOORD0.x;
    u_xlat0.y = vs_TEXCOORD0.y + _ShadowDistance;
    u_xlat0.x = texture(_MainTex, u_xlat0.xy).x;
    u_xlat16_1.x = dFdx(u_xlat0.x);
    u_xlat16_5 = dFdy(u_xlat0.x);
    u_xlat16_9 = (-u_xlat0.x) + u_xlat16_2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_9 = min(max(u_xlat16_9, 0.0), 1.0);
#else
    u_xlat16_9 = clamp(u_xlat16_9, 0.0, 1.0);
#endif
    u_xlat16_1.x = abs(u_xlat16_5) + abs(u_xlat16_1.x);
    u_xlat16_5 = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = _Blur * u_xlat16_5 + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_9 / u_xlat16_1.x;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat16_1.x * vs_COLOR0.w;
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
;
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_1.x;
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "UNITY_UI_CLIP_RECT" }
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
uniform 	mediump vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
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
uniform 	vec4 _ClipRect;
uniform 	mediump vec4 _OutlineColor;
uniform 	mediump vec4 _GradientColor1;
uniform 	mediump vec4 _GradientColor2;
uniform 	mediump vec4 _StripeColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump float _GradientScale;
uniform 	mediump float _GradientOffset;
uniform 	mediump float _StripeOffset;
uniform 	mediump float _StripeWidth;
uniform 	mediump float _ShadowDistance;
uniform 	mediump float _InnerThreshold;
uniform 	mediump float _CenterThreshold;
uniform 	mediump float _OuterThreshold;
uniform 	mediump float _Blur;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat4;
mediump float u_xlat16_5;
mediump float u_xlat16_9;
mediump float u_xlat16_13;
void main()
{
    u_xlat0.x = vs_TEXCOORD0.x + vs_TEXCOORD0.y;
    u_xlat0.x = u_xlat0.x + _StripeOffset;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_StripeWidth>=abs(u_xlat0.x));
#else
    u_xlatb0.x = _StripeWidth>=abs(u_xlat0.x);
#endif
    u_xlat0.x = u_xlatb0.x ? 1.0 : float(0.0);
    u_xlat4 = vs_TEXCOORD0.y * _GradientScale + (-_GradientOffset);
#ifdef UNITY_ADRENO_ES3
    u_xlat4 = min(max(u_xlat4, 0.0), 1.0);
#else
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = _GradientColor1.xyz + (-_GradientColor2.xyz);
    u_xlat16_1.xyz = vec3(u_xlat4) * u_xlat16_1.xyz + _GradientColor2.xyz;
    u_xlat16_1.xyz = _StripeColor.xyz * u_xlat0.xxx + u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz + (-_OutlineColor.xyz);
    u_xlat0.x = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat16_13 = dFdx(u_xlat0.x);
    u_xlat16_2.x = dFdy(u_xlat0.x);
    u_xlat16_13 = abs(u_xlat16_13) + abs(u_xlat16_2.x);
    u_xlat16_2.x = (-u_xlat16_13) + 1.0;
    u_xlat16_13 = _Blur * u_xlat16_2.x + u_xlat16_13;
    u_xlat16_2.xyz = (-vec3(_InnerThreshold, _CenterThreshold, _OuterThreshold)) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = vec3(_Blur) * u_xlat16_2.xyz + vec3(_InnerThreshold, _CenterThreshold, _OuterThreshold);
    u_xlat16_2.xy = (-u_xlat0.xx) + u_xlat16_2.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.xy = min(max(u_xlat16_2.xy, 0.0), 1.0);
#else
    u_xlat16_2.xy = clamp(u_xlat16_2.xy, 0.0, 1.0);
#endif
    u_xlat16_2.xy = u_xlat16_2.yx / vec2(u_xlat16_13);
    u_xlat16_13 = (-u_xlat16_2.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    u_xlat16_2.x = u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = vec3(u_xlat16_13) * u_xlat16_1.xyz + _OutlineColor.xyz;
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) + _ShadowColor.xyz;
    SV_Target0.xyz = u_xlat16_2.xxx * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat0.x = vs_TEXCOORD0.x;
    u_xlat0.y = vs_TEXCOORD0.y + _ShadowDistance;
    u_xlat0.x = texture(_MainTex, u_xlat0.xy).x;
    u_xlat16_1.x = dFdx(u_xlat0.x);
    u_xlat16_5 = dFdy(u_xlat0.x);
    u_xlat16_9 = (-u_xlat0.x) + u_xlat16_2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_9 = min(max(u_xlat16_9, 0.0), 1.0);
#else
    u_xlat16_9 = clamp(u_xlat16_9, 0.0, 1.0);
#endif
    u_xlat16_1.x = abs(u_xlat16_5) + abs(u_xlat16_1.x);
    u_xlat16_5 = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = _Blur * u_xlat16_5 + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_9 / u_xlat16_1.x;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat16_1.x * vs_COLOR0.w;
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
;
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_1.x;
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "UNITY_UI_CLIP_RECT" }
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
uniform 	mediump vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
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
uniform 	vec4 _ClipRect;
uniform 	mediump vec4 _OutlineColor;
uniform 	mediump vec4 _GradientColor1;
uniform 	mediump vec4 _GradientColor2;
uniform 	mediump vec4 _StripeColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump float _GradientScale;
uniform 	mediump float _GradientOffset;
uniform 	mediump float _StripeOffset;
uniform 	mediump float _StripeWidth;
uniform 	mediump float _ShadowDistance;
uniform 	mediump float _InnerThreshold;
uniform 	mediump float _CenterThreshold;
uniform 	mediump float _OuterThreshold;
uniform 	mediump float _Blur;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat4;
mediump float u_xlat16_5;
mediump float u_xlat16_9;
mediump float u_xlat16_13;
void main()
{
    u_xlat0.x = vs_TEXCOORD0.x + vs_TEXCOORD0.y;
    u_xlat0.x = u_xlat0.x + _StripeOffset;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_StripeWidth>=abs(u_xlat0.x));
#else
    u_xlatb0.x = _StripeWidth>=abs(u_xlat0.x);
#endif
    u_xlat0.x = u_xlatb0.x ? 1.0 : float(0.0);
    u_xlat4 = vs_TEXCOORD0.y * _GradientScale + (-_GradientOffset);
#ifdef UNITY_ADRENO_ES3
    u_xlat4 = min(max(u_xlat4, 0.0), 1.0);
#else
    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = _GradientColor1.xyz + (-_GradientColor2.xyz);
    u_xlat16_1.xyz = vec3(u_xlat4) * u_xlat16_1.xyz + _GradientColor2.xyz;
    u_xlat16_1.xyz = _StripeColor.xyz * u_xlat0.xxx + u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz + (-_OutlineColor.xyz);
    u_xlat0.x = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat16_13 = dFdx(u_xlat0.x);
    u_xlat16_2.x = dFdy(u_xlat0.x);
    u_xlat16_13 = abs(u_xlat16_13) + abs(u_xlat16_2.x);
    u_xlat16_2.x = (-u_xlat16_13) + 1.0;
    u_xlat16_13 = _Blur * u_xlat16_2.x + u_xlat16_13;
    u_xlat16_2.xyz = (-vec3(_InnerThreshold, _CenterThreshold, _OuterThreshold)) + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = vec3(_Blur) * u_xlat16_2.xyz + vec3(_InnerThreshold, _CenterThreshold, _OuterThreshold);
    u_xlat16_2.xy = (-u_xlat0.xx) + u_xlat16_2.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.xy = min(max(u_xlat16_2.xy, 0.0), 1.0);
#else
    u_xlat16_2.xy = clamp(u_xlat16_2.xy, 0.0, 1.0);
#endif
    u_xlat16_2.xy = u_xlat16_2.yx / vec2(u_xlat16_13);
    u_xlat16_13 = (-u_xlat16_2.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_13 = min(max(u_xlat16_13, 0.0), 1.0);
#else
    u_xlat16_13 = clamp(u_xlat16_13, 0.0, 1.0);
#endif
    u_xlat16_2.x = u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = vec3(u_xlat16_13) * u_xlat16_1.xyz + _OutlineColor.xyz;
    u_xlat16_3.xyz = (-u_xlat16_1.xyz) + _ShadowColor.xyz;
    SV_Target0.xyz = u_xlat16_2.xxx * u_xlat16_3.xyz + u_xlat16_1.xyz;
    u_xlat0.x = vs_TEXCOORD0.x;
    u_xlat0.y = vs_TEXCOORD0.y + _ShadowDistance;
    u_xlat0.x = texture(_MainTex, u_xlat0.xy).x;
    u_xlat16_1.x = dFdx(u_xlat0.x);
    u_xlat16_5 = dFdy(u_xlat0.x);
    u_xlat16_9 = (-u_xlat0.x) + u_xlat16_2.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_9 = min(max(u_xlat16_9, 0.0), 1.0);
#else
    u_xlat16_9 = clamp(u_xlat16_9, 0.0, 1.0);
#endif
    u_xlat16_1.x = abs(u_xlat16_5) + abs(u_xlat16_1.x);
    u_xlat16_5 = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = _Blur * u_xlat16_5 + u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_9 / u_xlat16_1.x;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat16_1.x * vs_COLOR0.w;
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
;
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * u_xlat16_1.x;
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
    return;
}

#endif
#ifdef FRAGMENT
#version 100
#ifdef GL_OES_standard_derivatives
#extension GL_OES_standard_derivatives : enable
#endif

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec4 _ClipRect;
uniform 	mediump vec4 _OutlineColor;
uniform 	mediump vec4 _GradientColor1;
uniform 	mediump vec4 _GradientColor2;
uniform 	mediump vec4 _StripeColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump float _GradientScale;
uniform 	mediump float _GradientOffset;
uniform 	mediump float _StripeOffset;
uniform 	mediump float _StripeWidth;
uniform 	mediump float _ShadowDistance;
uniform 	mediump float _InnerThreshold;
uniform 	mediump float _CenterThreshold;
uniform 	mediump float _OuterThreshold;
uniform 	mediump float _Blur;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
bvec4 u_xlatb0;
mediump vec2 u_xlat16_1;
mediump vec3 u_xlat16_2;
float u_xlat3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_10;
void main()
{
    u_xlat0.x = vs_TEXCOORD0.x;
    u_xlat0.y = vs_TEXCOORD0.y + _ShadowDistance;
    u_xlat0.x = texture2D(_MainTex, u_xlat0.xy).x;
    u_xlat16_1.x = dFdx(u_xlat0.x);
    u_xlat16_4.x = dFdy(u_xlat0.x);
    u_xlat16_1.x = abs(u_xlat16_4.x) + abs(u_xlat16_1.x);
    u_xlat16_4.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = _Blur * u_xlat16_4.x + u_xlat16_1.x;
    u_xlat16_4.xyz = (-vec3(_InnerThreshold, _CenterThreshold, _OuterThreshold)) + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = vec3(_Blur) * u_xlat16_4.xyz + vec3(_InnerThreshold, _CenterThreshold, _OuterThreshold);
    u_xlat16_10 = (-u_xlat0.x) + u_xlat16_4.z;
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
    u_xlat16_1.x = u_xlat16_10 / u_xlat16_1.x;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
    u_xlat16_1.x = u_xlat16_1.x * vs_COLOR0.w;
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
;
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat16_10 = u_xlat16_1.x * u_xlat0.x + -0.00100000005;
    u_xlat0.x = u_xlat0.x * u_xlat16_1.x;
    SV_Target0.w = u_xlat0.x;
    u_xlatb0.x = u_xlat16_10<0.0;
    if(u_xlatb0.x){discard;}
    u_xlat0.x = texture2D(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat16_1.x = dFdx(u_xlat0.x);
    u_xlat16_10 = dFdy(u_xlat0.x);
    u_xlat16_4.xy = (-u_xlat0.xx) + u_xlat16_4.xy;
    u_xlat16_4.xy = clamp(u_xlat16_4.xy, 0.0, 1.0);
    u_xlat16_1.x = abs(u_xlat16_10) + abs(u_xlat16_1.x);
    u_xlat16_10 = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = _Blur * u_xlat16_10 + u_xlat16_1.x;
    u_xlat16_1.xy = u_xlat16_4.yx / u_xlat16_1.xx;
    u_xlat16_1.x = u_xlat16_1.x;
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
    u_xlat16_4.x = (-u_xlat16_1.y) + 1.0;
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
    u_xlat0.x = vs_TEXCOORD0.x + vs_TEXCOORD0.y;
    u_xlat0.x = u_xlat0.x + _StripeOffset;
    u_xlatb0.x = _StripeWidth>=abs(u_xlat0.x);
    u_xlat0.x = u_xlatb0.x ? 1.0 : float(0.0);
    u_xlat3 = vs_TEXCOORD0.y * _GradientScale + (-_GradientOffset);
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
    u_xlat16_2.xyz = _GradientColor1.xyz + (-_GradientColor2.xyz);
    u_xlat16_2.xyz = vec3(u_xlat3) * u_xlat16_2.xyz + _GradientColor2.xyz;
    u_xlat16_2.xyz = _StripeColor.xyz * u_xlat0.xxx + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz + (-_OutlineColor.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xxx * u_xlat16_2.xyz + _OutlineColor.xyz;
    u_xlat16_2.xyz = (-u_xlat16_4.xyz) + _ShadowColor.xyz;
    SV_Target0.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + u_xlat16_4.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
    return;
}

#endif
#ifdef FRAGMENT
#version 100
#ifdef GL_OES_standard_derivatives
#extension GL_OES_standard_derivatives : enable
#endif

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec4 _ClipRect;
uniform 	mediump vec4 _OutlineColor;
uniform 	mediump vec4 _GradientColor1;
uniform 	mediump vec4 _GradientColor2;
uniform 	mediump vec4 _StripeColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump float _GradientScale;
uniform 	mediump float _GradientOffset;
uniform 	mediump float _StripeOffset;
uniform 	mediump float _StripeWidth;
uniform 	mediump float _ShadowDistance;
uniform 	mediump float _InnerThreshold;
uniform 	mediump float _CenterThreshold;
uniform 	mediump float _OuterThreshold;
uniform 	mediump float _Blur;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
bvec4 u_xlatb0;
mediump vec2 u_xlat16_1;
mediump vec3 u_xlat16_2;
float u_xlat3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_10;
void main()
{
    u_xlat0.x = vs_TEXCOORD0.x;
    u_xlat0.y = vs_TEXCOORD0.y + _ShadowDistance;
    u_xlat0.x = texture2D(_MainTex, u_xlat0.xy).x;
    u_xlat16_1.x = dFdx(u_xlat0.x);
    u_xlat16_4.x = dFdy(u_xlat0.x);
    u_xlat16_1.x = abs(u_xlat16_4.x) + abs(u_xlat16_1.x);
    u_xlat16_4.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = _Blur * u_xlat16_4.x + u_xlat16_1.x;
    u_xlat16_4.xyz = (-vec3(_InnerThreshold, _CenterThreshold, _OuterThreshold)) + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = vec3(_Blur) * u_xlat16_4.xyz + vec3(_InnerThreshold, _CenterThreshold, _OuterThreshold);
    u_xlat16_10 = (-u_xlat0.x) + u_xlat16_4.z;
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
    u_xlat16_1.x = u_xlat16_10 / u_xlat16_1.x;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
    u_xlat16_1.x = u_xlat16_1.x * vs_COLOR0.w;
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
;
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat16_10 = u_xlat16_1.x * u_xlat0.x + -0.00100000005;
    u_xlat0.x = u_xlat0.x * u_xlat16_1.x;
    SV_Target0.w = u_xlat0.x;
    u_xlatb0.x = u_xlat16_10<0.0;
    if(u_xlatb0.x){discard;}
    u_xlat0.x = texture2D(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat16_1.x = dFdx(u_xlat0.x);
    u_xlat16_10 = dFdy(u_xlat0.x);
    u_xlat16_4.xy = (-u_xlat0.xx) + u_xlat16_4.xy;
    u_xlat16_4.xy = clamp(u_xlat16_4.xy, 0.0, 1.0);
    u_xlat16_1.x = abs(u_xlat16_10) + abs(u_xlat16_1.x);
    u_xlat16_10 = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = _Blur * u_xlat16_10 + u_xlat16_1.x;
    u_xlat16_1.xy = u_xlat16_4.yx / u_xlat16_1.xx;
    u_xlat16_1.x = u_xlat16_1.x;
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
    u_xlat16_4.x = (-u_xlat16_1.y) + 1.0;
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
    u_xlat0.x = vs_TEXCOORD0.x + vs_TEXCOORD0.y;
    u_xlat0.x = u_xlat0.x + _StripeOffset;
    u_xlatb0.x = _StripeWidth>=abs(u_xlat0.x);
    u_xlat0.x = u_xlatb0.x ? 1.0 : float(0.0);
    u_xlat3 = vs_TEXCOORD0.y * _GradientScale + (-_GradientOffset);
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
    u_xlat16_2.xyz = _GradientColor1.xyz + (-_GradientColor2.xyz);
    u_xlat16_2.xyz = vec3(u_xlat3) * u_xlat16_2.xyz + _GradientColor2.xyz;
    u_xlat16_2.xyz = _StripeColor.xyz * u_xlat0.xxx + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz + (-_OutlineColor.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xxx * u_xlat16_2.xyz + _OutlineColor.xyz;
    u_xlat16_2.xyz = (-u_xlat16_4.xyz) + _ShadowColor.xyz;
    SV_Target0.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + u_xlat16_4.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
    return;
}

#endif
#ifdef FRAGMENT
#version 100
#ifdef GL_OES_standard_derivatives
#extension GL_OES_standard_derivatives : enable
#endif

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec4 _ClipRect;
uniform 	mediump vec4 _OutlineColor;
uniform 	mediump vec4 _GradientColor1;
uniform 	mediump vec4 _GradientColor2;
uniform 	mediump vec4 _StripeColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump float _GradientScale;
uniform 	mediump float _GradientOffset;
uniform 	mediump float _StripeOffset;
uniform 	mediump float _StripeWidth;
uniform 	mediump float _ShadowDistance;
uniform 	mediump float _InnerThreshold;
uniform 	mediump float _CenterThreshold;
uniform 	mediump float _OuterThreshold;
uniform 	mediump float _Blur;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
bvec4 u_xlatb0;
mediump vec2 u_xlat16_1;
mediump vec3 u_xlat16_2;
float u_xlat3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_10;
void main()
{
    u_xlat0.x = vs_TEXCOORD0.x;
    u_xlat0.y = vs_TEXCOORD0.y + _ShadowDistance;
    u_xlat0.x = texture2D(_MainTex, u_xlat0.xy).x;
    u_xlat16_1.x = dFdx(u_xlat0.x);
    u_xlat16_4.x = dFdy(u_xlat0.x);
    u_xlat16_1.x = abs(u_xlat16_4.x) + abs(u_xlat16_1.x);
    u_xlat16_4.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = _Blur * u_xlat16_4.x + u_xlat16_1.x;
    u_xlat16_4.xyz = (-vec3(_InnerThreshold, _CenterThreshold, _OuterThreshold)) + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = vec3(_Blur) * u_xlat16_4.xyz + vec3(_InnerThreshold, _CenterThreshold, _OuterThreshold);
    u_xlat16_10 = (-u_xlat0.x) + u_xlat16_4.z;
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
    u_xlat16_1.x = u_xlat16_10 / u_xlat16_1.x;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
    u_xlat16_1.x = u_xlat16_1.x * vs_COLOR0.w;
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
;
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat16_10 = u_xlat16_1.x * u_xlat0.x + -0.00100000005;
    u_xlat0.x = u_xlat0.x * u_xlat16_1.x;
    SV_Target0.w = u_xlat0.x;
    u_xlatb0.x = u_xlat16_10<0.0;
    if(u_xlatb0.x){discard;}
    u_xlat0.x = texture2D(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat16_1.x = dFdx(u_xlat0.x);
    u_xlat16_10 = dFdy(u_xlat0.x);
    u_xlat16_4.xy = (-u_xlat0.xx) + u_xlat16_4.xy;
    u_xlat16_4.xy = clamp(u_xlat16_4.xy, 0.0, 1.0);
    u_xlat16_1.x = abs(u_xlat16_10) + abs(u_xlat16_1.x);
    u_xlat16_10 = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = _Blur * u_xlat16_10 + u_xlat16_1.x;
    u_xlat16_1.xy = u_xlat16_4.yx / u_xlat16_1.xx;
    u_xlat16_1.x = u_xlat16_1.x;
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
    u_xlat16_4.x = (-u_xlat16_1.y) + 1.0;
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
    u_xlat0.x = vs_TEXCOORD0.x + vs_TEXCOORD0.y;
    u_xlat0.x = u_xlat0.x + _StripeOffset;
    u_xlatb0.x = _StripeWidth>=abs(u_xlat0.x);
    u_xlat0.x = u_xlatb0.x ? 1.0 : float(0.0);
    u_xlat3 = vs_TEXCOORD0.y * _GradientScale + (-_GradientOffset);
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
    u_xlat16_2.xyz = _GradientColor1.xyz + (-_GradientColor2.xyz);
    u_xlat16_2.xyz = vec3(u_xlat3) * u_xlat16_2.xyz + _GradientColor2.xyz;
    u_xlat16_2.xyz = _StripeColor.xyz * u_xlat0.xxx + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz + (-_OutlineColor.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xxx * u_xlat16_2.xyz + _OutlineColor.xyz;
    u_xlat16_2.xyz = (-u_xlat16_4.xyz) + _ShadowColor.xyz;
    SV_Target0.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + u_xlat16_4.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" }
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
uniform 	mediump vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
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
uniform 	vec4 _ClipRect;
uniform 	mediump vec4 _OutlineColor;
uniform 	mediump vec4 _GradientColor1;
uniform 	mediump vec4 _GradientColor2;
uniform 	mediump vec4 _StripeColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump float _GradientScale;
uniform 	mediump float _GradientOffset;
uniform 	mediump float _StripeOffset;
uniform 	mediump float _StripeWidth;
uniform 	mediump float _ShadowDistance;
uniform 	mediump float _InnerThreshold;
uniform 	mediump float _CenterThreshold;
uniform 	mediump float _OuterThreshold;
uniform 	mediump float _Blur;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
mediump vec2 u_xlat16_1;
mediump vec3 u_xlat16_2;
float u_xlat3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_10;
void main()
{
    u_xlat0.x = vs_TEXCOORD0.x;
    u_xlat0.y = vs_TEXCOORD0.y + _ShadowDistance;
    u_xlat0.x = texture(_MainTex, u_xlat0.xy).x;
    u_xlat16_1.x = dFdx(u_xlat0.x);
    u_xlat16_4.x = dFdy(u_xlat0.x);
    u_xlat16_1.x = abs(u_xlat16_4.x) + abs(u_xlat16_1.x);
    u_xlat16_4.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = _Blur * u_xlat16_4.x + u_xlat16_1.x;
    u_xlat16_4.xyz = (-vec3(_InnerThreshold, _CenterThreshold, _OuterThreshold)) + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = vec3(_Blur) * u_xlat16_4.xyz + vec3(_InnerThreshold, _CenterThreshold, _OuterThreshold);
    u_xlat16_10 = (-u_xlat0.x) + u_xlat16_4.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat16_10 / u_xlat16_1.x;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat16_1.x * vs_COLOR0.w;
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
;
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat16_10 = u_xlat16_1.x * u_xlat0.x + -0.00100000005;
    u_xlat0.x = u_xlat0.x * u_xlat16_1.x;
    SV_Target0.w = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_10<0.0);
#else
    u_xlatb0.x = u_xlat16_10<0.0;
#endif
    if(u_xlatb0.x){discard;}
    u_xlat0.x = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat16_1.x = dFdx(u_xlat0.x);
    u_xlat16_10 = dFdy(u_xlat0.x);
    u_xlat16_4.xy = (-u_xlat0.xx) + u_xlat16_4.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.xy = min(max(u_xlat16_4.xy, 0.0), 1.0);
#else
    u_xlat16_4.xy = clamp(u_xlat16_4.xy, 0.0, 1.0);
#endif
    u_xlat16_1.x = abs(u_xlat16_10) + abs(u_xlat16_1.x);
    u_xlat16_10 = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = _Blur * u_xlat16_10 + u_xlat16_1.x;
    u_xlat16_1.xy = u_xlat16_4.yx / u_xlat16_1.xx;
    u_xlat16_1.x = u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_4.x = (-u_xlat16_1.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat0.x = vs_TEXCOORD0.x + vs_TEXCOORD0.y;
    u_xlat0.x = u_xlat0.x + _StripeOffset;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_StripeWidth>=abs(u_xlat0.x));
#else
    u_xlatb0.x = _StripeWidth>=abs(u_xlat0.x);
#endif
    u_xlat0.x = u_xlatb0.x ? 1.0 : float(0.0);
    u_xlat3 = vs_TEXCOORD0.y * _GradientScale + (-_GradientOffset);
#ifdef UNITY_ADRENO_ES3
    u_xlat3 = min(max(u_xlat3, 0.0), 1.0);
#else
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = _GradientColor1.xyz + (-_GradientColor2.xyz);
    u_xlat16_2.xyz = vec3(u_xlat3) * u_xlat16_2.xyz + _GradientColor2.xyz;
    u_xlat16_2.xyz = _StripeColor.xyz * u_xlat0.xxx + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz + (-_OutlineColor.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xxx * u_xlat16_2.xyz + _OutlineColor.xyz;
    u_xlat16_2.xyz = (-u_xlat16_4.xyz) + _ShadowColor.xyz;
    SV_Target0.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + u_xlat16_4.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" }
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
uniform 	mediump vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
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
uniform 	vec4 _ClipRect;
uniform 	mediump vec4 _OutlineColor;
uniform 	mediump vec4 _GradientColor1;
uniform 	mediump vec4 _GradientColor2;
uniform 	mediump vec4 _StripeColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump float _GradientScale;
uniform 	mediump float _GradientOffset;
uniform 	mediump float _StripeOffset;
uniform 	mediump float _StripeWidth;
uniform 	mediump float _ShadowDistance;
uniform 	mediump float _InnerThreshold;
uniform 	mediump float _CenterThreshold;
uniform 	mediump float _OuterThreshold;
uniform 	mediump float _Blur;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
mediump vec2 u_xlat16_1;
mediump vec3 u_xlat16_2;
float u_xlat3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_10;
void main()
{
    u_xlat0.x = vs_TEXCOORD0.x;
    u_xlat0.y = vs_TEXCOORD0.y + _ShadowDistance;
    u_xlat0.x = texture(_MainTex, u_xlat0.xy).x;
    u_xlat16_1.x = dFdx(u_xlat0.x);
    u_xlat16_4.x = dFdy(u_xlat0.x);
    u_xlat16_1.x = abs(u_xlat16_4.x) + abs(u_xlat16_1.x);
    u_xlat16_4.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = _Blur * u_xlat16_4.x + u_xlat16_1.x;
    u_xlat16_4.xyz = (-vec3(_InnerThreshold, _CenterThreshold, _OuterThreshold)) + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = vec3(_Blur) * u_xlat16_4.xyz + vec3(_InnerThreshold, _CenterThreshold, _OuterThreshold);
    u_xlat16_10 = (-u_xlat0.x) + u_xlat16_4.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat16_10 / u_xlat16_1.x;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat16_1.x * vs_COLOR0.w;
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
;
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat16_10 = u_xlat16_1.x * u_xlat0.x + -0.00100000005;
    u_xlat0.x = u_xlat0.x * u_xlat16_1.x;
    SV_Target0.w = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_10<0.0);
#else
    u_xlatb0.x = u_xlat16_10<0.0;
#endif
    if(u_xlatb0.x){discard;}
    u_xlat0.x = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat16_1.x = dFdx(u_xlat0.x);
    u_xlat16_10 = dFdy(u_xlat0.x);
    u_xlat16_4.xy = (-u_xlat0.xx) + u_xlat16_4.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.xy = min(max(u_xlat16_4.xy, 0.0), 1.0);
#else
    u_xlat16_4.xy = clamp(u_xlat16_4.xy, 0.0, 1.0);
#endif
    u_xlat16_1.x = abs(u_xlat16_10) + abs(u_xlat16_1.x);
    u_xlat16_10 = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = _Blur * u_xlat16_10 + u_xlat16_1.x;
    u_xlat16_1.xy = u_xlat16_4.yx / u_xlat16_1.xx;
    u_xlat16_1.x = u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_4.x = (-u_xlat16_1.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat0.x = vs_TEXCOORD0.x + vs_TEXCOORD0.y;
    u_xlat0.x = u_xlat0.x + _StripeOffset;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_StripeWidth>=abs(u_xlat0.x));
#else
    u_xlatb0.x = _StripeWidth>=abs(u_xlat0.x);
#endif
    u_xlat0.x = u_xlatb0.x ? 1.0 : float(0.0);
    u_xlat3 = vs_TEXCOORD0.y * _GradientScale + (-_GradientOffset);
#ifdef UNITY_ADRENO_ES3
    u_xlat3 = min(max(u_xlat3, 0.0), 1.0);
#else
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = _GradientColor1.xyz + (-_GradientColor2.xyz);
    u_xlat16_2.xyz = vec3(u_xlat3) * u_xlat16_2.xyz + _GradientColor2.xyz;
    u_xlat16_2.xyz = _StripeColor.xyz * u_xlat0.xxx + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz + (-_OutlineColor.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xxx * u_xlat16_2.xyz + _OutlineColor.xyz;
    u_xlat16_2.xyz = (-u_xlat16_4.xyz) + _ShadowColor.xyz;
    SV_Target0.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + u_xlat16_4.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" }
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
uniform 	mediump vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1 = in_POSITION0;
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
uniform 	vec4 _ClipRect;
uniform 	mediump vec4 _OutlineColor;
uniform 	mediump vec4 _GradientColor1;
uniform 	mediump vec4 _GradientColor2;
uniform 	mediump vec4 _StripeColor;
uniform 	mediump vec4 _ShadowColor;
uniform 	mediump float _GradientScale;
uniform 	mediump float _GradientOffset;
uniform 	mediump float _StripeOffset;
uniform 	mediump float _StripeWidth;
uniform 	mediump float _ShadowDistance;
uniform 	mediump float _InnerThreshold;
uniform 	mediump float _CenterThreshold;
uniform 	mediump float _OuterThreshold;
uniform 	mediump float _Blur;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
mediump vec2 u_xlat16_1;
mediump vec3 u_xlat16_2;
float u_xlat3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_10;
void main()
{
    u_xlat0.x = vs_TEXCOORD0.x;
    u_xlat0.y = vs_TEXCOORD0.y + _ShadowDistance;
    u_xlat0.x = texture(_MainTex, u_xlat0.xy).x;
    u_xlat16_1.x = dFdx(u_xlat0.x);
    u_xlat16_4.x = dFdy(u_xlat0.x);
    u_xlat16_1.x = abs(u_xlat16_4.x) + abs(u_xlat16_1.x);
    u_xlat16_4.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = _Blur * u_xlat16_4.x + u_xlat16_1.x;
    u_xlat16_4.xyz = (-vec3(_InnerThreshold, _CenterThreshold, _OuterThreshold)) + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = vec3(_Blur) * u_xlat16_4.xyz + vec3(_InnerThreshold, _CenterThreshold, _OuterThreshold);
    u_xlat16_10 = (-u_xlat0.x) + u_xlat16_4.z;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat16_10 / u_xlat16_1.x;
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat16_1.x * vs_COLOR0.w;
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
;
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat16_10 = u_xlat16_1.x * u_xlat0.x + -0.00100000005;
    u_xlat0.x = u_xlat0.x * u_xlat16_1.x;
    SV_Target0.w = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_10<0.0);
#else
    u_xlatb0.x = u_xlat16_10<0.0;
#endif
    if(u_xlatb0.x){discard;}
    u_xlat0.x = texture(_MainTex, vs_TEXCOORD0.xy).x;
    u_xlat16_1.x = dFdx(u_xlat0.x);
    u_xlat16_10 = dFdy(u_xlat0.x);
    u_xlat16_4.xy = (-u_xlat0.xx) + u_xlat16_4.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.xy = min(max(u_xlat16_4.xy, 0.0), 1.0);
#else
    u_xlat16_4.xy = clamp(u_xlat16_4.xy, 0.0, 1.0);
#endif
    u_xlat16_1.x = abs(u_xlat16_10) + abs(u_xlat16_1.x);
    u_xlat16_10 = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = _Blur * u_xlat16_10 + u_xlat16_1.x;
    u_xlat16_1.xy = u_xlat16_4.yx / u_xlat16_1.xx;
    u_xlat16_1.x = u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_4.x = (-u_xlat16_1.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat0.x = vs_TEXCOORD0.x + vs_TEXCOORD0.y;
    u_xlat0.x = u_xlat0.x + _StripeOffset;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(_StripeWidth>=abs(u_xlat0.x));
#else
    u_xlatb0.x = _StripeWidth>=abs(u_xlat0.x);
#endif
    u_xlat0.x = u_xlatb0.x ? 1.0 : float(0.0);
    u_xlat3 = vs_TEXCOORD0.y * _GradientScale + (-_GradientOffset);
#ifdef UNITY_ADRENO_ES3
    u_xlat3 = min(max(u_xlat3, 0.0), 1.0);
#else
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = _GradientColor1.xyz + (-_GradientColor2.xyz);
    u_xlat16_2.xyz = vec3(u_xlat3) * u_xlat16_2.xyz + _GradientColor2.xyz;
    u_xlat16_2.xyz = _StripeColor.xyz * u_xlat0.xxx + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz + (-_OutlineColor.xyz);
    u_xlat16_4.xyz = u_xlat16_4.xxx * u_xlat16_2.xyz + _OutlineColor.xyz;
    u_xlat16_2.xyz = (-u_xlat16_4.xyz) + _ShadowColor.xyz;
    SV_Target0.xyz = u_xlat16_1.xxx * u_xlat16_2.xyz + u_xlat16_4.xyz;
    return;
}

#endif
"
}
}
}
}
}