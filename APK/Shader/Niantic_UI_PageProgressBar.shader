//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Niantic/UI/PageProgressBar" {
Properties {
_Color ("Tint Color", Color) = (1,1,1,1)
_CircleSize ("Circle Size", Range(0, 1)) = 0.2
_CircleColor ("Circle Color", Color) = (0,0,0,1)
_LineWidth ("Line Width", Range(0, 1)) = 0.2
_LineLength ("Line Length", Range(0, 1)) = 0.5
_LineColor ("Line Color", Color) = (1,1,1,1)
_MaxNumber ("Maximum Indicator number", Float) = 4
_Antialias ("Antialias Strength", Float) = 0.04
_MainTex ("Texture", 2D) = "white" { }
_StencilComp ("Stencil Comparison", Float) = 8
_Stencil ("Stencil ID", Float) = 0
_StencilOp ("Stencil Operation", Float) = 0
_StencilWriteMask ("Stencil Write Mask", Float) = 255
_StencilReadMask ("Stencil Read Mask", Float) = 255
_ColorMask ("Color Mask", Float) = 15
}
SubShader {
 Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
  ColorMask 0 0
  ZTest Always
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
  GpuProgramID 56681
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0 * _Color;
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
uniform 	mediump float _CircleSize;
uniform 	mediump vec4 _CircleColor;
uniform 	mediump float _LineWidth;
uniform 	mediump float _LineLength;
uniform 	mediump vec4 _LineColor;
uniform 	int _MaxNumber;
uniform 	mediump float _Antialias;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
float u_xlat2;
mediump vec3 u_xlat16_4;
float u_xlat5;
float trunc(float x) { return sign(x)*floor(abs(x)); }
vec2 trunc(vec2 x) { return sign(x)*floor(abs(x)); }
vec3 trunc(vec3 x) { return sign(x)*floor(abs(x)); }
vec4 trunc(vec4 x) { return sign(x)*floor(abs(x)); }

void main()
{
    u_xlat0.xy = fract(vs_TEXCOORD0.xx);
    u_xlat16_1 = vec4(_LineLength, _LineLength, _LineWidth, _LineWidth) * vec4(-1.0, 1.0, -1.0, 1.0) + vec4(0.5, 0.5, 0.5, 0.5);
    u_xlat0.zw = vs_TEXCOORD0.yy;
    u_xlat16_0 = u_xlat0 + (-u_xlat16_1);
    u_xlat16_0 = u_xlat16_0 * vec4(inf, inf, inf, inf);
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
    u_xlat16_1 = u_xlat16_0 * vec4(-2.0, -2.0, -2.0, -2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat16_0 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_1.xz = u_xlat16_0.xz * u_xlat16_1.xz;
    u_xlat16_4.xz = (-u_xlat16_1.yw) * u_xlat16_0.yw + vec2(1.0, 1.0);
    u_xlat16_1.xy = min(u_xlat16_4.xz, u_xlat16_1.xz);
    u_xlat16_0.w = u_xlat16_1.y * u_xlat16_1.x;
    u_xlat2 = float(_MaxNumber);
    u_xlat5 = u_xlat2 * vs_TEXCOORD0.x;
    u_xlat5 = trunc(u_xlat5);
    u_xlat2 = vs_TEXCOORD0.x * u_xlat2 + (-u_xlat5);
    u_xlat16_1.x = u_xlat2 * 2.0 + -0.5;
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.y = vs_TEXCOORD0.y + vs_TEXCOORD0.y;
    u_xlat16_1.xy = u_xlat16_1.xy + vec2(-1.0, -1.0);
    u_xlat2 = dot(u_xlat16_1.xy, u_xlat16_1.xy);
    u_xlat5 = u_xlat2 + _Antialias;
    u_xlat2 = u_xlat2 + (-_Antialias);
    u_xlat5 = (-u_xlat2) + u_xlat5;
    u_xlat2 = (-u_xlat2) + _CircleSize;
    u_xlat5 = float(1.0) / u_xlat5;
    u_xlat2 = u_xlat5 * u_xlat2;
    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
    u_xlat5 = u_xlat2 * -2.0 + 3.0;
    u_xlat2 = u_xlat2 * u_xlat2;
    u_xlat16_1.w = u_xlat5 * u_xlat2 + (-u_xlat16_0.w);
    u_xlat2 = u_xlat2 * u_xlat5;
    u_xlat16_0.xyz = _LineColor.xyz;
    u_xlat16_1.xyz = (-u_xlat16_0.xyz) + _CircleColor.xyz;
    u_xlat16_0 = vec4(u_xlat2) * u_xlat16_1 + u_xlat16_0;
    SV_Target0 = u_xlat16_0 * vs_COLOR0;
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
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0 * _Color;
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
uniform 	mediump float _CircleSize;
uniform 	mediump vec4 _CircleColor;
uniform 	mediump float _LineWidth;
uniform 	mediump float _LineLength;
uniform 	mediump vec4 _LineColor;
uniform 	int _MaxNumber;
uniform 	mediump float _Antialias;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
float u_xlat2;
mediump vec3 u_xlat16_4;
float u_xlat5;
float trunc(float x) { return sign(x)*floor(abs(x)); }
vec2 trunc(vec2 x) { return sign(x)*floor(abs(x)); }
vec3 trunc(vec3 x) { return sign(x)*floor(abs(x)); }
vec4 trunc(vec4 x) { return sign(x)*floor(abs(x)); }

void main()
{
    u_xlat0.xy = fract(vs_TEXCOORD0.xx);
    u_xlat16_1 = vec4(_LineLength, _LineLength, _LineWidth, _LineWidth) * vec4(-1.0, 1.0, -1.0, 1.0) + vec4(0.5, 0.5, 0.5, 0.5);
    u_xlat0.zw = vs_TEXCOORD0.yy;
    u_xlat16_0 = u_xlat0 + (-u_xlat16_1);
    u_xlat16_0 = u_xlat16_0 * vec4(inf, inf, inf, inf);
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
    u_xlat16_1 = u_xlat16_0 * vec4(-2.0, -2.0, -2.0, -2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat16_0 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_1.xz = u_xlat16_0.xz * u_xlat16_1.xz;
    u_xlat16_4.xz = (-u_xlat16_1.yw) * u_xlat16_0.yw + vec2(1.0, 1.0);
    u_xlat16_1.xy = min(u_xlat16_4.xz, u_xlat16_1.xz);
    u_xlat16_0.w = u_xlat16_1.y * u_xlat16_1.x;
    u_xlat2 = float(_MaxNumber);
    u_xlat5 = u_xlat2 * vs_TEXCOORD0.x;
    u_xlat5 = trunc(u_xlat5);
    u_xlat2 = vs_TEXCOORD0.x * u_xlat2 + (-u_xlat5);
    u_xlat16_1.x = u_xlat2 * 2.0 + -0.5;
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.y = vs_TEXCOORD0.y + vs_TEXCOORD0.y;
    u_xlat16_1.xy = u_xlat16_1.xy + vec2(-1.0, -1.0);
    u_xlat2 = dot(u_xlat16_1.xy, u_xlat16_1.xy);
    u_xlat5 = u_xlat2 + _Antialias;
    u_xlat2 = u_xlat2 + (-_Antialias);
    u_xlat5 = (-u_xlat2) + u_xlat5;
    u_xlat2 = (-u_xlat2) + _CircleSize;
    u_xlat5 = float(1.0) / u_xlat5;
    u_xlat2 = u_xlat5 * u_xlat2;
    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
    u_xlat5 = u_xlat2 * -2.0 + 3.0;
    u_xlat2 = u_xlat2 * u_xlat2;
    u_xlat16_1.w = u_xlat5 * u_xlat2 + (-u_xlat16_0.w);
    u_xlat2 = u_xlat2 * u_xlat5;
    u_xlat16_0.xyz = _LineColor.xyz;
    u_xlat16_1.xyz = (-u_xlat16_0.xyz) + _CircleColor.xyz;
    u_xlat16_0 = vec4(u_xlat2) * u_xlat16_1 + u_xlat16_0;
    SV_Target0 = u_xlat16_0 * vs_COLOR0;
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
attribute highp vec2 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0 * _Color;
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
uniform 	mediump float _CircleSize;
uniform 	mediump vec4 _CircleColor;
uniform 	mediump float _LineWidth;
uniform 	mediump float _LineLength;
uniform 	mediump vec4 _LineColor;
uniform 	int _MaxNumber;
uniform 	mediump float _Antialias;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
float u_xlat2;
mediump vec3 u_xlat16_4;
float u_xlat5;
float trunc(float x) { return sign(x)*floor(abs(x)); }
vec2 trunc(vec2 x) { return sign(x)*floor(abs(x)); }
vec3 trunc(vec3 x) { return sign(x)*floor(abs(x)); }
vec4 trunc(vec4 x) { return sign(x)*floor(abs(x)); }

void main()
{
    u_xlat0.xy = fract(vs_TEXCOORD0.xx);
    u_xlat16_1 = vec4(_LineLength, _LineLength, _LineWidth, _LineWidth) * vec4(-1.0, 1.0, -1.0, 1.0) + vec4(0.5, 0.5, 0.5, 0.5);
    u_xlat0.zw = vs_TEXCOORD0.yy;
    u_xlat16_0 = u_xlat0 + (-u_xlat16_1);
    u_xlat16_0 = u_xlat16_0 * vec4(inf, inf, inf, inf);
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
    u_xlat16_1 = u_xlat16_0 * vec4(-2.0, -2.0, -2.0, -2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat16_0 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_1.xz = u_xlat16_0.xz * u_xlat16_1.xz;
    u_xlat16_4.xz = (-u_xlat16_1.yw) * u_xlat16_0.yw + vec2(1.0, 1.0);
    u_xlat16_1.xy = min(u_xlat16_4.xz, u_xlat16_1.xz);
    u_xlat16_0.w = u_xlat16_1.y * u_xlat16_1.x;
    u_xlat2 = float(_MaxNumber);
    u_xlat5 = u_xlat2 * vs_TEXCOORD0.x;
    u_xlat5 = trunc(u_xlat5);
    u_xlat2 = vs_TEXCOORD0.x * u_xlat2 + (-u_xlat5);
    u_xlat16_1.x = u_xlat2 * 2.0 + -0.5;
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.y = vs_TEXCOORD0.y + vs_TEXCOORD0.y;
    u_xlat16_1.xy = u_xlat16_1.xy + vec2(-1.0, -1.0);
    u_xlat2 = dot(u_xlat16_1.xy, u_xlat16_1.xy);
    u_xlat5 = u_xlat2 + _Antialias;
    u_xlat2 = u_xlat2 + (-_Antialias);
    u_xlat5 = (-u_xlat2) + u_xlat5;
    u_xlat2 = (-u_xlat2) + _CircleSize;
    u_xlat5 = float(1.0) / u_xlat5;
    u_xlat2 = u_xlat5 * u_xlat2;
    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
    u_xlat5 = u_xlat2 * -2.0 + 3.0;
    u_xlat2 = u_xlat2 * u_xlat2;
    u_xlat16_1.w = u_xlat5 * u_xlat2 + (-u_xlat16_0.w);
    u_xlat2 = u_xlat2 * u_xlat5;
    u_xlat16_0.xyz = _LineColor.xyz;
    u_xlat16_1.xyz = (-u_xlat16_0.xyz) + _CircleColor.xyz;
    u_xlat16_0 = vec4(u_xlat2) * u_xlat16_1 + u_xlat16_0;
    SV_Target0 = u_xlat16_0 * vs_COLOR0;
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
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0 * _Color;
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
uniform 	mediump float _CircleSize;
uniform 	mediump vec4 _CircleColor;
uniform 	mediump float _LineWidth;
uniform 	mediump float _LineLength;
uniform 	mediump vec4 _LineColor;
uniform 	int _MaxNumber;
uniform 	mediump float _Antialias;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
float u_xlat2;
mediump vec3 u_xlat16_4;
float u_xlat5;
void main()
{
    u_xlat0.xy = fract(vs_TEXCOORD0.xx);
    u_xlat16_1 = vec4(_LineLength, _LineLength, _LineWidth, _LineWidth) * vec4(-1.0, 1.0, -1.0, 1.0) + vec4(0.5, 0.5, 0.5, 0.5);
    u_xlat0.zw = vs_TEXCOORD0.yy;
    u_xlat16_0 = u_xlat0 + (-u_xlat16_1);
    u_xlat16_0 = u_xlat16_0 * vec4(intBitsToFloat(int(0x7F800000u)), intBitsToFloat(int(0x7F800000u)), intBitsToFloat(int(0x7F800000u)), intBitsToFloat(int(0x7F800000u)));
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_1 = u_xlat16_0 * vec4(-2.0, -2.0, -2.0, -2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat16_0 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_1.xz = u_xlat16_0.xz * u_xlat16_1.xz;
    u_xlat16_4.xz = (-u_xlat16_1.yw) * u_xlat16_0.yw + vec2(1.0, 1.0);
    u_xlat16_1.xy = min(u_xlat16_4.xz, u_xlat16_1.xz);
    u_xlat16_0.w = u_xlat16_1.y * u_xlat16_1.x;
    u_xlat2 = float(_MaxNumber);
    u_xlat5 = u_xlat2 * vs_TEXCOORD0.x;
    u_xlat5 = trunc(u_xlat5);
    u_xlat2 = vs_TEXCOORD0.x * u_xlat2 + (-u_xlat5);
    u_xlat16_1.x = u_xlat2 * 2.0 + -0.5;
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.y = vs_TEXCOORD0.y + vs_TEXCOORD0.y;
    u_xlat16_1.xy = u_xlat16_1.xy + vec2(-1.0, -1.0);
    u_xlat2 = dot(u_xlat16_1.xy, u_xlat16_1.xy);
    u_xlat5 = u_xlat2 + _Antialias;
    u_xlat2 = u_xlat2 + (-_Antialias);
    u_xlat5 = (-u_xlat2) + u_xlat5;
    u_xlat2 = (-u_xlat2) + _CircleSize;
    u_xlat5 = float(1.0) / u_xlat5;
    u_xlat2 = u_xlat5 * u_xlat2;
#ifdef UNITY_ADRENO_ES3
    u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
#else
    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
#endif
    u_xlat5 = u_xlat2 * -2.0 + 3.0;
    u_xlat2 = u_xlat2 * u_xlat2;
    u_xlat16_1.w = u_xlat5 * u_xlat2 + (-u_xlat16_0.w);
    u_xlat2 = u_xlat2 * u_xlat5;
    u_xlat16_0.xyz = _LineColor.xyz;
    u_xlat16_1.xyz = (-u_xlat16_0.xyz) + _CircleColor.xyz;
    u_xlat16_0 = vec4(u_xlat2) * u_xlat16_1 + u_xlat16_0;
    SV_Target0 = u_xlat16_0 * vs_COLOR0;
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
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0 * _Color;
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
uniform 	mediump float _CircleSize;
uniform 	mediump vec4 _CircleColor;
uniform 	mediump float _LineWidth;
uniform 	mediump float _LineLength;
uniform 	mediump vec4 _LineColor;
uniform 	int _MaxNumber;
uniform 	mediump float _Antialias;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
float u_xlat2;
mediump vec3 u_xlat16_4;
float u_xlat5;
void main()
{
    u_xlat0.xy = fract(vs_TEXCOORD0.xx);
    u_xlat16_1 = vec4(_LineLength, _LineLength, _LineWidth, _LineWidth) * vec4(-1.0, 1.0, -1.0, 1.0) + vec4(0.5, 0.5, 0.5, 0.5);
    u_xlat0.zw = vs_TEXCOORD0.yy;
    u_xlat16_0 = u_xlat0 + (-u_xlat16_1);
    u_xlat16_0 = u_xlat16_0 * vec4(intBitsToFloat(int(0x7F800000u)), intBitsToFloat(int(0x7F800000u)), intBitsToFloat(int(0x7F800000u)), intBitsToFloat(int(0x7F800000u)));
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_1 = u_xlat16_0 * vec4(-2.0, -2.0, -2.0, -2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat16_0 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_1.xz = u_xlat16_0.xz * u_xlat16_1.xz;
    u_xlat16_4.xz = (-u_xlat16_1.yw) * u_xlat16_0.yw + vec2(1.0, 1.0);
    u_xlat16_1.xy = min(u_xlat16_4.xz, u_xlat16_1.xz);
    u_xlat16_0.w = u_xlat16_1.y * u_xlat16_1.x;
    u_xlat2 = float(_MaxNumber);
    u_xlat5 = u_xlat2 * vs_TEXCOORD0.x;
    u_xlat5 = trunc(u_xlat5);
    u_xlat2 = vs_TEXCOORD0.x * u_xlat2 + (-u_xlat5);
    u_xlat16_1.x = u_xlat2 * 2.0 + -0.5;
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.y = vs_TEXCOORD0.y + vs_TEXCOORD0.y;
    u_xlat16_1.xy = u_xlat16_1.xy + vec2(-1.0, -1.0);
    u_xlat2 = dot(u_xlat16_1.xy, u_xlat16_1.xy);
    u_xlat5 = u_xlat2 + _Antialias;
    u_xlat2 = u_xlat2 + (-_Antialias);
    u_xlat5 = (-u_xlat2) + u_xlat5;
    u_xlat2 = (-u_xlat2) + _CircleSize;
    u_xlat5 = float(1.0) / u_xlat5;
    u_xlat2 = u_xlat5 * u_xlat2;
#ifdef UNITY_ADRENO_ES3
    u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
#else
    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
#endif
    u_xlat5 = u_xlat2 * -2.0 + 3.0;
    u_xlat2 = u_xlat2 * u_xlat2;
    u_xlat16_1.w = u_xlat5 * u_xlat2 + (-u_xlat16_0.w);
    u_xlat2 = u_xlat2 * u_xlat5;
    u_xlat16_0.xyz = _LineColor.xyz;
    u_xlat16_1.xyz = (-u_xlat16_0.xyz) + _CircleColor.xyz;
    u_xlat16_0 = vec4(u_xlat2) * u_xlat16_1 + u_xlat16_0;
    SV_Target0 = u_xlat16_0 * vs_COLOR0;
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
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0 * _Color;
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
uniform 	mediump float _CircleSize;
uniform 	mediump vec4 _CircleColor;
uniform 	mediump float _LineWidth;
uniform 	mediump float _LineLength;
uniform 	mediump vec4 _LineColor;
uniform 	int _MaxNumber;
uniform 	mediump float _Antialias;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
float u_xlat2;
mediump vec3 u_xlat16_4;
float u_xlat5;
void main()
{
    u_xlat0.xy = fract(vs_TEXCOORD0.xx);
    u_xlat16_1 = vec4(_LineLength, _LineLength, _LineWidth, _LineWidth) * vec4(-1.0, 1.0, -1.0, 1.0) + vec4(0.5, 0.5, 0.5, 0.5);
    u_xlat0.zw = vs_TEXCOORD0.yy;
    u_xlat16_0 = u_xlat0 + (-u_xlat16_1);
    u_xlat16_0 = u_xlat16_0 * vec4(intBitsToFloat(int(0x7F800000u)), intBitsToFloat(int(0x7F800000u)), intBitsToFloat(int(0x7F800000u)), intBitsToFloat(int(0x7F800000u)));
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_1 = u_xlat16_0 * vec4(-2.0, -2.0, -2.0, -2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat16_0 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_1.xz = u_xlat16_0.xz * u_xlat16_1.xz;
    u_xlat16_4.xz = (-u_xlat16_1.yw) * u_xlat16_0.yw + vec2(1.0, 1.0);
    u_xlat16_1.xy = min(u_xlat16_4.xz, u_xlat16_1.xz);
    u_xlat16_0.w = u_xlat16_1.y * u_xlat16_1.x;
    u_xlat2 = float(_MaxNumber);
    u_xlat5 = u_xlat2 * vs_TEXCOORD0.x;
    u_xlat5 = trunc(u_xlat5);
    u_xlat2 = vs_TEXCOORD0.x * u_xlat2 + (-u_xlat5);
    u_xlat16_1.x = u_xlat2 * 2.0 + -0.5;
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_1.x;
    u_xlat16_1.y = vs_TEXCOORD0.y + vs_TEXCOORD0.y;
    u_xlat16_1.xy = u_xlat16_1.xy + vec2(-1.0, -1.0);
    u_xlat2 = dot(u_xlat16_1.xy, u_xlat16_1.xy);
    u_xlat5 = u_xlat2 + _Antialias;
    u_xlat2 = u_xlat2 + (-_Antialias);
    u_xlat5 = (-u_xlat2) + u_xlat5;
    u_xlat2 = (-u_xlat2) + _CircleSize;
    u_xlat5 = float(1.0) / u_xlat5;
    u_xlat2 = u_xlat5 * u_xlat2;
#ifdef UNITY_ADRENO_ES3
    u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
#else
    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
#endif
    u_xlat5 = u_xlat2 * -2.0 + 3.0;
    u_xlat2 = u_xlat2 * u_xlat2;
    u_xlat16_1.w = u_xlat5 * u_xlat2 + (-u_xlat16_0.w);
    u_xlat2 = u_xlat2 * u_xlat5;
    u_xlat16_0.xyz = _LineColor.xyz;
    u_xlat16_1.xyz = (-u_xlat16_0.xyz) + _CircleColor.xyz;
    u_xlat16_0 = vec4(u_xlat2) * u_xlat16_1 + u_xlat16_0;
    SV_Target0 = u_xlat16_0 * vs_COLOR0;
    return;
}

#endif
"
}
}
}
}
}