//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Unlit/UnlitPanningDetail" {
Properties {
_MainTex ("Texture", 2D) = "white" { }
_DetailTex ("Detail Texture", 2D) = "white" { }
_DetailScale ("Detail Texture Scale", Vector) = (1,1,1,0)
_Color ("Color", Color) = (1,1,1,1)
[Enum(UnityEngine.Rendering.CullMode)] _Cull ("Culling Mode (None = double-sided)", Float) = 2
_PanningSpeed ("Panning Speed", Vector) = (0,0,0,0)
_Interval ("Gap Between Each Repeat", Float) = 0
_Rate ("Show Rate On Each Repeat", Range(0, 1)) = 1
_StencilComp ("Stencil Comparison", Float) = 8
_Stencil ("Stencil ID", Float) = 0
_StencilOp ("Stencil Operation", Float) = 0
_StencilWriteMask ("Stencil Write Mask", Float) = 255
_StencilReadMask ("Stencil Read Mask", Float) = 255
_ColorMask ("Color Mask", Float) = 15
[Toggle(UNITY_UI_ALPHACLIP)] _UseUIAlphaClip ("Use Alpha Clip", Float) = 0
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
  GpuProgramID 39540
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _PanningSpeed;
uniform 	mediump vec4 _DetailScale;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat4.xy = _Time.yy * _PanningSpeed.xy + u_xlat0.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    vs_TEXCOORD1.xy = u_xlat4.xy * _DetailScale.xy;
    vs_TEXCOORD2 = in_POSITION0;
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
uniform 	vec4 _Color;
uniform 	mediump float _Interval;
uniform 	mediump float _Rate;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DetailTex;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
bool u_xlatb3;
void main()
{
    u_xlat0.x = floor(abs(vs_TEXCOORD1.x));
    u_xlat16_1.x = _Interval + 1.0;
    u_xlat0.x = u_xlat0.x / u_xlat16_1.x;
    u_xlatb3 = u_xlat0.x>=(-u_xlat0.x);
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb3) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat16_1.x * u_xlat0.x;
    u_xlat16_1.x = (-_Rate) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * _Interval;
    u_xlatb0 = u_xlat0.x>=u_xlat16_1.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_2 = texture2D(_DetailTex, vs_TEXCOORD1.xy);
    u_xlat16_1 = u_xlat10_1 * u_xlat10_2;
    u_xlat0.w = u_xlat0.x * u_xlat16_1.w;
    u_xlat0.xyz = u_xlat16_1.xyz * _Color.xyz;
    SV_Target0 = u_xlat0 * vs_COLOR0;
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
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _PanningSpeed;
uniform 	mediump vec4 _DetailScale;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat4.xy = _Time.yy * _PanningSpeed.xy + u_xlat0.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    vs_TEXCOORD1.xy = u_xlat4.xy * _DetailScale.xy;
    vs_TEXCOORD2 = in_POSITION0;
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
uniform 	vec4 _Color;
uniform 	mediump float _Interval;
uniform 	mediump float _Rate;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DetailTex;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
bool u_xlatb3;
void main()
{
    u_xlat0.x = floor(abs(vs_TEXCOORD1.x));
    u_xlat16_1.x = _Interval + 1.0;
    u_xlat0.x = u_xlat0.x / u_xlat16_1.x;
    u_xlatb3 = u_xlat0.x>=(-u_xlat0.x);
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb3) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat16_1.x * u_xlat0.x;
    u_xlat16_1.x = (-_Rate) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * _Interval;
    u_xlatb0 = u_xlat0.x>=u_xlat16_1.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_2 = texture2D(_DetailTex, vs_TEXCOORD1.xy);
    u_xlat16_1 = u_xlat10_1 * u_xlat10_2;
    u_xlat0.w = u_xlat0.x * u_xlat16_1.w;
    u_xlat0.xyz = u_xlat16_1.xyz * _Color.xyz;
    SV_Target0 = u_xlat0 * vs_COLOR0;
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
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _PanningSpeed;
uniform 	mediump vec4 _DetailScale;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat4.xy = _Time.yy * _PanningSpeed.xy + u_xlat0.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    vs_TEXCOORD1.xy = u_xlat4.xy * _DetailScale.xy;
    vs_TEXCOORD2 = in_POSITION0;
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
uniform 	vec4 _Color;
uniform 	mediump float _Interval;
uniform 	mediump float _Rate;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DetailTex;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
bool u_xlatb3;
void main()
{
    u_xlat0.x = floor(abs(vs_TEXCOORD1.x));
    u_xlat16_1.x = _Interval + 1.0;
    u_xlat0.x = u_xlat0.x / u_xlat16_1.x;
    u_xlatb3 = u_xlat0.x>=(-u_xlat0.x);
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb3) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat16_1.x * u_xlat0.x;
    u_xlat16_1.x = (-_Rate) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * _Interval;
    u_xlatb0 = u_xlat0.x>=u_xlat16_1.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_2 = texture2D(_DetailTex, vs_TEXCOORD1.xy);
    u_xlat16_1 = u_xlat10_1 * u_xlat10_2;
    u_xlat0.w = u_xlat0.x * u_xlat16_1.w;
    u_xlat0.xyz = u_xlat16_1.xyz * _Color.xyz;
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
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _PanningSpeed;
uniform 	mediump vec4 _DetailScale;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat4.xy = _Time.yy * _PanningSpeed.xy + u_xlat0.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    vs_TEXCOORD1.xy = u_xlat4.xy * _DetailScale.xy;
    vs_TEXCOORD2 = in_POSITION0;
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
uniform 	vec4 _Color;
uniform 	mediump float _Interval;
uniform 	mediump float _Rate;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _DetailTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
bool u_xlatb3;
void main()
{
    u_xlat0.x = floor(abs(vs_TEXCOORD1.x));
    u_xlat16_1.x = _Interval + 1.0;
    u_xlat0.x = u_xlat0.x / u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat0.x>=(-u_xlat0.x));
#else
    u_xlatb3 = u_xlat0.x>=(-u_xlat0.x);
#endif
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb3) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat16_1.x * u_xlat0.x;
    u_xlat16_1.x = (-_Rate) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * _Interval;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=u_xlat16_1.x);
