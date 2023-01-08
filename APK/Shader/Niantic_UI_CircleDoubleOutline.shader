//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Niantic/UI/CircleDoubleOutline" {
Properties {
_MainTex ("Sprite Texture", 2D) = "white" { }
_Color ("Tint", Color) = (1,1,1,1)
_CenterColor ("Center Color", Color) = (1,1,1,1)
_Radius ("Border Radius", Range(0, 1)) = 0.5
[Space] _BorderColorInner ("Border Color Inner", Color) = (0,1,0,0.5)
_BorderWidthInner ("Border Width Inner", Range(0, 1)) = 0.1
[Space] _BorderColorOuter ("Border Color Outer", Color) = (1,0,0,0.5)
_BorderWidthOuter ("Border Width Outer", Range(0, 1)) = 0.1
[Space] _StencilComp ("Stencil Comparison", Float) = 8
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
  GpuProgramID 58746
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _Color;
uniform 	mediump float _Radius;
uniform 	mediump float _BorderWidthOuter;
uniform 	mediump float _BorderWidthInner;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec3 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
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
    vs_COLOR0 = in_COLOR0 * _Color;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_2.x = (-_BorderWidthOuter) + _Radius;
    u_xlat16_2.y = u_xlat16_2.x + (-_BorderWidthInner);
    u_xlat0.xy = u_xlat0.xy / u_xlat16_2.yy;
    vs_TEXCOORD2.zw = u_xlat16_2.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy + vec2(0.5, 0.5);
    vs_TEXCOORD1 = in_POSITION0;
    u_xlat0.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    vs_TEXCOORD2.xy = u_xlat0.xy;
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
uniform 	mediump vec4 _CenterColor;
uniform 	mediump vec4 _BorderColorOuter;
uniform 	mediump vec4 _BorderColorInner;
uniform 	mediump float _Radius;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
mediump vec4 u_xlat16_0;
float u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
bvec2 u_xlatb3;
mediump vec2 u_xlat16_6;
mediump float u_xlat16_12;
void main()
{
    u_xlat16_0.xyz = vs_COLOR0.xyz;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0.w = 1.0;
    u_xlat16_2 = u_xlat10_1 * u_xlat16_0 + (-_CenterColor);
    u_xlat1 = u_xlat16_0.w * u_xlat10_1.w;
    u_xlat16_0 = vec4(u_xlat1) * u_xlat16_2 + _CenterColor;
    u_xlat16_1 = (-u_xlat16_0) + _BorderColorInner;
    u_xlat16_2.x = dot(vs_TEXCOORD2.xy, vs_TEXCOORD2.xy);
    u_xlat16_2.x = sqrt(u_xlat16_2.x);
    u_xlat16_2.yz = u_xlat16_2.xx + (-vs_TEXCOORD2.wz);
    u_xlat16_2.x = u_xlat16_2.x + (-_Radius);
    u_xlat16_2.xyz = u_xlat16_2.xyz + vec3(1.0, 1.0, 1.0);
    u_xlatb3.x = 1.0>=u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb3.x) ? 1.0 : 0.0;
    u_xlatb3.xy = greaterThanEqual(u_xlat16_2.yzyy, vec4(1.0, 1.0, 0.0, 0.0)).xy;
    u_xlat16_6.x = (u_xlatb3.x) ? float(1.0) : float(0.0);
    u_xlat16_6.y = (u_xlatb3.y) ? float(1.0) : float(0.0);
    u_xlat16_0 = u_xlat16_6.xxxx * u_xlat16_1 + u_xlat16_0;
    u_xlat16_1 = (-u_xlat16_0) + _BorderColorOuter;
    u_xlat16_0 = u_xlat16_6.yyyy * u_xlat16_1 + u_xlat16_0;
    u_xlat16_12 = u_xlat16_0.w * vs_COLOR0.w;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_2.x * u_xlat16_12;
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
uniform 	mediump float _Radius;
uniform 	mediump float _BorderWidthOuter;
uniform 	mediump float _BorderWidthInner;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec3 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
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
    vs_COLOR0 = in_COLOR0 * _Color;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_2.x = (-_BorderWidthOuter) + _Radius;
    u_xlat16_2.y = u_xlat16_2.x + (-_BorderWidthInner);
    u_xlat0.xy = u_xlat0.xy / u_xlat16_2.yy;
    vs_TEXCOORD2.zw = u_xlat16_2.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy + vec2(0.5, 0.5);
    vs_TEXCOORD1 = in_POSITION0;
    u_xlat0.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    vs_TEXCOORD2.xy = u_xlat0.xy;
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
uniform 	mediump vec4 _CenterColor;
uniform 	mediump vec4 _BorderColorOuter;
uniform 	mediump vec4 _BorderColorInner;
uniform 	mediump float _Radius;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
mediump vec4 u_xlat16_0;
float u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
bvec2 u_xlatb3;
mediump vec2 u_xlat16_6;
mediump float u_xlat16_12;
void main()
{
    u_xlat16_0.xyz = vs_COLOR0.xyz;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0.w = 1.0;
    u_xlat16_2 = u_xlat10_1 * u_xlat16_0 + (-_CenterColor);
    u_xlat1 = u_xlat16_0.w * u_xlat10_1.w;
    u_xlat16_0 = vec4(u_xlat1) * u_xlat16_2 + _CenterColor;
    u_xlat16_1 = (-u_xlat16_0) + _BorderColorInner;
    u_xlat16_2.x = dot(vs_TEXCOORD2.xy, vs_TEXCOORD2.xy);
    u_xlat16_2.x = sqrt(u_xlat16_2.x);
    u_xlat16_2.yz = u_xlat16_2.xx + (-vs_TEXCOORD2.wz);
    u_xlat16_2.x = u_xlat16_2.x + (-_Radius);
    u_xlat16_2.xyz = u_xlat16_2.xyz + vec3(1.0, 1.0, 1.0);
    u_xlatb3.x = 1.0>=u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb3.x) ? 1.0 : 0.0;
    u_xlatb3.xy = greaterThanEqual(u_xlat16_2.yzyy, vec4(1.0, 1.0, 0.0, 0.0)).xy;
    u_xlat16_6.x = (u_xlatb3.x) ? float(1.0) : float(0.0);
    u_xlat16_6.y = (u_xlatb3.y) ? float(1.0) : float(0.0);
    u_xlat16_0 = u_xlat16_6.xxxx * u_xlat16_1 + u_xlat16_0;
    u_xlat16_1 = (-u_xlat16_0) + _BorderColorOuter;
    u_xlat16_0 = u_xlat16_6.yyyy * u_xlat16_1 + u_xlat16_0;
    u_xlat16_12 = u_xlat16_0.w * vs_COLOR0.w;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_2.x * u_xlat16_12;
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
uniform 	mediump float _Radius;
uniform 	mediump float _BorderWidthOuter;
uniform 	mediump float _BorderWidthInner;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec3 in_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying mediump vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
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
    vs_COLOR0 = in_COLOR0 * _Color;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_2.x = (-_BorderWidthOuter) + _Radius;
    u_xlat16_2.y = u_xlat16_2.x + (-_BorderWidthInner);
    u_xlat0.xy = u_xlat0.xy / u_xlat16_2.yy;
    vs_TEXCOORD2.zw = u_xlat16_2.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy + vec2(0.5, 0.5);
    vs_TEXCOORD1 = in_POSITION0;
    u_xlat0.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    vs_TEXCOORD2.xy = u_xlat0.xy;
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
uniform 	mediump vec4 _CenterColor;
uniform 	mediump vec4 _BorderColorOuter;
uniform 	mediump vec4 _BorderColorInner;
uniform 	mediump float _Radius;
uniform lowp sampler2D _MainTex;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
mediump vec4 u_xlat16_0;
float u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec4 u_xlat16_2;
bvec2 u_xlatb3;
mediump vec2 u_xlat16_6;
mediump float u_xlat16_12;
void main()
{
    u_xlat16_0.xyz = vs_COLOR0.xyz;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0.w = 1.0;
    u_xlat16_2 = u_xlat10_1 * u_xlat16_0 + (-_CenterColor);
    u_xlat1 = u_xlat16_0.w * u_xlat10_1.w;
    u_xlat16_0 = vec4(u_xlat1) * u_xlat16_2 + _CenterColor;
    u_xlat16_1 = (-u_xlat16_0) + _BorderColorInner;
    u_xlat16_2.x = dot(vs_TEXCOORD2.xy, vs_TEXCOORD2.xy);
    u_xlat16_2.x = sqrt(u_xlat16_2.x);
    u_xlat16_2.yz = u_xlat16_2.xx + (-vs_TEXCOORD2.wz);
    u_xlat16_2.x = u_xlat16_2.x + (-_Radius);
    u_xlat16_2.xyz = u_xlat16_2.xyz + vec3(1.0, 1.0, 1.0);
    u_xlatb3.x = 1.0>=u_xlat16_2.x;
    u_xlat16_2.x = (u_xlatb3.x) ? 1.0 : 0.0;
    u_xlatb3.xy = greaterThanEqual(u_xlat16_2.yzyy, vec4(1.0, 1.0, 0.0, 0.0)).xy;
    u_xlat16_6.x = (u_xlatb3.x) ? float(1.0) : float(0.0);
    u_xlat16_6.y = (u_xlatb3.y) ? float(1.0) : float(0.0);
    u_xlat16_0 = u_xlat16_6.xxxx * u_xlat16_1 + u_xlat16_0;
    u_xlat16_1 = (-u_xlat16_0) + _BorderColorOuter;
    u_xlat16_0 = u_xlat16_6.yyyy * u_xlat16_1 + u_xlat16_0;
    u_xlat16_12 = u_xlat16_0.w * vs_COLOR0.w;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_2.x * u_xlat16_12;
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
uniform 	mediump float _Radius;
uniform 	mediump float _BorderWidthOuter;
uniform 	mediump float _BorderWidthInner;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec3 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
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
    vs_COLOR0 = in_COLOR0 * _Color;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_2.x = (-_BorderWidthOuter) + _Radius;
    u_xlat16_2.y = u_xlat16_2.x + (-_BorderWidthInner);
    u_xlat0.xy = u_xlat0.xy / u_xlat16_2.yy;
    vs_TEXCOORD2.zw = u_xlat16_2.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy + vec2(0.5, 0.5);
    vs_TEXCOORD1 = in_POSITION0;
    u_xlat0.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    vs_TEXCOORD2.xy = u_xlat0.xy;
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
uniform 	mediump vec4 _CenterColor;
uniform 	mediump vec4 _BorderColorOuter;
uniform 	mediump vec4 _BorderColorInner;
uniform 	mediump float _Radius;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
float u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
bvec2 u_xlatb3;
mediump vec2 u_xlat16_6;
mediump float u_xlat16_12;
void main()
{
    u_xlat16_0.xyz = vs_COLOR0.xyz;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0.w = 1.0;
    u_xlat16_2 = u_xlat16_1 * u_xlat16_0 + (-_CenterColor);
    u_xlat1 = u_xlat16_0.w * u_xlat16_1.w;
    u_xlat16_0 = vec4(u_xlat1) * u_xlat16_2 + _CenterColor;
    u_xlat16_1 = (-u_xlat16_0) + _BorderColorInner;
    u_xlat16_2.x = dot(vs_TEXCOORD2.xy, vs_TEXCOORD2.xy);
    u_xlat16_2.x = sqrt(u_xlat16_2.x);
    u_xlat16_2.yz = u_xlat16_2.xx + (-vs_TEXCOORD2.wz);
    u_xlat16_2.x = u_xlat16_2.x + (-_Radius);
    u_xlat16_2.xyz = u_xlat16_2.xyz + vec3(1.0, 1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb3.x = !!(1.0>=u_xlat16_2.x);
#else
    u_xlatb3.x = 1.0>=u_xlat16_2.x;
#endif
    u_xlat16_2.x = (u_xlatb3.x) ? 1.0 : 0.0;
    u_xlatb3.xy = greaterThanEqual(u_xlat16_2.yzyy, vec4(1.0, 1.0, 0.0, 0.0)).xy;
    u_xlat16_6.x = (u_xlatb3.x) ? float(1.0) : float(0.0);
    u_xlat16_6.y = (u_xlatb3.y) ? float(1.0) : float(0.0);
    u_xlat16_0 = u_xlat16_6.xxxx * u_xlat16_1 + u_xlat16_0;
    u_xlat16_1 = (-u_xlat16_0) + _BorderColorOuter;
    u_xlat16_0 = u_xlat16_6.yyyy * u_xlat16_1 + u_xlat16_0;
    u_xlat16_12 = u_xlat16_0.w * vs_COLOR0.w;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_2.x * u_xlat16_12;
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
uniform 	mediump float _Radius;
uniform 	mediump float _BorderWidthOuter;
uniform 	mediump float _BorderWidthInner;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec3 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
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
    vs_COLOR0 = in_COLOR0 * _Color;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_2.x = (-_BorderWidthOuter) + _Radius;
    u_xlat16_2.y = u_xlat16_2.x + (-_BorderWidthInner);
    u_xlat0.xy = u_xlat0.xy / u_xlat16_2.yy;
    vs_TEXCOORD2.zw = u_xlat16_2.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy + vec2(0.5, 0.5);
    vs_TEXCOORD1 = in_POSITION0;
    u_xlat0.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    vs_TEXCOORD2.xy = u_xlat0.xy;
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
uniform 	mediump vec4 _CenterColor;
uniform 	mediump vec4 _BorderColorOuter;
uniform 	mediump vec4 _BorderColorInner;
uniform 	mediump float _Radius;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
float u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
bvec2 u_xlatb3;
mediump vec2 u_xlat16_6;
mediump float u_xlat16_12;
void main()
{
    u_xlat16_0.xyz = vs_COLOR0.xyz;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0.w = 1.0;
    u_xlat16_2 = u_xlat16_1 * u_xlat16_0 + (-_CenterColor);
    u_xlat1 = u_xlat16_0.w * u_xlat16_1.w;
    u_xlat16_0 = vec4(u_xlat1) * u_xlat16_2 + _CenterColor;
    u_xlat16_1 = (-u_xlat16_0) + _BorderColorInner;
    u_xlat16_2.x = dot(vs_TEXCOORD2.xy, vs_TEXCOORD2.xy);
    u_xlat16_2.x = sqrt(u_xlat16_2.x);
    u_xlat16_2.yz = u_xlat16_2.xx + (-vs_TEXCOORD2.wz);
    u_xlat16_2.x = u_xlat16_2.x + (-_Radius);
    u_xlat16_2.xyz = u_xlat16_2.xyz + vec3(1.0, 1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb3.x = !!(1.0>=u_xlat16_2.x);
#else
    u_xlatb3.x = 1.0>=u_xlat16_2.x;
#endif
    u_xlat16_2.x = (u_xlatb3.x) ? 1.0 : 0.0;
    u_xlatb3.xy = greaterThanEqual(u_xlat16_2.yzyy, vec4(1.0, 1.0, 0.0, 0.0)).xy;
    u_xlat16_6.x = (u_xlatb3.x) ? float(1.0) : float(0.0);
    u_xlat16_6.y = (u_xlatb3.y) ? float(1.0) : float(0.0);
    u_xlat16_0 = u_xlat16_6.xxxx * u_xlat16_1 + u_xlat16_0;
    u_xlat16_1 = (-u_xlat16_0) + _BorderColorOuter;
    u_xlat16_0 = u_xlat16_6.yyyy * u_xlat16_1 + u_xlat16_0;
    u_xlat16_12 = u_xlat16_0.w * vs_COLOR0.w;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_2.x * u_xlat16_12;
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
uniform 	mediump float _Radius;
uniform 	mediump float _BorderWidthOuter;
uniform 	mediump float _BorderWidthInner;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec3 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
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
    vs_COLOR0 = in_COLOR0 * _Color;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = u_xlat0.xy + vec2(-0.5, -0.5);
    u_xlat16_2.x = (-_BorderWidthOuter) + _Radius;
    u_xlat16_2.y = u_xlat16_2.x + (-_BorderWidthInner);
    u_xlat0.xy = u_xlat0.xy / u_xlat16_2.yy;
    vs_TEXCOORD2.zw = u_xlat16_2.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy + vec2(0.5, 0.5);
    vs_TEXCOORD1 = in_POSITION0;
    u_xlat0.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    vs_TEXCOORD2.xy = u_xlat0.xy;
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
uniform 	mediump vec4 _CenterColor;
uniform 	mediump vec4 _BorderColorOuter;
uniform 	mediump vec4 _BorderColorInner;
uniform 	mediump float _Radius;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
float u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
bvec2 u_xlatb3;
mediump vec2 u_xlat16_6;
mediump float u_xlat16_12;
void main()
{
    u_xlat16_0.xyz = vs_COLOR0.xyz;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0.w = 1.0;
    u_xlat16_2 = u_xlat16_1 * u_xlat16_0 + (-_CenterColor);
    u_xlat1 = u_xlat16_0.w * u_xlat16_1.w;
    u_xlat16_0 = vec4(u_xlat1) * u_xlat16_2 + _CenterColor;
    u_xlat16_1 = (-u_xlat16_0) + _BorderColorInner;
    u_xlat16_2.x = dot(vs_TEXCOORD2.xy, vs_TEXCOORD2.xy);
    u_xlat16_2.x = sqrt(u_xlat16_2.x);
    u_xlat16_2.yz = u_xlat16_2.xx + (-vs_TEXCOORD2.wz);
    u_xlat16_2.x = u_xlat16_2.x + (-_Radius);
    u_xlat16_2.xyz = u_xlat16_2.xyz + vec3(1.0, 1.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb3.x = !!(1.0>=u_xlat16_2.x);
#else
    u_xlatb3.x = 1.0>=u_xlat16_2.x;
#endif
    u_xlat16_2.x = (u_xlatb3.x) ? 1.0 : 0.0;
    u_xlatb3.xy = greaterThanEqual(u_xlat16_2.yzyy, vec4(1.0, 1.0, 0.0, 0.0)).xy;
    u_xlat16_6.x = (u_xlatb3.x) ? float(1.0) : float(0.0);
    u_xlat16_6.y = (u_xlatb3.y) ? float(1.0) : float(0.0);
    u_xlat16_0 = u_xlat16_6.xxxx * u_xlat16_1 + u_xlat16_0;
    u_xlat16_1 = (-u_xlat16_0) + _BorderColorOuter;
    u_xlat16_0 = u_xlat16_6.yyyy * u_xlat16_1 + u_xlat16_0;
    u_xlat16_12 = u_xlat16_0.w * vs_COLOR0.w;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_2.x * u_xlat16_12;
    return;
}

#endif
"
}
}
}
}
}