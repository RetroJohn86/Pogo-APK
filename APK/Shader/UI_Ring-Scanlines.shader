//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "UI/Ring-Scanlines" {
Properties {
_ColorA ("Color A", Color) = (1,1,1,1)
_ColorB ("Color B", Color) = (1,1,1,1)
_GradientScale ("Gradient Scale", Float) = 2
_Radius ("Outer Radius", Float) = 1
_Thickness ("Thickneses", Float) = 0.1
_ScanlineFrequency ("Scanline Frequency", Float) = 1000
_ScanlineIntensity ("Scanline Intensity", Float) = 0.4
_ScanlineGlowFrequency ("Scanline Glow Frequency", Float) = 5
_ScanlineGlowSpeed ("Scanline Glow Speed", Float) = 5
_StencilComp ("Stencil Comparison", Float) = 8
_Stencil ("Stencil ID", Float) = 0
_StencilOp ("Stencil Operation", Float) = 0
_StencilWriteMask ("Stencil Write Mask", Float) = 255
_StencilReadMask ("Stencil Read Mask", Float) = 255
_ColorMask ("Color Mask", Float) = 15
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
  GpuProgramID 40081
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _ColorA;
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
    u_xlat0 = in_COLOR0 * _ColorA;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
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
uniform 	vec4 _Time;
uniform 	mediump vec4 _ColorB;
uniform 	float _GradientScale;
uniform 	float _Radius;
uniform 	float _Thickness;
uniform 	float _ScanlineFrequency;
uniform 	float _ScanlineIntensity;
uniform 	float _ScanlineGlowFrequency;
uniform 	float _ScanlineGlowSpeed;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
float u_xlat3;
mediump float u_xlat16_4;
float u_xlat6;
float u_xlat9;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat16_1.x = dFdx(u_xlat0.x);
    u_xlat16_4 = dFdy(u_xlat0.x);
    u_xlat16_1.x = abs(u_xlat16_4) + abs(u_xlat16_1.x);
    u_xlat3 = u_xlat0.x + (-_Radius);
    u_xlat3 = u_xlat3 / u_xlat16_1.x;
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
    u_xlat3 = (-u_xlat3) + 1.0;
    u_xlat6 = (-_Thickness) + _Radius;
    u_xlat6 = (-u_xlat6) + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _GradientScale;
    u_xlat6 = u_xlat6 / u_xlat16_1.x;
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
    u_xlat16_1.x = u_xlat6 * u_xlat3;
    u_xlat2 = (-vs_COLOR0) + _ColorB;
    u_xlat0 = u_xlat0.xxxx * u_xlat2 + vs_COLOR0;
    SV_Target0.w = u_xlat16_1.x * u_xlat0.w;
    u_xlat9 = vs_TEXCOORD0.x * _ScanlineGlowFrequency;
    u_xlat9 = _Time.y * _ScanlineGlowSpeed + u_xlat9;
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 0.5 + 0.5;
    u_xlat16_1.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat2.xyz = u_xlat16_1.xyz * vec3(u_xlat9) + (-u_xlat0.xyz);
    u_xlat9 = vs_TEXCOORD0.y * _ScanlineFrequency;
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 0.5 + 0.5;
    u_xlat9 = u_xlat9 * _ScanlineIntensity;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat2.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
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
uniform 	mediump vec4 _ColorA;
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
    u_xlat0 = in_COLOR0 * _ColorA;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
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
uniform 	vec4 _Time;
uniform 	mediump vec4 _ColorB;
uniform 	float _GradientScale;
uniform 	float _Radius;
uniform 	float _Thickness;
uniform 	float _ScanlineFrequency;
uniform 	float _ScanlineIntensity;
uniform 	float _ScanlineGlowFrequency;
uniform 	float _ScanlineGlowSpeed;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
float u_xlat3;
mediump float u_xlat16_4;
float u_xlat6;
float u_xlat9;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat16_1.x = dFdx(u_xlat0.x);
    u_xlat16_4 = dFdy(u_xlat0.x);
    u_xlat16_1.x = abs(u_xlat16_4) + abs(u_xlat16_1.x);
    u_xlat3 = u_xlat0.x + (-_Radius);
    u_xlat3 = u_xlat3 / u_xlat16_1.x;
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
    u_xlat3 = (-u_xlat3) + 1.0;
    u_xlat6 = (-_Thickness) + _Radius;
    u_xlat6 = (-u_xlat6) + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _GradientScale;
    u_xlat6 = u_xlat6 / u_xlat16_1.x;
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
    u_xlat16_1.x = u_xlat6 * u_xlat3;
    u_xlat2 = (-vs_COLOR0) + _ColorB;
    u_xlat0 = u_xlat0.xxxx * u_xlat2 + vs_COLOR0;
    SV_Target0.w = u_xlat16_1.x * u_xlat0.w;
    u_xlat9 = vs_TEXCOORD0.x * _ScanlineGlowFrequency;
    u_xlat9 = _Time.y * _ScanlineGlowSpeed + u_xlat9;
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 0.5 + 0.5;
    u_xlat16_1.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat2.xyz = u_xlat16_1.xyz * vec3(u_xlat9) + (-u_xlat0.xyz);
    u_xlat9 = vs_TEXCOORD0.y * _ScanlineFrequency;
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 0.5 + 0.5;
    u_xlat9 = u_xlat9 * _ScanlineIntensity;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat2.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
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
uniform 	mediump vec4 _ColorA;
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
    u_xlat0 = in_COLOR0 * _ColorA;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
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
uniform 	vec4 _Time;
uniform 	mediump vec4 _ColorB;
uniform 	float _GradientScale;
uniform 	float _Radius;
uniform 	float _Thickness;
uniform 	float _ScanlineFrequency;
uniform 	float _ScanlineIntensity;
uniform 	float _ScanlineGlowFrequency;
uniform 	float _ScanlineGlowSpeed;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
float u_xlat3;
mediump float u_xlat16_4;
float u_xlat6;
float u_xlat9;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat16_1.x = dFdx(u_xlat0.x);
    u_xlat16_4 = dFdy(u_xlat0.x);
    u_xlat16_1.x = abs(u_xlat16_4) + abs(u_xlat16_1.x);
    u_xlat3 = u_xlat0.x + (-_Radius);
    u_xlat3 = u_xlat3 / u_xlat16_1.x;
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
    u_xlat3 = (-u_xlat3) + 1.0;
    u_xlat6 = (-_Thickness) + _Radius;
    u_xlat6 = (-u_xlat6) + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _GradientScale;
    u_xlat6 = u_xlat6 / u_xlat16_1.x;
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
    u_xlat16_1.x = u_xlat6 * u_xlat3;
    u_xlat2 = (-vs_COLOR0) + _ColorB;
    u_xlat0 = u_xlat0.xxxx * u_xlat2 + vs_COLOR0;
    SV_Target0.w = u_xlat16_1.x * u_xlat0.w;
    u_xlat9 = vs_TEXCOORD0.x * _ScanlineGlowFrequency;
    u_xlat9 = _Time.y * _ScanlineGlowSpeed + u_xlat9;
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 0.5 + 0.5;
    u_xlat16_1.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat2.xyz = u_xlat16_1.xyz * vec3(u_xlat9) + (-u_xlat0.xyz);
    u_xlat9 = vs_TEXCOORD0.y * _ScanlineFrequency;
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 0.5 + 0.5;
    u_xlat9 = u_xlat9 * _ScanlineIntensity;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat2.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
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
uniform 	mediump vec4 _ColorA;
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
    u_xlat0 = in_COLOR0 * _ColorA;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
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
uniform 	vec4 _Time;
uniform 	mediump vec4 _ColorB;
uniform 	float _GradientScale;
uniform 	float _Radius;
uniform 	float _Thickness;
uniform 	float _ScanlineFrequency;
uniform 	float _ScanlineIntensity;
uniform 	float _ScanlineGlowFrequency;
uniform 	float _ScanlineGlowSpeed;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
float u_xlat3;
mediump float u_xlat16_4;
float u_xlat6;
float u_xlat9;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat16_1.x = dFdx(u_xlat0.x);
    u_xlat16_4 = dFdy(u_xlat0.x);
    u_xlat16_1.x = abs(u_xlat16_4) + abs(u_xlat16_1.x);
    u_xlat3 = u_xlat0.x + (-_Radius);
    u_xlat3 = u_xlat3 / u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3 = min(max(u_xlat3, 0.0), 1.0);
#else
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
#endif
    u_xlat3 = (-u_xlat3) + 1.0;
    u_xlat6 = (-_Thickness) + _Radius;
    u_xlat6 = (-u_xlat6) + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _GradientScale;
    u_xlat6 = u_xlat6 / u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat6 * u_xlat3;
    u_xlat2 = (-vs_COLOR0) + _ColorB;
    u_xlat0 = u_xlat0.xxxx * u_xlat2 + vs_COLOR0;
    SV_Target0.w = u_xlat16_1.x * u_xlat0.w;
    u_xlat9 = vs_TEXCOORD0.x * _ScanlineGlowFrequency;
    u_xlat9 = _Time.y * _ScanlineGlowSpeed + u_xlat9;
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 0.5 + 0.5;
    u_xlat16_1.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat2.xyz = u_xlat16_1.xyz * vec3(u_xlat9) + (-u_xlat0.xyz);
    u_xlat9 = vs_TEXCOORD0.y * _ScanlineFrequency;
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 0.5 + 0.5;
    u_xlat9 = u_xlat9 * _ScanlineIntensity;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat2.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
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
uniform 	mediump vec4 _ColorA;
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
    u_xlat0 = in_COLOR0 * _ColorA;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
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
uniform 	vec4 _Time;
uniform 	mediump vec4 _ColorB;
uniform 	float _GradientScale;
uniform 	float _Radius;
uniform 	float _Thickness;
uniform 	float _ScanlineFrequency;
uniform 	float _ScanlineIntensity;
uniform 	float _ScanlineGlowFrequency;
uniform 	float _ScanlineGlowSpeed;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
float u_xlat3;
mediump float u_xlat16_4;
float u_xlat6;
float u_xlat9;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat16_1.x = dFdx(u_xlat0.x);
    u_xlat16_4 = dFdy(u_xlat0.x);
    u_xlat16_1.x = abs(u_xlat16_4) + abs(u_xlat16_1.x);
    u_xlat3 = u_xlat0.x + (-_Radius);
    u_xlat3 = u_xlat3 / u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3 = min(max(u_xlat3, 0.0), 1.0);
#else
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
#endif
    u_xlat3 = (-u_xlat3) + 1.0;
    u_xlat6 = (-_Thickness) + _Radius;
    u_xlat6 = (-u_xlat6) + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _GradientScale;
    u_xlat6 = u_xlat6 / u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat6 * u_xlat3;
    u_xlat2 = (-vs_COLOR0) + _ColorB;
    u_xlat0 = u_xlat0.xxxx * u_xlat2 + vs_COLOR0;
    SV_Target0.w = u_xlat16_1.x * u_xlat0.w;
    u_xlat9 = vs_TEXCOORD0.x * _ScanlineGlowFrequency;
    u_xlat9 = _Time.y * _ScanlineGlowSpeed + u_xlat9;
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 0.5 + 0.5;
    u_xlat16_1.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat2.xyz = u_xlat16_1.xyz * vec3(u_xlat9) + (-u_xlat0.xyz);
    u_xlat9 = vs_TEXCOORD0.y * _ScanlineFrequency;
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 0.5 + 0.5;
    u_xlat9 = u_xlat9 * _ScanlineIntensity;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat2.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
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
uniform 	mediump vec4 _ColorA;
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
    u_xlat0 = in_COLOR0 * _ColorA;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
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
uniform 	vec4 _Time;
uniform 	mediump vec4 _ColorB;
uniform 	float _GradientScale;
uniform 	float _Radius;
uniform 	float _Thickness;
uniform 	float _ScanlineFrequency;
uniform 	float _ScanlineIntensity;
uniform 	float _ScanlineGlowFrequency;
uniform 	float _ScanlineGlowSpeed;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
float u_xlat3;
mediump float u_xlat16_4;
float u_xlat6;
float u_xlat9;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat16_1.x = dFdx(u_xlat0.x);
    u_xlat16_4 = dFdy(u_xlat0.x);
    u_xlat16_1.x = abs(u_xlat16_4) + abs(u_xlat16_1.x);
    u_xlat3 = u_xlat0.x + (-_Radius);
    u_xlat3 = u_xlat3 / u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3 = min(max(u_xlat3, 0.0), 1.0);
#else
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
#endif
    u_xlat3 = (-u_xlat3) + 1.0;
    u_xlat6 = (-_Thickness) + _Radius;
    u_xlat6 = (-u_xlat6) + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _GradientScale;
    u_xlat6 = u_xlat6 / u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat6 * u_xlat3;
    u_xlat2 = (-vs_COLOR0) + _ColorB;
    u_xlat0 = u_xlat0.xxxx * u_xlat2 + vs_COLOR0;
    SV_Target0.w = u_xlat16_1.x * u_xlat0.w;
    u_xlat9 = vs_TEXCOORD0.x * _ScanlineGlowFrequency;
    u_xlat9 = _Time.y * _ScanlineGlowSpeed + u_xlat9;
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 0.5 + 0.5;
    u_xlat16_1.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat2.xyz = u_xlat16_1.xyz * vec3(u_xlat9) + (-u_xlat0.xyz);
    u_xlat9 = vs_TEXCOORD0.y * _ScanlineFrequency;
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 0.5 + 0.5;
    u_xlat9 = u_xlat9 * _ScanlineIntensity;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat2.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
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
uniform 	mediump vec4 _ColorA;
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
    u_xlat0 = in_COLOR0 * _ColorA;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
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
uniform 	vec4 _Time;
uniform 	mediump vec4 _ColorB;
uniform 	float _GradientScale;
uniform 	float _Radius;
uniform 	float _Thickness;
uniform 	float _ScanlineFrequency;
uniform 	float _ScanlineIntensity;
uniform 	float _ScanlineGlowFrequency;
uniform 	float _ScanlineGlowSpeed;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
float u_xlat3;
mediump float u_xlat16_4;
float u_xlat6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat16_1.x = dFdx(u_xlat0.x);
    u_xlat16_4 = dFdy(u_xlat0.x);
    u_xlat16_1.x = abs(u_xlat16_4) + abs(u_xlat16_1.x);
    u_xlat3 = u_xlat0.x + (-_Radius);
    u_xlat3 = u_xlat3 / u_xlat16_1.x;
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
    u_xlat3 = (-u_xlat3) + 1.0;
    u_xlat6 = (-_Thickness) + _Radius;
    u_xlat6 = (-u_xlat6) + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _GradientScale;
    u_xlat6 = u_xlat6 / u_xlat16_1.x;
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
    u_xlat16_1.x = u_xlat6 * u_xlat3;
    u_xlat2 = (-vs_COLOR0) + _ColorB;
    u_xlat0 = u_xlat0.xxxx * u_xlat2 + vs_COLOR0;
    u_xlat16_4 = u_xlat0.w * u_xlat16_1.x + -0.00100000005;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat0.w;
    SV_Target0.w = u_xlat16_1.x;
    u_xlatb9 = u_xlat16_4<0.0;
    if(u_xlatb9){discard;}
    u_xlat9 = vs_TEXCOORD0.x * _ScanlineGlowFrequency;
    u_xlat9 = _Time.y * _ScanlineGlowSpeed + u_xlat9;
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 0.5 + 0.5;
    u_xlat16_1.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat2.xyz = u_xlat16_1.xyz * vec3(u_xlat9) + (-u_xlat0.xyz);
    u_xlat9 = vs_TEXCOORD0.y * _ScanlineFrequency;
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 0.5 + 0.5;
    u_xlat9 = u_xlat9 * _ScanlineIntensity;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat2.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
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
uniform 	mediump vec4 _ColorA;
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
    u_xlat0 = in_COLOR0 * _ColorA;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
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
uniform 	vec4 _Time;
uniform 	mediump vec4 _ColorB;
uniform 	float _GradientScale;
uniform 	float _Radius;
uniform 	float _Thickness;
uniform 	float _ScanlineFrequency;
uniform 	float _ScanlineIntensity;
uniform 	float _ScanlineGlowFrequency;
uniform 	float _ScanlineGlowSpeed;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
float u_xlat3;
mediump float u_xlat16_4;
float u_xlat6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat16_1.x = dFdx(u_xlat0.x);
    u_xlat16_4 = dFdy(u_xlat0.x);
    u_xlat16_1.x = abs(u_xlat16_4) + abs(u_xlat16_1.x);
    u_xlat3 = u_xlat0.x + (-_Radius);
    u_xlat3 = u_xlat3 / u_xlat16_1.x;
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
    u_xlat3 = (-u_xlat3) + 1.0;
    u_xlat6 = (-_Thickness) + _Radius;
    u_xlat6 = (-u_xlat6) + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _GradientScale;
    u_xlat6 = u_xlat6 / u_xlat16_1.x;
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
    u_xlat16_1.x = u_xlat6 * u_xlat3;
    u_xlat2 = (-vs_COLOR0) + _ColorB;
    u_xlat0 = u_xlat0.xxxx * u_xlat2 + vs_COLOR0;
    u_xlat16_4 = u_xlat0.w * u_xlat16_1.x + -0.00100000005;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat0.w;
    SV_Target0.w = u_xlat16_1.x;
    u_xlatb9 = u_xlat16_4<0.0;
    if(u_xlatb9){discard;}
    u_xlat9 = vs_TEXCOORD0.x * _ScanlineGlowFrequency;
    u_xlat9 = _Time.y * _ScanlineGlowSpeed + u_xlat9;
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 0.5 + 0.5;
    u_xlat16_1.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat2.xyz = u_xlat16_1.xyz * vec3(u_xlat9) + (-u_xlat0.xyz);
    u_xlat9 = vs_TEXCOORD0.y * _ScanlineFrequency;
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 0.5 + 0.5;
    u_xlat9 = u_xlat9 * _ScanlineIntensity;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat2.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
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
uniform 	mediump vec4 _ColorA;
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
    u_xlat0 = in_COLOR0 * _ColorA;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
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
uniform 	vec4 _Time;
uniform 	mediump vec4 _ColorB;
uniform 	float _GradientScale;
uniform 	float _Radius;
uniform 	float _Thickness;
uniform 	float _ScanlineFrequency;
uniform 	float _ScanlineIntensity;
uniform 	float _ScanlineGlowFrequency;
uniform 	float _ScanlineGlowSpeed;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
float u_xlat3;
mediump float u_xlat16_4;
float u_xlat6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat16_1.x = dFdx(u_xlat0.x);
    u_xlat16_4 = dFdy(u_xlat0.x);
    u_xlat16_1.x = abs(u_xlat16_4) + abs(u_xlat16_1.x);
    u_xlat3 = u_xlat0.x + (-_Radius);
    u_xlat3 = u_xlat3 / u_xlat16_1.x;
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
    u_xlat3 = (-u_xlat3) + 1.0;
    u_xlat6 = (-_Thickness) + _Radius;
    u_xlat6 = (-u_xlat6) + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _GradientScale;
    u_xlat6 = u_xlat6 / u_xlat16_1.x;
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
    u_xlat16_1.x = u_xlat6 * u_xlat3;
    u_xlat2 = (-vs_COLOR0) + _ColorB;
    u_xlat0 = u_xlat0.xxxx * u_xlat2 + vs_COLOR0;
    u_xlat16_4 = u_xlat0.w * u_xlat16_1.x + -0.00100000005;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat0.w;
    SV_Target0.w = u_xlat16_1.x;
    u_xlatb9 = u_xlat16_4<0.0;
    if(u_xlatb9){discard;}
    u_xlat9 = vs_TEXCOORD0.x * _ScanlineGlowFrequency;
    u_xlat9 = _Time.y * _ScanlineGlowSpeed + u_xlat9;
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 0.5 + 0.5;
    u_xlat16_1.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat2.xyz = u_xlat16_1.xyz * vec3(u_xlat9) + (-u_xlat0.xyz);
    u_xlat9 = vs_TEXCOORD0.y * _ScanlineFrequency;
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 0.5 + 0.5;
    u_xlat9 = u_xlat9 * _ScanlineIntensity;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat2.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
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
uniform 	mediump vec4 _ColorA;
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
    u_xlat0 = in_COLOR0 * _ColorA;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
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
uniform 	vec4 _Time;
uniform 	mediump vec4 _ColorB;
uniform 	float _GradientScale;
uniform 	float _Radius;
uniform 	float _Thickness;
uniform 	float _ScanlineFrequency;
uniform 	float _ScanlineIntensity;
uniform 	float _ScanlineGlowFrequency;
uniform 	float _ScanlineGlowSpeed;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
float u_xlat3;
mediump float u_xlat16_4;
float u_xlat6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat16_1.x = dFdx(u_xlat0.x);
    u_xlat16_4 = dFdy(u_xlat0.x);
    u_xlat16_1.x = abs(u_xlat16_4) + abs(u_xlat16_1.x);
    u_xlat3 = u_xlat0.x + (-_Radius);
    u_xlat3 = u_xlat3 / u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3 = min(max(u_xlat3, 0.0), 1.0);
#else
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
#endif
    u_xlat3 = (-u_xlat3) + 1.0;
    u_xlat6 = (-_Thickness) + _Radius;
    u_xlat6 = (-u_xlat6) + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _GradientScale;
    u_xlat6 = u_xlat6 / u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat6 * u_xlat3;
    u_xlat2 = (-vs_COLOR0) + _ColorB;
    u_xlat0 = u_xlat0.xxxx * u_xlat2 + vs_COLOR0;
    u_xlat16_4 = u_xlat0.w * u_xlat16_1.x + -0.00100000005;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat0.w;
    SV_Target0.w = u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat16_4<0.0);