#else
    u_xlatb0 = u_xlat0.x>=u_xlat16_1.x;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2 = texture(_DetailTex, vs_TEXCOORD1.xy);
    u_xlat16_1 = u_xlat16_1 * u_xlat16_2;
    u_xlat0.w = u_xlat0.x * u_xlat16_1.w;
    u_xlat0.xyz = u_xlat16_1.xyz * _Color.xyz;
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
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _PanningSpeed;
uniform 	mediump vec4 _DetailScale;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat4.xy = _Time.yy * _PanningSpeed.xy + u_xlat0.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    vs_TEXCOORD1.xy = u_xlat4.xy * _DetailScale.xy;
    vs_TEXCOORD2 = in_POSITION0;
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
uniform 	vec4 _Color;
uniform 	mediump float _Interval;
uniform 	mediump float _Rate;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _DetailTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
bool u_xlatb3;
void main()
{
    u_xlat0.x = floor(abs(vs_TEXCOORD1.x));
    u_xlat16_1.x = _Interval + 1.0;
    u_xlat0.x = u_xlat0.x / u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat0.x>=(-u_xlat0.x));
#else
    u_xlatb3 = u_xlat0.x>=(-u_xlat0.x);
#endif
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb3) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat16_1.x * u_xlat0.x;
    u_xlat16_1.x = (-_Rate) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * _Interval;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=u_xlat16_1.x);
#else
    u_xlatb0 = u_xlat0.x>=u_xlat16_1.x;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2 = texture(_DetailTex, vs_TEXCOORD1.xy);
    u_xlat16_1 = u_xlat16_1 * u_xlat16_2;
    u_xlat0.w = u_xlat0.x * u_xlat16_1.w;
    u_xlat0.xyz = u_xlat16_1.xyz * _Color.xyz;
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
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _PanningSpeed;
uniform 	mediump vec4 _DetailScale;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat4.xy = _Time.yy * _PanningSpeed.xy + u_xlat0.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    vs_TEXCOORD1.xy = u_xlat4.xy * _DetailScale.xy;
    vs_TEXCOORD2 = in_POSITION0;
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
uniform 	vec4 _Color;
uniform 	mediump float _Interval;
uniform 	mediump float _Rate;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _DetailTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
bool u_xlatb3;
void main()
{
    u_xlat0.x = floor(abs(vs_TEXCOORD1.x));
    u_xlat16_1.x = _Interval + 1.0;
    u_xlat0.x = u_xlat0.x / u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat0.x>=(-u_xlat0.x));
#else
    u_xlatb3 = u_xlat0.x>=(-u_xlat0.x);
#endif
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb3) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat16_1.x * u_xlat0.x;
    u_xlat16_1.x = (-_Rate) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * _Interval;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=u_xlat16_1.x);
