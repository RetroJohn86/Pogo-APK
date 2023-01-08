//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Niantic/PokemonInventoryBackground" {
Properties {
_MainTex ("Sprite Texture", 2D) = "white" { }
_EdgeWidth ("Edge Width", Float) = 0.05
_EdgeFeather ("Edge Feather", Float) = 0.05
_EdgeColor ("Edge Color", Color) = (0.7,0.7,0.7,1)
_TopLeftColor ("Top Left Color", Color) = (0.2,0.83,0.2,1)
_TopRightColor ("Top Right Color", Color) = (0.2,0.83,0.2,1)
_BottomLeftColor ("Bottom Left Color", Color) = (1,1,1,1)
_BottomRightColor ("Bottom Right Color", Color) = (1,1,1,1)
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
  GpuProgramID 60115
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
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
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat1 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat1;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD0.xy = u_xlat0.xy / u_xlat0.ww;
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
uniform 	float _EdgeWidth;
uniform 	float _EdgeFeather;
uniform 	mediump vec4 _EdgeColor;
uniform 	vec4 _TopLeftColor;
uniform 	vec4 _TopRightColor;
uniform 	vec4 _BottomLeftColor;
uniform 	vec4 _BottomRightColor;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
float u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
float u_xlat3;
float u_xlat6;
void main()
{
    u_xlat0 = (-_EdgeWidth) + 0.5;
    u_xlat3 = u_xlat0 + _EdgeFeather;
    u_xlat0 = u_xlat0 + (-_EdgeFeather);
    u_xlat3 = (-u_xlat0) + u_xlat3;
    u_xlat3 = float(1.0) / u_xlat3;
    u_xlat6 = vs_TEXCOORD0.x + -0.5;
    u_xlat0 = (-u_xlat0) + abs(u_xlat6);
    u_xlat0 = u_xlat3 * u_xlat0;
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
    u_xlat3 = u_xlat0 * -2.0 + 3.0;
    u_xlat0 = u_xlat0 * u_xlat0;
    u_xlat0 = u_xlat0 * u_xlat3;
    u_xlat1 = _TopRightColor + (-_BottomRightColor);
    u_xlat1 = vs_TEXCOORD0.yyyy * u_xlat1 + _BottomRightColor;
    u_xlat2 = _TopLeftColor + (-_BottomLeftColor);
    u_xlat2 = vs_TEXCOORD0.yyyy * u_xlat2 + _BottomLeftColor;
    u_xlat1 = u_xlat1 + (-u_xlat2);
    u_xlat1 = vs_TEXCOORD0.xxxx * u_xlat1 + u_xlat2;
    u_xlat16_2 = (-u_xlat1) + _EdgeColor;
    SV_Target0 = vec4(u_xlat0) * u_xlat16_2 + u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
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
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat1 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat1;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD0.xy = u_xlat0.xy / u_xlat0.ww;
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
uniform 	float _EdgeWidth;
uniform 	float _EdgeFeather;
uniform 	mediump vec4 _EdgeColor;
uniform 	vec4 _TopLeftColor;
uniform 	vec4 _TopRightColor;
uniform 	vec4 _BottomLeftColor;
uniform 	vec4 _BottomRightColor;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
float u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
float u_xlat3;
float u_xlat6;
void main()
{
    u_xlat0 = (-_EdgeWidth) + 0.5;
    u_xlat3 = u_xlat0 + _EdgeFeather;
    u_xlat0 = u_xlat0 + (-_EdgeFeather);
    u_xlat3 = (-u_xlat0) + u_xlat3;
    u_xlat3 = float(1.0) / u_xlat3;
    u_xlat6 = vs_TEXCOORD0.x + -0.5;
    u_xlat0 = (-u_xlat0) + abs(u_xlat6);
    u_xlat0 = u_xlat3 * u_xlat0;
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
    u_xlat3 = u_xlat0 * -2.0 + 3.0;
    u_xlat0 = u_xlat0 * u_xlat0;
    u_xlat0 = u_xlat0 * u_xlat3;
    u_xlat1 = _TopRightColor + (-_BottomRightColor);
    u_xlat1 = vs_TEXCOORD0.yyyy * u_xlat1 + _BottomRightColor;
    u_xlat2 = _TopLeftColor + (-_BottomLeftColor);
    u_xlat2 = vs_TEXCOORD0.yyyy * u_xlat2 + _BottomLeftColor;
    u_xlat1 = u_xlat1 + (-u_xlat2);
    u_xlat1 = vs_TEXCOORD0.xxxx * u_xlat1 + u_xlat2;
    u_xlat16_2 = (-u_xlat1) + _EdgeColor;
    SV_Target0 = vec4(u_xlat0) * u_xlat16_2 + u_xlat1;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
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
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat1 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat1;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD0.xy = u_xlat0.xy / u_xlat0.ww;
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
uniform 	float _EdgeWidth;
uniform 	float _EdgeFeather;
uniform 	mediump vec4 _EdgeColor;
uniform 	vec4 _TopLeftColor;
uniform 	vec4 _TopRightColor;
uniform 	vec4 _BottomLeftColor;
uniform 	vec4 _BottomRightColor;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
float u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
float u_xlat3;
float u_xlat6;
void main()
{
    u_xlat0 = (-_EdgeWidth) + 0.5;
    u_xlat3 = u_xlat0 + _EdgeFeather;
    u_xlat0 = u_xlat0 + (-_EdgeFeather);
    u_xlat3 = (-u_xlat0) + u_xlat3;
    u_xlat3 = float(1.0) / u_xlat3;
    u_xlat6 = vs_TEXCOORD0.x + -0.5;
    u_xlat0 = (-u_xlat0) + abs(u_xlat6);
    u_xlat0 = u_xlat3 * u_xlat0;
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
    u_xlat3 = u_xlat0 * -2.0 + 3.0;
    u_xlat0 = u_xlat0 * u_xlat0;
    u_xlat0 = u_xlat0 * u_xlat3;
    u_xlat1 = _TopRightColor + (-_BottomRightColor);
    u_xlat1 = vs_TEXCOORD0.yyyy * u_xlat1 + _BottomRightColor;
    u_xlat2 = _TopLeftColor + (-_BottomLeftColor);
    u_xlat2 = vs_TEXCOORD0.yyyy * u_xlat2 + _BottomLeftColor;
    u_xlat1 = u_xlat1 + (-u_xlat2);
    u_xlat1 = vs_TEXCOORD0.xxxx * u_xlat1 + u_xlat2;
    u_xlat16_2 = (-u_xlat1) + _EdgeColor;
    SV_Target0 = vec4(u_xlat0) * u_xlat16_2 + u_xlat1;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
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
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat1 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat1;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD0.xy = u_xlat0.xy / u_xlat0.ww;
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
uniform 	float _EdgeWidth;
uniform 	float _EdgeFeather;
uniform 	mediump vec4 _EdgeColor;
uniform 	vec4 _TopLeftColor;
uniform 	vec4 _TopRightColor;
uniform 	vec4 _BottomLeftColor;
uniform 	vec4 _BottomRightColor;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
float u_xlat3;
float u_xlat6;
void main()
{
    u_xlat0 = (-_EdgeWidth) + 0.5;
    u_xlat3 = u_xlat0 + _EdgeFeather;
    u_xlat0 = u_xlat0 + (-_EdgeFeather);
    u_xlat3 = (-u_xlat0) + u_xlat3;
    u_xlat3 = float(1.0) / u_xlat3;
    u_xlat6 = vs_TEXCOORD0.x + -0.5;
    u_xlat0 = (-u_xlat0) + abs(u_xlat6);
    u_xlat0 = u_xlat3 * u_xlat0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat3 = u_xlat0 * -2.0 + 3.0;
    u_xlat0 = u_xlat0 * u_xlat0;
    u_xlat0 = u_xlat0 * u_xlat3;
    u_xlat1 = _TopRightColor + (-_BottomRightColor);
    u_xlat1 = vs_TEXCOORD0.yyyy * u_xlat1 + _BottomRightColor;
    u_xlat2 = _TopLeftColor + (-_BottomLeftColor);
    u_xlat2 = vs_TEXCOORD0.yyyy * u_xlat2 + _BottomLeftColor;
    u_xlat1 = u_xlat1 + (-u_xlat2);
    u_xlat1 = vs_TEXCOORD0.xxxx * u_xlat1 + u_xlat2;
    u_xlat16_2 = (-u_xlat1) + _EdgeColor;
    SV_Target0 = vec4(u_xlat0) * u_xlat16_2 + u_xlat1;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
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
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat1 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat1;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD0.xy = u_xlat0.xy / u_xlat0.ww;
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
uniform 	float _EdgeWidth;
uniform 	float _EdgeFeather;
uniform 	mediump vec4 _EdgeColor;
uniform 	vec4 _TopLeftColor;
uniform 	vec4 _TopRightColor;
uniform 	vec4 _BottomLeftColor;
uniform 	vec4 _BottomRightColor;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
float u_xlat3;
float u_xlat6;
void main()
{
    u_xlat0 = (-_EdgeWidth) + 0.5;
    u_xlat3 = u_xlat0 + _EdgeFeather;
    u_xlat0 = u_xlat0 + (-_EdgeFeather);
    u_xlat3 = (-u_xlat0) + u_xlat3;
    u_xlat3 = float(1.0) / u_xlat3;
    u_xlat6 = vs_TEXCOORD0.x + -0.5;
    u_xlat0 = (-u_xlat0) + abs(u_xlat6);
    u_xlat0 = u_xlat3 * u_xlat0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat3 = u_xlat0 * -2.0 + 3.0;
    u_xlat0 = u_xlat0 * u_xlat0;
    u_xlat0 = u_xlat0 * u_xlat3;
    u_xlat1 = _TopRightColor + (-_BottomRightColor);
    u_xlat1 = vs_TEXCOORD0.yyyy * u_xlat1 + _BottomRightColor;
    u_xlat2 = _TopLeftColor + (-_BottomLeftColor);
    u_xlat2 = vs_TEXCOORD0.yyyy * u_xlat2 + _BottomLeftColor;
    u_xlat1 = u_xlat1 + (-u_xlat2);
    u_xlat1 = vs_TEXCOORD0.xxxx * u_xlat1 + u_xlat2;
    u_xlat16_2 = (-u_xlat1) + _EdgeColor;
    SV_Target0 = vec4(u_xlat0) * u_xlat16_2 + u_xlat1;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
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
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat1 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat1;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD0.xy = u_xlat0.xy / u_xlat0.ww;
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
uniform 	float _EdgeWidth;
uniform 	float _EdgeFeather;
uniform 	mediump vec4 _EdgeColor;
uniform 	vec4 _TopLeftColor;
uniform 	vec4 _TopRightColor;
uniform 	vec4 _BottomLeftColor;
uniform 	vec4 _BottomRightColor;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
float u_xlat3;
float u_xlat6;
void main()
{
    u_xlat0 = (-_EdgeWidth) + 0.5;
    u_xlat3 = u_xlat0 + _EdgeFeather;
    u_xlat0 = u_xlat0 + (-_EdgeFeather);
    u_xlat3 = (-u_xlat0) + u_xlat3;
    u_xlat3 = float(1.0) / u_xlat3;
    u_xlat6 = vs_TEXCOORD0.x + -0.5;
    u_xlat0 = (-u_xlat0) + abs(u_xlat6);
    u_xlat0 = u_xlat3 * u_xlat0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat3 = u_xlat0 * -2.0 + 3.0;
    u_xlat0 = u_xlat0 * u_xlat0;
    u_xlat0 = u_xlat0 * u_xlat3;
    u_xlat1 = _TopRightColor + (-_BottomRightColor);
    u_xlat1 = vs_TEXCOORD0.yyyy * u_xlat1 + _BottomRightColor;
    u_xlat2 = _TopLeftColor + (-_BottomLeftColor);
    u_xlat2 = vs_TEXCOORD0.yyyy * u_xlat2 + _BottomLeftColor;
    u_xlat1 = u_xlat1 + (-u_xlat2);
    u_xlat1 = vs_TEXCOORD0.xxxx * u_xlat1 + u_xlat2;
    u_xlat16_2 = (-u_xlat1) + _EdgeColor;
    SV_Target0 = vec4(u_xlat0) * u_xlat16_2 + u_xlat1;
    return;
}

#endif
"
}
}
}
}
}