#else
    u_xlatb9 = u_xlat16_4<0.0;
#endif
    if(u_xlatb9){discard;}
    u_xlat9 = vs_TEXCOORD0.x * _ScanlineGlowFrequency;
    u_xlat9 = _Time.y * _ScanlineGlowSpeed + u_xlat9;
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 0.5 + 0.5;
    u_xlat16_1.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat2.xyz = u_xlat16_1.xyz * vec3(u_xlat9) + (-u_xlat0.xyz);
    u_xlat9 = vs_TEXCOORD0.y * _ScanlineFrequency;
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 0.5 + 0.5;
    u_xlat9 = u_xlat9 * _ScanlineIntensity;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat2.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
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
uniform 	mediump vec4 _ColorA;
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
    u_xlat0 = in_COLOR0 * _ColorA;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
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
uniform 	vec4 _Time;
uniform 	mediump vec4 _ColorB;
uniform 	float _GradientScale;
uniform 	float _Radius;
uniform 	float _Thickness;
uniform 	float _ScanlineFrequency;
uniform 	float _ScanlineIntensity;
uniform 	float _ScanlineGlowFrequency;
uniform 	float _ScanlineGlowSpeed;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
float u_xlat3;
mediump float u_xlat16_4;
float u_xlat6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat16_1.x = dFdx(u_xlat0.x);
    u_xlat16_4 = dFdy(u_xlat0.x);
    u_xlat16_1.x = abs(u_xlat16_4) + abs(u_xlat16_1.x);
    u_xlat3 = u_xlat0.x + (-_Radius);
    u_xlat3 = u_xlat3 / u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3 = min(max(u_xlat3, 0.0), 1.0);