#else
    u_xlatb0 = u_xlat0.x>=u_xlat16_1.x;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2 = texture(_DetailTex, vs_TEXCOORD1.xy);
    u_xlat16_1 = u_xlat16_1 * u_xlat16_2;
    u_xlat0.w = u_xlat0.x * u_xlat16_1.w;
    u_xlat0.xyz = u_xlat16_1.xyz * _Color.xyz;
    SV_Target0 = u_xlat0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Local Keywords { "UNITY_UI_ALPHACLIP" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _PanningSpeed;
uniform 	mediump vec4 _DetailScale;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat4.xy = _Time.yy * _PanningSpeed.xy + u_xlat0.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    vs_TEXCOORD1.xy = u_xlat4.xy * _DetailScale.xy;
    vs_TEXCOORD2 = in_POSITION0;
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
uniform 	vec4 _Color;
uniform 	mediump float _Interval;
uniform 	mediump float _Rate;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DetailTex;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
mediump float u_xlat16_3;
bool u_xlatb4;
void main()
{
    u_xlat0.x = floor(abs(vs_TEXCOORD1.x));
    u_xlat16_1.x = _Interval + 1.0;
    u_xlat0.x = u_xlat0.x / u_xlat16_1.x;
    u_xlatb4 = u_xlat0.x>=(-u_xlat0.x);
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat16_1.x * u_xlat0.x;
    u_xlat16_1.x = (-_Rate) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * _Interval;
    u_xlatb0 = u_xlat0.x>=u_xlat16_1.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_2 = texture2D(_DetailTex, vs_TEXCOORD1.xy);
    u_xlat16_1 = u_xlat10_1 * u_xlat10_2;
    u_xlat0.w = u_xlat0.x * u_xlat16_1.w;
    u_xlat0.xyz = u_xlat16_1.xyz * _Color.xyz;
    u_xlat16_1 = u_xlat0 * vs_COLOR0;
    u_xlat16_3 = u_xlat0.w * vs_COLOR0.w + -0.00100000005;
    u_xlatb0 = u_xlat16_3<0.0;
    if(u_xlatb0){discard;}
    SV_Target0 = u_xlat16_1;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Local Keywords { "UNITY_UI_ALPHACLIP" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _PanningSpeed;
uniform 	mediump vec4 _DetailScale;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat4.xy = _Time.yy * _PanningSpeed.xy + u_xlat0.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    vs_TEXCOORD1.xy = u_xlat4.xy * _DetailScale.xy;
    vs_TEXCOORD2 = in_POSITION0;
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
uniform 	vec4 _Color;
uniform 	mediump float _Interval;
uniform 	mediump float _Rate;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DetailTex;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
mediump float u_xlat16_3;
bool u_xlatb4;
void main()
{
    u_xlat0.x = floor(abs(vs_TEXCOORD1.x));
    u_xlat16_1.x = _Interval + 1.0;
    u_xlat0.x = u_xlat0.x / u_xlat16_1.x;
    u_xlatb4 = u_xlat0.x>=(-u_xlat0.x);
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat16_1.x * u_xlat0.x;
    u_xlat16_1.x = (-_Rate) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * _Interval;
    u_xlatb0 = u_xlat0.x>=u_xlat16_1.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_2 = texture2D(_DetailTex, vs_TEXCOORD1.xy);
    u_xlat16_1 = u_xlat10_1 * u_xlat10_2;
    u_xlat0.w = u_xlat0.x * u_xlat16_1.w;
    u_xlat0.xyz = u_xlat16_1.xyz * _Color.xyz;
    u_xlat16_1 = u_xlat0 * vs_COLOR0;
    u_xlat16_3 = u_xlat0.w * vs_COLOR0.w + -0.00100000005;
    u_xlatb0 = u_xlat16_3<0.0;
    if(u_xlatb0){discard;}
    SV_Target0 = u_xlat16_1;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Local Keywords { "UNITY_UI_ALPHACLIP" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _PanningSpeed;
uniform 	mediump vec4 _DetailScale;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat4.xy = _Time.yy * _PanningSpeed.xy + u_xlat0.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    vs_TEXCOORD1.xy = u_xlat4.xy * _DetailScale.xy;
    vs_TEXCOORD2 = in_POSITION0;
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
uniform 	vec4 _Color;
uniform 	mediump float _Interval;
uniform 	mediump float _Rate;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DetailTex;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
mediump float u_xlat16_3;
bool u_xlatb4;
void main()
{
    u_xlat0.x = floor(abs(vs_TEXCOORD1.x));
    u_xlat16_1.x = _Interval + 1.0;
    u_xlat0.x = u_xlat0.x / u_xlat16_1.x;
    u_xlatb4 = u_xlat0.x>=(-u_xlat0.x);
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat16_1.x * u_xlat0.x;
    u_xlat16_1.x = (-_Rate) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * _Interval;
    u_xlatb0 = u_xlat0.x>=u_xlat16_1.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_2 = texture2D(_DetailTex, vs_TEXCOORD1.xy);
    u_xlat16_1 = u_xlat10_1 * u_xlat10_2;
    u_xlat0.w = u_xlat0.x * u_xlat16_1.w;
    u_xlat0.xyz = u_xlat16_1.xyz * _Color.xyz;
    u_xlat16_1 = u_xlat0 * vs_COLOR0;
    u_xlat16_3 = u_xlat0.w * vs_COLOR0.w + -0.00100000005;
    u_xlatb0 = u_xlat16_3<0.0;
    if(u_xlatb0){discard;}
    SV_Target0 = u_xlat16_1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Local Keywords { "UNITY_UI_ALPHACLIP" }
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
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _PanningSpeed;
uniform 	mediump vec4 _DetailScale;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat4.xy = _Time.yy * _PanningSpeed.xy + u_xlat0.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    vs_TEXCOORD1.xy = u_xlat4.xy * _DetailScale.xy;
    vs_TEXCOORD2 = in_POSITION0;
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
uniform 	vec4 _Color;
uniform 	mediump float _Interval;
uniform 	mediump float _Rate;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _DetailTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
mediump float u_xlat16_3;
bool u_xlatb4;
void main()
{
    u_xlat0.x = floor(abs(vs_TEXCOORD1.x));
    u_xlat16_1.x = _Interval + 1.0;
    u_xlat0.x = u_xlat0.x / u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat0.x>=(-u_xlat0.x));
#else
    u_xlatb4 = u_xlat0.x>=(-u_xlat0.x);
#endif
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat16_1.x * u_xlat0.x;
    u_xlat16_1.x = (-_Rate) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * _Interval;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=u_xlat16_1.x);
#else
    u_xlatb0 = u_xlat0.x>=u_xlat16_1.x;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2 = texture(_DetailTex, vs_TEXCOORD1.xy);
    u_xlat16_1 = u_xlat16_1 * u_xlat16_2;
    u_xlat0.w = u_xlat0.x * u_xlat16_1.w;
    u_xlat0.xyz = u_xlat16_1.xyz * _Color.xyz;
    u_xlat16_1 = u_xlat0 * vs_COLOR0;
    u_xlat16_3 = u_xlat0.w * vs_COLOR0.w + -0.00100000005;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_3<0.0);
#else
    u_xlatb0 = u_xlat16_3<0.0;
#endif
    if(u_xlatb0){discard;}
    SV_Target0 = u_xlat16_1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Local Keywords { "UNITY_UI_ALPHACLIP" }
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
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _PanningSpeed;
uniform 	mediump vec4 _DetailScale;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat4.xy = _Time.yy * _PanningSpeed.xy + u_xlat0.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    vs_TEXCOORD1.xy = u_xlat4.xy * _DetailScale.xy;
    vs_TEXCOORD2 = in_POSITION0;
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
uniform 	vec4 _Color;
uniform 	mediump float _Interval;
uniform 	mediump float _Rate;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _DetailTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
mediump float u_xlat16_3;
bool u_xlatb4;
void main()
{
    u_xlat0.x = floor(abs(vs_TEXCOORD1.x));
    u_xlat16_1.x = _Interval + 1.0;
    u_xlat0.x = u_xlat0.x / u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat0.x>=(-u_xlat0.x));
#else
    u_xlatb4 = u_xlat0.x>=(-u_xlat0.x);
#endif
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat16_1.x * u_xlat0.x;
    u_xlat16_1.x = (-_Rate) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * _Interval;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=u_xlat16_1.x);
#else
    u_xlatb0 = u_xlat0.x>=u_xlat16_1.x;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2 = texture(_DetailTex, vs_TEXCOORD1.xy);
    u_xlat16_1 = u_xlat16_1 * u_xlat16_2;
    u_xlat0.w = u_xlat0.x * u_xlat16_1.w;
    u_xlat0.xyz = u_xlat16_1.xyz * _Color.xyz;
    u_xlat16_1 = u_xlat0 * vs_COLOR0;
    u_xlat16_3 = u_xlat0.w * vs_COLOR0.w + -0.00100000005;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_3<0.0);
#else
    u_xlatb0 = u_xlat16_3<0.0;
#endif
    if(u_xlatb0){discard;}
    SV_Target0 = u_xlat16_1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Local Keywords { "UNITY_UI_ALPHACLIP" }
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
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _PanningSpeed;
uniform 	mediump vec4 _DetailScale;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat4.xy = _Time.yy * _PanningSpeed.xy + u_xlat0.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    vs_TEXCOORD1.xy = u_xlat4.xy * _DetailScale.xy;
    vs_TEXCOORD2 = in_POSITION0;
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
uniform 	vec4 _Color;
uniform 	mediump float _Interval;
uniform 	mediump float _Rate;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _DetailTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
mediump float u_xlat16_3;
bool u_xlatb4;
void main()
{
    u_xlat0.x = floor(abs(vs_TEXCOORD1.x));
    u_xlat16_1.x = _Interval + 1.0;
    u_xlat0.x = u_xlat0.x / u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat0.x>=(-u_xlat0.x));
#else
    u_xlatb4 = u_xlat0.x>=(-u_xlat0.x);
#endif
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat16_1.x * u_xlat0.x;
    u_xlat16_1.x = (-_Rate) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * _Interval;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=u_xlat16_1.x);
#else
    u_xlatb0 = u_xlat0.x>=u_xlat16_1.x;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2 = texture(_DetailTex, vs_TEXCOORD1.xy);
    u_xlat16_1 = u_xlat16_1 * u_xlat16_2;
    u_xlat0.w = u_xlat0.x * u_xlat16_1.w;
    u_xlat0.xyz = u_xlat16_1.xyz * _Color.xyz;
    u_xlat16_1 = u_xlat0 * vs_COLOR0;
    u_xlat16_3 = u_xlat0.w * vs_COLOR0.w + -0.00100000005;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_3<0.0);
