//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Niantic/Animated/Egg Hatch Sequence/UV Bands-Radial" {
Properties {
_MainTex ("Sprite Texture", 2D) = "white" { }
[Toggle(ANIMATE_SELF)] _AnimateSelf ("Animate Self", Float) = 1
_AnimationProgress ("Animation Progress", Float) = 0
[Space] _ScrollSpeed ("Scroll Speed", Float) = 1
_BandColor ("Band Color", Color) = (1,0,0,1)
_BandNumber ("Band Number", Float) = 1
_BandPosition ("Band Gradient Position", Range(0, 1)) = 0
_BandFalloff ("Band Gradient Falloff", Range(0, 11)) = 0
_Boost ("Boost", Range(0, 1)) = 1
_BoostScalar ("Boost Scalar", Float) = 2
_centerGlowFalloff ("Center Glow Falloff", Range(0, 11)) = 1
}
SubShader {
 Tags { "IgnoreProjectors" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "IgnoreProjectors" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend One One, One One
  ZWrite Off
  Cull Off
  GpuProgramID 33958
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _AnimationProgress;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump float vs_COLOR0;
varying highp vec3 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
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
    vs_COLOR0 = in_COLOR0.w;
    u_xlat16_2 = fract(_AnimationProgress);
    vs_TEXCOORD0.z = u_xlat16_2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
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
uniform 	mediump float _BandNumber;
uniform 	mediump vec3 _BandColor;
uniform 	mediump float _BandPosition;
uniform 	mediump float _BandFalloff;
uniform 	mediump float _BoostScalar;
uniform 	mediump float _Boost;
uniform 	mediump float _centerGlowFalloff;
varying mediump float vs_COLOR0;
varying highp vec3 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
float u_xlat0;
mediump vec4 u_xlat16_1;
float u_xlat2;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_5;
void main()
{
    u_xlat0 = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
    u_xlat0 = sqrt(u_xlat0);
    u_xlat0 = min(u_xlat0, 1.0);
    u_xlat2 = u_xlat0 + vs_TEXCOORD0.z;
    u_xlat2 = u_xlat2 * _BandNumber;
    u_xlat2 = fract(u_xlat2);
    u_xlat16_1.x = u_xlat2 + -0.5;
    u_xlat16_1.x = abs(u_xlat16_1.x) + abs(u_xlat16_1.x);
    u_xlat16_3 = (-u_xlat0) + 1.0;
    u_xlat0 = (-u_xlat0) * u_xlat0 + 1.0;
    u_xlat16_1.x = _BandPosition * u_xlat16_3 + u_xlat16_1.x;
    u_xlat16_1.y = log2(u_xlat16_3);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_5.xy = exp2(vec2(_centerGlowFalloff, _BandFalloff));
    u_xlat16_1.xy = u_xlat16_1.xy * u_xlat16_5.yx;
    u_xlat16_3 = exp2(u_xlat16_1.y);
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat0 = u_xlat0 * u_xlat16_1.x;
    u_xlat16_1.xzw = _BandColor.xyz * vec3(vec3(_BoostScalar, _BoostScalar, _BoostScalar));
    u_xlat16_1.xzw = u_xlat16_1.xzw * vec3(vec3(_Boost, _Boost, _Boost));
    u_xlat16_1.xyz = u_xlat16_1.xzw * vec3(u_xlat0) + vec3(u_xlat16_3);
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vs_COLOR0);
    SV_Target0.w = 1.0;
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
uniform 	mediump float _AnimationProgress;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump float vs_COLOR0;
varying highp vec3 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
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
    vs_COLOR0 = in_COLOR0.w;
    u_xlat16_2 = fract(_AnimationProgress);
    vs_TEXCOORD0.z = u_xlat16_2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
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
uniform 	mediump float _BandNumber;
uniform 	mediump vec3 _BandColor;
uniform 	mediump float _BandPosition;
uniform 	mediump float _BandFalloff;
uniform 	mediump float _BoostScalar;
uniform 	mediump float _Boost;
uniform 	mediump float _centerGlowFalloff;
varying mediump float vs_COLOR0;
varying highp vec3 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
float u_xlat0;
mediump vec4 u_xlat16_1;
float u_xlat2;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_5;
void main()
{
    u_xlat0 = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
    u_xlat0 = sqrt(u_xlat0);
    u_xlat0 = min(u_xlat0, 1.0);
    u_xlat2 = u_xlat0 + vs_TEXCOORD0.z;
    u_xlat2 = u_xlat2 * _BandNumber;
    u_xlat2 = fract(u_xlat2);
    u_xlat16_1.x = u_xlat2 + -0.5;
    u_xlat16_1.x = abs(u_xlat16_1.x) + abs(u_xlat16_1.x);
    u_xlat16_3 = (-u_xlat0) + 1.0;
    u_xlat0 = (-u_xlat0) * u_xlat0 + 1.0;
    u_xlat16_1.x = _BandPosition * u_xlat16_3 + u_xlat16_1.x;
    u_xlat16_1.y = log2(u_xlat16_3);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_5.xy = exp2(vec2(_centerGlowFalloff, _BandFalloff));
    u_xlat16_1.xy = u_xlat16_1.xy * u_xlat16_5.yx;
    u_xlat16_3 = exp2(u_xlat16_1.y);
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat0 = u_xlat0 * u_xlat16_1.x;
    u_xlat16_1.xzw = _BandColor.xyz * vec3(vec3(_BoostScalar, _BoostScalar, _BoostScalar));
    u_xlat16_1.xzw = u_xlat16_1.xzw * vec3(vec3(_Boost, _Boost, _Boost));
    u_xlat16_1.xyz = u_xlat16_1.xzw * vec3(u_xlat0) + vec3(u_xlat16_3);
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vs_COLOR0);
    SV_Target0.w = 1.0;
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
uniform 	mediump float _AnimationProgress;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump float vs_COLOR0;
varying highp vec3 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
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
    vs_COLOR0 = in_COLOR0.w;
    u_xlat16_2 = fract(_AnimationProgress);
    vs_TEXCOORD0.z = u_xlat16_2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
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
uniform 	mediump float _BandNumber;
uniform 	mediump vec3 _BandColor;
uniform 	mediump float _BandPosition;
uniform 	mediump float _BandFalloff;
uniform 	mediump float _BoostScalar;
uniform 	mediump float _Boost;
uniform 	mediump float _centerGlowFalloff;
varying mediump float vs_COLOR0;
varying highp vec3 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
float u_xlat0;
mediump vec4 u_xlat16_1;
float u_xlat2;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_5;
void main()
{
    u_xlat0 = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
    u_xlat0 = sqrt(u_xlat0);
    u_xlat0 = min(u_xlat0, 1.0);
    u_xlat2 = u_xlat0 + vs_TEXCOORD0.z;
    u_xlat2 = u_xlat2 * _BandNumber;
    u_xlat2 = fract(u_xlat2);
    u_xlat16_1.x = u_xlat2 + -0.5;
    u_xlat16_1.x = abs(u_xlat16_1.x) + abs(u_xlat16_1.x);
    u_xlat16_3 = (-u_xlat0) + 1.0;
    u_xlat0 = (-u_xlat0) * u_xlat0 + 1.0;
    u_xlat16_1.x = _BandPosition * u_xlat16_3 + u_xlat16_1.x;
    u_xlat16_1.y = log2(u_xlat16_3);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_5.xy = exp2(vec2(_centerGlowFalloff, _BandFalloff));
    u_xlat16_1.xy = u_xlat16_1.xy * u_xlat16_5.yx;
    u_xlat16_3 = exp2(u_xlat16_1.y);
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat0 = u_xlat0 * u_xlat16_1.x;
    u_xlat16_1.xzw = _BandColor.xyz * vec3(vec3(_BoostScalar, _BoostScalar, _BoostScalar));
    u_xlat16_1.xzw = u_xlat16_1.xzw * vec3(vec3(_Boost, _Boost, _Boost));
    u_xlat16_1.xyz = u_xlat16_1.xzw * vec3(u_xlat0) + vec3(u_xlat16_3);
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vs_COLOR0);
    SV_Target0.w = 1.0;
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
uniform 	mediump float _AnimationProgress;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump float vs_COLOR0;
out highp vec3 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
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
    vs_COLOR0 = in_COLOR0.w;
    u_xlat16_2 = fract(_AnimationProgress);
    vs_TEXCOORD0.z = u_xlat16_2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
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
uniform 	mediump float _BandNumber;
uniform 	mediump vec3 _BandColor;
uniform 	mediump float _BandPosition;
uniform 	mediump float _BandFalloff;
uniform 	mediump float _BoostScalar;
uniform 	mediump float _Boost;
uniform 	mediump float _centerGlowFalloff;
in mediump float vs_COLOR0;
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump vec4 u_xlat16_1;
float u_xlat2;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_5;
void main()
{
    u_xlat0 = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
    u_xlat0 = sqrt(u_xlat0);
    u_xlat0 = min(u_xlat0, 1.0);
    u_xlat2 = u_xlat0 + vs_TEXCOORD0.z;
    u_xlat2 = u_xlat2 * _BandNumber;
    u_xlat2 = fract(u_xlat2);
    u_xlat16_1.x = u_xlat2 + -0.5;
    u_xlat16_1.x = abs(u_xlat16_1.x) + abs(u_xlat16_1.x);
    u_xlat16_3 = (-u_xlat0) + 1.0;
    u_xlat0 = (-u_xlat0) * u_xlat0 + 1.0;
    u_xlat16_1.x = _BandPosition * u_xlat16_3 + u_xlat16_1.x;
    u_xlat16_1.y = log2(u_xlat16_3);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_5.xy = exp2(vec2(_centerGlowFalloff, _BandFalloff));
    u_xlat16_1.xy = u_xlat16_1.xy * u_xlat16_5.yx;
    u_xlat16_3 = exp2(u_xlat16_1.y);
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat0 = u_xlat0 * u_xlat16_1.x;
    u_xlat16_1.xzw = _BandColor.xyz * vec3(vec3(_BoostScalar, _BoostScalar, _BoostScalar));
    u_xlat16_1.xzw = u_xlat16_1.xzw * vec3(vec3(_Boost, _Boost, _Boost));
    u_xlat16_1.xyz = u_xlat16_1.xzw * vec3(u_xlat0) + vec3(u_xlat16_3);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xyz = min(max(u_xlat16_1.xyz, 0.0), 1.0);
#else
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vs_COLOR0);
    SV_Target0.w = 1.0;
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
uniform 	mediump float _AnimationProgress;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump float vs_COLOR0;
out highp vec3 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
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
    vs_COLOR0 = in_COLOR0.w;
    u_xlat16_2 = fract(_AnimationProgress);
    vs_TEXCOORD0.z = u_xlat16_2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
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
uniform 	mediump float _BandNumber;
uniform 	mediump vec3 _BandColor;
uniform 	mediump float _BandPosition;
uniform 	mediump float _BandFalloff;
uniform 	mediump float _BoostScalar;
uniform 	mediump float _Boost;
uniform 	mediump float _centerGlowFalloff;
in mediump float vs_COLOR0;
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump vec4 u_xlat16_1;
float u_xlat2;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_5;
void main()
{
    u_xlat0 = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
    u_xlat0 = sqrt(u_xlat0);
    u_xlat0 = min(u_xlat0, 1.0);
    u_xlat2 = u_xlat0 + vs_TEXCOORD0.z;
    u_xlat2 = u_xlat2 * _BandNumber;
    u_xlat2 = fract(u_xlat2);
    u_xlat16_1.x = u_xlat2 + -0.5;
    u_xlat16_1.x = abs(u_xlat16_1.x) + abs(u_xlat16_1.x);
    u_xlat16_3 = (-u_xlat0) + 1.0;
    u_xlat0 = (-u_xlat0) * u_xlat0 + 1.0;
    u_xlat16_1.x = _BandPosition * u_xlat16_3 + u_xlat16_1.x;
    u_xlat16_1.y = log2(u_xlat16_3);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_5.xy = exp2(vec2(_centerGlowFalloff, _BandFalloff));
    u_xlat16_1.xy = u_xlat16_1.xy * u_xlat16_5.yx;
    u_xlat16_3 = exp2(u_xlat16_1.y);
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat0 = u_xlat0 * u_xlat16_1.x;
    u_xlat16_1.xzw = _BandColor.xyz * vec3(vec3(_BoostScalar, _BoostScalar, _BoostScalar));
    u_xlat16_1.xzw = u_xlat16_1.xzw * vec3(vec3(_Boost, _Boost, _Boost));
    u_xlat16_1.xyz = u_xlat16_1.xzw * vec3(u_xlat0) + vec3(u_xlat16_3);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xyz = min(max(u_xlat16_1.xyz, 0.0), 1.0);
#else
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vs_COLOR0);
    SV_Target0.w = 1.0;
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
uniform 	mediump float _AnimationProgress;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump float vs_COLOR0;
out highp vec3 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_2;
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
    vs_COLOR0 = in_COLOR0.w;
    u_xlat16_2 = fract(_AnimationProgress);
    vs_TEXCOORD0.z = u_xlat16_2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
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
uniform 	mediump float _BandNumber;
uniform 	mediump vec3 _BandColor;
uniform 	mediump float _BandPosition;
uniform 	mediump float _BandFalloff;
uniform 	mediump float _BoostScalar;
uniform 	mediump float _Boost;
uniform 	mediump float _centerGlowFalloff;
in mediump float vs_COLOR0;
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump vec4 u_xlat16_1;
float u_xlat2;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_5;
void main()
{
    u_xlat0 = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
    u_xlat0 = sqrt(u_xlat0);
    u_xlat0 = min(u_xlat0, 1.0);
    u_xlat2 = u_xlat0 + vs_TEXCOORD0.z;
    u_xlat2 = u_xlat2 * _BandNumber;
    u_xlat2 = fract(u_xlat2);
    u_xlat16_1.x = u_xlat2 + -0.5;
    u_xlat16_1.x = abs(u_xlat16_1.x) + abs(u_xlat16_1.x);
    u_xlat16_3 = (-u_xlat0) + 1.0;
    u_xlat0 = (-u_xlat0) * u_xlat0 + 1.0;
    u_xlat16_1.x = _BandPosition * u_xlat16_3 + u_xlat16_1.x;
    u_xlat16_1.y = log2(u_xlat16_3);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_5.xy = exp2(vec2(_centerGlowFalloff, _BandFalloff));
    u_xlat16_1.xy = u_xlat16_1.xy * u_xlat16_5.yx;
    u_xlat16_3 = exp2(u_xlat16_1.y);
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat0 = u_xlat0 * u_xlat16_1.x;
    u_xlat16_1.xzw = _BandColor.xyz * vec3(vec3(_BoostScalar, _BoostScalar, _BoostScalar));
    u_xlat16_1.xzw = u_xlat16_1.xzw * vec3(vec3(_Boost, _Boost, _Boost));
    u_xlat16_1.xyz = u_xlat16_1.xzw * vec3(u_xlat0) + vec3(u_xlat16_3);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xyz = min(max(u_xlat16_1.xyz, 0.0), 1.0);
#else
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vs_COLOR0);
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ANIMATE_SELF" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _ScrollSpeed;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump float vs_COLOR0;
varying highp vec3 vs_TEXCOORD0;
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
    vs_COLOR0 = in_COLOR0.w;
    u_xlat0.x = _Time.y * _ScrollSpeed;
    vs_TEXCOORD0.z = fract(u_xlat0.x);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
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
uniform 	mediump float _BandNumber;
uniform 	mediump vec3 _BandColor;
uniform 	mediump float _BandPosition;
uniform 	mediump float _BandFalloff;
uniform 	mediump float _BoostScalar;
uniform 	mediump float _Boost;
uniform 	mediump float _centerGlowFalloff;
varying mediump float vs_COLOR0;
varying highp vec3 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
float u_xlat0;
mediump vec4 u_xlat16_1;
float u_xlat2;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_5;
void main()
{
    u_xlat0 = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
    u_xlat0 = sqrt(u_xlat0);
    u_xlat0 = min(u_xlat0, 1.0);
    u_xlat2 = u_xlat0 + vs_TEXCOORD0.z;
    u_xlat2 = u_xlat2 * _BandNumber;
    u_xlat2 = fract(u_xlat2);
    u_xlat16_1.x = u_xlat2 + -0.5;
    u_xlat16_1.x = abs(u_xlat16_1.x) + abs(u_xlat16_1.x);
    u_xlat16_3 = (-u_xlat0) + 1.0;
    u_xlat0 = (-u_xlat0) * u_xlat0 + 1.0;
    u_xlat16_1.x = _BandPosition * u_xlat16_3 + u_xlat16_1.x;
    u_xlat16_1.y = log2(u_xlat16_3);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_5.xy = exp2(vec2(_centerGlowFalloff, _BandFalloff));
    u_xlat16_1.xy = u_xlat16_1.xy * u_xlat16_5.yx;
    u_xlat16_3 = exp2(u_xlat16_1.y);
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat0 = u_xlat0 * u_xlat16_1.x;
    u_xlat16_1.xzw = _BandColor.xyz * vec3(vec3(_BoostScalar, _BoostScalar, _BoostScalar));
    u_xlat16_1.xzw = u_xlat16_1.xzw * vec3(vec3(_Boost, _Boost, _Boost));
    u_xlat16_1.xyz = u_xlat16_1.xzw * vec3(u_xlat0) + vec3(u_xlat16_3);
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vs_COLOR0);
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ANIMATE_SELF" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _ScrollSpeed;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump float vs_COLOR0;
varying highp vec3 vs_TEXCOORD0;
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
    vs_COLOR0 = in_COLOR0.w;
    u_xlat0.x = _Time.y * _ScrollSpeed;
    vs_TEXCOORD0.z = fract(u_xlat0.x);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
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
uniform 	mediump float _BandNumber;
uniform 	mediump vec3 _BandColor;
uniform 	mediump float _BandPosition;
uniform 	mediump float _BandFalloff;
uniform 	mediump float _BoostScalar;
uniform 	mediump float _Boost;
uniform 	mediump float _centerGlowFalloff;
varying mediump float vs_COLOR0;
varying highp vec3 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
float u_xlat0;
mediump vec4 u_xlat16_1;
float u_xlat2;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_5;
void main()
{
    u_xlat0 = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
    u_xlat0 = sqrt(u_xlat0);
    u_xlat0 = min(u_xlat0, 1.0);
    u_xlat2 = u_xlat0 + vs_TEXCOORD0.z;
    u_xlat2 = u_xlat2 * _BandNumber;
    u_xlat2 = fract(u_xlat2);
    u_xlat16_1.x = u_xlat2 + -0.5;
    u_xlat16_1.x = abs(u_xlat16_1.x) + abs(u_xlat16_1.x);
    u_xlat16_3 = (-u_xlat0) + 1.0;
    u_xlat0 = (-u_xlat0) * u_xlat0 + 1.0;
    u_xlat16_1.x = _BandPosition * u_xlat16_3 + u_xlat16_1.x;
    u_xlat16_1.y = log2(u_xlat16_3);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_5.xy = exp2(vec2(_centerGlowFalloff, _BandFalloff));
    u_xlat16_1.xy = u_xlat16_1.xy * u_xlat16_5.yx;
    u_xlat16_3 = exp2(u_xlat16_1.y);
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat0 = u_xlat0 * u_xlat16_1.x;
    u_xlat16_1.xzw = _BandColor.xyz * vec3(vec3(_BoostScalar, _BoostScalar, _BoostScalar));
    u_xlat16_1.xzw = u_xlat16_1.xzw * vec3(vec3(_Boost, _Boost, _Boost));
    u_xlat16_1.xyz = u_xlat16_1.xzw * vec3(u_xlat0) + vec3(u_xlat16_3);
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vs_COLOR0);
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ANIMATE_SELF" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _ScrollSpeed;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump float vs_COLOR0;
varying highp vec3 vs_TEXCOORD0;
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
    vs_COLOR0 = in_COLOR0.w;
    u_xlat0.x = _Time.y * _ScrollSpeed;
    vs_TEXCOORD0.z = fract(u_xlat0.x);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
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
uniform 	mediump float _BandNumber;
uniform 	mediump vec3 _BandColor;
uniform 	mediump float _BandPosition;
uniform 	mediump float _BandFalloff;
uniform 	mediump float _BoostScalar;
uniform 	mediump float _Boost;
uniform 	mediump float _centerGlowFalloff;
varying mediump float vs_COLOR0;
varying highp vec3 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
float u_xlat0;
mediump vec4 u_xlat16_1;
float u_xlat2;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_5;
void main()
{
    u_xlat0 = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
    u_xlat0 = sqrt(u_xlat0);
    u_xlat0 = min(u_xlat0, 1.0);
    u_xlat2 = u_xlat0 + vs_TEXCOORD0.z;
    u_xlat2 = u_xlat2 * _BandNumber;
    u_xlat2 = fract(u_xlat2);
    u_xlat16_1.x = u_xlat2 + -0.5;
    u_xlat16_1.x = abs(u_xlat16_1.x) + abs(u_xlat16_1.x);
    u_xlat16_3 = (-u_xlat0) + 1.0;
    u_xlat0 = (-u_xlat0) * u_xlat0 + 1.0;
    u_xlat16_1.x = _BandPosition * u_xlat16_3 + u_xlat16_1.x;
    u_xlat16_1.y = log2(u_xlat16_3);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_5.xy = exp2(vec2(_centerGlowFalloff, _BandFalloff));
    u_xlat16_1.xy = u_xlat16_1.xy * u_xlat16_5.yx;
    u_xlat16_3 = exp2(u_xlat16_1.y);
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat0 = u_xlat0 * u_xlat16_1.x;
    u_xlat16_1.xzw = _BandColor.xyz * vec3(vec3(_BoostScalar, _BoostScalar, _BoostScalar));
    u_xlat16_1.xzw = u_xlat16_1.xzw * vec3(vec3(_Boost, _Boost, _Boost));
    u_xlat16_1.xyz = u_xlat16_1.xzw * vec3(u_xlat0) + vec3(u_xlat16_3);
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vs_COLOR0);
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ANIMATE_SELF" }
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
uniform 	mediump float _ScrollSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump float vs_COLOR0;
out highp vec3 vs_TEXCOORD0;
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
    vs_COLOR0 = in_COLOR0.w;
    u_xlat0.x = _Time.y * _ScrollSpeed;
    vs_TEXCOORD0.z = fract(u_xlat0.x);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
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
uniform 	mediump float _BandNumber;
uniform 	mediump vec3 _BandColor;
uniform 	mediump float _BandPosition;
uniform 	mediump float _BandFalloff;
uniform 	mediump float _BoostScalar;
uniform 	mediump float _Boost;
uniform 	mediump float _centerGlowFalloff;
in mediump float vs_COLOR0;
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump vec4 u_xlat16_1;
float u_xlat2;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_5;
void main()
{
    u_xlat0 = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
    u_xlat0 = sqrt(u_xlat0);
    u_xlat0 = min(u_xlat0, 1.0);
    u_xlat2 = u_xlat0 + vs_TEXCOORD0.z;
    u_xlat2 = u_xlat2 * _BandNumber;
    u_xlat2 = fract(u_xlat2);
    u_xlat16_1.x = u_xlat2 + -0.5;
    u_xlat16_1.x = abs(u_xlat16_1.x) + abs(u_xlat16_1.x);
    u_xlat16_3 = (-u_xlat0) + 1.0;
    u_xlat0 = (-u_xlat0) * u_xlat0 + 1.0;
    u_xlat16_1.x = _BandPosition * u_xlat16_3 + u_xlat16_1.x;
    u_xlat16_1.y = log2(u_xlat16_3);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_5.xy = exp2(vec2(_centerGlowFalloff, _BandFalloff));
    u_xlat16_1.xy = u_xlat16_1.xy * u_xlat16_5.yx;
    u_xlat16_3 = exp2(u_xlat16_1.y);
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat0 = u_xlat0 * u_xlat16_1.x;
    u_xlat16_1.xzw = _BandColor.xyz * vec3(vec3(_BoostScalar, _BoostScalar, _BoostScalar));
    u_xlat16_1.xzw = u_xlat16_1.xzw * vec3(vec3(_Boost, _Boost, _Boost));
    u_xlat16_1.xyz = u_xlat16_1.xzw * vec3(u_xlat0) + vec3(u_xlat16_3);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xyz = min(max(u_xlat16_1.xyz, 0.0), 1.0);
#else
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vs_COLOR0);
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ANIMATE_SELF" }
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
uniform 	mediump float _ScrollSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump float vs_COLOR0;
out highp vec3 vs_TEXCOORD0;
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
    vs_COLOR0 = in_COLOR0.w;
    u_xlat0.x = _Time.y * _ScrollSpeed;
    vs_TEXCOORD0.z = fract(u_xlat0.x);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
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
uniform 	mediump float _BandNumber;
uniform 	mediump vec3 _BandColor;
uniform 	mediump float _BandPosition;
uniform 	mediump float _BandFalloff;
uniform 	mediump float _BoostScalar;
uniform 	mediump float _Boost;
uniform 	mediump float _centerGlowFalloff;
in mediump float vs_COLOR0;
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump vec4 u_xlat16_1;
float u_xlat2;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_5;
void main()
{
    u_xlat0 = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
    u_xlat0 = sqrt(u_xlat0);
    u_xlat0 = min(u_xlat0, 1.0);
    u_xlat2 = u_xlat0 + vs_TEXCOORD0.z;
    u_xlat2 = u_xlat2 * _BandNumber;
    u_xlat2 = fract(u_xlat2);
    u_xlat16_1.x = u_xlat2 + -0.5;
    u_xlat16_1.x = abs(u_xlat16_1.x) + abs(u_xlat16_1.x);
    u_xlat16_3 = (-u_xlat0) + 1.0;
    u_xlat0 = (-u_xlat0) * u_xlat0 + 1.0;
    u_xlat16_1.x = _BandPosition * u_xlat16_3 + u_xlat16_1.x;
    u_xlat16_1.y = log2(u_xlat16_3);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_5.xy = exp2(vec2(_centerGlowFalloff, _BandFalloff));
    u_xlat16_1.xy = u_xlat16_1.xy * u_xlat16_5.yx;
    u_xlat16_3 = exp2(u_xlat16_1.y);
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat0 = u_xlat0 * u_xlat16_1.x;
    u_xlat16_1.xzw = _BandColor.xyz * vec3(vec3(_BoostScalar, _BoostScalar, _BoostScalar));
    u_xlat16_1.xzw = u_xlat16_1.xzw * vec3(vec3(_Boost, _Boost, _Boost));
    u_xlat16_1.xyz = u_xlat16_1.xzw * vec3(u_xlat0) + vec3(u_xlat16_3);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xyz = min(max(u_xlat16_1.xyz, 0.0), 1.0);
#else
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vs_COLOR0);
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ANIMATE_SELF" }
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
uniform 	mediump float _ScrollSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump float vs_COLOR0;
out highp vec3 vs_TEXCOORD0;
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
    vs_COLOR0 = in_COLOR0.w;
    u_xlat0.x = _Time.y * _ScrollSpeed;
    vs_TEXCOORD0.z = fract(u_xlat0.x);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
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
uniform 	mediump float _BandNumber;
uniform 	mediump vec3 _BandColor;
uniform 	mediump float _BandPosition;
uniform 	mediump float _BandFalloff;
uniform 	mediump float _BoostScalar;
uniform 	mediump float _Boost;
uniform 	mediump float _centerGlowFalloff;
in mediump float vs_COLOR0;
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump vec4 u_xlat16_1;
float u_xlat2;
mediump float u_xlat16_3;
mediump vec2 u_xlat16_5;
void main()
{
    u_xlat0 = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
    u_xlat0 = sqrt(u_xlat0);
    u_xlat0 = min(u_xlat0, 1.0);
    u_xlat2 = u_xlat0 + vs_TEXCOORD0.z;
    u_xlat2 = u_xlat2 * _BandNumber;
    u_xlat2 = fract(u_xlat2);
    u_xlat16_1.x = u_xlat2 + -0.5;
    u_xlat16_1.x = abs(u_xlat16_1.x) + abs(u_xlat16_1.x);
    u_xlat16_3 = (-u_xlat0) + 1.0;
    u_xlat0 = (-u_xlat0) * u_xlat0 + 1.0;
    u_xlat16_1.x = _BandPosition * u_xlat16_3 + u_xlat16_1.x;
    u_xlat16_1.y = log2(u_xlat16_3);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_5.xy = exp2(vec2(_centerGlowFalloff, _BandFalloff));
    u_xlat16_1.xy = u_xlat16_1.xy * u_xlat16_5.yx;
    u_xlat16_3 = exp2(u_xlat16_1.y);
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat0 = u_xlat0 * u_xlat16_1.x;
    u_xlat16_1.xzw = _BandColor.xyz * vec3(vec3(_BoostScalar, _BoostScalar, _BoostScalar));
    u_xlat16_1.xzw = u_xlat16_1.xzw * vec3(vec3(_Boost, _Boost, _Boost));
    u_xlat16_1.xyz = u_xlat16_1.xzw * vec3(u_xlat0) + vec3(u_xlat16_3);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xyz = min(max(u_xlat16_1.xyz, 0.0), 1.0);
#else
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vs_COLOR0);
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
}
}
}
}