#else
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
#endif
    u_xlat3 = (-u_xlat3) + 1.0;
    u_xlat6 = (-_Thickness) + _Radius;
    u_xlat6 = (-u_xlat6) + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _GradientScale;
    u_xlat6 = u_xlat6 / u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat6 * u_xlat3;
    u_xlat2 = (-vs_COLOR0) + _ColorB;
    u_xlat0 = u_xlat0.xxxx * u_xlat2 + vs_COLOR0;
    u_xlat16_4 = u_xlat0.w * u_xlat16_1.x + -0.00100000005;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat0.w;
    SV_Target0.w = u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat16_4<0.0);
#else
    u_xlatb9 = u_xlat16_4<0.0;
#endif
    if(u_xlatb9){discard;}
    u_xlat9 = vs_TEXCOORD0.x * _ScanlineGlowFrequency;
    u_xlat9 = _Time.y * _ScanlineGlowSpeed + u_xlat9;
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 0.5 + 0.5;
    u_xlat16_1.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat2.xyz = u_xlat16_1.xyz * vec3(u_xlat9) + (-u_xlat0.xyz);
    u_xlat9 = vs_TEXCOORD0.y * _ScanlineFrequency;
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 0.5 + 0.5;
    u_xlat9 = u_xlat9 * _ScanlineIntensity;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat2.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
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
uniform 	mediump vec4 _ColorA;
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
    u_xlat0 = in_COLOR0 * _ColorA;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
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
uniform 	vec4 _Time;
uniform 	mediump vec4 _ColorB;
uniform 	float _GradientScale;
uniform 	float _Radius;
uniform 	float _Thickness;
uniform 	float _ScanlineFrequency;
uniform 	float _ScanlineIntensity;
uniform 	float _ScanlineGlowFrequency;
uniform 	float _ScanlineGlowSpeed;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
float u_xlat3;
mediump float u_xlat16_4;
float u_xlat6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat16_1.x = dFdx(u_xlat0.x);
    u_xlat16_4 = dFdy(u_xlat0.x);
    u_xlat16_1.x = abs(u_xlat16_4) + abs(u_xlat16_1.x);
    u_xlat3 = u_xlat0.x + (-_Radius);
    u_xlat3 = u_xlat3 / u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3 = min(max(u_xlat3, 0.0), 1.0);