#else
    u_xlatb0 = u_xlat16_3<0.0;
#endif
    if(u_xlatb0){discard;}
    SV_Target0 = u_xlat16_1;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Local Keywords { "UNITY_UI_CLIP_RECT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _PanningSpeed;
uniform 	mediump vec4 _DetailScale;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat4.xy = _Time.yy * _PanningSpeed.xy + u_xlat0.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    vs_TEXCOORD1.xy = u_xlat4.xy * _DetailScale.xy;
    vs_TEXCOORD2 = in_POSITION0;
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
uniform 	vec4 _Color;
uniform 	mediump float _Interval;
uniform 	mediump float _Rate;
uniform 	vec4 _ClipRect;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DetailTex;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
bvec4 u_xlatb2;
bool u_xlatb3;
void main()
{
    u_xlat0.x = floor(abs(vs_TEXCOORD1.x));
    u_xlat16_1.x = _Interval + 1.0;
    u_xlat0.x = u_xlat0.x / u_xlat16_1.x;
    u_xlatb3 = u_xlat0.x>=(-u_xlat0.x);
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb3) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat16_1.x * u_xlat0.x;
    u_xlat16_1.x = (-_Rate) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * _Interval;
    u_xlatb0 = u_xlat0.x>=u_xlat16_1.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_2 = texture2D(_DetailTex, vs_TEXCOORD1.xy);
    u_xlat16_1 = u_xlat10_1 * u_xlat10_2;
    u_xlat0.w = u_xlat0.x * u_xlat16_1.w;
    u_xlat0.xyz = u_xlat16_1.xyz * _Color.xyz;
    u_xlat16_0 = u_xlat0 * vs_COLOR0;
    u_xlatb2.xy = greaterThanEqual(vs_TEXCOORD2.xyxx, _ClipRect.xyxx).xy;
    u_xlatb2.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD2.xxxy).zw;
    u_xlat2.x = u_xlatb2.x ? float(1.0) : 0.0;
    u_xlat2.y = u_xlatb2.y ? float(1.0) : 0.0;
    u_xlat2.z = u_xlatb2.z ? float(1.0) : 0.0;
    u_xlat2.w = u_xlatb2.w ? float(1.0) : 0.0;
;
    u_xlat2.xy = u_xlat2.zw * u_xlat2.xy;
    u_xlat2.x = u_xlat2.y * u_xlat2.x;
    u_xlat2.x = u_xlat16_0.w * u_xlat2.x;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = u_xlat2.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Local Keywords { "UNITY_UI_CLIP_RECT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _PanningSpeed;
uniform 	mediump vec4 _DetailScale;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat4.xy = _Time.yy * _PanningSpeed.xy + u_xlat0.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    vs_TEXCOORD1.xy = u_xlat4.xy * _DetailScale.xy;
    vs_TEXCOORD2 = in_POSITION0;
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
uniform 	vec4 _Color;
uniform 	mediump float _Interval;
uniform 	mediump float _Rate;
uniform 	vec4 _ClipRect;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DetailTex;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
bvec4 u_xlatb2;
bool u_xlatb3;
void main()
{
    u_xlat0.x = floor(abs(vs_TEXCOORD1.x));
    u_xlat16_1.x = _Interval + 1.0;
    u_xlat0.x = u_xlat0.x / u_xlat16_1.x;
    u_xlatb3 = u_xlat0.x>=(-u_xlat0.x);
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb3) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat16_1.x * u_xlat0.x;
    u_xlat16_1.x = (-_Rate) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * _Interval;
    u_xlatb0 = u_xlat0.x>=u_xlat16_1.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_2 = texture2D(_DetailTex, vs_TEXCOORD1.xy);
    u_xlat16_1 = u_xlat10_1 * u_xlat10_2;
    u_xlat0.w = u_xlat0.x * u_xlat16_1.w;
    u_xlat0.xyz = u_xlat16_1.xyz * _Color.xyz;
    u_xlat16_0 = u_xlat0 * vs_COLOR0;
    u_xlatb2.xy = greaterThanEqual(vs_TEXCOORD2.xyxx, _ClipRect.xyxx).xy;
    u_xlatb2.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD2.xxxy).zw;
    u_xlat2.x = u_xlatb2.x ? float(1.0) : 0.0;
    u_xlat2.y = u_xlatb2.y ? float(1.0) : 0.0;
    u_xlat2.z = u_xlatb2.z ? float(1.0) : 0.0;
    u_xlat2.w = u_xlatb2.w ? float(1.0) : 0.0;
