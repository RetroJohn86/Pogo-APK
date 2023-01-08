//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Niantic/Mega/Sparkle" {
Properties {
_TintColor ("Tint Color", Color) = (0.5,0.5,0.5,0.5)
_MainTex ("Particle Texture", 2D) = "white" { }
_InvFade ("Soft Particles Factor", Range(0.01, 3)) = 1
_Sharpness ("Sharpness", Float) = 1
_Pow ("Power", Float) = 3
[Toggle(ENABLE_OUTLINE)] _EnableOutline ("Enable Outline", Float) = 0
_OutlineColor ("Outline Color", Color) = (1,1,1,1)
_OutlineThickness ("Thickness", Float) = 3
[Space] [Enum(UnityEngine.Rendering.BlendMode)] _Blend ("Blend mode", Float) = 2
[Enum(UnityEngine.Rendering.BlendMode)] _Blend2 ("Blend mode 2", Float) = 0
_Stencil ("Stencil ID", Float) = 0
_StencilOp ("Stencil Operation", Float) = 0
_StencilComp ("Stencil Comparison", Float) = 0
_StencilReadMask ("Stencil Read Mask", Float) = 255
_StencilWriteMask ("Stencil Write Mask", Float) = 255
_ColorMask ("Color Mask", Float) = 15
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend Zero Zero, Zero Zero
  ColorMask RGB 0
  ZWrite Off
  Cull Off
  GpuProgramID 24400
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
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
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Sharpness;
uniform 	float _Pow;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
vec4 u_xlat1;
ivec2 u_xlati1;
vec2 u_xlat4;
ivec2 u_xlati4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlati4.xy = ivec2(ivec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * -1);
    u_xlati1.xy = ivec2(ivec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * -1);
    u_xlati4.xy = (-u_xlati4.xy) + u_xlati1.xy;
    u_xlat4.xy = vec2(u_xlati4.xy);
    u_xlat0.xy = (-u_xlat0.xy) + u_xlat4.xy;
    u_xlat0.xy = u_xlat4.xy * u_xlat0.xy;
    u_xlat0.xy = log2(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_Pow, _Pow));
    u_xlat0.xy = exp2(u_xlat0.xy);
    u_xlat0.x = u_xlat0.y + u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -1.0;
    u_xlat1 = vs_COLOR0 + vs_COLOR0;
    u_xlat1 = u_xlat1 * _TintColor;
    u_xlat0.x = u_xlat0.x * u_xlat1.w;
    u_xlat1.w = u_xlat0.x * _Sharpness;
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
    SV_Target0 = u_xlat1;
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
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
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
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Sharpness;
uniform 	float _Pow;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
vec4 u_xlat1;
ivec2 u_xlati1;
vec2 u_xlat4;
ivec2 u_xlati4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlati4.xy = ivec2(ivec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * -1);
    u_xlati1.xy = ivec2(ivec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * -1);
    u_xlati4.xy = (-u_xlati4.xy) + u_xlati1.xy;
    u_xlat4.xy = vec2(u_xlati4.xy);
    u_xlat0.xy = (-u_xlat0.xy) + u_xlat4.xy;
    u_xlat0.xy = u_xlat4.xy * u_xlat0.xy;
    u_xlat0.xy = log2(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_Pow, _Pow));
    u_xlat0.xy = exp2(u_xlat0.xy);
    u_xlat0.x = u_xlat0.y + u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -1.0;
    u_xlat1 = vs_COLOR0 + vs_COLOR0;
    u_xlat1 = u_xlat1 * _TintColor;
    u_xlat0.x = u_xlat0.x * u_xlat1.w;
    u_xlat1.w = u_xlat0.x * _Sharpness;
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
    SV_Target0 = u_xlat1;
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
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
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
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Sharpness;
uniform 	float _Pow;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
vec4 u_xlat1;
ivec2 u_xlati1;
vec2 u_xlat4;
ivec2 u_xlati4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlati4.xy = ivec2(ivec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * -1);
    u_xlati1.xy = ivec2(ivec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * -1);
    u_xlati4.xy = (-u_xlati4.xy) + u_xlati1.xy;
    u_xlat4.xy = vec2(u_xlati4.xy);
    u_xlat0.xy = (-u_xlat0.xy) + u_xlat4.xy;
    u_xlat0.xy = u_xlat4.xy * u_xlat0.xy;
    u_xlat0.xy = log2(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_Pow, _Pow));
    u_xlat0.xy = exp2(u_xlat0.xy);
    u_xlat0.x = u_xlat0.y + u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -1.0;
    u_xlat1 = vs_COLOR0 + vs_COLOR0;
    u_xlat1 = u_xlat1 * _TintColor;
    u_xlat0.x = u_xlat0.x * u_xlat1.w;
    u_xlat1.w = u_xlat0.x * _Sharpness;
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
    SV_Target0 = u_xlat1;
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
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
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
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Sharpness;
uniform 	float _Pow;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
vec4 u_xlat1;
ivec2 u_xlati1;
vec2 u_xlat4;
ivec2 u_xlati4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlati4.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati1.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlati4.xy = (-u_xlati4.xy) + u_xlati1.xy;
    u_xlat4.xy = vec2(u_xlati4.xy);
    u_xlat0.xy = (-u_xlat0.xy) + u_xlat4.xy;
    u_xlat0.xy = u_xlat4.xy * u_xlat0.xy;
    u_xlat0.xy = log2(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_Pow, _Pow));
    u_xlat0.xy = exp2(u_xlat0.xy);
    u_xlat0.x = u_xlat0.y + u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -1.0;
    u_xlat1 = vs_COLOR0 + vs_COLOR0;
    u_xlat1 = u_xlat1 * _TintColor;
    u_xlat0.x = u_xlat0.x * u_xlat1.w;
    u_xlat1.w = u_xlat0.x * _Sharpness;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat1;
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
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
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
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Sharpness;
uniform 	float _Pow;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
vec4 u_xlat1;
ivec2 u_xlati1;
vec2 u_xlat4;
ivec2 u_xlati4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlati4.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati1.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlati4.xy = (-u_xlati4.xy) + u_xlati1.xy;
    u_xlat4.xy = vec2(u_xlati4.xy);
    u_xlat0.xy = (-u_xlat0.xy) + u_xlat4.xy;
    u_xlat0.xy = u_xlat4.xy * u_xlat0.xy;
    u_xlat0.xy = log2(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_Pow, _Pow));
    u_xlat0.xy = exp2(u_xlat0.xy);
    u_xlat0.x = u_xlat0.y + u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -1.0;
    u_xlat1 = vs_COLOR0 + vs_COLOR0;
    u_xlat1 = u_xlat1 * _TintColor;
    u_xlat0.x = u_xlat0.x * u_xlat1.w;
    u_xlat1.w = u_xlat0.x * _Sharpness;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat1;
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
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
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
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Sharpness;
uniform 	float _Pow;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
vec4 u_xlat1;
ivec2 u_xlati1;
vec2 u_xlat4;
ivec2 u_xlati4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlati4.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati1.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlati4.xy = (-u_xlati4.xy) + u_xlati1.xy;
    u_xlat4.xy = vec2(u_xlati4.xy);
    u_xlat0.xy = (-u_xlat0.xy) + u_xlat4.xy;
    u_xlat0.xy = u_xlat4.xy * u_xlat0.xy;
    u_xlat0.xy = log2(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_Pow, _Pow));
    u_xlat0.xy = exp2(u_xlat0.xy);
    u_xlat0.x = u_xlat0.y + u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -1.0;
    u_xlat1 = vs_COLOR0 + vs_COLOR0;
    u_xlat1 = u_xlat1 * _TintColor;
    u_xlat0.x = u_xlat0.x * u_xlat1.w;
    u_xlat1.w = u_xlat0.x * _Sharpness;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ENABLE_OUTLINE" "SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat2;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD2.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.w = u_xlat1.w;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _TintColor;