#else
    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
#endif
    u_xlat3 = (-u_xlat3) + 1.0;
    u_xlat6 = (-_Thickness) + _Radius;
    u_xlat6 = (-u_xlat6) + u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _GradientScale;
    u_xlat6 = u_xlat6 / u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat6 = min(max(u_xlat6, 0.0), 1.0);
#else
    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat6 * u_xlat3;
    u_xlat2 = (-vs_COLOR0) + _ColorB;
    u_xlat0 = u_xlat0.xxxx * u_xlat2 + vs_COLOR0;
    u_xlat16_4 = u_xlat0.w * u_xlat16_1.x + -0.00100000005;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat0.w;
    SV_Target0.w = u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat16_4<0.0);
#else
    u_xlatb9 = u_xlat16_4<0.0;
#endif
    if(u_xlatb9){discard;}
    u_xlat9 = vs_TEXCOORD0.x * _ScanlineGlowFrequency;
    u_xlat9 = _Time.y * _ScanlineGlowSpeed + u_xlat9;
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 0.5 + 0.5;
    u_xlat16_1.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat2.xyz = u_xlat16_1.xyz * vec3(u_xlat9) + (-u_xlat0.xyz);
    u_xlat9 = vs_TEXCOORD0.y * _ScanlineFrequency;
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 0.5 + 0.5;
    u_xlat9 = u_xlat9 * _ScanlineIntensity;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat2.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
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
uniform 	mediump vec4 _ColorA;
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
    u_xlat0 = in_COLOR0 * _ColorA;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
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
uniform 	vec4 _Time;
uniform 	mediump vec4 _ColorB;
uniform 	vec4 _ClipRect;
uniform 	float _GradientScale;
uniform 	float _Radius;
uniform 	float _Thickness;
uniform 	float _ScanlineFrequency;
uniform 	float _ScanlineIntensity;
uniform 	float _ScanlineGlowFrequency;
uniform 	float _ScanlineGlowSpeed;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
bvec4 u_xlatb0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat4;
mediump float u_xlat16_5;
float u_xlat8;
float u_xlat12;
float u_xlat14;
void main()
{
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
;
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat4 = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
    u_xlat4 = sqrt(u_xlat4);
    u_xlat16_1.x = dFdx(u_xlat4);
    u_xlat16_5 = dFdy(u_xlat4);
    u_xlat16_1.x = abs(u_xlat16_5) + abs(u_xlat16_1.x);
    u_xlat8 = u_xlat4 + (-_Radius);
    u_xlat8 = u_xlat8 / u_xlat16_1.x;
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
    u_xlat8 = (-u_xlat8) + 1.0;
    u_xlat12 = (-_Thickness) + _Radius;
    u_xlat12 = (-u_xlat12) + u_xlat4;
    u_xlat4 = u_xlat4 * _GradientScale;
    u_xlat12 = u_xlat12 / u_xlat16_1.x;
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
    u_xlat16_1.x = u_xlat12 * u_xlat8;
    u_xlat2 = (-vs_COLOR0) + _ColorB;
    u_xlat2 = vec4(u_xlat4) * u_xlat2 + vs_COLOR0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat2.w;
    u_xlat0.w = u_xlat0.x * u_xlat16_1.x;
    u_xlat14 = vs_TEXCOORD0.x * _ScanlineGlowFrequency;
    u_xlat14 = _Time.y * _ScanlineGlowSpeed + u_xlat14;
    u_xlat14 = sin(u_xlat14);
    u_xlat14 = u_xlat14 * 0.5 + 0.5;
    u_xlat16_1.xyz = u_xlat2.xyz + u_xlat2.xyz;
    u_xlat3.xyz = u_xlat16_1.xyz * vec3(u_xlat14) + (-u_xlat2.xyz);
    u_xlat14 = vs_TEXCOORD0.y * _ScanlineFrequency;
    u_xlat14 = sin(u_xlat14);
    u_xlat14 = u_xlat14 * 0.5 + 0.5;
    u_xlat14 = u_xlat14 * _ScanlineIntensity;
    u_xlat0.xyz = vec3(u_xlat14) * u_xlat3.xyz + u_xlat2.xyz;
    SV_Target0 = u_xlat0;
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
uniform 	mediump vec4 _ColorA;
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
    u_xlat0 = in_COLOR0 * _ColorA;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
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
uniform 	vec4 _Time;
uniform 	mediump vec4 _ColorB;
uniform 	vec4 _ClipRect;
uniform 	float _GradientScale;
uniform 	float _Radius;
uniform 	float _Thickness;
uniform 	float _ScanlineFrequency;
uniform 	float _ScanlineIntensity;
uniform 	float _ScanlineGlowFrequency;
uniform 	float _ScanlineGlowSpeed;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
bvec4 u_xlatb0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat4;
mediump float u_xlat16_5;
float u_xlat8;
float u_xlat12;
float u_xlat14;
void main()
{
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
;
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat4 = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
    u_xlat4 = sqrt(u_xlat4);
    u_xlat16_1.x = dFdx(u_xlat4);
    u_xlat16_5 = dFdy(u_xlat4);
    u_xlat16_1.x = abs(u_xlat16_5) + abs(u_xlat16_1.x);
    u_xlat8 = u_xlat4 + (-_Radius);
    u_xlat8 = u_xlat8 / u_xlat16_1.x;
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
    u_xlat8 = (-u_xlat8) + 1.0;
    u_xlat12 = (-_Thickness) + _Radius;
    u_xlat12 = (-u_xlat12) + u_xlat4;
    u_xlat4 = u_xlat4 * _GradientScale;
    u_xlat12 = u_xlat12 / u_xlat16_1.x;
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
    u_xlat16_1.x = u_xlat12 * u_xlat8;
    u_xlat2 = (-vs_COLOR0) + _ColorB;
    u_xlat2 = vec4(u_xlat4) * u_xlat2 + vs_COLOR0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat2.w;
    u_xlat0.w = u_xlat0.x * u_xlat16_1.x;
    u_xlat14 = vs_TEXCOORD0.x * _ScanlineGlowFrequency;
    u_xlat14 = _Time.y * _ScanlineGlowSpeed + u_xlat14;
    u_xlat14 = sin(u_xlat14);
    u_xlat14 = u_xlat14 * 0.5 + 0.5;
    u_xlat16_1.xyz = u_xlat2.xyz + u_xlat2.xyz;
    u_xlat3.xyz = u_xlat16_1.xyz * vec3(u_xlat14) + (-u_xlat2.xyz);
    u_xlat14 = vs_TEXCOORD0.y * _ScanlineFrequency;
    u_xlat14 = sin(u_xlat14);
    u_xlat14 = u_xlat14 * 0.5 + 0.5;
    u_xlat14 = u_xlat14 * _ScanlineIntensity;
    u_xlat0.xyz = vec3(u_xlat14) * u_xlat3.xyz + u_xlat2.xyz;
    SV_Target0 = u_xlat0;
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
uniform 	mediump vec4 _ColorA;
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
    u_xlat0 = in_COLOR0 * _ColorA;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
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
uniform 	vec4 _Time;
uniform 	mediump vec4 _ColorB;
uniform 	vec4 _ClipRect;
uniform 	float _GradientScale;
uniform 	float _Radius;
uniform 	float _Thickness;
uniform 	float _ScanlineFrequency;
uniform 	float _ScanlineIntensity;
uniform 	float _ScanlineGlowFrequency;
uniform 	float _ScanlineGlowSpeed;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
bvec4 u_xlatb0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat4;
mediump float u_xlat16_5;
float u_xlat8;
float u_xlat12;
float u_xlat14;
void main()
{
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
;
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat4 = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
    u_xlat4 = sqrt(u_xlat4);
    u_xlat16_1.x = dFdx(u_xlat4);
    u_xlat16_5 = dFdy(u_xlat4);
    u_xlat16_1.x = abs(u_xlat16_5) + abs(u_xlat16_1.x);
    u_xlat8 = u_xlat4 + (-_Radius);
    u_xlat8 = u_xlat8 / u_xlat16_1.x;
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
    u_xlat8 = (-u_xlat8) + 1.0;
    u_xlat12 = (-_Thickness) + _Radius;
    u_xlat12 = (-u_xlat12) + u_xlat4;
    u_xlat4 = u_xlat4 * _GradientScale;
    u_xlat12 = u_xlat12 / u_xlat16_1.x;
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
    u_xlat16_1.x = u_xlat12 * u_xlat8;
    u_xlat2 = (-vs_COLOR0) + _ColorB;
    u_xlat2 = vec4(u_xlat4) * u_xlat2 + vs_COLOR0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat2.w;
    u_xlat0.w = u_xlat0.x * u_xlat16_1.x;
    u_xlat14 = vs_TEXCOORD0.x * _ScanlineGlowFrequency;
    u_xlat14 = _Time.y * _ScanlineGlowSpeed + u_xlat14;
    u_xlat14 = sin(u_xlat14);
    u_xlat14 = u_xlat14 * 0.5 + 0.5;
    u_xlat16_1.xyz = u_xlat2.xyz + u_xlat2.xyz;
    u_xlat3.xyz = u_xlat16_1.xyz * vec3(u_xlat14) + (-u_xlat2.xyz);
    u_xlat14 = vs_TEXCOORD0.y * _ScanlineFrequency;
    u_xlat14 = sin(u_xlat14);
    u_xlat14 = u_xlat14 * 0.5 + 0.5;
    u_xlat14 = u_xlat14 * _ScanlineIntensity;
    u_xlat0.xyz = vec3(u_xlat14) * u_xlat3.xyz + u_xlat2.xyz;
    SV_Target0 = u_xlat0;
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
uniform 	mediump vec4 _ColorA;
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
    u_xlat0 = in_COLOR0 * _ColorA;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
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
uniform 	vec4 _Time;
uniform 	mediump vec4 _ColorB;
uniform 	vec4 _ClipRect;
uniform 	float _GradientScale;
uniform 	float _Radius;
uniform 	float _Thickness;
uniform 	float _ScanlineFrequency;
uniform 	float _ScanlineIntensity;
uniform 	float _ScanlineGlowFrequency;
uniform 	float _ScanlineGlowSpeed;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat4;
mediump float u_xlat16_5;
float u_xlat8;
float u_xlat12;
float u_xlat14;
void main()
{
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
;
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat4 = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
    u_xlat4 = sqrt(u_xlat4);
    u_xlat16_1.x = dFdx(u_xlat4);
    u_xlat16_5 = dFdy(u_xlat4);
    u_xlat16_1.x = abs(u_xlat16_5) + abs(u_xlat16_1.x);
    u_xlat8 = u_xlat4 + (-_Radius);
    u_xlat8 = u_xlat8 / u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat8 = (-u_xlat8) + 1.0;
    u_xlat12 = (-_Thickness) + _Radius;
    u_xlat12 = (-u_xlat12) + u_xlat4;
    u_xlat4 = u_xlat4 * _GradientScale;
    u_xlat12 = u_xlat12 / u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat12 * u_xlat8;
    u_xlat2 = (-vs_COLOR0) + _ColorB;
    u_xlat2 = vec4(u_xlat4) * u_xlat2 + vs_COLOR0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat2.w;
    u_xlat0.w = u_xlat0.x * u_xlat16_1.x;
    u_xlat14 = vs_TEXCOORD0.x * _ScanlineGlowFrequency;
    u_xlat14 = _Time.y * _ScanlineGlowSpeed + u_xlat14;
    u_xlat14 = sin(u_xlat14);
    u_xlat14 = u_xlat14 * 0.5 + 0.5;
    u_xlat16_1.xyz = u_xlat2.xyz + u_xlat2.xyz;
    u_xlat3.xyz = u_xlat16_1.xyz * vec3(u_xlat14) + (-u_xlat2.xyz);
    u_xlat14 = vs_TEXCOORD0.y * _ScanlineFrequency;
    u_xlat14 = sin(u_xlat14);
    u_xlat14 = u_xlat14 * 0.5 + 0.5;
    u_xlat14 = u_xlat14 * _ScanlineIntensity;
    u_xlat0.xyz = vec3(u_xlat14) * u_xlat3.xyz + u_xlat2.xyz;
    SV_Target0 = u_xlat0;
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
uniform 	mediump vec4 _ColorA;
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
    u_xlat0 = in_COLOR0 * _ColorA;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
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
uniform 	vec4 _Time;
uniform 	mediump vec4 _ColorB;
uniform 	vec4 _ClipRect;
uniform 	float _GradientScale;
uniform 	float _Radius;
uniform 	float _Thickness;
uniform 	float _ScanlineFrequency;
uniform 	float _ScanlineIntensity;
uniform 	float _ScanlineGlowFrequency;
uniform 	float _ScanlineGlowSpeed;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat4;
mediump float u_xlat16_5;
float u_xlat8;
float u_xlat12;
float u_xlat14;
void main()
{
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
;
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat4 = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
    u_xlat4 = sqrt(u_xlat4);
    u_xlat16_1.x = dFdx(u_xlat4);
    u_xlat16_5 = dFdy(u_xlat4);
    u_xlat16_1.x = abs(u_xlat16_5) + abs(u_xlat16_1.x);
    u_xlat8 = u_xlat4 + (-_Radius);
    u_xlat8 = u_xlat8 / u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat8 = (-u_xlat8) + 1.0;
    u_xlat12 = (-_Thickness) + _Radius;
    u_xlat12 = (-u_xlat12) + u_xlat4;
    u_xlat4 = u_xlat4 * _GradientScale;
    u_xlat12 = u_xlat12 / u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat12 * u_xlat8;
    u_xlat2 = (-vs_COLOR0) + _ColorB;
    u_xlat2 = vec4(u_xlat4) * u_xlat2 + vs_COLOR0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat2.w;
    u_xlat0.w = u_xlat0.x * u_xlat16_1.x;
    u_xlat14 = vs_TEXCOORD0.x * _ScanlineGlowFrequency;
    u_xlat14 = _Time.y * _ScanlineGlowSpeed + u_xlat14;
    u_xlat14 = sin(u_xlat14);
    u_xlat14 = u_xlat14 * 0.5 + 0.5;
    u_xlat16_1.xyz = u_xlat2.xyz + u_xlat2.xyz;
    u_xlat3.xyz = u_xlat16_1.xyz * vec3(u_xlat14) + (-u_xlat2.xyz);
    u_xlat14 = vs_TEXCOORD0.y * _ScanlineFrequency;
    u_xlat14 = sin(u_xlat14);
    u_xlat14 = u_xlat14 * 0.5 + 0.5;
    u_xlat14 = u_xlat14 * _ScanlineIntensity;
    u_xlat0.xyz = vec3(u_xlat14) * u_xlat3.xyz + u_xlat2.xyz;
    SV_Target0 = u_xlat0;
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
uniform 	mediump vec4 _ColorA;
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
    u_xlat0 = in_COLOR0 * _ColorA;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
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
uniform 	vec4 _Time;
uniform 	mediump vec4 _ColorB;
uniform 	vec4 _ClipRect;
uniform 	float _GradientScale;
uniform 	float _Radius;
uniform 	float _Thickness;
uniform 	float _ScanlineFrequency;
uniform 	float _ScanlineIntensity;
uniform 	float _ScanlineGlowFrequency;
uniform 	float _ScanlineGlowSpeed;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat4;
mediump float u_xlat16_5;
float u_xlat8;
float u_xlat12;
float u_xlat14;
void main()
{
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
;
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat4 = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
    u_xlat4 = sqrt(u_xlat4);
    u_xlat16_1.x = dFdx(u_xlat4);
    u_xlat16_5 = dFdy(u_xlat4);
    u_xlat16_1.x = abs(u_xlat16_5) + abs(u_xlat16_1.x);
    u_xlat8 = u_xlat4 + (-_Radius);
    u_xlat8 = u_xlat8 / u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat8 = (-u_xlat8) + 1.0;
    u_xlat12 = (-_Thickness) + _Radius;
    u_xlat12 = (-u_xlat12) + u_xlat4;
    u_xlat4 = u_xlat4 * _GradientScale;
    u_xlat12 = u_xlat12 / u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat12 * u_xlat8;
    u_xlat2 = (-vs_COLOR0) + _ColorB;
    u_xlat2 = vec4(u_xlat4) * u_xlat2 + vs_COLOR0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat2.w;
    u_xlat0.w = u_xlat0.x * u_xlat16_1.x;
    u_xlat14 = vs_TEXCOORD0.x * _ScanlineGlowFrequency;
    u_xlat14 = _Time.y * _ScanlineGlowSpeed + u_xlat14;
    u_xlat14 = sin(u_xlat14);
    u_xlat14 = u_xlat14 * 0.5 + 0.5;
    u_xlat16_1.xyz = u_xlat2.xyz + u_xlat2.xyz;
    u_xlat3.xyz = u_xlat16_1.xyz * vec3(u_xlat14) + (-u_xlat2.xyz);
    u_xlat14 = vs_TEXCOORD0.y * _ScanlineFrequency;
    u_xlat14 = sin(u_xlat14);
    u_xlat14 = u_xlat14 * 0.5 + 0.5;
    u_xlat14 = u_xlat14 * _ScanlineIntensity;
    u_xlat0.xyz = vec3(u_xlat14) * u_xlat3.xyz + u_xlat2.xyz;
    SV_Target0 = u_xlat0;
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
uniform 	mediump vec4 _ColorA;
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
    u_xlat0 = in_COLOR0 * _ColorA;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
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
uniform 	vec4 _Time;
uniform 	mediump vec4 _ColorB;
uniform 	vec4 _ClipRect;
uniform 	float _GradientScale;
uniform 	float _Radius;
uniform 	float _Thickness;
uniform 	float _ScanlineFrequency;
uniform 	float _ScanlineIntensity;
uniform 	float _ScanlineGlowFrequency;
uniform 	float _ScanlineGlowSpeed;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
bvec4 u_xlatb0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat4;
mediump float u_xlat16_5;
float u_xlat8;
float u_xlat12;
float u_xlat14;
bool u_xlatb14;
void main()
{
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
;
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat4 = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
    u_xlat4 = sqrt(u_xlat4);
    u_xlat16_1.x = dFdx(u_xlat4);
    u_xlat16_5 = dFdy(u_xlat4);
    u_xlat16_1.x = abs(u_xlat16_5) + abs(u_xlat16_1.x);
    u_xlat8 = u_xlat4 + (-_Radius);
    u_xlat8 = u_xlat8 / u_xlat16_1.x;
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
    u_xlat8 = (-u_xlat8) + 1.0;
    u_xlat12 = (-_Thickness) + _Radius;
    u_xlat12 = (-u_xlat12) + u_xlat4;
    u_xlat4 = u_xlat4 * _GradientScale;
    u_xlat12 = u_xlat12 / u_xlat16_1.x;
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
    u_xlat16_1.x = u_xlat12 * u_xlat8;
    u_xlat2 = (-vs_COLOR0) + _ColorB;
    u_xlat2 = vec4(u_xlat4) * u_xlat2 + vs_COLOR0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat2.w;
    u_xlat16_5 = u_xlat16_1.x * u_xlat0.x + -0.00100000005;
    u_xlat0.w = u_xlat0.x * u_xlat16_1.x;
    u_xlatb14 = u_xlat16_5<0.0;
    if(u_xlatb14){discard;}
    u_xlat14 = vs_TEXCOORD0.x * _ScanlineGlowFrequency;
    u_xlat14 = _Time.y * _ScanlineGlowSpeed + u_xlat14;
    u_xlat14 = sin(u_xlat14);
    u_xlat14 = u_xlat14 * 0.5 + 0.5;
    u_xlat16_1.xyz = u_xlat2.xyz + u_xlat2.xyz;
    u_xlat3.xyz = u_xlat16_1.xyz * vec3(u_xlat14) + (-u_xlat2.xyz);
    u_xlat14 = vs_TEXCOORD0.y * _ScanlineFrequency;
    u_xlat14 = sin(u_xlat14);
    u_xlat14 = u_xlat14 * 0.5 + 0.5;
    u_xlat14 = u_xlat14 * _ScanlineIntensity;
    u_xlat0.xyz = vec3(u_xlat14) * u_xlat3.xyz + u_xlat2.xyz;
    SV_Target0 = u_xlat0;
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
uniform 	mediump vec4 _ColorA;
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
    u_xlat0 = in_COLOR0 * _ColorA;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
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
uniform 	vec4 _Time;
uniform 	mediump vec4 _ColorB;
uniform 	vec4 _ClipRect;
uniform 	float _GradientScale;
uniform 	float _Radius;
uniform 	float _Thickness;
uniform 	float _ScanlineFrequency;
uniform 	float _ScanlineIntensity;
uniform 	float _ScanlineGlowFrequency;
uniform 	float _ScanlineGlowSpeed;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
bvec4 u_xlatb0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat4;
mediump float u_xlat16_5;
float u_xlat8;
float u_xlat12;
float u_xlat14;
bool u_xlatb14;
void main()
{
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
;
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat4 = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
    u_xlat4 = sqrt(u_xlat4);
    u_xlat16_1.x = dFdx(u_xlat4);
    u_xlat16_5 = dFdy(u_xlat4);
    u_xlat16_1.x = abs(u_xlat16_5) + abs(u_xlat16_1.x);
    u_xlat8 = u_xlat4 + (-_Radius);
    u_xlat8 = u_xlat8 / u_xlat16_1.x;
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
    u_xlat8 = (-u_xlat8) + 1.0;
    u_xlat12 = (-_Thickness) + _Radius;
    u_xlat12 = (-u_xlat12) + u_xlat4;
    u_xlat4 = u_xlat4 * _GradientScale;
    u_xlat12 = u_xlat12 / u_xlat16_1.x;
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
    u_xlat16_1.x = u_xlat12 * u_xlat8;
    u_xlat2 = (-vs_COLOR0) + _ColorB;
    u_xlat2 = vec4(u_xlat4) * u_xlat2 + vs_COLOR0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat2.w;
    u_xlat16_5 = u_xlat16_1.x * u_xlat0.x + -0.00100000005;
    u_xlat0.w = u_xlat0.x * u_xlat16_1.x;
    u_xlatb14 = u_xlat16_5<0.0;
    if(u_xlatb14){discard;}
    u_xlat14 = vs_TEXCOORD0.x * _ScanlineGlowFrequency;
    u_xlat14 = _Time.y * _ScanlineGlowSpeed + u_xlat14;
    u_xlat14 = sin(u_xlat14);
    u_xlat14 = u_xlat14 * 0.5 + 0.5;
    u_xlat16_1.xyz = u_xlat2.xyz + u_xlat2.xyz;
    u_xlat3.xyz = u_xlat16_1.xyz * vec3(u_xlat14) + (-u_xlat2.xyz);
    u_xlat14 = vs_TEXCOORD0.y * _ScanlineFrequency;
    u_xlat14 = sin(u_xlat14);
    u_xlat14 = u_xlat14 * 0.5 + 0.5;
    u_xlat14 = u_xlat14 * _ScanlineIntensity;
    u_xlat0.xyz = vec3(u_xlat14) * u_xlat3.xyz + u_xlat2.xyz;
    SV_Target0 = u_xlat0;
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
uniform 	mediump vec4 _ColorA;
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
    u_xlat0 = in_COLOR0 * _ColorA;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
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
uniform 	vec4 _Time;
uniform 	mediump vec4 _ColorB;
uniform 	vec4 _ClipRect;
uniform 	float _GradientScale;
uniform 	float _Radius;
uniform 	float _Thickness;
uniform 	float _ScanlineFrequency;
uniform 	float _ScanlineIntensity;
uniform 	float _ScanlineGlowFrequency;
uniform 	float _ScanlineGlowSpeed;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
bvec4 u_xlatb0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat4;
mediump float u_xlat16_5;
float u_xlat8;
float u_xlat12;
float u_xlat14;
bool u_xlatb14;
void main()
{
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
;
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat4 = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
    u_xlat4 = sqrt(u_xlat4);
    u_xlat16_1.x = dFdx(u_xlat4);
    u_xlat16_5 = dFdy(u_xlat4);
    u_xlat16_1.x = abs(u_xlat16_5) + abs(u_xlat16_1.x);
    u_xlat8 = u_xlat4 + (-_Radius);
    u_xlat8 = u_xlat8 / u_xlat16_1.x;
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
    u_xlat8 = (-u_xlat8) + 1.0;
    u_xlat12 = (-_Thickness) + _Radius;
    u_xlat12 = (-u_xlat12) + u_xlat4;
    u_xlat4 = u_xlat4 * _GradientScale;
    u_xlat12 = u_xlat12 / u_xlat16_1.x;
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
    u_xlat16_1.x = u_xlat12 * u_xlat8;
    u_xlat2 = (-vs_COLOR0) + _ColorB;
    u_xlat2 = vec4(u_xlat4) * u_xlat2 + vs_COLOR0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat2.w;
    u_xlat16_5 = u_xlat16_1.x * u_xlat0.x + -0.00100000005;
    u_xlat0.w = u_xlat0.x * u_xlat16_1.x;
    u_xlatb14 = u_xlat16_5<0.0;
    if(u_xlatb14){discard;}
    u_xlat14 = vs_TEXCOORD0.x * _ScanlineGlowFrequency;
    u_xlat14 = _Time.y * _ScanlineGlowSpeed + u_xlat14;
    u_xlat14 = sin(u_xlat14);
    u_xlat14 = u_xlat14 * 0.5 + 0.5;
    u_xlat16_1.xyz = u_xlat2.xyz + u_xlat2.xyz;
    u_xlat3.xyz = u_xlat16_1.xyz * vec3(u_xlat14) + (-u_xlat2.xyz);
    u_xlat14 = vs_TEXCOORD0.y * _ScanlineFrequency;
    u_xlat14 = sin(u_xlat14);
    u_xlat14 = u_xlat14 * 0.5 + 0.5;
    u_xlat14 = u_xlat14 * _ScanlineIntensity;
    u_xlat0.xyz = vec3(u_xlat14) * u_xlat3.xyz + u_xlat2.xyz;
    SV_Target0 = u_xlat0;
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
uniform 	mediump vec4 _ColorA;
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
    u_xlat0 = in_COLOR0 * _ColorA;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
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
uniform 	vec4 _Time;
uniform 	mediump vec4 _ColorB;
uniform 	vec4 _ClipRect;
uniform 	float _GradientScale;
uniform 	float _Radius;
uniform 	float _Thickness;
uniform 	float _ScanlineFrequency;
uniform 	float _ScanlineIntensity;
uniform 	float _ScanlineGlowFrequency;
uniform 	float _ScanlineGlowSpeed;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat4;
mediump float u_xlat16_5;
float u_xlat8;
float u_xlat12;
float u_xlat14;
bool u_xlatb14;
void main()
{
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
;
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat4 = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
    u_xlat4 = sqrt(u_xlat4);
    u_xlat16_1.x = dFdx(u_xlat4);
    u_xlat16_5 = dFdy(u_xlat4);
    u_xlat16_1.x = abs(u_xlat16_5) + abs(u_xlat16_1.x);
    u_xlat8 = u_xlat4 + (-_Radius);
    u_xlat8 = u_xlat8 / u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat8 = (-u_xlat8) + 1.0;
    u_xlat12 = (-_Thickness) + _Radius;
    u_xlat12 = (-u_xlat12) + u_xlat4;
    u_xlat4 = u_xlat4 * _GradientScale;
    u_xlat12 = u_xlat12 / u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat12 * u_xlat8;
    u_xlat2 = (-vs_COLOR0) + _ColorB;
    u_xlat2 = vec4(u_xlat4) * u_xlat2 + vs_COLOR0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat2.w;
    u_xlat16_5 = u_xlat16_1.x * u_xlat0.x + -0.00100000005;
    u_xlat0.w = u_xlat0.x * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(u_xlat16_5<0.0);
#else
    u_xlatb14 = u_xlat16_5<0.0;
#endif
    if(u_xlatb14){discard;}
    u_xlat14 = vs_TEXCOORD0.x * _ScanlineGlowFrequency;
    u_xlat14 = _Time.y * _ScanlineGlowSpeed + u_xlat14;
    u_xlat14 = sin(u_xlat14);
    u_xlat14 = u_xlat14 * 0.5 + 0.5;
    u_xlat16_1.xyz = u_xlat2.xyz + u_xlat2.xyz;
    u_xlat3.xyz = u_xlat16_1.xyz * vec3(u_xlat14) + (-u_xlat2.xyz);
    u_xlat14 = vs_TEXCOORD0.y * _ScanlineFrequency;
    u_xlat14 = sin(u_xlat14);
    u_xlat14 = u_xlat14 * 0.5 + 0.5;
    u_xlat14 = u_xlat14 * _ScanlineIntensity;
    u_xlat0.xyz = vec3(u_xlat14) * u_xlat3.xyz + u_xlat2.xyz;
    SV_Target0 = u_xlat0;
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
uniform 	mediump vec4 _ColorA;
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
    u_xlat0 = in_COLOR0 * _ColorA;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
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
uniform 	vec4 _Time;
uniform 	mediump vec4 _ColorB;
uniform 	vec4 _ClipRect;
uniform 	float _GradientScale;
uniform 	float _Radius;
uniform 	float _Thickness;
uniform 	float _ScanlineFrequency;
uniform 	float _ScanlineIntensity;
uniform 	float _ScanlineGlowFrequency;
uniform 	float _ScanlineGlowSpeed;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat4;
mediump float u_xlat16_5;
float u_xlat8;
float u_xlat12;
float u_xlat14;
bool u_xlatb14;
void main()
{
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
;
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat4 = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
    u_xlat4 = sqrt(u_xlat4);
    u_xlat16_1.x = dFdx(u_xlat4);
    u_xlat16_5 = dFdy(u_xlat4);
    u_xlat16_1.x = abs(u_xlat16_5) + abs(u_xlat16_1.x);
    u_xlat8 = u_xlat4 + (-_Radius);
    u_xlat8 = u_xlat8 / u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat8 = (-u_xlat8) + 1.0;
    u_xlat12 = (-_Thickness) + _Radius;
    u_xlat12 = (-u_xlat12) + u_xlat4;
    u_xlat4 = u_xlat4 * _GradientScale;
    u_xlat12 = u_xlat12 / u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat12 * u_xlat8;
    u_xlat2 = (-vs_COLOR0) + _ColorB;
    u_xlat2 = vec4(u_xlat4) * u_xlat2 + vs_COLOR0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat2.w;
    u_xlat16_5 = u_xlat16_1.x * u_xlat0.x + -0.00100000005;
    u_xlat0.w = u_xlat0.x * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(u_xlat16_5<0.0);
#else
    u_xlatb14 = u_xlat16_5<0.0;
#endif
    if(u_xlatb14){discard;}
    u_xlat14 = vs_TEXCOORD0.x * _ScanlineGlowFrequency;
    u_xlat14 = _Time.y * _ScanlineGlowSpeed + u_xlat14;
    u_xlat14 = sin(u_xlat14);
    u_xlat14 = u_xlat14 * 0.5 + 0.5;
    u_xlat16_1.xyz = u_xlat2.xyz + u_xlat2.xyz;
    u_xlat3.xyz = u_xlat16_1.xyz * vec3(u_xlat14) + (-u_xlat2.xyz);
    u_xlat14 = vs_TEXCOORD0.y * _ScanlineFrequency;
    u_xlat14 = sin(u_xlat14);
    u_xlat14 = u_xlat14 * 0.5 + 0.5;
    u_xlat14 = u_xlat14 * _ScanlineIntensity;
    u_xlat0.xyz = vec3(u_xlat14) * u_xlat3.xyz + u_xlat2.xyz;
    SV_Target0 = u_xlat0;
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
uniform 	mediump vec4 _ColorA;
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
    u_xlat0 = in_COLOR0 * _ColorA;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
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
uniform 	vec4 _Time;
uniform 	mediump vec4 _ColorB;
uniform 	vec4 _ClipRect;
uniform 	float _GradientScale;
uniform 	float _Radius;
uniform 	float _Thickness;
uniform 	float _ScanlineFrequency;
uniform 	float _ScanlineIntensity;
uniform 	float _ScanlineGlowFrequency;
uniform 	float _ScanlineGlowSpeed;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat4;
mediump float u_xlat16_5;
float u_xlat8;
float u_xlat12;
float u_xlat14;
bool u_xlatb14;
void main()
{
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD1.xxxy).zw;
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
;
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat4 = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
    u_xlat4 = sqrt(u_xlat4);
    u_xlat16_1.x = dFdx(u_xlat4);
    u_xlat16_5 = dFdy(u_xlat4);
    u_xlat16_1.x = abs(u_xlat16_5) + abs(u_xlat16_1.x);
    u_xlat8 = u_xlat4 + (-_Radius);
    u_xlat8 = u_xlat8 / u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat8 = (-u_xlat8) + 1.0;
    u_xlat12 = (-_Thickness) + _Radius;
    u_xlat12 = (-u_xlat12) + u_xlat4;
    u_xlat4 = u_xlat4 * _GradientScale;
    u_xlat12 = u_xlat12 / u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat16_1.x = u_xlat12 * u_xlat8;
    u_xlat2 = (-vs_COLOR0) + _ColorB;
    u_xlat2 = vec4(u_xlat4) * u_xlat2 + vs_COLOR0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat2.w;
    u_xlat16_5 = u_xlat16_1.x * u_xlat0.x + -0.00100000005;
    u_xlat0.w = u_xlat0.x * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(u_xlat16_5<0.0);
#else
    u_xlatb14 = u_xlat16_5<0.0;
#endif
    if(u_xlatb14){discard;}
    u_xlat14 = vs_TEXCOORD0.x * _ScanlineGlowFrequency;
    u_xlat14 = _Time.y * _ScanlineGlowSpeed + u_xlat14;
    u_xlat14 = sin(u_xlat14);
    u_xlat14 = u_xlat14 * 0.5 + 0.5;
    u_xlat16_1.xyz = u_xlat2.xyz + u_xlat2.xyz;
    u_xlat3.xyz = u_xlat16_1.xyz * vec3(u_xlat14) + (-u_xlat2.xyz);
    u_xlat14 = vs_TEXCOORD0.y * _ScanlineFrequency;
    u_xlat14 = sin(u_xlat14);
    u_xlat14 = u_xlat14 * 0.5 + 0.5;
    u_xlat14 = u_xlat14 * _ScanlineIntensity;
    u_xlat0.xyz = vec3(u_xlat14) * u_xlat3.xyz + u_xlat2.xyz;
    SV_Target0 = u_xlat0;
    return;
}

#endif
"
}
}
}
}
}