;
    u_xlat2.xy = u_xlat2.zw * u_xlat2.xy;
    u_xlat2.x = u_xlat2.y * u_xlat2.x;
    u_xlat2.x = u_xlat16_0.w * u_xlat2.x;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = u_xlat2.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Local Keywords { "UNITY_UI_CLIP_RECT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _PanningSpeed;
uniform 	mediump vec4 _DetailScale;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat4.xy = _Time.yy * _PanningSpeed.xy + u_xlat0.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    vs_TEXCOORD1.xy = u_xlat4.xy * _DetailScale.xy;
    vs_TEXCOORD2 = in_POSITION0;
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
uniform 	vec4 _Color;
uniform 	mediump float _Interval;
uniform 	mediump float _Rate;
uniform 	vec4 _ClipRect;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DetailTex;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
bvec4 u_xlatb2;
bool u_xlatb3;
void main()
{
    u_xlat0.x = floor(abs(vs_TEXCOORD1.x));
    u_xlat16_1.x = _Interval + 1.0;
    u_xlat0.x = u_xlat0.x / u_xlat16_1.x;
    u_xlatb3 = u_xlat0.x>=(-u_xlat0.x);
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb3) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat16_1.x * u_xlat0.x;
    u_xlat16_1.x = (-_Rate) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * _Interval;
    u_xlatb0 = u_xlat0.x>=u_xlat16_1.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_2 = texture2D(_DetailTex, vs_TEXCOORD1.xy);
    u_xlat16_1 = u_xlat10_1 * u_xlat10_2;
    u_xlat0.w = u_xlat0.x * u_xlat16_1.w;
    u_xlat0.xyz = u_xlat16_1.xyz * _Color.xyz;
    u_xlat16_0 = u_xlat0 * vs_COLOR0;
    u_xlatb2.xy = greaterThanEqual(vs_TEXCOORD2.xyxx, _ClipRect.xyxx).xy;
    u_xlatb2.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD2.xxxy).zw;
    u_xlat2.x = u_xlatb2.x ? float(1.0) : 0.0;
    u_xlat2.y = u_xlatb2.y ? float(1.0) : 0.0;
    u_xlat2.z = u_xlatb2.z ? float(1.0) : 0.0;
    u_xlat2.w = u_xlatb2.w ? float(1.0) : 0.0;
;
    u_xlat2.xy = u_xlat2.zw * u_xlat2.xy;
    u_xlat2.x = u_xlat2.y * u_xlat2.x;
    u_xlat2.x = u_xlat16_0.w * u_xlat2.x;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = u_xlat2.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Local Keywords { "UNITY_UI_CLIP_RECT" }
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
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _PanningSpeed;
uniform 	mediump vec4 _DetailScale;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat4.xy = _Time.yy * _PanningSpeed.xy + u_xlat0.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    vs_TEXCOORD1.xy = u_xlat4.xy * _DetailScale.xy;
    vs_TEXCOORD2 = in_POSITION0;
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
uniform 	vec4 _Color;
uniform 	mediump float _Interval;
uniform 	mediump float _Rate;
uniform 	vec4 _ClipRect;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _DetailTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
bvec4 u_xlatb2;
bool u_xlatb3;
void main()
{
    u_xlat0.x = floor(abs(vs_TEXCOORD1.x));
    u_xlat16_1.x = _Interval + 1.0;
    u_xlat0.x = u_xlat0.x / u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat0.x>=(-u_xlat0.x));
#else
    u_xlatb3 = u_xlat0.x>=(-u_xlat0.x);
#endif
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb3) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat16_1.x * u_xlat0.x;
    u_xlat16_1.x = (-_Rate) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * _Interval;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=u_xlat16_1.x);
#else
    u_xlatb0 = u_xlat0.x>=u_xlat16_1.x;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2 = texture(_DetailTex, vs_TEXCOORD1.xy);
    u_xlat16_1 = u_xlat16_1 * u_xlat16_2;
    u_xlat0.w = u_xlat0.x * u_xlat16_1.w;
    u_xlat0.xyz = u_xlat16_1.xyz * _Color.xyz;
    u_xlat16_0 = u_xlat0 * vs_COLOR0;
    u_xlatb2.xy = greaterThanEqual(vs_TEXCOORD2.xyxx, _ClipRect.xyxx).xy;
    u_xlatb2.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD2.xxxy).zw;
    u_xlat2.x = u_xlatb2.x ? float(1.0) : 0.0;
    u_xlat2.y = u_xlatb2.y ? float(1.0) : 0.0;
    u_xlat2.z = u_xlatb2.z ? float(1.0) : 0.0;
    u_xlat2.w = u_xlatb2.w ? float(1.0) : 0.0;
;
    u_xlat2.xy = u_xlat2.zw * u_xlat2.xy;
    u_xlat2.x = u_xlat2.y * u_xlat2.x;
    u_xlat2.x = u_xlat16_0.w * u_xlat2.x;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = u_xlat2.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Local Keywords { "UNITY_UI_CLIP_RECT" }
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
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _PanningSpeed;
uniform 	mediump vec4 _DetailScale;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat4.xy = _Time.yy * _PanningSpeed.xy + u_xlat0.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    vs_TEXCOORD1.xy = u_xlat4.xy * _DetailScale.xy;
    vs_TEXCOORD2 = in_POSITION0;
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
uniform 	vec4 _Color;
uniform 	mediump float _Interval;
uniform 	mediump float _Rate;
uniform 	vec4 _ClipRect;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _DetailTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
bvec4 u_xlatb2;
bool u_xlatb3;
void main()
{
    u_xlat0.x = floor(abs(vs_TEXCOORD1.x));
    u_xlat16_1.x = _Interval + 1.0;
    u_xlat0.x = u_xlat0.x / u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat0.x>=(-u_xlat0.x));
#else
    u_xlatb3 = u_xlat0.x>=(-u_xlat0.x);
#endif
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb3) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat16_1.x * u_xlat0.x;
    u_xlat16_1.x = (-_Rate) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * _Interval;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=u_xlat16_1.x);
#else
    u_xlatb0 = u_xlat0.x>=u_xlat16_1.x;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2 = texture(_DetailTex, vs_TEXCOORD1.xy);
    u_xlat16_1 = u_xlat16_1 * u_xlat16_2;
    u_xlat0.w = u_xlat0.x * u_xlat16_1.w;
    u_xlat0.xyz = u_xlat16_1.xyz * _Color.xyz;
    u_xlat16_0 = u_xlat0 * vs_COLOR0;
    u_xlatb2.xy = greaterThanEqual(vs_TEXCOORD2.xyxx, _ClipRect.xyxx).xy;
    u_xlatb2.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD2.xxxy).zw;
    u_xlat2.x = u_xlatb2.x ? float(1.0) : 0.0;
    u_xlat2.y = u_xlatb2.y ? float(1.0) : 0.0;
    u_xlat2.z = u_xlatb2.z ? float(1.0) : 0.0;
    u_xlat2.w = u_xlatb2.w ? float(1.0) : 0.0;
