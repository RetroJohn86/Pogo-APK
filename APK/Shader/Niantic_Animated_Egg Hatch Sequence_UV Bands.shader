//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Niantic/Animated/Egg Hatch Sequence/UV Bands" {
Properties {
_MainTex ("Main Tex", 2D) = "White" { }
_ScrollSpeed ("Scroll Speed", Float) = 1
_BandColor ("Band Color", Color) = (1,0,0,1)
_Bands ("Band Number", Float) = 1
_BandPosition ("Band Gradient Position", Range(0, 1)) = 0
_BandFalloff ("Band Gradient Falloff", Range(0, 11)) = 0
_BandAmount ("Band Amount", Range(0, 1)) = 1
_BackgroundColorTop ("Background Color Top", Color) = (0,0.2,1,0.5)
_BackgroundColorBottom ("Background Color Bottom", Color) = (1,1,1,0.75)
_BackgroundPosition ("Background Position", Range(0, 1)) = 0
_BackgroundFalloff ("Background Gradient Falloff", Range(0, 11)) = 0
_VertColorAmount ("Vertex Glow Amount", Range(0, 1)) = 0.2
}
SubShader {
 LOD 100
 Tags { "IgnoreProjectors" = "true" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  LOD 100
  Tags { "IgnoreProjectors" = "true" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  GpuProgramID 25342
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _ScrollSpeed;
uniform 	mediump float _BandFalloff;
uniform 	mediump float _BackgroundPosition;
uniform 	mediump float _BackgroundFalloff;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
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
    u_xlat0.x = sin(_Time.w);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = u_xlat0.x * 0.5 + _BackgroundFalloff;
    vs_TEXCOORD0.w = exp2(u_xlat0.x);
    u_xlat0.x = in_TEXCOORD0.y + (-_BackgroundPosition);
    vs_TEXCOORD0.y = (-u_xlat0.x) + 1.0;
    vs_TEXCOORD0.z = _Time.x * _ScrollSpeed + in_TEXCOORD0.y;
    vs_TEXCOORD0.x = in_TEXCOORD0.x;
    vs_TEXCOORD1.x = exp2(_BandFalloff);
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
uniform 	mediump float _Bands;
uniform 	mediump float _BandPosition;
uniform 	mediump vec3 _BandColor;
uniform 	mediump float _BandAmount;
uniform 	mediump vec3 _BackgroundColorTop;
uniform 	mediump vec3 _BackgroundColorBottom;
varying highp vec4 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
float u_xlat0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_4;
void main()
{
    u_xlat0 = vs_TEXCOORD0.z * _Bands;
    u_xlat0 = fract(u_xlat0);
    u_xlat16_1.x = u_xlat0 + -0.5;
    u_xlat16_1.x = abs(u_xlat16_1.x) * 2.0 + _BandPosition;
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * vs_TEXCOORD1.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_1.x = u_xlat16_1.x * _BandAmount;
    u_xlat16_4.xyz = _BandColor.xyz + (-_BackgroundColorTop.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz + _BackgroundColorTop.xyz;
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + _BackgroundColorBottom.xyz;
    u_xlat0 = log2(vs_TEXCOORD0.y);
    u_xlat0 = u_xlat0 * vs_TEXCOORD0.w;
    u_xlat0 = exp2(u_xlat0);
    u_xlat0 = min(u_xlat0, 1.0);
    SV_Target0.xyz = vec3(u_xlat0) * u_xlat16_2.xyz + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
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
uniform 	mediump float _ScrollSpeed;
uniform 	mediump float _BandFalloff;
uniform 	mediump float _BackgroundPosition;
uniform 	mediump float _BackgroundFalloff;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
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
    u_xlat0.x = sin(_Time.w);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = u_xlat0.x * 0.5 + _BackgroundFalloff;
    vs_TEXCOORD0.w = exp2(u_xlat0.x);
    u_xlat0.x = in_TEXCOORD0.y + (-_BackgroundPosition);
    vs_TEXCOORD0.y = (-u_xlat0.x) + 1.0;
    vs_TEXCOORD0.z = _Time.x * _ScrollSpeed + in_TEXCOORD0.y;
    vs_TEXCOORD0.x = in_TEXCOORD0.x;
    vs_TEXCOORD1.x = exp2(_BandFalloff);
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
uniform 	mediump float _Bands;
uniform 	mediump float _BandPosition;
uniform 	mediump vec3 _BandColor;
uniform 	mediump float _BandAmount;
uniform 	mediump vec3 _BackgroundColorTop;
uniform 	mediump vec3 _BackgroundColorBottom;
varying highp vec4 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
float u_xlat0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_4;
void main()
{
    u_xlat0 = vs_TEXCOORD0.z * _Bands;
    u_xlat0 = fract(u_xlat0);
    u_xlat16_1.x = u_xlat0 + -0.5;
    u_xlat16_1.x = abs(u_xlat16_1.x) * 2.0 + _BandPosition;
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * vs_TEXCOORD1.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_1.x = u_xlat16_1.x * _BandAmount;
    u_xlat16_4.xyz = _BandColor.xyz + (-_BackgroundColorTop.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz + _BackgroundColorTop.xyz;
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + _BackgroundColorBottom.xyz;
    u_xlat0 = log2(vs_TEXCOORD0.y);
    u_xlat0 = u_xlat0 * vs_TEXCOORD0.w;
    u_xlat0 = exp2(u_xlat0);
    u_xlat0 = min(u_xlat0, 1.0);
    SV_Target0.xyz = vec3(u_xlat0) * u_xlat16_2.xyz + u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
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
uniform 	mediump float _ScrollSpeed;
uniform 	mediump float _BandFalloff;
uniform 	mediump float _BackgroundPosition;
uniform 	mediump float _BackgroundFalloff;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec4 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
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
    u_xlat0.x = sin(_Time.w);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = u_xlat0.x * 0.5 + _BackgroundFalloff;
    vs_TEXCOORD0.w = exp2(u_xlat0.x);
    u_xlat0.x = in_TEXCOORD0.y + (-_BackgroundPosition);
    vs_TEXCOORD0.y = (-u_xlat0.x) + 1.0;
    vs_TEXCOORD0.z = _Time.x * _ScrollSpeed + in_TEXCOORD0.y;
    vs_TEXCOORD0.x = in_TEXCOORD0.x;
    vs_TEXCOORD1.x = exp2(_BandFalloff);
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
uniform 	mediump float _Bands;
uniform 	mediump float _BandPosition;
uniform 	mediump vec3 _BandColor;
uniform 	mediump float _BandAmount;
uniform 	mediump vec3 _BackgroundColorTop;
uniform 	mediump vec3 _BackgroundColorBottom;
varying highp vec4 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
float u_xlat0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_4;
void main()
{
    u_xlat0 = vs_TEXCOORD0.z * _Bands;
    u_xlat0 = fract(u_xlat0);
    u_xlat16_1.x = u_xlat0 + -0.5;
    u_xlat16_1.x = abs(u_xlat16_1.x) * 2.0 + _BandPosition;
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * vs_TEXCOORD1.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_1.x = u_xlat16_1.x * _BandAmount;
    u_xlat16_4.xyz = _BandColor.xyz + (-_BackgroundColorTop.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz + _BackgroundColorTop.xyz;
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + _BackgroundColorBottom.xyz;
    u_xlat0 = log2(vs_TEXCOORD0.y);
    u_xlat0 = u_xlat0 * vs_TEXCOORD0.w;
    u_xlat0 = exp2(u_xlat0);
    u_xlat0 = min(u_xlat0, 1.0);
    SV_Target0.xyz = vec3(u_xlat0) * u_xlat16_2.xyz + u_xlat16_1.xyz;
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
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _ScrollSpeed;
uniform 	mediump float _BandFalloff;
uniform 	mediump float _BackgroundPosition;
uniform 	mediump float _BackgroundFalloff;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
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
    u_xlat0.x = sin(_Time.w);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = u_xlat0.x * 0.5 + _BackgroundFalloff;
    vs_TEXCOORD0.w = exp2(u_xlat0.x);
    u_xlat0.x = in_TEXCOORD0.y + (-_BackgroundPosition);
    vs_TEXCOORD0.y = (-u_xlat0.x) + 1.0;
    vs_TEXCOORD0.z = _Time.x * _ScrollSpeed + in_TEXCOORD0.y;
    vs_TEXCOORD0.x = in_TEXCOORD0.x;
    vs_TEXCOORD1.x = exp2(_BandFalloff);
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
uniform 	mediump float _Bands;
uniform 	mediump float _BandPosition;
uniform 	mediump vec3 _BandColor;
uniform 	mediump float _BandAmount;
uniform 	mediump vec3 _BackgroundColorTop;
uniform 	mediump vec3 _BackgroundColorBottom;
in highp vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_4;
void main()
{
    u_xlat0 = vs_TEXCOORD0.z * _Bands;
    u_xlat0 = fract(u_xlat0);
    u_xlat16_1.x = u_xlat0 + -0.5;
    u_xlat16_1.x = abs(u_xlat16_1.x) * 2.0 + _BandPosition;
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * vs_TEXCOORD1.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_1.x = u_xlat16_1.x * _BandAmount;
    u_xlat16_4.xyz = _BandColor.xyz + (-_BackgroundColorTop.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz + _BackgroundColorTop.xyz;
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + _BackgroundColorBottom.xyz;
    u_xlat0 = log2(vs_TEXCOORD0.y);
    u_xlat0 = u_xlat0 * vs_TEXCOORD0.w;
    u_xlat0 = exp2(u_xlat0);
    u_xlat0 = min(u_xlat0, 1.0);
    SV_Target0.xyz = vec3(u_xlat0) * u_xlat16_2.xyz + u_xlat16_1.xyz;
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
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _ScrollSpeed;
uniform 	mediump float _BandFalloff;
uniform 	mediump float _BackgroundPosition;
uniform 	mediump float _BackgroundFalloff;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
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
    u_xlat0.x = sin(_Time.w);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = u_xlat0.x * 0.5 + _BackgroundFalloff;
    vs_TEXCOORD0.w = exp2(u_xlat0.x);
    u_xlat0.x = in_TEXCOORD0.y + (-_BackgroundPosition);
    vs_TEXCOORD0.y = (-u_xlat0.x) + 1.0;
    vs_TEXCOORD0.z = _Time.x * _ScrollSpeed + in_TEXCOORD0.y;
    vs_TEXCOORD0.x = in_TEXCOORD0.x;
    vs_TEXCOORD1.x = exp2(_BandFalloff);
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
uniform 	mediump float _Bands;
uniform 	mediump float _BandPosition;
uniform 	mediump vec3 _BandColor;
uniform 	mediump float _BandAmount;
uniform 	mediump vec3 _BackgroundColorTop;
uniform 	mediump vec3 _BackgroundColorBottom;
in highp vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_4;
void main()
{
    u_xlat0 = vs_TEXCOORD0.z * _Bands;
    u_xlat0 = fract(u_xlat0);
    u_xlat16_1.x = u_xlat0 + -0.5;
    u_xlat16_1.x = abs(u_xlat16_1.x) * 2.0 + _BandPosition;
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * vs_TEXCOORD1.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_1.x = u_xlat16_1.x * _BandAmount;
    u_xlat16_4.xyz = _BandColor.xyz + (-_BackgroundColorTop.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz + _BackgroundColorTop.xyz;
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + _BackgroundColorBottom.xyz;
    u_xlat0 = log2(vs_TEXCOORD0.y);
    u_xlat0 = u_xlat0 * vs_TEXCOORD0.w;
    u_xlat0 = exp2(u_xlat0);
    u_xlat0 = min(u_xlat0, 1.0);
    SV_Target0.xyz = vec3(u_xlat0) * u_xlat16_2.xyz + u_xlat16_1.xyz;
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
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _ScrollSpeed;
uniform 	mediump float _BandFalloff;
uniform 	mediump float _BackgroundPosition;
uniform 	mediump float _BackgroundFalloff;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
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
    u_xlat0.x = sin(_Time.w);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = u_xlat0.x * 0.5 + _BackgroundFalloff;
    vs_TEXCOORD0.w = exp2(u_xlat0.x);
    u_xlat0.x = in_TEXCOORD0.y + (-_BackgroundPosition);
    vs_TEXCOORD0.y = (-u_xlat0.x) + 1.0;
    vs_TEXCOORD0.z = _Time.x * _ScrollSpeed + in_TEXCOORD0.y;
    vs_TEXCOORD0.x = in_TEXCOORD0.x;
    vs_TEXCOORD1.x = exp2(_BandFalloff);
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
uniform 	mediump float _Bands;
uniform 	mediump float _BandPosition;
uniform 	mediump vec3 _BandColor;
uniform 	mediump float _BandAmount;
uniform 	mediump vec3 _BackgroundColorTop;
uniform 	mediump vec3 _BackgroundColorBottom;
in highp vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_4;
void main()
{
    u_xlat0 = vs_TEXCOORD0.z * _Bands;
    u_xlat0 = fract(u_xlat0);
    u_xlat16_1.x = u_xlat0 + -0.5;
    u_xlat16_1.x = abs(u_xlat16_1.x) * 2.0 + _BandPosition;
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * vs_TEXCOORD1.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_1.x = u_xlat16_1.x * _BandAmount;
    u_xlat16_4.xyz = _BandColor.xyz + (-_BackgroundColorTop.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz + _BackgroundColorTop.xyz;
    u_xlat16_2.xyz = (-u_xlat16_1.xyz) + _BackgroundColorBottom.xyz;
    u_xlat0 = log2(vs_TEXCOORD0.y);
    u_xlat0 = u_xlat0 * vs_TEXCOORD0.w;
    u_xlat0 = exp2(u_xlat0);
    u_xlat0 = min(u_xlat0, 1.0);
    SV_Target0.xyz = vec3(u_xlat0) * u_xlat16_2.xyz + u_xlat16_1.xyz;
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