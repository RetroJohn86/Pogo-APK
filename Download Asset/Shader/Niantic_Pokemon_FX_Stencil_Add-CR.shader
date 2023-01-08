//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Niantic/Pokemon/FX/Stencil/Add-CR" {
Properties {
_MainTex ("Base (RGB) Gloss (A)", 2D) = "white" { }
_MainTexTilling ("MainTexTilling", Vector) = (1,1,1,1)
_speedVariation ("speedVariation", Vector) = (0,0.5,0,1)
_MaskColor ("MaskColor", Color) = (0.5,0.5,0.5,1)
_MaskApply ("MaskApply", Range(0, 1)) = 1
_Intensity ("Intensity", Range(0, 10)) = 1
_NoiseA ("NoiseA", 2D) = "white" { }
_NoiseScroll ("NoiseScroll", Vector) = (0,0,0,0)
_Distortion ("Distortion", Range(0, 1)) = 0.5
[Enum(UnityEngine.Rendering.CompareFunction)] _StencilComp ("Stencil Compare Function", Float) = 8
[Enum(UnityEngine.Rendering.StencilOp)] _StencilOp ("Stencil Operation", Float) = 2
[Header(SORTING_AND_CULLING)] [Enum(UnityEngine.Rendering.CullMode)] _Cull ("Culling", Float) = 2
[Toggle] _ZWrite ("Z Write", Float) = 0
[Enum(UnityEngine.Rendering.CompareFunction)] _ZTest ("Z Test", Float) = 4
}
SubShader {
 LOD 100
 Tags { "QUEUE" = "Geometry+1" "RenderType" = "Opaque" }
 Pass {
  LOD 100
  Tags { "QUEUE" = "Geometry+1" "RenderType" = "Opaque" }
  Blend One One, One One
  ZTest Off
  ZWrite Off
  Cull Off
  Stencil {
   Comp Disabled
   Pass Keep
   Fail Keep
   ZFail Keep
  }
  GpuProgramID 57207
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _MainTexTilling;
uniform 	mediump vec4 _speedVariation;
uniform 	mediump vec4 _NoiseA_ST;
uniform 	mediump vec4 _NoiseScroll;
attribute highp vec4 in_POSITION0;
attribute mediump vec2 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
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
    u_xlat0.xy = _NoiseScroll.xy * _Time.yy + in_TEXCOORD0.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy * _NoiseA_ST.xy + _NoiseA_ST.zw;
    u_xlat0 = _Time.yyyy * _speedVariation;
    u_xlat0 = in_TEXCOORD0.xyxy * _MainTexTilling + u_xlat0;
    vs_TEXCOORD1 = u_xlat0;
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump float _Intensity;
uniform 	mediump float _Distortion;
uniform 	mediump vec4 _MaskColor;
uniform 	mediump float _MaskApply;
uniform lowp sampler2D _NoiseA;
uniform lowp sampler2D _MainTex;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump float u_xlat16_2;
void main()
{
    u_xlat10_0.x = texture2D(_NoiseA, vs_TEXCOORD0.xy).y;
    u_xlat16_0 = u_xlat10_0.xxxx * vec4(_Distortion) + vs_TEXCOORD1;
    u_xlat16_0 = u_xlat16_0 * _MainTex_ST.xyxy + _MainTex_ST.zwzw;
    u_xlat10_1 = texture2D(_MainTex, u_xlat16_0.zw);
    u_xlat10_0 = texture2D(_MainTex, u_xlat16_0.xy);
    u_xlat16_1 = (-u_xlat10_0) + u_xlat10_1;
    u_xlat16_0 = u_xlat16_1 * vec4(0.5, 0.5, 0.5, 0.5) + u_xlat10_0;
    u_xlat16_1 = (-u_xlat16_0) + _MaskColor;
    u_xlat16_2 = vs_COLOR0.x * _MaskApply;
    u_xlat16_0 = vec4(u_xlat16_2) * u_xlat16_1 + u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0.wwww;
    SV_Target0 = u_xlat16_0 * vec4(_Intensity);
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _MainTexTilling;
uniform 	mediump vec4 _speedVariation;
uniform 	mediump vec4 _NoiseA_ST;
uniform 	mediump vec4 _NoiseScroll;
attribute highp vec4 in_POSITION0;
attribute mediump vec2 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
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
    u_xlat0.xy = _NoiseScroll.xy * _Time.yy + in_TEXCOORD0.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy * _NoiseA_ST.xy + _NoiseA_ST.zw;
    u_xlat0 = _Time.yyyy * _speedVariation;
    u_xlat0 = in_TEXCOORD0.xyxy * _MainTexTilling + u_xlat0;
    vs_TEXCOORD1 = u_xlat0;
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump float _Intensity;
uniform 	mediump float _Distortion;
uniform 	mediump vec4 _MaskColor;
uniform 	mediump float _MaskApply;
uniform lowp sampler2D _NoiseA;
uniform lowp sampler2D _MainTex;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump float u_xlat16_2;
void main()
{
    u_xlat10_0.x = texture2D(_NoiseA, vs_TEXCOORD0.xy).y;
    u_xlat16_0 = u_xlat10_0.xxxx * vec4(_Distortion) + vs_TEXCOORD1;
    u_xlat16_0 = u_xlat16_0 * _MainTex_ST.xyxy + _MainTex_ST.zwzw;
    u_xlat10_1 = texture2D(_MainTex, u_xlat16_0.zw);
    u_xlat10_0 = texture2D(_MainTex, u_xlat16_0.xy);
    u_xlat16_1 = (-u_xlat10_0) + u_xlat10_1;
    u_xlat16_0 = u_xlat16_1 * vec4(0.5, 0.5, 0.5, 0.5) + u_xlat10_0;
    u_xlat16_1 = (-u_xlat16_0) + _MaskColor;
    u_xlat16_2 = vs_COLOR0.x * _MaskApply;
    u_xlat16_0 = vec4(u_xlat16_2) * u_xlat16_1 + u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0.wwww;
    SV_Target0 = u_xlat16_0 * vec4(_Intensity);
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _MainTexTilling;
uniform 	mediump vec4 _speedVariation;
uniform 	mediump vec4 _NoiseA_ST;
uniform 	mediump vec4 _NoiseScroll;
attribute highp vec4 in_POSITION0;
attribute mediump vec2 in_TEXCOORD0;
attribute mediump vec4 in_COLOR0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
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
    u_xlat0.xy = _NoiseScroll.xy * _Time.yy + in_TEXCOORD0.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy * _NoiseA_ST.xy + _NoiseA_ST.zw;
    u_xlat0 = _Time.yyyy * _speedVariation;
    u_xlat0 = in_TEXCOORD0.xyxy * _MainTexTilling + u_xlat0;
    vs_TEXCOORD1 = u_xlat0;
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump float _Intensity;
uniform 	mediump float _Distortion;
uniform 	mediump vec4 _MaskColor;
uniform 	mediump float _MaskApply;
uniform lowp sampler2D _NoiseA;
uniform lowp sampler2D _MainTex;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump float u_xlat16_2;
void main()
{
    u_xlat10_0.x = texture2D(_NoiseA, vs_TEXCOORD0.xy).y;
    u_xlat16_0 = u_xlat10_0.xxxx * vec4(_Distortion) + vs_TEXCOORD1;
    u_xlat16_0 = u_xlat16_0 * _MainTex_ST.xyxy + _MainTex_ST.zwzw;
    u_xlat10_1 = texture2D(_MainTex, u_xlat16_0.zw);
    u_xlat10_0 = texture2D(_MainTex, u_xlat16_0.xy);
    u_xlat16_1 = (-u_xlat10_0) + u_xlat10_1;
    u_xlat16_0 = u_xlat16_1 * vec4(0.5, 0.5, 0.5, 0.5) + u_xlat10_0;
    u_xlat16_1 = (-u_xlat16_0) + _MaskColor;
    u_xlat16_2 = vs_COLOR0.x * _MaskApply;
    u_xlat16_0 = vec4(u_xlat16_2) * u_xlat16_1 + u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0.wwww;
    SV_Target0 = u_xlat16_0 * vec4(_Intensity);
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
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _MainTexTilling;
uniform 	mediump vec4 _speedVariation;
uniform 	mediump vec4 _NoiseA_ST;
uniform 	mediump vec4 _NoiseScroll;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
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
    u_xlat0.xy = _NoiseScroll.xy * _Time.yy + in_TEXCOORD0.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy * _NoiseA_ST.xy + _NoiseA_ST.zw;
    u_xlat0 = _Time.yyyy * _speedVariation;
    u_xlat0 = in_TEXCOORD0.xyxy * _MainTexTilling + u_xlat0;
    vs_TEXCOORD1 = u_xlat0;
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump float _Intensity;
uniform 	mediump float _Distortion;
uniform 	mediump vec4 _MaskColor;
uniform 	mediump float _MaskApply;
UNITY_LOCATION(0) uniform mediump sampler2D _NoiseA;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
mediump float u_xlat16_2;
void main()
{
    u_xlat16_0.x = texture(_NoiseA, vs_TEXCOORD0.xy).y;
    u_xlat16_0 = u_xlat16_0.xxxx * vec4(_Distortion) + vs_TEXCOORD1;
    u_xlat16_0 = u_xlat16_0 * _MainTex_ST.xyxy + _MainTex_ST.zwzw;
    u_xlat16_1 = texture(_MainTex, u_xlat16_0.zw);
    u_xlat16_0 = texture(_MainTex, u_xlat16_0.xy);
    u_xlat16_1 = (-u_xlat16_0) + u_xlat16_1;
    u_xlat16_0 = u_xlat16_1 * vec4(0.5, 0.5, 0.5, 0.5) + u_xlat16_0;
    u_xlat16_1 = (-u_xlat16_0) + _MaskColor;
    u_xlat16_2 = vs_COLOR0.x * _MaskApply;
    u_xlat16_0 = vec4(u_xlat16_2) * u_xlat16_1 + u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0.wwww;
    SV_Target0 = u_xlat16_0 * vec4(_Intensity);
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
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _MainTexTilling;
uniform 	mediump vec4 _speedVariation;
uniform 	mediump vec4 _NoiseA_ST;
uniform 	mediump vec4 _NoiseScroll;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
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
    u_xlat0.xy = _NoiseScroll.xy * _Time.yy + in_TEXCOORD0.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy * _NoiseA_ST.xy + _NoiseA_ST.zw;
    u_xlat0 = _Time.yyyy * _speedVariation;
    u_xlat0 = in_TEXCOORD0.xyxy * _MainTexTilling + u_xlat0;
    vs_TEXCOORD1 = u_xlat0;
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump float _Intensity;
uniform 	mediump float _Distortion;
uniform 	mediump vec4 _MaskColor;
uniform 	mediump float _MaskApply;
UNITY_LOCATION(0) uniform mediump sampler2D _NoiseA;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
mediump float u_xlat16_2;
void main()
{
    u_xlat16_0.x = texture(_NoiseA, vs_TEXCOORD0.xy).y;
    u_xlat16_0 = u_xlat16_0.xxxx * vec4(_Distortion) + vs_TEXCOORD1;
    u_xlat16_0 = u_xlat16_0 * _MainTex_ST.xyxy + _MainTex_ST.zwzw;
    u_xlat16_1 = texture(_MainTex, u_xlat16_0.zw);
    u_xlat16_0 = texture(_MainTex, u_xlat16_0.xy);
    u_xlat16_1 = (-u_xlat16_0) + u_xlat16_1;
    u_xlat16_0 = u_xlat16_1 * vec4(0.5, 0.5, 0.5, 0.5) + u_xlat16_0;
    u_xlat16_1 = (-u_xlat16_0) + _MaskColor;
    u_xlat16_2 = vs_COLOR0.x * _MaskApply;
    u_xlat16_0 = vec4(u_xlat16_2) * u_xlat16_1 + u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0.wwww;
    SV_Target0 = u_xlat16_0 * vec4(_Intensity);
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
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _MainTexTilling;
uniform 	mediump vec4 _speedVariation;
uniform 	mediump vec4 _NoiseA_ST;
uniform 	mediump vec4 _NoiseScroll;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
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
    u_xlat0.xy = _NoiseScroll.xy * _Time.yy + in_TEXCOORD0.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy * _NoiseA_ST.xy + _NoiseA_ST.zw;
    u_xlat0 = _Time.yyyy * _speedVariation;
    u_xlat0 = in_TEXCOORD0.xyxy * _MainTexTilling + u_xlat0;
    vs_TEXCOORD1 = u_xlat0;
    vs_COLOR0 = in_COLOR0;
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
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump float _Intensity;
uniform 	mediump float _Distortion;
uniform 	mediump vec4 _MaskColor;
uniform 	mediump float _MaskApply;
UNITY_LOCATION(0) uniform mediump sampler2D _NoiseA;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
mediump vec4 u_xlat16_1;
mediump float u_xlat16_2;
void main()
{
    u_xlat16_0.x = texture(_NoiseA, vs_TEXCOORD0.xy).y;
    u_xlat16_0 = u_xlat16_0.xxxx * vec4(_Distortion) + vs_TEXCOORD1;
    u_xlat16_0 = u_xlat16_0 * _MainTex_ST.xyxy + _MainTex_ST.zwzw;
    u_xlat16_1 = texture(_MainTex, u_xlat16_0.zw);
    u_xlat16_0 = texture(_MainTex, u_xlat16_0.xy);
    u_xlat16_1 = (-u_xlat16_0) + u_xlat16_1;
    u_xlat16_0 = u_xlat16_1 * vec4(0.5, 0.5, 0.5, 0.5) + u_xlat16_0;
    u_xlat16_1 = (-u_xlat16_0) + _MaskColor;
    u_xlat16_2 = vs_COLOR0.x * _MaskApply;
    u_xlat16_0 = vec4(u_xlat16_2) * u_xlat16_1 + u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * vs_COLOR0.wwww;
    SV_Target0 = u_xlat16_0 * vec4(_Intensity);
    return;
}

#endif
"
}
}
}
}
}