;
    u_xlat2.xy = u_xlat2.zw * u_xlat2.xy;
    u_xlat2.x = u_xlat2.y * u_xlat2.x;
    u_xlat2.x = u_xlat16_0.w * u_xlat2.x;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = u_xlat2.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Local Keywords { "UNITY_UI_CLIP_RECT" }
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
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _PanningSpeed;
uniform 	mediump vec4 _DetailScale;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat4.xy = _Time.yy * _PanningSpeed.xy + u_xlat0.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    vs_TEXCOORD1.xy = u_xlat4.xy * _DetailScale.xy;
    vs_TEXCOORD2 = in_POSITION0;
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
uniform 	vec4 _Color;
uniform 	mediump float _Interval;
uniform 	mediump float _Rate;
uniform 	vec4 _ClipRect;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _DetailTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
bvec4 u_xlatb2;
bool u_xlatb3;
void main()
{
    u_xlat0.x = floor(abs(vs_TEXCOORD1.x));
    u_xlat16_1.x = _Interval + 1.0;
    u_xlat0.x = u_xlat0.x / u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat0.x>=(-u_xlat0.x));
#else
    u_xlatb3 = u_xlat0.x>=(-u_xlat0.x);
#endif
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb3) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat16_1.x * u_xlat0.x;
    u_xlat16_1.x = (-_Rate) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * _Interval;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=u_xlat16_1.x);
#else
    u_xlatb0 = u_xlat0.x>=u_xlat16_1.x;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2 = texture(_DetailTex, vs_TEXCOORD1.xy);
    u_xlat16_1 = u_xlat16_1 * u_xlat16_2;
    u_xlat0.w = u_xlat0.x * u_xlat16_1.w;
    u_xlat0.xyz = u_xlat16_1.xyz * _Color.xyz;
    u_xlat16_0 = u_xlat0 * vs_COLOR0;
    u_xlatb2.xy = greaterThanEqual(vs_TEXCOORD2.xyxx, _ClipRect.xyxx).xy;
    u_xlatb2.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD2.xxxy).zw;
    u_xlat2.x = u_xlatb2.x ? float(1.0) : 0.0;
    u_xlat2.y = u_xlatb2.y ? float(1.0) : 0.0;
    u_xlat2.z = u_xlatb2.z ? float(1.0) : 0.0;
    u_xlat2.w = u_xlatb2.w ? float(1.0) : 0.0;
;
    u_xlat2.xy = u_xlat2.zw * u_xlat2.xy;
    u_xlat2.x = u_xlat2.y * u_xlat2.x;
    u_xlat2.x = u_xlat16_0.w * u_xlat2.x;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = u_xlat2.x;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Local Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _PanningSpeed;
uniform 	mediump vec4 _DetailScale;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat4.xy = _Time.yy * _PanningSpeed.xy + u_xlat0.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    vs_TEXCOORD1.xy = u_xlat4.xy * _DetailScale.xy;
    vs_TEXCOORD2 = in_POSITION0;
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
uniform 	vec4 _Color;
uniform 	mediump float _Interval;
uniform 	mediump float _Rate;
uniform 	vec4 _ClipRect;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DetailTex;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
bool u_xlatb4;
void main()
{
    u_xlat0.x = floor(abs(vs_TEXCOORD1.x));
    u_xlat16_1.x = _Interval + 1.0;
    u_xlat0.x = u_xlat0.x / u_xlat16_1.x;
    u_xlatb4 = u_xlat0.x>=(-u_xlat0.x);
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat16_1.x * u_xlat0.x;
    u_xlat16_1.x = (-_Rate) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * _Interval;
    u_xlatb0 = u_xlat0.x>=u_xlat16_1.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_2 = texture2D(_DetailTex, vs_TEXCOORD1.xy);
    u_xlat16_1 = u_xlat10_1 * u_xlat10_2;
    u_xlat0.w = u_xlat0.x * u_xlat16_1.w;
    u_xlat0.xyz = u_xlat16_1.xyz * _Color.xyz;
    u_xlat16_0 = u_xlat0 * vs_COLOR0;
    u_xlatb2.xy = greaterThanEqual(vs_TEXCOORD2.xyxx, _ClipRect.xyxx).xy;
    u_xlatb2.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD2.xxxy).zw;
    u_xlat2.x = u_xlatb2.x ? float(1.0) : 0.0;
    u_xlat2.y = u_xlatb2.y ? float(1.0) : 0.0;
    u_xlat2.z = u_xlatb2.z ? float(1.0) : 0.0;
    u_xlat2.w = u_xlatb2.w ? float(1.0) : 0.0;
