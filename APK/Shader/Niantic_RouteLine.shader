//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Niantic/RouteLine" {
Properties {
_TintColor ("Tint Color", Color) = (1,0,0,1)
_Scale ("Scale", Float) = 1
_Gradient ("Gradient", Float) = -3.5
_OffsetY ("Offset", Float) = 1
_LineWidth ("Width", Float) = 0.045
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent-1" "RenderType" = "Transparent" }
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent-1" "RenderType" = "Transparent" }
  Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
  ZWrite Off
  Cull Off
  GpuProgramID 263
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _Scale;
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
uniform 	float _Scale;
uniform 	float _Gradient;
uniform 	float _OffsetY;
uniform 	float _LineWidth;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_1;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_5;
void main()
{
    u_xlat0.x = vs_TEXCOORD0.x / _Scale;
    u_xlat16_1 = (-u_xlat0.x) * u_xlat0.x + u_xlat0.x;
    u_xlat0.x = u_xlat16_1 * _Gradient + _OffsetY;
    u_xlat1.z = u_xlat0.x + (-_LineWidth);
    u_xlat1.w = u_xlat0.x + _LineWidth;
    u_xlat1.x = float(-0.0199999996);
    u_xlat1.y = float(-0.0199999996);
    u_xlat0 = u_xlat1 + vec4(0.100000001, 0.5, -0.0199999996, -0.0199999996);
    u_xlat1.xy = fract(vs_TEXCOORD0.xx);
    u_xlat1.zw = vs_TEXCOORD0.yy;
    u_xlat0 = (-u_xlat0) + u_xlat1;
    u_xlat0 = u_xlat0 * vec4(24.9999962, 25.0000057, 25.0, 25.0);
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
    u_xlat1 = u_xlat0 * vec4(-2.0, -2.0, -2.0, -2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat0 = u_xlat0 * u_xlat0;
    u_xlat3.xz = u_xlat0.yw * u_xlat1.yw;
    u_xlat16_2.xy = (-u_xlat1.xz) * u_xlat0.xz + vec2(1.0, 1.0);
    u_xlat16_2.xy = max(u_xlat3.xz, u_xlat16_2.xy);
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
uniform 	float _Scale;
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
uniform 	float _Scale;
uniform 	float _Gradient;
uniform 	float _OffsetY;
uniform 	float _LineWidth;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_1;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_5;
void main()
{
    u_xlat0.x = vs_TEXCOORD0.x / _Scale;
    u_xlat16_1 = (-u_xlat0.x) * u_xlat0.x + u_xlat0.x;
    u_xlat0.x = u_xlat16_1 * _Gradient + _OffsetY;
    u_xlat1.z = u_xlat0.x + (-_LineWidth);
    u_xlat1.w = u_xlat0.x + _LineWidth;
    u_xlat1.x = float(-0.0199999996);
    u_xlat1.y = float(-0.0199999996);
    u_xlat0 = u_xlat1 + vec4(0.100000001, 0.5, -0.0199999996, -0.0199999996);
    u_xlat1.xy = fract(vs_TEXCOORD0.xx);
    u_xlat1.zw = vs_TEXCOORD0.yy;
    u_xlat0 = (-u_xlat0) + u_xlat1;
    u_xlat0 = u_xlat0 * vec4(24.9999962, 25.0000057, 25.0, 25.0);
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
    u_xlat1 = u_xlat0 * vec4(-2.0, -2.0, -2.0, -2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat0 = u_xlat0 * u_xlat0;
    u_xlat3.xz = u_xlat0.yw * u_xlat1.yw;
    u_xlat16_2.xy = (-u_xlat1.xz) * u_xlat0.xz + vec2(1.0, 1.0);
    u_xlat16_2.xy = max(u_xlat3.xz, u_xlat16_2.xy);
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
uniform 	float _Scale;
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
uniform 	float _Scale;
uniform 	float _Gradient;
uniform 	float _OffsetY;
uniform 	float _LineWidth;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_1;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_5;
void main()
{
    u_xlat0.x = vs_TEXCOORD0.x / _Scale;
    u_xlat16_1 = (-u_xlat0.x) * u_xlat0.x + u_xlat0.x;
    u_xlat0.x = u_xlat16_1 * _Gradient + _OffsetY;
    u_xlat1.z = u_xlat0.x + (-_LineWidth);
    u_xlat1.w = u_xlat0.x + _LineWidth;
    u_xlat1.x = float(-0.0199999996);
    u_xlat1.y = float(-0.0199999996);
    u_xlat0 = u_xlat1 + vec4(0.100000001, 0.5, -0.0199999996, -0.0199999996);
    u_xlat1.xy = fract(vs_TEXCOORD0.xx);
    u_xlat1.zw = vs_TEXCOORD0.yy;
    u_xlat0 = (-u_xlat0) + u_xlat1;
    u_xlat0 = u_xlat0 * vec4(24.9999962, 25.0000057, 25.0, 25.0);
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
    u_xlat1 = u_xlat0 * vec4(-2.0, -2.0, -2.0, -2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat0 = u_xlat0 * u_xlat0;
    u_xlat3.xz = u_xlat0.yw * u_xlat1.yw;
    u_xlat16_2.xy = (-u_xlat1.xz) * u_xlat0.xz + vec2(1.0, 1.0);
    u_xlat16_2.xy = max(u_xlat3.xz, u_xlat16_2.xy);
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
uniform 	float _Scale;
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
uniform 	float _Scale;
uniform 	float _Gradient;
uniform 	float _OffsetY;
uniform 	float _LineWidth;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_1;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_5;
void main()
{
    u_xlat0.x = vs_TEXCOORD0.x / _Scale;
    u_xlat16_1 = (-u_xlat0.x) * u_xlat0.x + u_xlat0.x;
    u_xlat0.x = u_xlat16_1 * _Gradient + _OffsetY;
    u_xlat1.z = u_xlat0.x + (-_LineWidth);
    u_xlat1.w = u_xlat0.x + _LineWidth;
    u_xlat1.x = float(-0.0199999996);
    u_xlat1.y = float(-0.0199999996);
    u_xlat0 = u_xlat1 + vec4(0.100000001, 0.5, -0.0199999996, -0.0199999996);
    u_xlat1.xy = fract(vs_TEXCOORD0.xx);
    u_xlat1.zw = vs_TEXCOORD0.yy;
    u_xlat0 = (-u_xlat0) + u_xlat1;
    u_xlat0 = u_xlat0 * vec4(24.9999962, 25.0000057, 25.0, 25.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat1 = u_xlat0 * vec4(-2.0, -2.0, -2.0, -2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat0 = u_xlat0 * u_xlat0;
    u_xlat3.xz = u_xlat0.yw * u_xlat1.yw;
    u_xlat16_2.xy = (-u_xlat1.xz) * u_xlat0.xz + vec2(1.0, 1.0);
    u_xlat16_2.xy = max(u_xlat3.xz, u_xlat16_2.xy);
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
uniform 	float _Scale;
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
uniform 	float _Scale;
uniform 	float _Gradient;
uniform 	float _OffsetY;
uniform 	float _LineWidth;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_1;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_5;
void main()
{
    u_xlat0.x = vs_TEXCOORD0.x / _Scale;
    u_xlat16_1 = (-u_xlat0.x) * u_xlat0.x + u_xlat0.x;
    u_xlat0.x = u_xlat16_1 * _Gradient + _OffsetY;
    u_xlat1.z = u_xlat0.x + (-_LineWidth);
    u_xlat1.w = u_xlat0.x + _LineWidth;
    u_xlat1.x = float(-0.0199999996);
    u_xlat1.y = float(-0.0199999996);
    u_xlat0 = u_xlat1 + vec4(0.100000001, 0.5, -0.0199999996, -0.0199999996);
    u_xlat1.xy = fract(vs_TEXCOORD0.xx);
    u_xlat1.zw = vs_TEXCOORD0.yy;
    u_xlat0 = (-u_xlat0) + u_xlat1;
    u_xlat0 = u_xlat0 * vec4(24.9999962, 25.0000057, 25.0, 25.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat1 = u_xlat0 * vec4(-2.0, -2.0, -2.0, -2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat0 = u_xlat0 * u_xlat0;
    u_xlat3.xz = u_xlat0.yw * u_xlat1.yw;
    u_xlat16_2.xy = (-u_xlat1.xz) * u_xlat0.xz + vec2(1.0, 1.0);
    u_xlat16_2.xy = max(u_xlat3.xz, u_xlat16_2.xy);
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
uniform 	float _Scale;
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
uniform 	float _Scale;
uniform 	float _Gradient;
uniform 	float _OffsetY;
uniform 	float _LineWidth;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump float u_xlat16_1;
mediump vec2 u_xlat16_2;
vec3 u_xlat3;
mediump float u_xlat16_5;
void main()
{
    u_xlat0.x = vs_TEXCOORD0.x / _Scale;
    u_xlat16_1 = (-u_xlat0.x) * u_xlat0.x + u_xlat0.x;
    u_xlat0.x = u_xlat16_1 * _Gradient + _OffsetY;
    u_xlat1.z = u_xlat0.x + (-_LineWidth);
    u_xlat1.w = u_xlat0.x + _LineWidth;
    u_xlat1.x = float(-0.0199999996);
    u_xlat1.y = float(-0.0199999996);
    u_xlat0 = u_xlat1 + vec4(0.100000001, 0.5, -0.0199999996, -0.0199999996);
    u_xlat1.xy = fract(vs_TEXCOORD0.xx);
    u_xlat1.zw = vs_TEXCOORD0.yy;
    u_xlat0 = (-u_xlat0) + u_xlat1;
    u_xlat0 = u_xlat0 * vec4(24.9999962, 25.0000057, 25.0, 25.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat1 = u_xlat0 * vec4(-2.0, -2.0, -2.0, -2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat0 = u_xlat0 * u_xlat0;
    u_xlat3.xz = u_xlat0.yw * u_xlat1.yw;
    u_xlat16_2.xy = (-u_xlat1.xz) * u_xlat0.xz + vec2(1.0, 1.0);
    u_xlat16_2.xy = max(u_xlat3.xz, u_xlat16_2.xy);
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