uniform 	float _InvFade;
uniform 	float _Sharpness;
uniform 	float _Pow;
uniform 	mediump float _OutlineThickness;
uniform 	mediump vec4 _OutlineColor;
uniform highp sampler2D _CameraDepthTexture;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
ivec2 u_xlati1;
vec3 u_xlat2;
vec2 u_xlat4;
vec2 u_xlat5;
ivec2 u_xlati5;
void main()
{
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat0.x = texture2D(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD2.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat0.x = dot(vs_COLOR0.ww, u_xlat0.xx);
    u_xlat0.x = u_xlat0.x * _TintColor.w;
    u_xlat2.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlati1.xy = ivec2(ivec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat2.xyxx).xy) * -1);
    u_xlati5.xy = ivec2(ivec2(lessThan(u_xlat2.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy) * -1);
    u_xlati1.xy = (-u_xlati1.xy) + u_xlati5.xy;
    u_xlat1.xy = vec2(u_xlati1.xy);
    u_xlat2.xy = (-u_xlat2.xy) + u_xlat1.xy;
    u_xlat5.xy = u_xlat1.xy * u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy * u_xlat1.xy + (-vec2(_OutlineThickness));
    u_xlat2.xy = log2(u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy * vec2(vec2(_Pow, _Pow));
    u_xlat2.xy = exp2(u_xlat2.xy);
    u_xlat2.x = u_xlat2.y + u_xlat2.x;
    u_xlat4.xy = log2(u_xlat5.xy);
    u_xlat4.xy = u_xlat4.xy * vec2(vec2(_Pow, _Pow));
    u_xlat4.xy = exp2(u_xlat4.xy);
    u_xlat4.x = u_xlat4.y + u_xlat4.x;
    u_xlat2.z = max(u_xlat2.x, u_xlat4.x);
    u_xlat2.x = u_xlat4.x + u_xlat2.x;
    u_xlat2.xy = u_xlat2.xz + vec2(-2.0, -1.0);
    u_xlat2.x = u_xlat2.x * _Sharpness;
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat0.x = u_xlat2.y * u_xlat0.x;
    u_xlat1.w = u_xlat0.x * _Sharpness;
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
    u_xlat0.xzw = vs_COLOR0.xyz + vs_COLOR0.xyz;
    u_xlat0.xzw = u_xlat0.xzw * _TintColor.xyz + (-_OutlineColor.xyz);
    u_xlat1.xyz = u_xlat2.xxx * u_xlat0.xzw + _OutlineColor.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ENABLE_OUTLINE" "SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat2;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD2.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.w = u_xlat1.w;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _TintColor;
uniform 	float _InvFade;
uniform 	float _Sharpness;
uniform 	float _Pow;
uniform 	mediump float _OutlineThickness;
uniform 	mediump vec4 _OutlineColor;
uniform highp sampler2D _CameraDepthTexture;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
ivec2 u_xlati1;
vec3 u_xlat2;
vec2 u_xlat4;
vec2 u_xlat5;
ivec2 u_xlati5;
void main()
{
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat0.x = texture2D(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD2.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat0.x = dot(vs_COLOR0.ww, u_xlat0.xx);
    u_xlat0.x = u_xlat0.x * _TintColor.w;
    u_xlat2.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlati1.xy = ivec2(ivec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat2.xyxx).xy) * -1);
    u_xlati5.xy = ivec2(ivec2(lessThan(u_xlat2.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy) * -1);
    u_xlati1.xy = (-u_xlati1.xy) + u_xlati5.xy;
    u_xlat1.xy = vec2(u_xlati1.xy);
    u_xlat2.xy = (-u_xlat2.xy) + u_xlat1.xy;
    u_xlat5.xy = u_xlat1.xy * u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy * u_xlat1.xy + (-vec2(_OutlineThickness));
    u_xlat2.xy = log2(u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy * vec2(vec2(_Pow, _Pow));
    u_xlat2.xy = exp2(u_xlat2.xy);
    u_xlat2.x = u_xlat2.y + u_xlat2.x;
    u_xlat4.xy = log2(u_xlat5.xy);
    u_xlat4.xy = u_xlat4.xy * vec2(vec2(_Pow, _Pow));
    u_xlat4.xy = exp2(u_xlat4.xy);
    u_xlat4.x = u_xlat4.y + u_xlat4.x;
    u_xlat2.z = max(u_xlat2.x, u_xlat4.x);
    u_xlat2.x = u_xlat4.x + u_xlat2.x;
    u_xlat2.xy = u_xlat2.xz + vec2(-2.0, -1.0);
    u_xlat2.x = u_xlat2.x * _Sharpness;
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat0.x = u_xlat2.y * u_xlat0.x;
    u_xlat1.w = u_xlat0.x * _Sharpness;
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
    u_xlat0.xzw = vs_COLOR0.xyz + vs_COLOR0.xyz;
    u_xlat0.xzw = u_xlat0.xzw * _TintColor.xyz + (-_OutlineColor.xyz);
    u_xlat1.xyz = u_xlat2.xxx * u_xlat0.xzw + _OutlineColor.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ENABLE_OUTLINE" "SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat2;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD2.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.w = u_xlat1.w;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _TintColor;
uniform 	float _InvFade;
uniform 	float _Sharpness;
uniform 	float _Pow;
uniform 	mediump float _OutlineThickness;
uniform 	mediump vec4 _OutlineColor;
uniform highp sampler2D _CameraDepthTexture;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
ivec2 u_xlati1;
vec3 u_xlat2;
vec2 u_xlat4;
vec2 u_xlat5;
ivec2 u_xlati5;
void main()
{
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat0.x = texture2D(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD2.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat0.x = dot(vs_COLOR0.ww, u_xlat0.xx);
    u_xlat0.x = u_xlat0.x * _TintColor.w;
    u_xlat2.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlati1.xy = ivec2(ivec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat2.xyxx).xy) * -1);
    u_xlati5.xy = ivec2(ivec2(lessThan(u_xlat2.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy) * -1);
    u_xlati1.xy = (-u_xlati1.xy) + u_xlati5.xy;
    u_xlat1.xy = vec2(u_xlati1.xy);
    u_xlat2.xy = (-u_xlat2.xy) + u_xlat1.xy;
    u_xlat5.xy = u_xlat1.xy * u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy * u_xlat1.xy + (-vec2(_OutlineThickness));
    u_xlat2.xy = log2(u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy * vec2(vec2(_Pow, _Pow));
    u_xlat2.xy = exp2(u_xlat2.xy);
    u_xlat2.x = u_xlat2.y + u_xlat2.x;
    u_xlat4.xy = log2(u_xlat5.xy);
    u_xlat4.xy = u_xlat4.xy * vec2(vec2(_Pow, _Pow));
    u_xlat4.xy = exp2(u_xlat4.xy);
    u_xlat4.x = u_xlat4.y + u_xlat4.x;
    u_xlat2.z = max(u_xlat2.x, u_xlat4.x);
    u_xlat2.x = u_xlat4.x + u_xlat2.x;
    u_xlat2.xy = u_xlat2.xz + vec2(-2.0, -1.0);
    u_xlat2.x = u_xlat2.x * _Sharpness;
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat0.x = u_xlat2.y * u_xlat0.x;
    u_xlat1.w = u_xlat0.x * _Sharpness;
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
    u_xlat0.xzw = vs_COLOR0.xyz + vs_COLOR0.xyz;
    u_xlat0.xzw = u_xlat0.xzw * _TintColor.xyz + (-_OutlineColor.xyz);
    u_xlat1.xyz = u_xlat2.xxx * u_xlat0.xzw + _OutlineColor.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ENABLE_OUTLINE" "SOFTPARTICLES_ON" }
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat2;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD2.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.w = u_xlat1.w;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _TintColor;
uniform 	float _InvFade;
uniform 	float _Sharpness;
uniform 	float _Pow;
uniform 	mediump float _OutlineThickness;
uniform 	mediump vec4 _OutlineColor;
UNITY_LOCATION(0) uniform highp sampler2D _CameraDepthTexture;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
ivec2 u_xlati1;
vec3 u_xlat2;
vec2 u_xlat4;
vec2 u_xlat5;
ivec2 u_xlati5;
void main()
{
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD2.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(vs_COLOR0.ww, u_xlat0.xx);
    u_xlat0.x = u_xlat0.x * _TintColor.w;
    u_xlat2.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlati1.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat2.xyxx).xy) * 0xFFFFFFFFu);
    u_xlati5.xy = ivec2(uvec2(lessThan(u_xlat2.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlati1.xy = (-u_xlati1.xy) + u_xlati5.xy;
    u_xlat1.xy = vec2(u_xlati1.xy);
    u_xlat2.xy = (-u_xlat2.xy) + u_xlat1.xy;
    u_xlat5.xy = u_xlat1.xy * u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy * u_xlat1.xy + (-vec2(_OutlineThickness));
    u_xlat2.xy = log2(u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy * vec2(vec2(_Pow, _Pow));
    u_xlat2.xy = exp2(u_xlat2.xy);
    u_xlat2.x = u_xlat2.y + u_xlat2.x;
    u_xlat4.xy = log2(u_xlat5.xy);
    u_xlat4.xy = u_xlat4.xy * vec2(vec2(_Pow, _Pow));
    u_xlat4.xy = exp2(u_xlat4.xy);
    u_xlat4.x = u_xlat4.y + u_xlat4.x;
    u_xlat2.z = max(u_xlat2.x, u_xlat4.x);
    u_xlat2.x = u_xlat4.x + u_xlat2.x;
    u_xlat2.xy = u_xlat2.xz + vec2(-2.0, -1.0);
    u_xlat2.x = u_xlat2.x * _Sharpness;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat2.y * u_xlat0.x;
    u_xlat1.w = u_xlat0.x * _Sharpness;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    u_xlat0.xzw = vs_COLOR0.xyz + vs_COLOR0.xyz;
    u_xlat0.xzw = u_xlat0.xzw * _TintColor.xyz + (-_OutlineColor.xyz);
    u_xlat1.xyz = u_xlat2.xxx * u_xlat0.xzw + _OutlineColor.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ENABLE_OUTLINE" "SOFTPARTICLES_ON" }
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat2;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD2.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.w = u_xlat1.w;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _TintColor;
uniform 	float _InvFade;
uniform 	float _Sharpness;
uniform 	float _Pow;
uniform 	mediump float _OutlineThickness;
uniform 	mediump vec4 _OutlineColor;
UNITY_LOCATION(0) uniform highp sampler2D _CameraDepthTexture;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
ivec2 u_xlati1;
vec3 u_xlat2;
vec2 u_xlat4;
vec2 u_xlat5;
ivec2 u_xlati5;
void main()
{
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD2.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(vs_COLOR0.ww, u_xlat0.xx);
    u_xlat0.x = u_xlat0.x * _TintColor.w;
    u_xlat2.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlati1.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat2.xyxx).xy) * 0xFFFFFFFFu);
    u_xlati5.xy = ivec2(uvec2(lessThan(u_xlat2.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlati1.xy = (-u_xlati1.xy) + u_xlati5.xy;
    u_xlat1.xy = vec2(u_xlati1.xy);
    u_xlat2.xy = (-u_xlat2.xy) + u_xlat1.xy;
    u_xlat5.xy = u_xlat1.xy * u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy * u_xlat1.xy + (-vec2(_OutlineThickness));
    u_xlat2.xy = log2(u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy * vec2(vec2(_Pow, _Pow));
    u_xlat2.xy = exp2(u_xlat2.xy);
    u_xlat2.x = u_xlat2.y + u_xlat2.x;
    u_xlat4.xy = log2(u_xlat5.xy);
    u_xlat4.xy = u_xlat4.xy * vec2(vec2(_Pow, _Pow));
    u_xlat4.xy = exp2(u_xlat4.xy);
    u_xlat4.x = u_xlat4.y + u_xlat4.x;
    u_xlat2.z = max(u_xlat2.x, u_xlat4.x);
    u_xlat2.x = u_xlat4.x + u_xlat2.x;
    u_xlat2.xy = u_xlat2.xz + vec2(-2.0, -1.0);
    u_xlat2.x = u_xlat2.x * _Sharpness;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat2.y * u_xlat0.x;
    u_xlat1.w = u_xlat0.x * _Sharpness;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    u_xlat0.xzw = vs_COLOR0.xyz + vs_COLOR0.xyz;
    u_xlat0.xzw = u_xlat0.xzw * _TintColor.xyz + (-_OutlineColor.xyz);
    u_xlat1.xyz = u_xlat2.xxx * u_xlat0.xzw + _OutlineColor.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ENABLE_OUTLINE" "SOFTPARTICLES_ON" }
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat2;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD2.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.w = u_xlat1.w;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _TintColor;
uniform 	float _InvFade;
uniform 	float _Sharpness;
uniform 	float _Pow;
uniform 	mediump float _OutlineThickness;
uniform 	mediump vec4 _OutlineColor;
UNITY_LOCATION(0) uniform highp sampler2D _CameraDepthTexture;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
ivec2 u_xlati1;
vec3 u_xlat2;
vec2 u_xlat4;
vec2 u_xlat5;
ivec2 u_xlati5;
void main()
{
    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD2.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(vs_COLOR0.ww, u_xlat0.xx);
    u_xlat0.x = u_xlat0.x * _TintColor.w;
    u_xlat2.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlati1.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat2.xyxx).xy) * 0xFFFFFFFFu);
    u_xlati5.xy = ivec2(uvec2(lessThan(u_xlat2.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlati1.xy = (-u_xlati1.xy) + u_xlati5.xy;
    u_xlat1.xy = vec2(u_xlati1.xy);
    u_xlat2.xy = (-u_xlat2.xy) + u_xlat1.xy;
    u_xlat5.xy = u_xlat1.xy * u_xlat2.xy;
    u_xlat2.xy = u_xlat2.xy * u_xlat1.xy + (-vec2(_OutlineThickness));
    u_xlat2.xy = log2(u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy * vec2(vec2(_Pow, _Pow));
    u_xlat2.xy = exp2(u_xlat2.xy);
    u_xlat2.x = u_xlat2.y + u_xlat2.x;
    u_xlat4.xy = log2(u_xlat5.xy);
    u_xlat4.xy = u_xlat4.xy * vec2(vec2(_Pow, _Pow));
    u_xlat4.xy = exp2(u_xlat4.xy);
    u_xlat4.x = u_xlat4.y + u_xlat4.x;
    u_xlat2.z = max(u_xlat2.x, u_xlat4.x);
    u_xlat2.x = u_xlat4.x + u_xlat2.x;
    u_xlat2.xy = u_xlat2.xz + vec2(-2.0, -1.0);
    u_xlat2.x = u_xlat2.x * _Sharpness;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat2.y * u_xlat0.x;
    u_xlat1.w = u_xlat0.x * _Sharpness;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    u_xlat0.xzw = vs_COLOR0.xyz + vs_COLOR0.xyz;
    u_xlat0.xzw = u_xlat0.xzw * _TintColor.xyz + (-_OutlineColor.xyz);
    u_xlat1.xyz = u_xlat2.xxx * u_xlat0.xzw + _OutlineColor.xyz;
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat2;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD2.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.w = u_xlat1.w;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _TintColor;
uniform 	float _InvFade;
uniform 	float _Sharpness;
uniform 	float _Pow;
uniform highp sampler2D _CameraDepthTexture;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
vec4 u_xlat1;
ivec2 u_xlati1;
vec2 u_xlat2;
vec2 u_xlat4;
ivec2 u_xlati4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlati4.xy = ivec2(ivec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * -1);
    u_xlati1.xy = ivec2(ivec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * -1);
    u_xlati4.xy = (-u_xlati4.xy) + u_xlati1.xy;
    u_xlat4.xy = vec2(u_xlati4.xy);
    u_xlat0.xy = (-u_xlat0.xy) + u_xlat4.xy;
    u_xlat0.xy = u_xlat4.xy * u_xlat0.xy;
    u_xlat0.xy = log2(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_Pow, _Pow));
    u_xlat0.xy = exp2(u_xlat0.xy);
    u_xlat0.x = u_xlat0.y + u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -1.0;
    u_xlat2.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat2.x = texture2D(_CameraDepthTexture, u_xlat2.xy).x;
    u_xlat2.x = _ZBufferParams.z * u_xlat2.x + _ZBufferParams.w;
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat2.x = u_xlat2.x + (-vs_TEXCOORD2.z);
    u_xlat2.x = u_xlat2.x * _InvFade;
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat1.w = dot(vs_COLOR0.ww, u_xlat2.xx);
    u_xlat1.xyz = vs_COLOR0.xyz + vs_COLOR0.xyz;
    u_xlat1 = u_xlat1 * _TintColor;
    u_xlat0.x = u_xlat0.x * u_xlat1.w;
    u_xlat1.w = u_xlat0.x * _Sharpness;
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat2;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD2.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.w = u_xlat1.w;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _TintColor;
uniform 	float _InvFade;
uniform 	float _Sharpness;
uniform 	float _Pow;
uniform highp sampler2D _CameraDepthTexture;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
vec4 u_xlat1;
ivec2 u_xlati1;
vec2 u_xlat2;
vec2 u_xlat4;
ivec2 u_xlati4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlati4.xy = ivec2(ivec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * -1);
    u_xlati1.xy = ivec2(ivec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * -1);
    u_xlati4.xy = (-u_xlati4.xy) + u_xlati1.xy;
    u_xlat4.xy = vec2(u_xlati4.xy);
    u_xlat0.xy = (-u_xlat0.xy) + u_xlat4.xy;
    u_xlat0.xy = u_xlat4.xy * u_xlat0.xy;
    u_xlat0.xy = log2(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_Pow, _Pow));
    u_xlat0.xy = exp2(u_xlat0.xy);
    u_xlat0.x = u_xlat0.y + u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -1.0;
    u_xlat2.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat2.x = texture2D(_CameraDepthTexture, u_xlat2.xy).x;
    u_xlat2.x = _ZBufferParams.z * u_xlat2.x + _ZBufferParams.w;
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat2.x = u_xlat2.x + (-vs_TEXCOORD2.z);
    u_xlat2.x = u_xlat2.x * _InvFade;
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat1.w = dot(vs_COLOR0.ww, u_xlat2.xx);
    u_xlat1.xyz = vs_COLOR0.xyz + vs_COLOR0.xyz;
    u_xlat1 = u_xlat1 * _TintColor;
    u_xlat0.x = u_xlat0.x * u_xlat1.w;
    u_xlat1.w = u_xlat0.x * _Sharpness;
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat2;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD2.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.w = u_xlat1.w;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _TintColor;
uniform 	float _InvFade;
uniform 	float _Sharpness;
uniform 	float _Pow;
uniform highp sampler2D _CameraDepthTexture;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
vec4 u_xlat1;
ivec2 u_xlati1;
vec2 u_xlat2;
vec2 u_xlat4;
ivec2 u_xlati4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlati4.xy = ivec2(ivec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * -1);
    u_xlati1.xy = ivec2(ivec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * -1);
    u_xlati4.xy = (-u_xlati4.xy) + u_xlati1.xy;
    u_xlat4.xy = vec2(u_xlati4.xy);
    u_xlat0.xy = (-u_xlat0.xy) + u_xlat4.xy;
    u_xlat0.xy = u_xlat4.xy * u_xlat0.xy;
    u_xlat0.xy = log2(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_Pow, _Pow));
    u_xlat0.xy = exp2(u_xlat0.xy);
    u_xlat0.x = u_xlat0.y + u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -1.0;
    u_xlat2.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat2.x = texture2D(_CameraDepthTexture, u_xlat2.xy).x;
    u_xlat2.x = _ZBufferParams.z * u_xlat2.x + _ZBufferParams.w;
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat2.x = u_xlat2.x + (-vs_TEXCOORD2.z);
    u_xlat2.x = u_xlat2.x * _InvFade;
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
    u_xlat1.w = dot(vs_COLOR0.ww, u_xlat2.xx);
    u_xlat1.xyz = vs_COLOR0.xyz + vs_COLOR0.xyz;
    u_xlat1 = u_xlat1 * _TintColor;
    u_xlat0.x = u_xlat0.x * u_xlat1.w;
    u_xlat1.w = u_xlat0.x * _Sharpness;
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" }
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat2;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD2.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.w = u_xlat1.w;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _TintColor;
uniform 	float _InvFade;
uniform 	float _Sharpness;
uniform 	float _Pow;
UNITY_LOCATION(0) uniform highp sampler2D _CameraDepthTexture;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
vec4 u_xlat1;
ivec2 u_xlati1;
vec2 u_xlat2;
vec2 u_xlat4;
ivec2 u_xlati4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlati4.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati1.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlati4.xy = (-u_xlati4.xy) + u_xlati1.xy;
    u_xlat4.xy = vec2(u_xlati4.xy);
    u_xlat0.xy = (-u_xlat0.xy) + u_xlat4.xy;
    u_xlat0.xy = u_xlat4.xy * u_xlat0.xy;
    u_xlat0.xy = log2(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_Pow, _Pow));
    u_xlat0.xy = exp2(u_xlat0.xy);
    u_xlat0.x = u_xlat0.y + u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -1.0;
    u_xlat2.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat2.x = texture(_CameraDepthTexture, u_xlat2.xy).x;
    u_xlat2.x = _ZBufferParams.z * u_xlat2.x + _ZBufferParams.w;
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat2.x = u_xlat2.x + (-vs_TEXCOORD2.z);
    u_xlat2.x = u_xlat2.x * _InvFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat1.w = dot(vs_COLOR0.ww, u_xlat2.xx);
    u_xlat1.xyz = vs_COLOR0.xyz + vs_COLOR0.xyz;
    u_xlat1 = u_xlat1 * _TintColor;
    u_xlat0.x = u_xlat0.x * u_xlat1.w;
    u_xlat1.w = u_xlat0.x * _Sharpness;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" }
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat2;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD2.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.w = u_xlat1.w;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _TintColor;
uniform 	float _InvFade;
uniform 	float _Sharpness;
uniform 	float _Pow;
UNITY_LOCATION(0) uniform highp sampler2D _CameraDepthTexture;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
vec4 u_xlat1;
ivec2 u_xlati1;
vec2 u_xlat2;
vec2 u_xlat4;
ivec2 u_xlati4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlati4.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati1.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlati4.xy = (-u_xlati4.xy) + u_xlati1.xy;
    u_xlat4.xy = vec2(u_xlati4.xy);
    u_xlat0.xy = (-u_xlat0.xy) + u_xlat4.xy;
    u_xlat0.xy = u_xlat4.xy * u_xlat0.xy;
    u_xlat0.xy = log2(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_Pow, _Pow));
    u_xlat0.xy = exp2(u_xlat0.xy);
    u_xlat0.x = u_xlat0.y + u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -1.0;
    u_xlat2.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat2.x = texture(_CameraDepthTexture, u_xlat2.xy).x;
    u_xlat2.x = _ZBufferParams.z * u_xlat2.x + _ZBufferParams.w;
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat2.x = u_xlat2.x + (-vs_TEXCOORD2.z);
    u_xlat2.x = u_xlat2.x * _InvFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat1.w = dot(vs_COLOR0.ww, u_xlat2.xx);
    u_xlat1.xyz = vs_COLOR0.xyz + vs_COLOR0.xyz;
    u_xlat1 = u_xlat1 * _TintColor;
    u_xlat0.x = u_xlat0.x * u_xlat1.w;
    u_xlat1.w = u_xlat0.x * _Sharpness;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" }
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat2;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD2.z = (-u_xlat0.x);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.w = u_xlat1.w;
    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
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
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 _TintColor;
uniform 	float _InvFade;
uniform 	float _Sharpness;
uniform 	float _Pow;
UNITY_LOCATION(0) uniform highp sampler2D _CameraDepthTexture;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
vec4 u_xlat1;
ivec2 u_xlati1;
vec2 u_xlat2;
vec2 u_xlat4;
ivec2 u_xlati4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlati4.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati1.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlati4.xy = (-u_xlati4.xy) + u_xlati1.xy;
    u_xlat4.xy = vec2(u_xlati4.xy);
    u_xlat0.xy = (-u_xlat0.xy) + u_xlat4.xy;
    u_xlat0.xy = u_xlat4.xy * u_xlat0.xy;
    u_xlat0.xy = log2(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_Pow, _Pow));
    u_xlat0.xy = exp2(u_xlat0.xy);
    u_xlat0.x = u_xlat0.y + u_xlat0.x;
    u_xlat0.x = u_xlat0.x + -1.0;
    u_xlat2.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
    u_xlat2.x = texture(_CameraDepthTexture, u_xlat2.xy).x;
    u_xlat2.x = _ZBufferParams.z * u_xlat2.x + _ZBufferParams.w;
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat2.x = u_xlat2.x + (-vs_TEXCOORD2.z);
    u_xlat2.x = u_xlat2.x * _InvFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat1.w = dot(vs_COLOR0.ww, u_xlat2.xx);
    u_xlat1.xyz = vs_COLOR0.xyz + vs_COLOR0.xyz;
    u_xlat1 = u_xlat1 * _TintColor;
    u_xlat0.x = u_xlat0.x * u_xlat1.w;
    u_xlat1.w = u_xlat0.x * _Sharpness;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ENABLE_OUTLINE" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
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
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Sharpness;
uniform 	float _Pow;
uniform 	mediump float _OutlineThickness;
uniform 	mediump vec4 _OutlineColor;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
vec4 u_xlat1;
ivec2 u_xlati1;
vec4 u_xlat2;
vec2 u_xlat3;
vec2 u_xlat6;
ivec2 u_xlati6;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlati6.xy = ivec2(ivec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * -1);
    u_xlati1.xy = ivec2(ivec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * -1);
    u_xlati6.xy = (-u_xlati6.xy) + u_xlati1.xy;
    u_xlat6.xy = vec2(u_xlati6.xy);
    u_xlat0.xy = (-u_xlat0.xy) + u_xlat6.xy;
    u_xlat1.xy = u_xlat6.xy * u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * u_xlat6.xy + (-vec2(_OutlineThickness));
    u_xlat0.xy = log2(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_Pow, _Pow));
    u_xlat0.xy = exp2(u_xlat0.xy);
    u_xlat0.x = u_xlat0.y + u_xlat0.x;
    u_xlat3.xy = log2(u_xlat1.xy);
    u_xlat3.xy = u_xlat3.xy * vec2(vec2(_Pow, _Pow));
    u_xlat3.xy = exp2(u_xlat3.xy);
    u_xlat3.x = u_xlat3.y + u_xlat3.x;
    u_xlat0.z = u_xlat3.x + u_xlat0.x;
    u_xlat0.x = max(u_xlat0.x, u_xlat3.x);
    u_xlat0.xy = u_xlat0.xz + vec2(-1.0, -2.0);
    u_xlat3.x = u_xlat0.y * _Sharpness;
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat1 = vs_COLOR0 + vs_COLOR0;
    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz + (-_OutlineColor.xyz);
    u_xlat6.x = u_xlat1.w * _TintColor.w;
    u_xlat0.x = u_xlat0.x * u_xlat6.x;
    u_xlat2.w = u_xlat0.x * _Sharpness;
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
    u_xlat2.xyz = u_xlat3.xxx * u_xlat1.xyz + _OutlineColor.xyz;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ENABLE_OUTLINE" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
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
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Sharpness;
uniform 	float _Pow;
uniform 	mediump float _OutlineThickness;
uniform 	mediump vec4 _OutlineColor;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
vec4 u_xlat1;
ivec2 u_xlati1;
vec4 u_xlat2;
vec2 u_xlat3;
vec2 u_xlat6;
ivec2 u_xlati6;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlati6.xy = ivec2(ivec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * -1);
    u_xlati1.xy = ivec2(ivec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * -1);
    u_xlati6.xy = (-u_xlati6.xy) + u_xlati1.xy;
    u_xlat6.xy = vec2(u_xlati6.xy);
    u_xlat0.xy = (-u_xlat0.xy) + u_xlat6.xy;
    u_xlat1.xy = u_xlat6.xy * u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * u_xlat6.xy + (-vec2(_OutlineThickness));
    u_xlat0.xy = log2(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_Pow, _Pow));
    u_xlat0.xy = exp2(u_xlat0.xy);
    u_xlat0.x = u_xlat0.y + u_xlat0.x;
    u_xlat3.xy = log2(u_xlat1.xy);
    u_xlat3.xy = u_xlat3.xy * vec2(vec2(_Pow, _Pow));
    u_xlat3.xy = exp2(u_xlat3.xy);
    u_xlat3.x = u_xlat3.y + u_xlat3.x;
    u_xlat0.z = u_xlat3.x + u_xlat0.x;
    u_xlat0.x = max(u_xlat0.x, u_xlat3.x);
    u_xlat0.xy = u_xlat0.xz + vec2(-1.0, -2.0);
    u_xlat3.x = u_xlat0.y * _Sharpness;
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat1 = vs_COLOR0 + vs_COLOR0;
    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz + (-_OutlineColor.xyz);
    u_xlat6.x = u_xlat1.w * _TintColor.w;
    u_xlat0.x = u_xlat0.x * u_xlat6.x;
    u_xlat2.w = u_xlat0.x * _Sharpness;
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
    u_xlat2.xyz = u_xlat3.xxx * u_xlat1.xyz + _OutlineColor.xyz;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ENABLE_OUTLINE" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
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
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Sharpness;
uniform 	float _Pow;
uniform 	mediump float _OutlineThickness;
uniform 	mediump vec4 _OutlineColor;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
vec4 u_xlat1;
ivec2 u_xlati1;
vec4 u_xlat2;
vec2 u_xlat3;
vec2 u_xlat6;
ivec2 u_xlati6;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlati6.xy = ivec2(ivec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * -1);
    u_xlati1.xy = ivec2(ivec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * -1);
    u_xlati6.xy = (-u_xlati6.xy) + u_xlati1.xy;
    u_xlat6.xy = vec2(u_xlati6.xy);
    u_xlat0.xy = (-u_xlat0.xy) + u_xlat6.xy;
    u_xlat1.xy = u_xlat6.xy * u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * u_xlat6.xy + (-vec2(_OutlineThickness));
    u_xlat0.xy = log2(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_Pow, _Pow));
    u_xlat0.xy = exp2(u_xlat0.xy);
    u_xlat0.x = u_xlat0.y + u_xlat0.x;
    u_xlat3.xy = log2(u_xlat1.xy);
    u_xlat3.xy = u_xlat3.xy * vec2(vec2(_Pow, _Pow));
    u_xlat3.xy = exp2(u_xlat3.xy);
    u_xlat3.x = u_xlat3.y + u_xlat3.x;
    u_xlat0.z = u_xlat3.x + u_xlat0.x;
    u_xlat0.x = max(u_xlat0.x, u_xlat3.x);
    u_xlat0.xy = u_xlat0.xz + vec2(-1.0, -2.0);
    u_xlat3.x = u_xlat0.y * _Sharpness;
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat1 = vs_COLOR0 + vs_COLOR0;
    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz + (-_OutlineColor.xyz);
    u_xlat6.x = u_xlat1.w * _TintColor.w;
    u_xlat0.x = u_xlat0.x * u_xlat6.x;
    u_xlat2.w = u_xlat0.x * _Sharpness;
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
    u_xlat2.xyz = u_xlat3.xxx * u_xlat1.xyz + _OutlineColor.xyz;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ENABLE_OUTLINE" }
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
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
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
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Sharpness;
uniform 	float _Pow;
uniform 	mediump float _OutlineThickness;
uniform 	mediump vec4 _OutlineColor;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec4 u_xlat1;
ivec2 u_xlati1;
vec4 u_xlat2;
vec2 u_xlat3;
vec2 u_xlat6;
ivec2 u_xlati6;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlati6.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati1.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlati6.xy = (-u_xlati6.xy) + u_xlati1.xy;
    u_xlat6.xy = vec2(u_xlati6.xy);
    u_xlat0.xy = (-u_xlat0.xy) + u_xlat6.xy;
    u_xlat1.xy = u_xlat6.xy * u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * u_xlat6.xy + (-vec2(_OutlineThickness));
    u_xlat0.xy = log2(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_Pow, _Pow));
    u_xlat0.xy = exp2(u_xlat0.xy);
    u_xlat0.x = u_xlat0.y + u_xlat0.x;
    u_xlat3.xy = log2(u_xlat1.xy);
    u_xlat3.xy = u_xlat3.xy * vec2(vec2(_Pow, _Pow));
    u_xlat3.xy = exp2(u_xlat3.xy);
    u_xlat3.x = u_xlat3.y + u_xlat3.x;
    u_xlat0.z = u_xlat3.x + u_xlat0.x;
    u_xlat0.x = max(u_xlat0.x, u_xlat3.x);
    u_xlat0.xy = u_xlat0.xz + vec2(-1.0, -2.0);
    u_xlat3.x = u_xlat0.y * _Sharpness;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat1 = vs_COLOR0 + vs_COLOR0;
    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz + (-_OutlineColor.xyz);
    u_xlat6.x = u_xlat1.w * _TintColor.w;
    u_xlat0.x = u_xlat0.x * u_xlat6.x;
    u_xlat2.w = u_xlat0.x * _Sharpness;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat3.xxx * u_xlat1.xyz + _OutlineColor.xyz;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ENABLE_OUTLINE" }
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
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
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
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Sharpness;
uniform 	float _Pow;
uniform 	mediump float _OutlineThickness;
uniform 	mediump vec4 _OutlineColor;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec4 u_xlat1;
ivec2 u_xlati1;
vec4 u_xlat2;
vec2 u_xlat3;
vec2 u_xlat6;
ivec2 u_xlati6;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlati6.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati1.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlati6.xy = (-u_xlati6.xy) + u_xlati1.xy;
    u_xlat6.xy = vec2(u_xlati6.xy);
    u_xlat0.xy = (-u_xlat0.xy) + u_xlat6.xy;
    u_xlat1.xy = u_xlat6.xy * u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * u_xlat6.xy + (-vec2(_OutlineThickness));
    u_xlat0.xy = log2(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_Pow, _Pow));
    u_xlat0.xy = exp2(u_xlat0.xy);
    u_xlat0.x = u_xlat0.y + u_xlat0.x;
    u_xlat3.xy = log2(u_xlat1.xy);
    u_xlat3.xy = u_xlat3.xy * vec2(vec2(_Pow, _Pow));
    u_xlat3.xy = exp2(u_xlat3.xy);
    u_xlat3.x = u_xlat3.y + u_xlat3.x;
    u_xlat0.z = u_xlat3.x + u_xlat0.x;
    u_xlat0.x = max(u_xlat0.x, u_xlat3.x);
    u_xlat0.xy = u_xlat0.xz + vec2(-1.0, -2.0);
    u_xlat3.x = u_xlat0.y * _Sharpness;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat1 = vs_COLOR0 + vs_COLOR0;
    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz + (-_OutlineColor.xyz);
    u_xlat6.x = u_xlat1.w * _TintColor.w;
    u_xlat0.x = u_xlat0.x * u_xlat6.x;
    u_xlat2.w = u_xlat0.x * _Sharpness;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat3.xxx * u_xlat1.xyz + _OutlineColor.xyz;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ENABLE_OUTLINE" }
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
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
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
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	float _Sharpness;
uniform 	float _Pow;
uniform 	mediump float _OutlineThickness;
uniform 	mediump vec4 _OutlineColor;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec4 u_xlat1;
ivec2 u_xlati1;
vec4 u_xlat2;
vec2 u_xlat3;
vec2 u_xlat6;
ivec2 u_xlati6;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlati6.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat0.xyxy).xy) * 0xFFFFFFFFu);
    u_xlati1.xy = ivec2(uvec2(lessThan(u_xlat0.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    u_xlati6.xy = (-u_xlati6.xy) + u_xlati1.xy;
    u_xlat6.xy = vec2(u_xlati6.xy);
    u_xlat0.xy = (-u_xlat0.xy) + u_xlat6.xy;
    u_xlat1.xy = u_xlat6.xy * u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * u_xlat6.xy + (-vec2(_OutlineThickness));
    u_xlat0.xy = log2(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_Pow, _Pow));
    u_xlat0.xy = exp2(u_xlat0.xy);
    u_xlat0.x = u_xlat0.y + u_xlat0.x;
    u_xlat3.xy = log2(u_xlat1.xy);
    u_xlat3.xy = u_xlat3.xy * vec2(vec2(_Pow, _Pow));
    u_xlat3.xy = exp2(u_xlat3.xy);
    u_xlat3.x = u_xlat3.y + u_xlat3.x;
    u_xlat0.z = u_xlat3.x + u_xlat0.x;
    u_xlat0.x = max(u_xlat0.x, u_xlat3.x);
    u_xlat0.xy = u_xlat0.xz + vec2(-1.0, -2.0);
    u_xlat3.x = u_xlat0.y * _Sharpness;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat1 = vs_COLOR0 + vs_COLOR0;
    u_xlat1.xyz = u_xlat1.xyz * _TintColor.xyz + (-_OutlineColor.xyz);
    u_xlat6.x = u_xlat1.w * _TintColor.w;
    u_xlat0.x = u_xlat0.x * u_xlat6.x;
    u_xlat2.w = u_xlat0.x * _Sharpness;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.w = min(max(u_xlat2.w, 0.0), 1.0);
#else
    u_xlat2.w = clamp(u_xlat2.w, 0.0, 1.0);
#endif
    u_xlat2.xyz = u_xlat3.xxx * u_xlat1.xyz + _OutlineColor.xyz;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
}
}
}
}