;
    u_xlat2.xy = u_xlat2.zw * u_xlat2.xy;
    u_xlat2.x = u_xlat2.y * u_xlat2.x;
    u_xlat16_3 = u_xlat16_0.w * u_xlat2.x + -0.00100000005;
    u_xlat2.x = u_xlat16_0.w * u_xlat2.x;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = u_xlat2.x;
    u_xlatb2.x = u_xlat16_3<0.0;
    if(u_xlatb2.x){discard;}
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Local Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _PanningSpeed;
uniform 	mediump vec4 _DetailScale;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat4.xy = _Time.yy * _PanningSpeed.xy + u_xlat0.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    vs_TEXCOORD1.xy = u_xlat4.xy * _DetailScale.xy;
    vs_TEXCOORD2 = in_POSITION0;
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
uniform 	vec4 _Color;
uniform 	mediump float _Interval;
uniform 	mediump float _Rate;
uniform 	vec4 _ClipRect;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DetailTex;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
bool u_xlatb4;
void main()
{
    u_xlat0.x = floor(abs(vs_TEXCOORD1.x));
    u_xlat16_1.x = _Interval + 1.0;
    u_xlat0.x = u_xlat0.x / u_xlat16_1.x;
    u_xlatb4 = u_xlat0.x>=(-u_xlat0.x);
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat16_1.x * u_xlat0.x;
    u_xlat16_1.x = (-_Rate) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * _Interval;
    u_xlatb0 = u_xlat0.x>=u_xlat16_1.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_2 = texture2D(_DetailTex, vs_TEXCOORD1.xy);
    u_xlat16_1 = u_xlat10_1 * u_xlat10_2;
    u_xlat0.w = u_xlat0.x * u_xlat16_1.w;
    u_xlat0.xyz = u_xlat16_1.xyz * _Color.xyz;
    u_xlat16_0 = u_xlat0 * vs_COLOR0;
    u_xlatb2.xy = greaterThanEqual(vs_TEXCOORD2.xyxx, _ClipRect.xyxx).xy;
    u_xlatb2.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD2.xxxy).zw;
    u_xlat2.x = u_xlatb2.x ? float(1.0) : 0.0;
    u_xlat2.y = u_xlatb2.y ? float(1.0) : 0.0;
    u_xlat2.z = u_xlatb2.z ? float(1.0) : 0.0;
    u_xlat2.w = u_xlatb2.w ? float(1.0) : 0.0;
;
    u_xlat2.xy = u_xlat2.zw * u_xlat2.xy;
    u_xlat2.x = u_xlat2.y * u_xlat2.x;
    u_xlat16_3 = u_xlat16_0.w * u_xlat2.x + -0.00100000005;
    u_xlat2.x = u_xlat16_0.w * u_xlat2.x;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = u_xlat2.x;
    u_xlatb2.x = u_xlat16_3<0.0;
    if(u_xlatb2.x){discard;}
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Local Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _PanningSpeed;
uniform 	mediump vec4 _DetailScale;
attribute highp vec4 in_POSITION0;
attribute mediump vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat4.xy = _Time.yy * _PanningSpeed.xy + u_xlat0.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    vs_TEXCOORD1.xy = u_xlat4.xy * _DetailScale.xy;
    vs_TEXCOORD2 = in_POSITION0;
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
uniform 	vec4 _Color;
uniform 	mediump float _Interval;
uniform 	mediump float _Rate;
uniform 	vec4 _ClipRect;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DetailTex;
varying mediump vec2 vs_TEXCOORD0;
varying mediump vec2 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
bool u_xlatb4;
void main()
{
    u_xlat0.x = floor(abs(vs_TEXCOORD1.x));
    u_xlat16_1.x = _Interval + 1.0;
    u_xlat0.x = u_xlat0.x / u_xlat16_1.x;
    u_xlatb4 = u_xlat0.x>=(-u_xlat0.x);
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat16_1.x * u_xlat0.x;
    u_xlat16_1.x = (-_Rate) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * _Interval;
    u_xlatb0 = u_xlat0.x>=u_xlat16_1.x;
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_2 = texture2D(_DetailTex, vs_TEXCOORD1.xy);
    u_xlat16_1 = u_xlat10_1 * u_xlat10_2;
    u_xlat0.w = u_xlat0.x * u_xlat16_1.w;
    u_xlat0.xyz = u_xlat16_1.xyz * _Color.xyz;
    u_xlat16_0 = u_xlat0 * vs_COLOR0;
    u_xlatb2.xy = greaterThanEqual(vs_TEXCOORD2.xyxx, _ClipRect.xyxx).xy;
    u_xlatb2.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD2.xxxy).zw;
    u_xlat2.x = u_xlatb2.x ? float(1.0) : 0.0;
    u_xlat2.y = u_xlatb2.y ? float(1.0) : 0.0;
    u_xlat2.z = u_xlatb2.z ? float(1.0) : 0.0;
    u_xlat2.w = u_xlatb2.w ? float(1.0) : 0.0;
;
    u_xlat2.xy = u_xlat2.zw * u_xlat2.xy;
    u_xlat2.x = u_xlat2.y * u_xlat2.x;
    u_xlat16_3 = u_xlat16_0.w * u_xlat2.x + -0.00100000005;
    u_xlat2.x = u_xlat16_0.w * u_xlat2.x;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = u_xlat2.x;
    u_xlatb2.x = u_xlat16_3<0.0;
    if(u_xlatb2.x){discard;}
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Local Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" }
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
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _PanningSpeed;
uniform 	mediump vec4 _DetailScale;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat4.xy = _Time.yy * _PanningSpeed.xy + u_xlat0.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    vs_TEXCOORD1.xy = u_xlat4.xy * _DetailScale.xy;
    vs_TEXCOORD2 = in_POSITION0;
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
uniform 	vec4 _Color;
uniform 	mediump float _Interval;
uniform 	mediump float _Rate;
uniform 	vec4 _ClipRect;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _DetailTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
bool u_xlatb4;
void main()
{
    u_xlat0.x = floor(abs(vs_TEXCOORD1.x));
    u_xlat16_1.x = _Interval + 1.0;
    u_xlat0.x = u_xlat0.x / u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat0.x>=(-u_xlat0.x));
#else
    u_xlatb4 = u_xlat0.x>=(-u_xlat0.x);
#endif
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat16_1.x * u_xlat0.x;
    u_xlat16_1.x = (-_Rate) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * _Interval;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=u_xlat16_1.x);
#else
    u_xlatb0 = u_xlat0.x>=u_xlat16_1.x;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2 = texture(_DetailTex, vs_TEXCOORD1.xy);
    u_xlat16_1 = u_xlat16_1 * u_xlat16_2;
    u_xlat0.w = u_xlat0.x * u_xlat16_1.w;
    u_xlat0.xyz = u_xlat16_1.xyz * _Color.xyz;
    u_xlat16_0 = u_xlat0 * vs_COLOR0;
    u_xlatb2.xy = greaterThanEqual(vs_TEXCOORD2.xyxx, _ClipRect.xyxx).xy;
    u_xlatb2.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD2.xxxy).zw;
    u_xlat2.x = u_xlatb2.x ? float(1.0) : 0.0;
    u_xlat2.y = u_xlatb2.y ? float(1.0) : 0.0;
    u_xlat2.z = u_xlatb2.z ? float(1.0) : 0.0;
    u_xlat2.w = u_xlatb2.w ? float(1.0) : 0.0;
