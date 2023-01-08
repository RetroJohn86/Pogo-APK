//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Niantic/UI/DottedLineVertical" {
Properties {
_MainTex ("Sprite Texture", 2D) = "white" { }
_ColorMask ("Color Mask", Float) = 15
_Height ("Height", Float) = 100
[Header(PROPERTIES)] _Color ("Tint", Color) = (1,1,1,1)
_Width ("Line Width", Range(0, 0.5)) = 0.2
_DotHeight ("Dot Height in Pixel", Float) = 30
_Ratio ("Dot Ratio", Range(0, 1)) = 0.3
_Feather ("Feather", Float) = 0.1
[Enum(UnityEngine.Rendering.CompareFunction)] unity_GUIZTestMode ("ZTest", Float) = 4
[Header(STENCIL PROPERTIES)] _Stencil ("Stencil ID [0;255]", Float) = 0
_ReadMask ("Stencil Read Mask [0;255]", Float) = 255
_WriteMask ("Stencil Write Mask [0;255]", Float) = 255
[Enum(UnityEngine.Rendering.CompareFunction)] _StencilComp ("Stencil Comparison", Float) = 8
[Enum(UnityEngine.Rendering.StencilOp)] _StencilOp ("Stencil Operation", Float) = 0
[Enum(UnityEngine.Rendering.StencilOp)] _StencilFail ("Stencil Fail", Float) = 0
[Enum(UnityEngine.Rendering.StencilOp)] _StencilZFail ("Stencil ZFail", Float) = 0
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
  GpuProgramID 21425
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
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
    vs_COLOR0 = in_COLOR0 * _Color;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1 = in_POSITION0;
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
uniform 	float _Width;
uniform 	float _DotHeight;
uniform 	float _Ratio;
uniform 	float _Feather;
uniform 	float _Height;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
float u_xlat0;
mediump float u_xlat16_1;
vec2 u_xlat2;
vec2 u_xlat4;
float u_xlat6;
void main()
{
    u_xlat0 = vs_TEXCOORD0.y * _Height;
    u_xlat0 = u_xlat0 / _DotHeight;
    u_xlat0 = fract(u_xlat0);
    u_xlat2.xy = (-vec2(vec2(_Feather, _Feather))) + vec2(_Width, _Ratio);
    u_xlat0 = (-u_xlat2.y) + u_xlat0;
    u_xlat4.xy = (-u_xlat2.xy) + vec2(_Width, _Ratio);
    u_xlat4.xy = vec2(1.0, 1.0) / u_xlat4.xy;
    u_xlat0 = u_xlat4.y * u_xlat0;
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
    u_xlat6 = u_xlat0 * -2.0 + 3.0;
    u_xlat0 = u_xlat0 * u_xlat0;
    u_xlat0 = u_xlat0 * u_xlat6;
    u_xlat6 = vs_TEXCOORD0.x + -0.5;
    u_xlat2.x = (-u_xlat2.x) + abs(u_xlat6);
    u_xlat2.x = u_xlat4.x * u_xlat2.x;
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat4.x = u_xlat2.x * -2.0 + 3.0;
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat2.x = (-u_xlat4.x) * u_xlat2.x + 1.0;
    u_xlat16_1 = u_xlat0 * u_xlat2.x;
    SV_Target0.w = u_xlat16_1 * vs_COLOR0.w;
    SV_Target0.xyz = vs_COLOR0.xyz;
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
uniform 	mediump vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
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
    vs_COLOR0 = in_COLOR0 * _Color;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1 = in_POSITION0;
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
uniform 	float _Width;
uniform 	float _DotHeight;
uniform 	float _Ratio;
uniform 	float _Feather;
uniform 	float _Height;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
float u_xlat0;
mediump float u_xlat16_1;
vec2 u_xlat2;
vec2 u_xlat4;
float u_xlat6;
void main()
{
    u_xlat0 = vs_TEXCOORD0.y * _Height;
    u_xlat0 = u_xlat0 / _DotHeight;
    u_xlat0 = fract(u_xlat0);
    u_xlat2.xy = (-vec2(vec2(_Feather, _Feather))) + vec2(_Width, _Ratio);
    u_xlat0 = (-u_xlat2.y) + u_xlat0;
    u_xlat4.xy = (-u_xlat2.xy) + vec2(_Width, _Ratio);
    u_xlat4.xy = vec2(1.0, 1.0) / u_xlat4.xy;
    u_xlat0 = u_xlat4.y * u_xlat0;
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
    u_xlat6 = u_xlat0 * -2.0 + 3.0;
    u_xlat0 = u_xlat0 * u_xlat0;
    u_xlat0 = u_xlat0 * u_xlat6;
    u_xlat6 = vs_TEXCOORD0.x + -0.5;
    u_xlat2.x = (-u_xlat2.x) + abs(u_xlat6);
    u_xlat2.x = u_xlat4.x * u_xlat2.x;
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat4.x = u_xlat2.x * -2.0 + 3.0;
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat2.x = (-u_xlat4.x) * u_xlat2.x + 1.0;
    u_xlat16_1 = u_xlat0 * u_xlat2.x;
    SV_Target0.w = u_xlat16_1 * vs_COLOR0.w;
    SV_Target0.xyz = vs_COLOR0.xyz;
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
uniform 	mediump vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
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
    vs_COLOR0 = in_COLOR0 * _Color;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1 = in_POSITION0;
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
uniform 	float _Width;
uniform 	float _DotHeight;
uniform 	float _Ratio;
uniform 	float _Feather;
uniform 	float _Height;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
float u_xlat0;
mediump float u_xlat16_1;
vec2 u_xlat2;
vec2 u_xlat4;
float u_xlat6;
void main()
{
    u_xlat0 = vs_TEXCOORD0.y * _Height;
    u_xlat0 = u_xlat0 / _DotHeight;
    u_xlat0 = fract(u_xlat0);
    u_xlat2.xy = (-vec2(vec2(_Feather, _Feather))) + vec2(_Width, _Ratio);
    u_xlat0 = (-u_xlat2.y) + u_xlat0;
    u_xlat4.xy = (-u_xlat2.xy) + vec2(_Width, _Ratio);
    u_xlat4.xy = vec2(1.0, 1.0) / u_xlat4.xy;
    u_xlat0 = u_xlat4.y * u_xlat0;
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
    u_xlat6 = u_xlat0 * -2.0 + 3.0;
    u_xlat0 = u_xlat0 * u_xlat0;
    u_xlat0 = u_xlat0 * u_xlat6;
    u_xlat6 = vs_TEXCOORD0.x + -0.5;
    u_xlat2.x = (-u_xlat2.x) + abs(u_xlat6);
    u_xlat2.x = u_xlat4.x * u_xlat2.x;
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat4.x = u_xlat2.x * -2.0 + 3.0;
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat2.x = (-u_xlat4.x) * u_xlat2.x + 1.0;
    u_xlat16_1 = u_xlat0 * u_xlat2.x;
    SV_Target0.w = u_xlat16_1 * vs_COLOR0.w;
    SV_Target0.xyz = vs_COLOR0.xyz;
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
uniform 	mediump vec4 _Color;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
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
    vs_COLOR0 = in_COLOR0 * _Color;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Width;
uniform 	float _DotHeight;
uniform 	float _Ratio;
uniform 	float _Feather;
uniform 	float _Height;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump float u_xlat16_1;
vec2 u_xlat2;
vec2 u_xlat4;
float u_xlat6;
void main()
{
    u_xlat0 = vs_TEXCOORD0.y * _Height;
    u_xlat0 = u_xlat0 / _DotHeight;
    u_xlat0 = fract(u_xlat0);
    u_xlat2.xy = (-vec2(vec2(_Feather, _Feather))) + vec2(_Width, _Ratio);
    u_xlat0 = (-u_xlat2.y) + u_xlat0;
    u_xlat4.xy = (-u_xlat2.xy) + vec2(_Width, _Ratio);
    u_xlat4.xy = vec2(1.0, 1.0) / u_xlat4.xy;
    u_xlat0 = u_xlat4.y * u_xlat0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat6 = u_xlat0 * -2.0 + 3.0;
    u_xlat0 = u_xlat0 * u_xlat0;
    u_xlat0 = u_xlat0 * u_xlat6;
    u_xlat6 = vs_TEXCOORD0.x + -0.5;
    u_xlat2.x = (-u_xlat2.x) + abs(u_xlat6);
    u_xlat2.x = u_xlat4.x * u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat2.x * -2.0 + 3.0;
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat2.x = (-u_xlat4.x) * u_xlat2.x + 1.0;
    u_xlat16_1 = u_xlat0 * u_xlat2.x;
    SV_Target0.w = u_xlat16_1 * vs_COLOR0.w;
    SV_Target0.xyz = vs_COLOR0.xyz;
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
uniform 	mediump vec4 _Color;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
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
    vs_COLOR0 = in_COLOR0 * _Color;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Width;
uniform 	float _DotHeight;
uniform 	float _Ratio;
uniform 	float _Feather;
uniform 	float _Height;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump float u_xlat16_1;
vec2 u_xlat2;
vec2 u_xlat4;
float u_xlat6;
void main()
{
    u_xlat0 = vs_TEXCOORD0.y * _Height;
    u_xlat0 = u_xlat0 / _DotHeight;
    u_xlat0 = fract(u_xlat0);
    u_xlat2.xy = (-vec2(vec2(_Feather, _Feather))) + vec2(_Width, _Ratio);
    u_xlat0 = (-u_xlat2.y) + u_xlat0;
    u_xlat4.xy = (-u_xlat2.xy) + vec2(_Width, _Ratio);
    u_xlat4.xy = vec2(1.0, 1.0) / u_xlat4.xy;
    u_xlat0 = u_xlat4.y * u_xlat0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat6 = u_xlat0 * -2.0 + 3.0;
    u_xlat0 = u_xlat0 * u_xlat0;
    u_xlat0 = u_xlat0 * u_xlat6;
    u_xlat6 = vs_TEXCOORD0.x + -0.5;
    u_xlat2.x = (-u_xlat2.x) + abs(u_xlat6);
    u_xlat2.x = u_xlat4.x * u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat2.x * -2.0 + 3.0;
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat2.x = (-u_xlat4.x) * u_xlat2.x + 1.0;
    u_xlat16_1 = u_xlat0 * u_xlat2.x;
    SV_Target0.w = u_xlat16_1 * vs_COLOR0.w;
    SV_Target0.xyz = vs_COLOR0.xyz;
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
uniform 	mediump vec4 _Color;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
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
    vs_COLOR0 = in_COLOR0 * _Color;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Width;
uniform 	float _DotHeight;
uniform 	float _Ratio;
uniform 	float _Feather;
uniform 	float _Height;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump float u_xlat16_1;
vec2 u_xlat2;
vec2 u_xlat4;
float u_xlat6;
void main()
{
    u_xlat0 = vs_TEXCOORD0.y * _Height;
    u_xlat0 = u_xlat0 / _DotHeight;
    u_xlat0 = fract(u_xlat0);
    u_xlat2.xy = (-vec2(vec2(_Feather, _Feather))) + vec2(_Width, _Ratio);
    u_xlat0 = (-u_xlat2.y) + u_xlat0;
    u_xlat4.xy = (-u_xlat2.xy) + vec2(_Width, _Ratio);
    u_xlat4.xy = vec2(1.0, 1.0) / u_xlat4.xy;
    u_xlat0 = u_xlat4.y * u_xlat0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat6 = u_xlat0 * -2.0 + 3.0;
    u_xlat0 = u_xlat0 * u_xlat0;
    u_xlat0 = u_xlat0 * u_xlat6;
    u_xlat6 = vs_TEXCOORD0.x + -0.5;
    u_xlat2.x = (-u_xlat2.x) + abs(u_xlat6);
    u_xlat2.x = u_xlat4.x * u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat4.x = u_xlat2.x * -2.0 + 3.0;
    u_xlat2.x = u_xlat2.x * u_xlat2.x;
    u_xlat2.x = (-u_xlat4.x) * u_xlat2.x + 1.0;
    u_xlat16_1 = u_xlat0 * u_xlat2.x;
    SV_Target0.w = u_xlat16_1 * vs_COLOR0.w;
    SV_Target0.xyz = vs_COLOR0.xyz;
    return;
}

#endif
"
}
}
}
}
}