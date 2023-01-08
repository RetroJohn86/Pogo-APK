//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Niantic/UI/SpriteOutline" {
Properties {
_MainTex ("Main Texture", 2D) = "white" { }
_Color ("Tint Color", Color) = (1,1,1,1)
_OutlineColor ("Outline Color", Color) = (1,1,1,1)
_OutlineSize ("Outline size", Float) = 1
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
  GpuProgramID 3096
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	vec4 _MainTex_TexelSize;
uniform 	mediump vec4 _OutlineColor;
uniform 	mediump float _OutlineSize;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump float u_xlat16_1;
vec4 u_xlat2;
lowp float u_xlat10_3;
void main()
{
    u_xlat0.x = (-_MainTex_TexelSize.x) * _OutlineSize + vs_TEXCOORD0.x;
    u_xlat0.yz = vs_TEXCOORD0.yx;
    u_xlat10_0.x = texture2D(_MainTex, u_xlat0.xy).w;
    u_xlat0.w = _MainTex_TexelSize.y * _OutlineSize + vs_TEXCOORD0.y;
    u_xlat10_3 = texture2D(_MainTex, u_xlat0.zw).w;
    u_xlat16_1 = u_xlat10_3 * u_xlat10_0.x;
    u_xlat0.x = _MainTex_TexelSize.x * _OutlineSize + vs_TEXCOORD0.x;
    u_xlat0.yz = vs_TEXCOORD0.yx;
    u_xlat10_0.x = texture2D(_MainTex, u_xlat0.xy).w;
    u_xlat16_1 = u_xlat10_0.x * u_xlat16_1;
    u_xlat0.w = (-_MainTex_TexelSize.y) * _OutlineSize + vs_TEXCOORD0.y;
    u_xlat10_0.x = texture2D(_MainTex, u_xlat0.zw).w;
    u_xlat16_1 = (-u_xlat16_1) * u_xlat10_0.x + 1.0;
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2 = u_xlat10_0 * vs_COLOR0;
    u_xlat16_0 = (-u_xlat10_0) * vs_COLOR0 + _OutlineColor;
    u_xlat16_1 = u_xlat16_1 * u_xlat2.w;
    SV_Target0 = vec4(u_xlat16_1) * u_xlat16_0 + u_xlat2;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	vec4 _MainTex_TexelSize;
uniform 	mediump vec4 _OutlineColor;
uniform 	mediump float _OutlineSize;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump float u_xlat16_1;
vec4 u_xlat2;
lowp float u_xlat10_3;
void main()
{
    u_xlat0.x = (-_MainTex_TexelSize.x) * _OutlineSize + vs_TEXCOORD0.x;
    u_xlat0.yz = vs_TEXCOORD0.yx;
    u_xlat10_0.x = texture2D(_MainTex, u_xlat0.xy).w;
    u_xlat0.w = _MainTex_TexelSize.y * _OutlineSize + vs_TEXCOORD0.y;
    u_xlat10_3 = texture2D(_MainTex, u_xlat0.zw).w;
    u_xlat16_1 = u_xlat10_3 * u_xlat10_0.x;
    u_xlat0.x = _MainTex_TexelSize.x * _OutlineSize + vs_TEXCOORD0.x;
    u_xlat0.yz = vs_TEXCOORD0.yx;
    u_xlat10_0.x = texture2D(_MainTex, u_xlat0.xy).w;
    u_xlat16_1 = u_xlat10_0.x * u_xlat16_1;
    u_xlat0.w = (-_MainTex_TexelSize.y) * _OutlineSize + vs_TEXCOORD0.y;
    u_xlat10_0.x = texture2D(_MainTex, u_xlat0.zw).w;
    u_xlat16_1 = (-u_xlat16_1) * u_xlat10_0.x + 1.0;
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2 = u_xlat10_0 * vs_COLOR0;
    u_xlat16_0 = (-u_xlat10_0) * vs_COLOR0 + _OutlineColor;
    u_xlat16_1 = u_xlat16_1 * u_xlat2.w;
    SV_Target0 = vec4(u_xlat16_1) * u_xlat16_0 + u_xlat2;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	vec4 _MainTex_TexelSize;
uniform 	mediump vec4 _OutlineColor;
uniform 	mediump float _OutlineSize;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump float u_xlat16_1;
vec4 u_xlat2;
lowp float u_xlat10_3;
void main()
{
    u_xlat0.x = (-_MainTex_TexelSize.x) * _OutlineSize + vs_TEXCOORD0.x;
    u_xlat0.yz = vs_TEXCOORD0.yx;
    u_xlat10_0.x = texture2D(_MainTex, u_xlat0.xy).w;
    u_xlat0.w = _MainTex_TexelSize.y * _OutlineSize + vs_TEXCOORD0.y;
    u_xlat10_3 = texture2D(_MainTex, u_xlat0.zw).w;
    u_xlat16_1 = u_xlat10_3 * u_xlat10_0.x;
    u_xlat0.x = _MainTex_TexelSize.x * _OutlineSize + vs_TEXCOORD0.x;
    u_xlat0.yz = vs_TEXCOORD0.yx;
    u_xlat10_0.x = texture2D(_MainTex, u_xlat0.xy).w;
    u_xlat16_1 = u_xlat10_0.x * u_xlat16_1;
    u_xlat0.w = (-_MainTex_TexelSize.y) * _OutlineSize + vs_TEXCOORD0.y;
    u_xlat10_0.x = texture2D(_MainTex, u_xlat0.zw).w;
    u_xlat16_1 = (-u_xlat16_1) * u_xlat10_0.x + 1.0;
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2 = u_xlat10_0 * vs_COLOR0;
    u_xlat16_0 = (-u_xlat10_0) * vs_COLOR0 + _OutlineColor;
    u_xlat16_1 = u_xlat16_1 * u_xlat2.w;
    SV_Target0 = vec4(u_xlat16_1) * u_xlat16_0 + u_xlat2;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	vec4 _MainTex_TexelSize;
uniform 	mediump vec4 _OutlineColor;
uniform 	mediump float _OutlineSize;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump float u_xlat16_1;
vec4 u_xlat2;
mediump float u_xlat16_3;
void main()
{
    u_xlat0.x = (-_MainTex_TexelSize.x) * _OutlineSize + vs_TEXCOORD0.x;
    u_xlat0.yz = vs_TEXCOORD0.yx;
    u_xlat16_0.x = texture(_MainTex, u_xlat0.xy).w;
    u_xlat0.w = _MainTex_TexelSize.y * _OutlineSize + vs_TEXCOORD0.y;
    u_xlat16_3 = texture(_MainTex, u_xlat0.zw).w;
    u_xlat16_1 = u_xlat16_3 * u_xlat16_0.x;
    u_xlat0.x = _MainTex_TexelSize.x * _OutlineSize + vs_TEXCOORD0.x;
    u_xlat0.yz = vs_TEXCOORD0.yx;
    u_xlat16_0.x = texture(_MainTex, u_xlat0.xy).w;
    u_xlat16_1 = u_xlat16_0.x * u_xlat16_1;
    u_xlat0.w = (-_MainTex_TexelSize.y) * _OutlineSize + vs_TEXCOORD0.y;
    u_xlat16_0.x = texture(_MainTex, u_xlat0.zw).w;
    u_xlat16_1 = (-u_xlat16_1) * u_xlat16_0.x + 1.0;
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2 = u_xlat16_0 * vs_COLOR0;
    u_xlat16_0 = (-u_xlat16_0) * vs_COLOR0 + _OutlineColor;
    u_xlat16_1 = u_xlat16_1 * u_xlat2.w;
    SV_Target0 = vec4(u_xlat16_1) * u_xlat16_0 + u_xlat2;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	vec4 _MainTex_TexelSize;
uniform 	mediump vec4 _OutlineColor;
uniform 	mediump float _OutlineSize;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump float u_xlat16_1;
vec4 u_xlat2;
mediump float u_xlat16_3;
void main()
{
    u_xlat0.x = (-_MainTex_TexelSize.x) * _OutlineSize + vs_TEXCOORD0.x;
    u_xlat0.yz = vs_TEXCOORD0.yx;
    u_xlat16_0.x = texture(_MainTex, u_xlat0.xy).w;
    u_xlat0.w = _MainTex_TexelSize.y * _OutlineSize + vs_TEXCOORD0.y;
    u_xlat16_3 = texture(_MainTex, u_xlat0.zw).w;
    u_xlat16_1 = u_xlat16_3 * u_xlat16_0.x;
    u_xlat0.x = _MainTex_TexelSize.x * _OutlineSize + vs_TEXCOORD0.x;
    u_xlat0.yz = vs_TEXCOORD0.yx;
    u_xlat16_0.x = texture(_MainTex, u_xlat0.xy).w;
    u_xlat16_1 = u_xlat16_0.x * u_xlat16_1;
    u_xlat0.w = (-_MainTex_TexelSize.y) * _OutlineSize + vs_TEXCOORD0.y;
    u_xlat16_0.x = texture(_MainTex, u_xlat0.zw).w;
    u_xlat16_1 = (-u_xlat16_1) * u_xlat16_0.x + 1.0;
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2 = u_xlat16_0 * vs_COLOR0;
    u_xlat16_0 = (-u_xlat16_0) * vs_COLOR0 + _OutlineColor;
    u_xlat16_1 = u_xlat16_1 * u_xlat2.w;
    SV_Target0 = vec4(u_xlat16_1) * u_xlat16_0 + u_xlat2;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	vec4 _MainTex_TexelSize;
uniform 	mediump vec4 _OutlineColor;
uniform 	mediump float _OutlineSize;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump float u_xlat16_1;
vec4 u_xlat2;
mediump float u_xlat16_3;
void main()
{
    u_xlat0.x = (-_MainTex_TexelSize.x) * _OutlineSize + vs_TEXCOORD0.x;
    u_xlat0.yz = vs_TEXCOORD0.yx;
    u_xlat16_0.x = texture(_MainTex, u_xlat0.xy).w;
    u_xlat0.w = _MainTex_TexelSize.y * _OutlineSize + vs_TEXCOORD0.y;
    u_xlat16_3 = texture(_MainTex, u_xlat0.zw).w;
    u_xlat16_1 = u_xlat16_3 * u_xlat16_0.x;
    u_xlat0.x = _MainTex_TexelSize.x * _OutlineSize + vs_TEXCOORD0.x;
    u_xlat0.yz = vs_TEXCOORD0.yx;
    u_xlat16_0.x = texture(_MainTex, u_xlat0.xy).w;
    u_xlat16_1 = u_xlat16_0.x * u_xlat16_1;
    u_xlat0.w = (-_MainTex_TexelSize.y) * _OutlineSize + vs_TEXCOORD0.y;
    u_xlat16_0.x = texture(_MainTex, u_xlat0.zw).w;
    u_xlat16_1 = (-u_xlat16_1) * u_xlat16_0.x + 1.0;
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2 = u_xlat16_0 * vs_COLOR0;
    u_xlat16_0 = (-u_xlat16_0) * vs_COLOR0 + _OutlineColor;
    u_xlat16_1 = u_xlat16_1 * u_xlat2.w;
    SV_Target0 = vec4(u_xlat16_1) * u_xlat16_0 + u_xlat2;
    return;
}

#endif
"
}
}
}
}
}