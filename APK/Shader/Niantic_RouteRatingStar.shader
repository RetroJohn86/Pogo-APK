//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Niantic/RouteRatingStar" {
Properties {
_Color ("Tint Color", Color) = (1,1,1,1)
_RatingStarTexture ("Rating Star Texture", 2D) = "white" { }
_NoRatingStarTexture ("No Rating Star Texture", 2D) = "white" { }
_NumStars ("Number of Stars", Float) = 5
_Rating ("Rating", Range(0, 1)) = 0.5
_MainTex ("Sprite Texture", 2D) = "white" { }
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
  GpuProgramID 64654
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _RatingStarTexture_ST;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _RatingStarTexture_ST.xy + _RatingStarTexture_ST.zw;
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
uniform 	int _NumStars;
uniform 	mediump float _Rating;
uniform lowp sampler2D _RatingStarTexture;
uniform lowp sampler2D _NoRatingStarTexture;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
float u_xlat2;
bool u_xlatb2;
float u_xlat3;
float trunc(float x) { return sign(x)*floor(abs(x)); }
vec2 trunc(vec2 x) { return sign(x)*floor(abs(x)); }
vec3 trunc(vec3 x) { return sign(x)*floor(abs(x)); }
vec4 trunc(vec4 x) { return sign(x)*floor(abs(x)); }

void main()
{
    u_xlat0.x = float(_NumStars);
    u_xlat3 = u_xlat0.x * vs_TEXCOORD0.x;
    u_xlat3 = trunc(u_xlat3);
    u_xlat0.x = vs_TEXCOORD0.x * u_xlat0.x + (-u_xlat3);
    u_xlat0.y = vs_TEXCOORD0.y;
    u_xlat10_1 = texture2D(_RatingStarTexture, u_xlat0.xy);
    u_xlat10_0 = texture2D(_NoRatingStarTexture, u_xlat0.xy);
    u_xlat1 = (-u_xlat10_0) + u_xlat10_1;
    u_xlatb2 = _Rating>=vs_TEXCOORD0.x;
    u_xlat2 = u_xlatb2 ? 1.0 : float(0.0);
    u_xlat0 = vec4(u_xlat2) * u_xlat1 + u_xlat10_0;
    SV_Target0 = u_xlat0 * vs_COLOR0;
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
uniform 	vec4 _RatingStarTexture_ST;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _RatingStarTexture_ST.xy + _RatingStarTexture_ST.zw;
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
uniform 	int _NumStars;
uniform 	mediump float _Rating;
uniform lowp sampler2D _RatingStarTexture;
uniform lowp sampler2D _NoRatingStarTexture;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
float u_xlat2;
bool u_xlatb2;
float u_xlat3;
float trunc(float x) { return sign(x)*floor(abs(x)); }
vec2 trunc(vec2 x) { return sign(x)*floor(abs(x)); }
vec3 trunc(vec3 x) { return sign(x)*floor(abs(x)); }
vec4 trunc(vec4 x) { return sign(x)*floor(abs(x)); }

void main()
{
    u_xlat0.x = float(_NumStars);
    u_xlat3 = u_xlat0.x * vs_TEXCOORD0.x;
    u_xlat3 = trunc(u_xlat3);
    u_xlat0.x = vs_TEXCOORD0.x * u_xlat0.x + (-u_xlat3);
    u_xlat0.y = vs_TEXCOORD0.y;
    u_xlat10_1 = texture2D(_RatingStarTexture, u_xlat0.xy);
    u_xlat10_0 = texture2D(_NoRatingStarTexture, u_xlat0.xy);
    u_xlat1 = (-u_xlat10_0) + u_xlat10_1;
    u_xlatb2 = _Rating>=vs_TEXCOORD0.x;
    u_xlat2 = u_xlatb2 ? 1.0 : float(0.0);
    u_xlat0 = vec4(u_xlat2) * u_xlat1 + u_xlat10_0;
    SV_Target0 = u_xlat0 * vs_COLOR0;
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
uniform 	vec4 _RatingStarTexture_ST;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _RatingStarTexture_ST.xy + _RatingStarTexture_ST.zw;
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
uniform 	int _NumStars;
uniform 	mediump float _Rating;
uniform lowp sampler2D _RatingStarTexture;
uniform lowp sampler2D _NoRatingStarTexture;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
float u_xlat2;
bool u_xlatb2;
float u_xlat3;
float trunc(float x) { return sign(x)*floor(abs(x)); }
vec2 trunc(vec2 x) { return sign(x)*floor(abs(x)); }
vec3 trunc(vec3 x) { return sign(x)*floor(abs(x)); }
vec4 trunc(vec4 x) { return sign(x)*floor(abs(x)); }

void main()
{
    u_xlat0.x = float(_NumStars);
    u_xlat3 = u_xlat0.x * vs_TEXCOORD0.x;
    u_xlat3 = trunc(u_xlat3);
    u_xlat0.x = vs_TEXCOORD0.x * u_xlat0.x + (-u_xlat3);
    u_xlat0.y = vs_TEXCOORD0.y;
    u_xlat10_1 = texture2D(_RatingStarTexture, u_xlat0.xy);
    u_xlat10_0 = texture2D(_NoRatingStarTexture, u_xlat0.xy);
    u_xlat1 = (-u_xlat10_0) + u_xlat10_1;
    u_xlatb2 = _Rating>=vs_TEXCOORD0.x;
    u_xlat2 = u_xlatb2 ? 1.0 : float(0.0);
    u_xlat0 = vec4(u_xlat2) * u_xlat1 + u_xlat10_0;
    SV_Target0 = u_xlat0 * vs_COLOR0;
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
uniform 	vec4 _RatingStarTexture_ST;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _RatingStarTexture_ST.xy + _RatingStarTexture_ST.zw;
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
uniform 	int _NumStars;
uniform 	mediump float _Rating;
UNITY_LOCATION(0) uniform mediump sampler2D _RatingStarTexture;
UNITY_LOCATION(1) uniform mediump sampler2D _NoRatingStarTexture;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
float u_xlat2;
bool u_xlatb2;
float u_xlat3;
void main()
{
    u_xlat0.x = float(_NumStars);
    u_xlat3 = u_xlat0.x * vs_TEXCOORD0.x;
    u_xlat3 = trunc(u_xlat3);
    u_xlat0.x = vs_TEXCOORD0.x * u_xlat0.x + (-u_xlat3);
    u_xlat0.y = vs_TEXCOORD0.y;
    u_xlat16_1 = texture(_RatingStarTexture, u_xlat0.xy);
    u_xlat16_0 = texture(_NoRatingStarTexture, u_xlat0.xy);
    u_xlat1 = (-u_xlat16_0) + u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_Rating>=vs_TEXCOORD0.x);
#else
    u_xlatb2 = _Rating>=vs_TEXCOORD0.x;
#endif
    u_xlat2 = u_xlatb2 ? 1.0 : float(0.0);
    u_xlat0 = vec4(u_xlat2) * u_xlat1 + u_xlat16_0;
    SV_Target0 = u_xlat0 * vs_COLOR0;
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
uniform 	vec4 _RatingStarTexture_ST;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _RatingStarTexture_ST.xy + _RatingStarTexture_ST.zw;
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
uniform 	int _NumStars;
uniform 	mediump float _Rating;
UNITY_LOCATION(0) uniform mediump sampler2D _RatingStarTexture;
UNITY_LOCATION(1) uniform mediump sampler2D _NoRatingStarTexture;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
float u_xlat2;
bool u_xlatb2;
float u_xlat3;
void main()
{
    u_xlat0.x = float(_NumStars);
    u_xlat3 = u_xlat0.x * vs_TEXCOORD0.x;
    u_xlat3 = trunc(u_xlat3);
    u_xlat0.x = vs_TEXCOORD0.x * u_xlat0.x + (-u_xlat3);
    u_xlat0.y = vs_TEXCOORD0.y;
    u_xlat16_1 = texture(_RatingStarTexture, u_xlat0.xy);
    u_xlat16_0 = texture(_NoRatingStarTexture, u_xlat0.xy);
    u_xlat1 = (-u_xlat16_0) + u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_Rating>=vs_TEXCOORD0.x);
#else
    u_xlatb2 = _Rating>=vs_TEXCOORD0.x;
#endif
    u_xlat2 = u_xlatb2 ? 1.0 : float(0.0);
    u_xlat0 = vec4(u_xlat2) * u_xlat1 + u_xlat16_0;
    SV_Target0 = u_xlat0 * vs_COLOR0;
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
uniform 	vec4 _RatingStarTexture_ST;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _RatingStarTexture_ST.xy + _RatingStarTexture_ST.zw;
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
uniform 	int _NumStars;
uniform 	mediump float _Rating;
UNITY_LOCATION(0) uniform mediump sampler2D _RatingStarTexture;
UNITY_LOCATION(1) uniform mediump sampler2D _NoRatingStarTexture;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
float u_xlat2;
bool u_xlatb2;
float u_xlat3;
void main()
{
    u_xlat0.x = float(_NumStars);
    u_xlat3 = u_xlat0.x * vs_TEXCOORD0.x;
    u_xlat3 = trunc(u_xlat3);
    u_xlat0.x = vs_TEXCOORD0.x * u_xlat0.x + (-u_xlat3);
    u_xlat0.y = vs_TEXCOORD0.y;
    u_xlat16_1 = texture(_RatingStarTexture, u_xlat0.xy);
    u_xlat16_0 = texture(_NoRatingStarTexture, u_xlat0.xy);
    u_xlat1 = (-u_xlat16_0) + u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(_Rating>=vs_TEXCOORD0.x);
#else
    u_xlatb2 = _Rating>=vs_TEXCOORD0.x;
#endif
    u_xlat2 = u_xlatb2 ? 1.0 : float(0.0);
    u_xlat0 = vec4(u_xlat2) * u_xlat1 + u_xlat16_0;
    SV_Target0 = u_xlat0 * vs_COLOR0;
    return;
}

#endif
"
}
}
}
}
}