;
    u_xlat2.xy = u_xlat2.zw * u_xlat2.xy;
    u_xlat2.x = u_xlat2.y * u_xlat2.x;
    u_xlat16_3 = u_xlat16_0.w * u_xlat2.x + -0.00100000005;
    u_xlat2.x = u_xlat16_0.w * u_xlat2.x;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2.x = !!(u_xlat16_3<0.0);
#else
    u_xlatb2.x = u_xlat16_3<0.0;
#endif
    if(u_xlatb2.x){discard;}
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Local Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" }
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
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _PanningSpeed;
uniform 	mediump vec4 _DetailScale;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat4.xy = _Time.yy * _PanningSpeed.xy + u_xlat0.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    vs_TEXCOORD1.xy = u_xlat4.xy * _DetailScale.xy;
    vs_TEXCOORD2 = in_POSITION0;
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
uniform 	vec4 _Color;
uniform 	mediump float _Interval;
uniform 	mediump float _Rate;
uniform 	vec4 _ClipRect;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _DetailTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
bool u_xlatb4;
void main()
{
    u_xlat0.x = floor(abs(vs_TEXCOORD1.x));
    u_xlat16_1.x = _Interval + 1.0;
    u_xlat0.x = u_xlat0.x / u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat0.x>=(-u_xlat0.x));
#else
    u_xlatb4 = u_xlat0.x>=(-u_xlat0.x);
#endif
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat16_1.x * u_xlat0.x;
    u_xlat16_1.x = (-_Rate) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * _Interval;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=u_xlat16_1.x);
#else
    u_xlatb0 = u_xlat0.x>=u_xlat16_1.x;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2 = texture(_DetailTex, vs_TEXCOORD1.xy);
    u_xlat16_1 = u_xlat16_1 * u_xlat16_2;
    u_xlat0.w = u_xlat0.x * u_xlat16_1.w;
    u_xlat0.xyz = u_xlat16_1.xyz * _Color.xyz;
    u_xlat16_0 = u_xlat0 * vs_COLOR0;
    u_xlatb2.xy = greaterThanEqual(vs_TEXCOORD2.xyxx, _ClipRect.xyxx).xy;
    u_xlatb2.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD2.xxxy).zw;
    u_xlat2.x = u_xlatb2.x ? float(1.0) : 0.0;
    u_xlat2.y = u_xlatb2.y ? float(1.0) : 0.0;
    u_xlat2.z = u_xlatb2.z ? float(1.0) : 0.0;
    u_xlat2.w = u_xlatb2.w ? float(1.0) : 0.0;
;
    u_xlat2.xy = u_xlat2.zw * u_xlat2.xy;
    u_xlat2.x = u_xlat2.y * u_xlat2.x;
    u_xlat16_3 = u_xlat16_0.w * u_xlat2.x + -0.00100000005;
    u_xlat2.x = u_xlat16_0.w * u_xlat2.x;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2.x = !!(u_xlat16_3<0.0);
#else
    u_xlatb2.x = u_xlat16_3<0.0;
#endif
    if(u_xlatb2.x){discard;}
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Local Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" }
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
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _PanningSpeed;
uniform 	mediump vec4 _DetailScale;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat4.xy = _Time.yy * _PanningSpeed.xy + u_xlat0.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    vs_TEXCOORD1.xy = u_xlat4.xy * _DetailScale.xy;
    vs_TEXCOORD2 = in_POSITION0;
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
uniform 	vec4 _Color;
uniform 	mediump float _Interval;
uniform 	mediump float _Rate;
uniform 	vec4 _ClipRect;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _DetailTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
bvec4 u_xlatb2;
mediump float u_xlat16_3;
bool u_xlatb4;
void main()
{
    u_xlat0.x = floor(abs(vs_TEXCOORD1.x));
    u_xlat16_1.x = _Interval + 1.0;
    u_xlat0.x = u_xlat0.x / u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat0.x>=(-u_xlat0.x));
#else
    u_xlatb4 = u_xlat0.x>=(-u_xlat0.x);
#endif
    u_xlat0.x = fract(abs(u_xlat0.x));
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat0.x = u_xlat16_1.x * u_xlat0.x;
    u_xlat16_1.x = (-_Rate) + 1.0;
    u_xlat16_1.x = u_xlat16_1.x * _Interval;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x>=u_xlat16_1.x);
#else
    u_xlatb0 = u_xlat0.x>=u_xlat16_1.x;
#endif
    u_xlat0.x = u_xlatb0 ? 1.0 : float(0.0);
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_2 = texture(_DetailTex, vs_TEXCOORD1.xy);
    u_xlat16_1 = u_xlat16_1 * u_xlat16_2;
    u_xlat0.w = u_xlat0.x * u_xlat16_1.w;
    u_xlat0.xyz = u_xlat16_1.xyz * _Color.xyz;
    u_xlat16_0 = u_xlat0 * vs_COLOR0;
    u_xlatb2.xy = greaterThanEqual(vs_TEXCOORD2.xyxx, _ClipRect.xyxx).xy;
    u_xlatb2.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD2.xxxy).zw;
    u_xlat2.x = u_xlatb2.x ? float(1.0) : 0.0;
    u_xlat2.y = u_xlatb2.y ? float(1.0) : 0.0;
    u_xlat2.z = u_xlatb2.z ? float(1.0) : 0.0;
    u_xlat2.w = u_xlatb2.w ? float(1.0) : 0.0;
;
    u_xlat2.xy = u_xlat2.zw * u_xlat2.xy;
    u_xlat2.x = u_xlat2.y * u_xlat2.x;
    u_xlat16_3 = u_xlat16_0.w * u_xlat2.x + -0.00100000005;
    u_xlat2.x = u_xlat16_0.w * u_xlat2.x;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2.x = !!(u_xlat16_3<0.0);
#else
    u_xlatb2.x = u_xlat16_3<0.0;
#endif
    if(u_xlatb2.x){discard;}
    return;
}

#endif
"
}
}
}
}
}