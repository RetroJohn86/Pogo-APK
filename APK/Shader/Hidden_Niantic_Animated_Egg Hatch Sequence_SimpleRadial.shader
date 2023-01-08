//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/Niantic/Animated/Egg Hatch Sequence/SimpleRadial" {
Properties {
_BandColor ("Band Color", Color) = (1,0,0,1)
_OuterEdgeMaskFalloff ("Outside Edge Mask Falloff", Range(0, 11)) = 4
_Thickness ("Thickness", Range(0, 1)) = 0
_Falloff ("Gradient Falloff", Range(0, 11)) = 1
_Brightness ("Brightness", Range(0, 1)) = 1
_BrightnessScalar ("Brightness Scalar", Float) = 2
_Alpha ("Alpha", Range(0, 1)) = 1
_RingRadius ("Ring Radius (.4 = default)", Range(0, 1)) = 0.4
[Space] [Enum(UnityEngine.Rendering.BlendMode)] _Blend ("Blend mode", Float) = 2
[Enum(UnityEngine.Rendering.BlendMode)] _Blend2 ("Blend mode 2", Float) = 0
[Toggle] _ZWrite ("Z Write", Float) = 1
[Enum(UnityEngine.Rendering.CompareFunction)] _ZTest ("Z Test", Float) = 4
}
SubShader {
 Tags { "IgnoreProjectors" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "IgnoreProjectors" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend Zero Zero, Zero Zero
  ZTest Off
  ZWrite Off
  GpuProgramID 14505
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _RingRadius;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec3 vs_TEXCOORD0;
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
    u_xlat0.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    vs_TEXCOORD0.xy = u_xlat0.xy;
    vs_TEXCOORD0.z = _RingRadius * 2.5 + -1.0;
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
uniform 	mediump float _OuterEdgeMaskFalloff;
uniform 	mediump vec3 _BandColor;
uniform 	mediump float _Thickness;
uniform 	mediump float _Falloff;
uniform 	mediump float _BrightnessScalar;
uniform 	mediump float _Brightness;
uniform 	mediump float _Alpha;
varying mediump vec3 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
mediump float u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump float u_xlat16_2;
void main()
{
    u_xlat16_0 = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
    u_xlat16_0 = sqrt(u_xlat16_0);
    u_xlat16_1.x = u_xlat16_0 + (-vs_TEXCOORD0.z);
    u_xlat16_0 = u_xlat16_0 + _Thickness;
    u_xlat16_0 = u_xlat16_0 + (-vs_TEXCOORD0.z);
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
    u_xlat16_0 = log2(u_xlat16_0);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_2 = exp2(_OuterEdgeMaskFalloff);
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_2;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_2 = exp2(_Falloff);
    u_xlat16_0 = u_xlat16_0 * u_xlat16_2;
    u_xlat16_0 = exp2(u_xlat16_0);
    u_xlat16_0 = u_xlat16_1.x * u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * _Alpha;
    u_xlat16_1.xyz = vs_COLOR0.xyz * vec3(_BandColor.x, _BandColor.y, _BandColor.z);
    u_xlat16_1.xyz = vec3(u_xlat16_0) * u_xlat16_1.xyz;
    SV_Target0.w = u_xlat16_0;
    u_xlat16_0 = _Brightness * _BrightnessScalar;
    u_xlat16_0 = max(u_xlat16_0, 1.0);
    SV_Target0.xyz = vec3(u_xlat16_0) * u_xlat16_1.xyz;
    SV_Target0.xyz = clamp(SV_Target0.xyz, 0.0, 1.0);
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
uniform 	mediump float _RingRadius;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec3 vs_TEXCOORD0;
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
    u_xlat0.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    vs_TEXCOORD0.xy = u_xlat0.xy;
    vs_TEXCOORD0.z = _RingRadius * 2.5 + -1.0;
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
uniform 	mediump float _OuterEdgeMaskFalloff;
uniform 	mediump vec3 _BandColor;
uniform 	mediump float _Thickness;
uniform 	mediump float _Falloff;
uniform 	mediump float _BrightnessScalar;
uniform 	mediump float _Brightness;
uniform 	mediump float _Alpha;
varying mediump vec3 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
mediump float u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump float u_xlat16_2;
void main()
{
    u_xlat16_0 = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
    u_xlat16_0 = sqrt(u_xlat16_0);
    u_xlat16_1.x = u_xlat16_0 + (-vs_TEXCOORD0.z);
    u_xlat16_0 = u_xlat16_0 + _Thickness;
    u_xlat16_0 = u_xlat16_0 + (-vs_TEXCOORD0.z);
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
    u_xlat16_0 = log2(u_xlat16_0);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_2 = exp2(_OuterEdgeMaskFalloff);
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_2;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_2 = exp2(_Falloff);
    u_xlat16_0 = u_xlat16_0 * u_xlat16_2;
    u_xlat16_0 = exp2(u_xlat16_0);
    u_xlat16_0 = u_xlat16_1.x * u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * _Alpha;
    u_xlat16_1.xyz = vs_COLOR0.xyz * vec3(_BandColor.x, _BandColor.y, _BandColor.z);
    u_xlat16_1.xyz = vec3(u_xlat16_0) * u_xlat16_1.xyz;
    SV_Target0.w = u_xlat16_0;
    u_xlat16_0 = _Brightness * _BrightnessScalar;
    u_xlat16_0 = max(u_xlat16_0, 1.0);
    SV_Target0.xyz = vec3(u_xlat16_0) * u_xlat16_1.xyz;
    SV_Target0.xyz = clamp(SV_Target0.xyz, 0.0, 1.0);
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
uniform 	mediump float _RingRadius;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec3 vs_TEXCOORD0;
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
    u_xlat0.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    vs_TEXCOORD0.xy = u_xlat0.xy;
    vs_TEXCOORD0.z = _RingRadius * 2.5 + -1.0;
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
uniform 	mediump float _OuterEdgeMaskFalloff;
uniform 	mediump vec3 _BandColor;
uniform 	mediump float _Thickness;
uniform 	mediump float _Falloff;
uniform 	mediump float _BrightnessScalar;
uniform 	mediump float _Brightness;
uniform 	mediump float _Alpha;
varying mediump vec3 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
mediump float u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump float u_xlat16_2;
void main()
{
    u_xlat16_0 = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
    u_xlat16_0 = sqrt(u_xlat16_0);
    u_xlat16_1.x = u_xlat16_0 + (-vs_TEXCOORD0.z);
    u_xlat16_0 = u_xlat16_0 + _Thickness;
    u_xlat16_0 = u_xlat16_0 + (-vs_TEXCOORD0.z);
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
    u_xlat16_0 = log2(u_xlat16_0);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_2 = exp2(_OuterEdgeMaskFalloff);
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_2;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_2 = exp2(_Falloff);
    u_xlat16_0 = u_xlat16_0 * u_xlat16_2;
    u_xlat16_0 = exp2(u_xlat16_0);
    u_xlat16_0 = u_xlat16_1.x * u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * _Alpha;
    u_xlat16_1.xyz = vs_COLOR0.xyz * vec3(_BandColor.x, _BandColor.y, _BandColor.z);
    u_xlat16_1.xyz = vec3(u_xlat16_0) * u_xlat16_1.xyz;
    SV_Target0.w = u_xlat16_0;
    u_xlat16_0 = _Brightness * _BrightnessScalar;
    u_xlat16_0 = max(u_xlat16_0, 1.0);
    SV_Target0.xyz = vec3(u_xlat16_0) * u_xlat16_1.xyz;
    SV_Target0.xyz = clamp(SV_Target0.xyz, 0.0, 1.0);
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
uniform 	mediump float _RingRadius;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec3 vs_TEXCOORD0;
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
    u_xlat0.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    vs_TEXCOORD0.xy = u_xlat0.xy;
    vs_TEXCOORD0.z = _RingRadius * 2.5 + -1.0;
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
uniform 	mediump float _OuterEdgeMaskFalloff;
uniform 	mediump vec3 _BandColor;
uniform 	mediump float _Thickness;
uniform 	mediump float _Falloff;
uniform 	mediump float _BrightnessScalar;
uniform 	mediump float _Brightness;
uniform 	mediump float _Alpha;
in mediump vec3 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump float u_xlat16_2;
void main()
{
    u_xlat16_0 = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
    u_xlat16_0 = sqrt(u_xlat16_0);
    u_xlat16_1.x = u_xlat16_0 + (-vs_TEXCOORD0.z);
    u_xlat16_0 = u_xlat16_0 + _Thickness;
    u_xlat16_0 = u_xlat16_0 + (-vs_TEXCOORD0.z);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_0 = log2(u_xlat16_0);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_2 = exp2(_OuterEdgeMaskFalloff);
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_2;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_2 = exp2(_Falloff);
    u_xlat16_0 = u_xlat16_0 * u_xlat16_2;
    u_xlat16_0 = exp2(u_xlat16_0);
    u_xlat16_0 = u_xlat16_1.x * u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * _Alpha;
    u_xlat16_1.xyz = vs_COLOR0.xyz * vec3(_BandColor.x, _BandColor.y, _BandColor.z);
    u_xlat16_1.xyz = vec3(u_xlat16_0) * u_xlat16_1.xyz;
    SV_Target0.w = u_xlat16_0;
    u_xlat16_0 = _Brightness * _BrightnessScalar;
    u_xlat16_0 = max(u_xlat16_0, 1.0);
    SV_Target0.xyz = vec3(u_xlat16_0) * u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.xyz = min(max(SV_Target0.xyz, 0.0), 1.0);
#else
    SV_Target0.xyz = clamp(SV_Target0.xyz, 0.0, 1.0);
#endif
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
uniform 	mediump float _RingRadius;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec3 vs_TEXCOORD0;
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
    u_xlat0.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    vs_TEXCOORD0.xy = u_xlat0.xy;
    vs_TEXCOORD0.z = _RingRadius * 2.5 + -1.0;
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
uniform 	mediump float _OuterEdgeMaskFalloff;
uniform 	mediump vec3 _BandColor;
uniform 	mediump float _Thickness;
uniform 	mediump float _Falloff;
uniform 	mediump float _BrightnessScalar;
uniform 	mediump float _Brightness;
uniform 	mediump float _Alpha;
in mediump vec3 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump float u_xlat16_2;
void main()
{
    u_xlat16_0 = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
    u_xlat16_0 = sqrt(u_xlat16_0);
    u_xlat16_1.x = u_xlat16_0 + (-vs_TEXCOORD0.z);
    u_xlat16_0 = u_xlat16_0 + _Thickness;
    u_xlat16_0 = u_xlat16_0 + (-vs_TEXCOORD0.z);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_0 = log2(u_xlat16_0);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_2 = exp2(_OuterEdgeMaskFalloff);
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_2;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_2 = exp2(_Falloff);
    u_xlat16_0 = u_xlat16_0 * u_xlat16_2;
    u_xlat16_0 = exp2(u_xlat16_0);
    u_xlat16_0 = u_xlat16_1.x * u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * _Alpha;
    u_xlat16_1.xyz = vs_COLOR0.xyz * vec3(_BandColor.x, _BandColor.y, _BandColor.z);
    u_xlat16_1.xyz = vec3(u_xlat16_0) * u_xlat16_1.xyz;
    SV_Target0.w = u_xlat16_0;
    u_xlat16_0 = _Brightness * _BrightnessScalar;
    u_xlat16_0 = max(u_xlat16_0, 1.0);
    SV_Target0.xyz = vec3(u_xlat16_0) * u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.xyz = min(max(SV_Target0.xyz, 0.0), 1.0);
#else
    SV_Target0.xyz = clamp(SV_Target0.xyz, 0.0, 1.0);
#endif
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
uniform 	mediump float _RingRadius;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec3 vs_TEXCOORD0;
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
    u_xlat0.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    vs_TEXCOORD0.xy = u_xlat0.xy;
    vs_TEXCOORD0.z = _RingRadius * 2.5 + -1.0;
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
uniform 	mediump float _OuterEdgeMaskFalloff;
uniform 	mediump vec3 _BandColor;
uniform 	mediump float _Thickness;
uniform 	mediump float _Falloff;
uniform 	mediump float _BrightnessScalar;
uniform 	mediump float _Brightness;
uniform 	mediump float _Alpha;
in mediump vec3 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump float u_xlat16_2;
void main()
{
    u_xlat16_0 = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
    u_xlat16_0 = sqrt(u_xlat16_0);
    u_xlat16_1.x = u_xlat16_0 + (-vs_TEXCOORD0.z);
    u_xlat16_0 = u_xlat16_0 + _Thickness;
    u_xlat16_0 = u_xlat16_0 + (-vs_TEXCOORD0.z);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_0 = log2(u_xlat16_0);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_2 = exp2(_OuterEdgeMaskFalloff);
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_2;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_2 = exp2(_Falloff);
    u_xlat16_0 = u_xlat16_0 * u_xlat16_2;
    u_xlat16_0 = exp2(u_xlat16_0);
    u_xlat16_0 = u_xlat16_1.x * u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * _Alpha;
    u_xlat16_1.xyz = vs_COLOR0.xyz * vec3(_BandColor.x, _BandColor.y, _BandColor.z);
    u_xlat16_1.xyz = vec3(u_xlat16_0) * u_xlat16_1.xyz;
    SV_Target0.w = u_xlat16_0;
    u_xlat16_0 = _Brightness * _BrightnessScalar;
    u_xlat16_0 = max(u_xlat16_0, 1.0);
    SV_Target0.xyz = vec3(u_xlat16_0) * u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.xyz = min(max(SV_Target0.xyz, 0.0), 1.0);
#else
    SV_Target0.xyz = clamp(SV_Target0.xyz, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "BAND_STYLE_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _RingRadius;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec3 vs_TEXCOORD0;
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
    u_xlat0.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    vs_TEXCOORD0.xy = u_xlat0.xy;
    vs_TEXCOORD0.z = _RingRadius * 2.5 + -1.0;
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
uniform 	mediump float _OuterEdgeMaskFalloff;
uniform 	mediump vec3 _BandColor;
uniform 	mediump float _Thickness;
uniform 	mediump float _Falloff;
uniform 	mediump float _BrightnessScalar;
uniform 	mediump float _Brightness;
uniform 	mediump float _Alpha;
varying mediump vec3 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
mediump float u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump float u_xlat16_2;
void main()
{
    u_xlat16_0 = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
    u_xlat16_0 = sqrt(u_xlat16_0);
    u_xlat16_1.x = u_xlat16_0 + (-vs_TEXCOORD0.z);
    u_xlat16_0 = u_xlat16_0 + _Thickness;
    u_xlat16_0 = u_xlat16_0 + (-vs_TEXCOORD0.z);
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
    u_xlat16_0 = log2(u_xlat16_0);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_2 = exp2(_OuterEdgeMaskFalloff);
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_2;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_2 = exp2(_Falloff);
    u_xlat16_0 = u_xlat16_0 * u_xlat16_2;
    u_xlat16_0 = exp2(u_xlat16_0);
    u_xlat16_0 = u_xlat16_1.x * u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * _Alpha;
    u_xlat16_1.xyz = vs_COLOR0.xyz * vec3(_BandColor.x, _BandColor.y, _BandColor.z);
    u_xlat16_1.xyz = vec3(u_xlat16_0) * u_xlat16_1.xyz;
    SV_Target0.w = u_xlat16_0;
    u_xlat16_0 = _Brightness * _BrightnessScalar;
    u_xlat16_0 = max(u_xlat16_0, 1.0);
    SV_Target0.xyz = vec3(u_xlat16_0) * u_xlat16_1.xyz;
    SV_Target0.xyz = clamp(SV_Target0.xyz, 0.0, 1.0);
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "BAND_STYLE_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _RingRadius;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec3 vs_TEXCOORD0;
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
    u_xlat0.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    vs_TEXCOORD0.xy = u_xlat0.xy;
    vs_TEXCOORD0.z = _RingRadius * 2.5 + -1.0;
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
uniform 	mediump float _OuterEdgeMaskFalloff;
uniform 	mediump vec3 _BandColor;
uniform 	mediump float _Thickness;
uniform 	mediump float _Falloff;
uniform 	mediump float _BrightnessScalar;
uniform 	mediump float _Brightness;
uniform 	mediump float _Alpha;
varying mediump vec3 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
mediump float u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump float u_xlat16_2;
void main()
{
    u_xlat16_0 = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
    u_xlat16_0 = sqrt(u_xlat16_0);
    u_xlat16_1.x = u_xlat16_0 + (-vs_TEXCOORD0.z);
    u_xlat16_0 = u_xlat16_0 + _Thickness;
    u_xlat16_0 = u_xlat16_0 + (-vs_TEXCOORD0.z);
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
    u_xlat16_0 = log2(u_xlat16_0);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_2 = exp2(_OuterEdgeMaskFalloff);
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_2;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_2 = exp2(_Falloff);
    u_xlat16_0 = u_xlat16_0 * u_xlat16_2;
    u_xlat16_0 = exp2(u_xlat16_0);
    u_xlat16_0 = u_xlat16_1.x * u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * _Alpha;
    u_xlat16_1.xyz = vs_COLOR0.xyz * vec3(_BandColor.x, _BandColor.y, _BandColor.z);
    u_xlat16_1.xyz = vec3(u_xlat16_0) * u_xlat16_1.xyz;
    SV_Target0.w = u_xlat16_0;
    u_xlat16_0 = _Brightness * _BrightnessScalar;
    u_xlat16_0 = max(u_xlat16_0, 1.0);
    SV_Target0.xyz = vec3(u_xlat16_0) * u_xlat16_1.xyz;
    SV_Target0.xyz = clamp(SV_Target0.xyz, 0.0, 1.0);
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "BAND_STYLE_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _RingRadius;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec3 vs_TEXCOORD0;
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
    u_xlat0.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    vs_TEXCOORD0.xy = u_xlat0.xy;
    vs_TEXCOORD0.z = _RingRadius * 2.5 + -1.0;
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
uniform 	mediump float _OuterEdgeMaskFalloff;
uniform 	mediump vec3 _BandColor;
uniform 	mediump float _Thickness;
uniform 	mediump float _Falloff;
uniform 	mediump float _BrightnessScalar;
uniform 	mediump float _Brightness;
uniform 	mediump float _Alpha;
varying mediump vec3 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
mediump float u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump float u_xlat16_2;
void main()
{
    u_xlat16_0 = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
    u_xlat16_0 = sqrt(u_xlat16_0);
    u_xlat16_1.x = u_xlat16_0 + (-vs_TEXCOORD0.z);
    u_xlat16_0 = u_xlat16_0 + _Thickness;
    u_xlat16_0 = u_xlat16_0 + (-vs_TEXCOORD0.z);
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
    u_xlat16_0 = log2(u_xlat16_0);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_2 = exp2(_OuterEdgeMaskFalloff);
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_2;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_2 = exp2(_Falloff);
    u_xlat16_0 = u_xlat16_0 * u_xlat16_2;
    u_xlat16_0 = exp2(u_xlat16_0);
    u_xlat16_0 = u_xlat16_1.x * u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * _Alpha;
    u_xlat16_1.xyz = vs_COLOR0.xyz * vec3(_BandColor.x, _BandColor.y, _BandColor.z);
    u_xlat16_1.xyz = vec3(u_xlat16_0) * u_xlat16_1.xyz;
    SV_Target0.w = u_xlat16_0;
    u_xlat16_0 = _Brightness * _BrightnessScalar;
    u_xlat16_0 = max(u_xlat16_0, 1.0);
    SV_Target0.xyz = vec3(u_xlat16_0) * u_xlat16_1.xyz;
    SV_Target0.xyz = clamp(SV_Target0.xyz, 0.0, 1.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "BAND_STYLE_ON" }
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
uniform 	mediump float _RingRadius;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec3 vs_TEXCOORD0;
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
    u_xlat0.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    vs_TEXCOORD0.xy = u_xlat0.xy;
    vs_TEXCOORD0.z = _RingRadius * 2.5 + -1.0;
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
uniform 	mediump float _OuterEdgeMaskFalloff;
uniform 	mediump vec3 _BandColor;
uniform 	mediump float _Thickness;
uniform 	mediump float _Falloff;
uniform 	mediump float _BrightnessScalar;
uniform 	mediump float _Brightness;
uniform 	mediump float _Alpha;
in mediump vec3 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump float u_xlat16_2;
void main()
{
    u_xlat16_0 = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
    u_xlat16_0 = sqrt(u_xlat16_0);
    u_xlat16_1.x = u_xlat16_0 + (-vs_TEXCOORD0.z);
    u_xlat16_0 = u_xlat16_0 + _Thickness;
    u_xlat16_0 = u_xlat16_0 + (-vs_TEXCOORD0.z);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_0 = log2(u_xlat16_0);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_2 = exp2(_OuterEdgeMaskFalloff);
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_2;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_2 = exp2(_Falloff);
    u_xlat16_0 = u_xlat16_0 * u_xlat16_2;
    u_xlat16_0 = exp2(u_xlat16_0);
    u_xlat16_0 = u_xlat16_1.x * u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * _Alpha;
    u_xlat16_1.xyz = vs_COLOR0.xyz * vec3(_BandColor.x, _BandColor.y, _BandColor.z);
    u_xlat16_1.xyz = vec3(u_xlat16_0) * u_xlat16_1.xyz;
    SV_Target0.w = u_xlat16_0;
    u_xlat16_0 = _Brightness * _BrightnessScalar;
    u_xlat16_0 = max(u_xlat16_0, 1.0);
    SV_Target0.xyz = vec3(u_xlat16_0) * u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.xyz = min(max(SV_Target0.xyz, 0.0), 1.0);
#else
    SV_Target0.xyz = clamp(SV_Target0.xyz, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "BAND_STYLE_ON" }
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
uniform 	mediump float _RingRadius;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec3 vs_TEXCOORD0;
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
    u_xlat0.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    vs_TEXCOORD0.xy = u_xlat0.xy;
    vs_TEXCOORD0.z = _RingRadius * 2.5 + -1.0;
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
uniform 	mediump float _OuterEdgeMaskFalloff;
uniform 	mediump vec3 _BandColor;
uniform 	mediump float _Thickness;
uniform 	mediump float _Falloff;
uniform 	mediump float _BrightnessScalar;
uniform 	mediump float _Brightness;
uniform 	mediump float _Alpha;
in mediump vec3 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump float u_xlat16_2;
void main()
{
    u_xlat16_0 = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
    u_xlat16_0 = sqrt(u_xlat16_0);
    u_xlat16_1.x = u_xlat16_0 + (-vs_TEXCOORD0.z);
    u_xlat16_0 = u_xlat16_0 + _Thickness;
    u_xlat16_0 = u_xlat16_0 + (-vs_TEXCOORD0.z);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_0 = log2(u_xlat16_0);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_2 = exp2(_OuterEdgeMaskFalloff);
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_2;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_2 = exp2(_Falloff);
    u_xlat16_0 = u_xlat16_0 * u_xlat16_2;
    u_xlat16_0 = exp2(u_xlat16_0);
    u_xlat16_0 = u_xlat16_1.x * u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * _Alpha;
    u_xlat16_1.xyz = vs_COLOR0.xyz * vec3(_BandColor.x, _BandColor.y, _BandColor.z);
    u_xlat16_1.xyz = vec3(u_xlat16_0) * u_xlat16_1.xyz;
    SV_Target0.w = u_xlat16_0;
    u_xlat16_0 = _Brightness * _BrightnessScalar;
    u_xlat16_0 = max(u_xlat16_0, 1.0);
    SV_Target0.xyz = vec3(u_xlat16_0) * u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.xyz = min(max(SV_Target0.xyz, 0.0), 1.0);
#else
    SV_Target0.xyz = clamp(SV_Target0.xyz, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "BAND_STYLE_ON" }
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
uniform 	mediump float _RingRadius;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec3 vs_TEXCOORD0;
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
    u_xlat0.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    vs_TEXCOORD0.xy = u_xlat0.xy;
    vs_TEXCOORD0.z = _RingRadius * 2.5 + -1.0;
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
uniform 	mediump float _OuterEdgeMaskFalloff;
uniform 	mediump vec3 _BandColor;
uniform 	mediump float _Thickness;
uniform 	mediump float _Falloff;
uniform 	mediump float _BrightnessScalar;
uniform 	mediump float _Brightness;
uniform 	mediump float _Alpha;
in mediump vec3 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
mediump vec3 u_xlat16_1;
mediump float u_xlat16_2;
void main()
{
    u_xlat16_0 = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
    u_xlat16_0 = sqrt(u_xlat16_0);
    u_xlat16_1.x = u_xlat16_0 + (-vs_TEXCOORD0.z);
    u_xlat16_0 = u_xlat16_0 + _Thickness;
    u_xlat16_0 = u_xlat16_0 + (-vs_TEXCOORD0.z);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_0 = log2(u_xlat16_0);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_2 = exp2(_OuterEdgeMaskFalloff);
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_2;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_2 = exp2(_Falloff);
    u_xlat16_0 = u_xlat16_0 * u_xlat16_2;
    u_xlat16_0 = exp2(u_xlat16_0);
    u_xlat16_0 = u_xlat16_1.x * u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * _Alpha;
    u_xlat16_1.xyz = vs_COLOR0.xyz * vec3(_BandColor.x, _BandColor.y, _BandColor.z);
    u_xlat16_1.xyz = vec3(u_xlat16_0) * u_xlat16_1.xyz;
    SV_Target0.w = u_xlat16_0;
    u_xlat16_0 = _Brightness * _BrightnessScalar;
    u_xlat16_0 = max(u_xlat16_0, 1.0);
    SV_Target0.xyz = vec3(u_xlat16_0) * u_xlat16_1.xyz;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.xyz = min(max(SV_Target0.xyz, 0.0), 1.0);
#else
    SV_Target0.xyz = clamp(SV_Target0.xyz, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
}
}
}
}