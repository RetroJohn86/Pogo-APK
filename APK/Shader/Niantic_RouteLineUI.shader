//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Niantic/RouteLineUI" {
Properties {
_TintColor ("Tint Color", Color) = (1,0,0,1)
_Scale ("Scale", Float) = 1
_Offset ("Offset", Float) = 0
_LineWidth ("Width", Range(0, 1)) = 0.1
_StencilComp ("Stencil Comparison", Float) = 8
_Stencil ("Stencil ID", Float) = 0
_StencilOp ("Stencil Operation", Float) = 0
_StencilWriteMask ("Stencil Write Mask", Float) = 255
_StencilReadMask ("Stencil Read Mask", Float) = 255
_ColorMask ("Color Mask", Float) = 15
_MainTex ("Main Texture", 2D) = "white" { }
}
SubShader {
 Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
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
  GpuProgramID 60178
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Scale;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
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
    vs_TEXCOORD0.x = in_TEXCOORD0.x * _Scale;
    vs_TEXCOORD0.y = in_TEXCOORD0.y;
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
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _Offset;
uniform 	mediump float _LineWidth;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
vec3 u_xlat4;
mediump float u_xlat16_5;
void main()
{
    u_xlat16_0.xy = vec2(vec2(_LineWidth, _LineWidth)) * vec2(1.0, -1.0);
    u_xlat16_0.z = float(0.100000001);
    u_xlat16_0.w = float(0.899999976);
    u_xlat0 = u_xlat16_0 + vec4(-0.0500000007, 0.949999988, -0.0500000007, -0.0500000007);
    u_xlat1.x = vs_TEXCOORD0.x + _Offset;
    u_xlat1.xy = fract(u_xlat1.xx);
    u_xlat1.zw = vs_TEXCOORD0.yy;
    u_xlat0 = (-u_xlat0) + u_xlat1;
    u_xlat0 = u_xlat0 * vec4(10.0, 10.0, 9.99999905, 9.99999809);
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
    u_xlat1 = u_xlat0 * vec4(-2.0, -2.0, -2.0, -2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat0 = u_xlat0 * u_xlat0;
    u_xlat4.xz = u_xlat0.yw * u_xlat1.yw;
    u_xlat16_2.xy = (-u_xlat1.xz) * u_xlat0.xz + vec2(1.0, 1.0);
    u_xlat16_2.xy = max(u_xlat4.xz, u_xlat16_2.xy);
    u_xlat16_5 = (-u_xlat16_2.y) + 1.0;
    SV_Target0.w = u_xlat16_5 * u_xlat16_2.x;
    SV_Target0.xyz = _TintColor.xyz;
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
uniform 	mediump float _Scale;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
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
    vs_TEXCOORD0.x = in_TEXCOORD0.x * _Scale;
    vs_TEXCOORD0.y = in_TEXCOORD0.y;
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
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _Offset;
uniform 	mediump float _LineWidth;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
vec3 u_xlat4;
mediump float u_xlat16_5;
void main()
{
    u_xlat16_0.xy = vec2(vec2(_LineWidth, _LineWidth)) * vec2(1.0, -1.0);
    u_xlat16_0.z = float(0.100000001);
    u_xlat16_0.w = float(0.899999976);
    u_xlat0 = u_xlat16_0 + vec4(-0.0500000007, 0.949999988, -0.0500000007, -0.0500000007);
    u_xlat1.x = vs_TEXCOORD0.x + _Offset;
    u_xlat1.xy = fract(u_xlat1.xx);
    u_xlat1.zw = vs_TEXCOORD0.yy;
    u_xlat0 = (-u_xlat0) + u_xlat1;
    u_xlat0 = u_xlat0 * vec4(10.0, 10.0, 9.99999905, 9.99999809);
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
    u_xlat1 = u_xlat0 * vec4(-2.0, -2.0, -2.0, -2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat0 = u_xlat0 * u_xlat0;
    u_xlat4.xz = u_xlat0.yw * u_xlat1.yw;
    u_xlat16_2.xy = (-u_xlat1.xz) * u_xlat0.xz + vec2(1.0, 1.0);
    u_xlat16_2.xy = max(u_xlat4.xz, u_xlat16_2.xy);
    u_xlat16_5 = (-u_xlat16_2.y) + 1.0;
    SV_Target0.w = u_xlat16_5 * u_xlat16_2.x;
    SV_Target0.xyz = _TintColor.xyz;
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
uniform 	mediump float _Scale;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
varying highp vec2 vs_TEXCOORD0;
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
    vs_TEXCOORD0.x = in_TEXCOORD0.x * _Scale;
    vs_TEXCOORD0.y = in_TEXCOORD0.y;
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
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _Offset;
uniform 	mediump float _LineWidth;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
vec3 u_xlat4;
mediump float u_xlat16_5;
void main()
{
    u_xlat16_0.xy = vec2(vec2(_LineWidth, _LineWidth)) * vec2(1.0, -1.0);
    u_xlat16_0.z = float(0.100000001);
    u_xlat16_0.w = float(0.899999976);
    u_xlat0 = u_xlat16_0 + vec4(-0.0500000007, 0.949999988, -0.0500000007, -0.0500000007);
    u_xlat1.x = vs_TEXCOORD0.x + _Offset;
    u_xlat1.xy = fract(u_xlat1.xx);
    u_xlat1.zw = vs_TEXCOORD0.yy;
    u_xlat0 = (-u_xlat0) + u_xlat1;
    u_xlat0 = u_xlat0 * vec4(10.0, 10.0, 9.99999905, 9.99999809);
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
    u_xlat1 = u_xlat0 * vec4(-2.0, -2.0, -2.0, -2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat0 = u_xlat0 * u_xlat0;
    u_xlat4.xz = u_xlat0.yw * u_xlat1.yw;
    u_xlat16_2.xy = (-u_xlat1.xz) * u_xlat0.xz + vec2(1.0, 1.0);
    u_xlat16_2.xy = max(u_xlat4.xz, u_xlat16_2.xy);
    u_xlat16_5 = (-u_xlat16_2.y) + 1.0;
    SV_Target0.w = u_xlat16_5 * u_xlat16_2.x;
    SV_Target0.xyz = _TintColor.xyz;
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
uniform 	mediump float _Scale;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
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
    vs_TEXCOORD0.x = in_TEXCOORD0.x * _Scale;
    vs_TEXCOORD0.y = in_TEXCOORD0.y;
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
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _Offset;
uniform 	mediump float _LineWidth;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
vec3 u_xlat4;
mediump float u_xlat16_5;
void main()
{
    u_xlat16_0.xy = vec2(vec2(_LineWidth, _LineWidth)) * vec2(1.0, -1.0);
    u_xlat16_0.z = float(0.100000001);
    u_xlat16_0.w = float(0.899999976);
    u_xlat0 = u_xlat16_0 + vec4(-0.0500000007, 0.949999988, -0.0500000007, -0.0500000007);
    u_xlat1.x = vs_TEXCOORD0.x + _Offset;
    u_xlat1.xy = fract(u_xlat1.xx);
    u_xlat1.zw = vs_TEXCOORD0.yy;
    u_xlat0 = (-u_xlat0) + u_xlat1;
    u_xlat0 = u_xlat0 * vec4(10.0, 10.0, 9.99999905, 9.99999809);
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat1 = u_xlat0 * vec4(-2.0, -2.0, -2.0, -2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat0 = u_xlat0 * u_xlat0;
    u_xlat4.xz = u_xlat0.yw * u_xlat1.yw;
    u_xlat16_2.xy = (-u_xlat1.xz) * u_xlat0.xz + vec2(1.0, 1.0);
    u_xlat16_2.xy = max(u_xlat4.xz, u_xlat16_2.xy);
    u_xlat16_5 = (-u_xlat16_2.y) + 1.0;
    SV_Target0.w = u_xlat16_5 * u_xlat16_2.x;
    SV_Target0.xyz = _TintColor.xyz;
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
uniform 	mediump float _Scale;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
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
    vs_TEXCOORD0.x = in_TEXCOORD0.x * _Scale;
    vs_TEXCOORD0.y = in_TEXCOORD0.y;
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
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _Offset;
uniform 	mediump float _LineWidth;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
vec3 u_xlat4;
mediump float u_xlat16_5;
void main()
{
    u_xlat16_0.xy = vec2(vec2(_LineWidth, _LineWidth)) * vec2(1.0, -1.0);
    u_xlat16_0.z = float(0.100000001);
    u_xlat16_0.w = float(0.899999976);
    u_xlat0 = u_xlat16_0 + vec4(-0.0500000007, 0.949999988, -0.0500000007, -0.0500000007);
    u_xlat1.x = vs_TEXCOORD0.x + _Offset;
    u_xlat1.xy = fract(u_xlat1.xx);
    u_xlat1.zw = vs_TEXCOORD0.yy;
    u_xlat0 = (-u_xlat0) + u_xlat1;
    u_xlat0 = u_xlat0 * vec4(10.0, 10.0, 9.99999905, 9.99999809);
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat1 = u_xlat0 * vec4(-2.0, -2.0, -2.0, -2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat0 = u_xlat0 * u_xlat0;
    u_xlat4.xz = u_xlat0.yw * u_xlat1.yw;
    u_xlat16_2.xy = (-u_xlat1.xz) * u_xlat0.xz + vec2(1.0, 1.0);
    u_xlat16_2.xy = max(u_xlat4.xz, u_xlat16_2.xy);
    u_xlat16_5 = (-u_xlat16_2.y) + 1.0;
    SV_Target0.w = u_xlat16_5 * u_xlat16_2.x;
    SV_Target0.xyz = _TintColor.xyz;
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
uniform 	mediump float _Scale;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
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
    vs_TEXCOORD0.x = in_TEXCOORD0.x * _Scale;
    vs_TEXCOORD0.y = in_TEXCOORD0.y;
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
uniform 	mediump vec4 _TintColor;
uniform 	mediump float _Offset;
uniform 	mediump float _LineWidth;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
vec3 u_xlat4;
mediump float u_xlat16_5;
void main()
{
    u_xlat16_0.xy = vec2(vec2(_LineWidth, _LineWidth)) * vec2(1.0, -1.0);
    u_xlat16_0.z = float(0.100000001);
    u_xlat16_0.w = float(0.899999976);
    u_xlat0 = u_xlat16_0 + vec4(-0.0500000007, 0.949999988, -0.0500000007, -0.0500000007);
    u_xlat1.x = vs_TEXCOORD0.x + _Offset;
    u_xlat1.xy = fract(u_xlat1.xx);
    u_xlat1.zw = vs_TEXCOORD0.yy;
    u_xlat0 = (-u_xlat0) + u_xlat1;
    u_xlat0 = u_xlat0 * vec4(10.0, 10.0, 9.99999905, 9.99999809);
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat1 = u_xlat0 * vec4(-2.0, -2.0, -2.0, -2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat0 = u_xlat0 * u_xlat0;
    u_xlat4.xz = u_xlat0.yw * u_xlat1.yw;
    u_xlat16_2.xy = (-u_xlat1.xz) * u_xlat0.xz + vec2(1.0, 1.0);
    u_xlat16_2.xy = max(u_xlat4.xz, u_xlat16_2.xy);
    u_xlat16_5 = (-u_xlat16_2.y) + 1.0;
    SV_Target0.w = u_xlat16_5 * u_xlat16_2.x;
    SV_Target0.xyz = _TintColor.xyz;
    return;
}

#endif
"
}
}
}
}
}