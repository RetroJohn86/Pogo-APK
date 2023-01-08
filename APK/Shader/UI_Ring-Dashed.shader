//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "UI/Ring-Dashed" {
Properties {
_Color ("Tint", Color) = (1,1,1,1)
_Radius ("Outer Radius", Float) = 1
_Thickness ("Thickneses", Float) = 0.1
_DashFrequency ("Dash Frequency", Float) = 0.06
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
  GpuProgramID 51620
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    vs_TEXCOORD1 = in_POSITION0;
    return;
}

#endif
#ifdef FRAGMENT
#version 100
#ifdef GL_OES_standard_derivatives
#extension GL_OES_standard_derivatives : enable
#endif

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	float _Radius;
uniform 	float _Thickness;
uniform 	float _DashFrequency;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump float u_xlat16_1;
float u_xlat2;
bool u_xlatb2;
mediump float u_xlat16_3;
float u_xlat4;
bool u_xlatb4;
float u_xlat6;
bool u_xlatb6;
void main()
{
    u_xlat0.x = max(abs(vs_TEXCOORD0.x), abs(vs_TEXCOORD0.y));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat2 = min(abs(vs_TEXCOORD0.x), abs(vs_TEXCOORD0.y));
    u_xlat0.x = u_xlat0.x * u_xlat2;
    u_xlat2 = u_xlat0.x * u_xlat0.x;
    u_xlat4 = u_xlat2 * 0.0208350997 + -0.0851330012;
    u_xlat4 = u_xlat2 * u_xlat4 + 0.180141002;
    u_xlat4 = u_xlat2 * u_xlat4 + -0.330299497;
    u_xlat2 = u_xlat2 * u_xlat4 + 0.999866009;
    u_xlat4 = u_xlat2 * u_xlat0.x;
    u_xlat4 = u_xlat4 * -2.0 + 1.57079637;
    u_xlatb6 = abs(vs_TEXCOORD0.x)<abs(vs_TEXCOORD0.y);
    u_xlat4 = u_xlatb6 ? u_xlat4 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat2 + u_xlat4;
    u_xlatb2 = vs_TEXCOORD0.x<(-vs_TEXCOORD0.x);
    u_xlat2 = u_xlatb2 ? -3.14159274 : float(0.0);
    u_xlat0.x = u_xlat2 + u_xlat0.x;
    u_xlat2 = min(vs_TEXCOORD0.x, vs_TEXCOORD0.y);
    u_xlatb2 = u_xlat2<(-u_xlat2);
    u_xlat4 = max(vs_TEXCOORD0.x, vs_TEXCOORD0.y);
    u_xlatb4 = u_xlat4>=(-u_xlat4);
    u_xlatb2 = u_xlatb4 && u_xlatb2;
    u_xlat0.x = (u_xlatb2) ? (-u_xlat0.x) : u_xlat0.x;
    u_xlat0.x = u_xlat0.x + 3.1415925;
    u_xlat2 = u_xlat0.x * _DashFrequency;
    u_xlatb2 = u_xlat2>=(-u_xlat2);
    u_xlat2 = (u_xlatb2) ? _DashFrequency : (-_DashFrequency);
    u_xlat4 = float(1.0) / u_xlat2;
    u_xlat0.x = u_xlat4 * u_xlat0.x;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat4 = _DashFrequency * 0.5;
    u_xlat0.x = u_xlat2 * u_xlat0.x + (-u_xlat4);
    u_xlat2 = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
    u_xlat2 = sqrt(u_xlat2);
    u_xlat16_1 = dFdx(u_xlat2);
    u_xlat16_3 = dFdy(u_xlat2);
    u_xlat16_1 = abs(u_xlat16_3) + abs(u_xlat16_1);
    u_xlat0.z = u_xlat2 + (-_Radius);
    u_xlat0.xz = u_xlat0.xz / vec2(u_xlat16_1);
    u_xlat0.xz = clamp(u_xlat0.xz, 0.0, 1.0);
    u_xlat4 = (-u_xlat0.z) + 1.0;
    u_xlat6 = (-_Thickness) + _Radius;
    u_xlat2 = (-u_xlat6) + u_xlat2;
    u_xlat2 = u_xlat2 / u_xlat16_1;
    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
    u_xlat16_1 = u_xlat2 * u_xlat4;
    u_xlat16_1 = u_xlat16_1 * vs_COLOR0.w;
    u_xlat0.x = u_xlat0.x * u_xlat16_1;
    SV_Target0.w = u_xlat0.x;
    SV_Target0.xyz = vs_COLOR0.xyz;
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
uniform 	mediump vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    vs_TEXCOORD1 = in_POSITION0;
    return;
}

#endif
#ifdef FRAGMENT
#version 100
#ifdef GL_OES_standard_derivatives
#extension GL_OES_standard_derivatives : enable
#endif

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	float _Radius;
uniform 	float _Thickness;
uniform 	float _DashFrequency;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump float u_xlat16_1;
float u_xlat2;
bool u_xlatb2;
mediump float u_xlat16_3;
float u_xlat4;
bool u_xlatb4;
float u_xlat6;
bool u_xlatb6;
void main()
{
    u_xlat0.x = max(abs(vs_TEXCOORD0.x), abs(vs_TEXCOORD0.y));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat2 = min(abs(vs_TEXCOORD0.x), abs(vs_TEXCOORD0.y));
    u_xlat0.x = u_xlat0.x * u_xlat2;
    u_xlat2 = u_xlat0.x * u_xlat0.x;
    u_xlat4 = u_xlat2 * 0.0208350997 + -0.0851330012;
    u_xlat4 = u_xlat2 * u_xlat4 + 0.180141002;
    u_xlat4 = u_xlat2 * u_xlat4 + -0.330299497;
    u_xlat2 = u_xlat2 * u_xlat4 + 0.999866009;
    u_xlat4 = u_xlat2 * u_xlat0.x;
    u_xlat4 = u_xlat4 * -2.0 + 1.57079637;
    u_xlatb6 = abs(vs_TEXCOORD0.x)<abs(vs_TEXCOORD0.y);
    u_xlat4 = u_xlatb6 ? u_xlat4 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat2 + u_xlat4;
    u_xlatb2 = vs_TEXCOORD0.x<(-vs_TEXCOORD0.x);
    u_xlat2 = u_xlatb2 ? -3.14159274 : float(0.0);
    u_xlat0.x = u_xlat2 + u_xlat0.x;
    u_xlat2 = min(vs_TEXCOORD0.x, vs_TEXCOORD0.y);
    u_xlatb2 = u_xlat2<(-u_xlat2);
    u_xlat4 = max(vs_TEXCOORD0.x, vs_TEXCOORD0.y);
    u_xlatb4 = u_xlat4>=(-u_xlat4);
    u_xlatb2 = u_xlatb4 && u_xlatb2;
    u_xlat0.x = (u_xlatb2) ? (-u_xlat0.x) : u_xlat0.x;
    u_xlat0.x = u_xlat0.x + 3.1415925;
    u_xlat2 = u_xlat0.x * _DashFrequency;
    u_xlatb2 = u_xlat2>=(-u_xlat2);
    u_xlat2 = (u_xlatb2) ? _DashFrequency : (-_DashFrequency);
    u_xlat4 = float(1.0) / u_xlat2;
    u_xlat0.x = u_xlat4 * u_xlat0.x;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat4 = _DashFrequency * 0.5;
    u_xlat0.x = u_xlat2 * u_xlat0.x + (-u_xlat4);
    u_xlat2 = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
    u_xlat2 = sqrt(u_xlat2);
    u_xlat16_1 = dFdx(u_xlat2);
    u_xlat16_3 = dFdy(u_xlat2);
    u_xlat16_1 = abs(u_xlat16_3) + abs(u_xlat16_1);
    u_xlat0.z = u_xlat2 + (-_Radius);
    u_xlat0.xz = u_xlat0.xz / vec2(u_xlat16_1);
    u_xlat0.xz = clamp(u_xlat0.xz, 0.0, 1.0);
    u_xlat4 = (-u_xlat0.z) + 1.0;
    u_xlat6 = (-_Thickness) + _Radius;
    u_xlat2 = (-u_xlat6) + u_xlat2;
    u_xlat2 = u_xlat2 / u_xlat16_1;
    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
    u_xlat16_1 = u_xlat2 * u_xlat4;
    u_xlat16_1 = u_xlat16_1 * vs_COLOR0.w;
    u_xlat0.x = u_xlat0.x * u_xlat16_1;
    SV_Target0.w = u_xlat0.x;
    SV_Target0.xyz = vs_COLOR0.xyz;
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
uniform 	mediump vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    vs_TEXCOORD1 = in_POSITION0;
    return;
}

#endif
#ifdef FRAGMENT
#version 100
#ifdef GL_OES_standard_derivatives
#extension GL_OES_standard_derivatives : enable
#endif

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	float _Radius;
uniform 	float _Thickness;
uniform 	float _DashFrequency;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump float u_xlat16_1;
float u_xlat2;
bool u_xlatb2;
mediump float u_xlat16_3;
float u_xlat4;
bool u_xlatb4;
float u_xlat6;
bool u_xlatb6;
void main()
{
    u_xlat0.x = max(abs(vs_TEXCOORD0.x), abs(vs_TEXCOORD0.y));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat2 = min(abs(vs_TEXCOORD0.x), abs(vs_TEXCOORD0.y));
    u_xlat0.x = u_xlat0.x * u_xlat2;
    u_xlat2 = u_xlat0.x * u_xlat0.x;
    u_xlat4 = u_xlat2 * 0.0208350997 + -0.0851330012;
    u_xlat4 = u_xlat2 * u_xlat4 + 0.180141002;
    u_xlat4 = u_xlat2 * u_xlat4 + -0.330299497;
    u_xlat2 = u_xlat2 * u_xlat4 + 0.999866009;
    u_xlat4 = u_xlat2 * u_xlat0.x;
    u_xlat4 = u_xlat4 * -2.0 + 1.57079637;
    u_xlatb6 = abs(vs_TEXCOORD0.x)<abs(vs_TEXCOORD0.y);
    u_xlat4 = u_xlatb6 ? u_xlat4 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat2 + u_xlat4;
    u_xlatb2 = vs_TEXCOORD0.x<(-vs_TEXCOORD0.x);
    u_xlat2 = u_xlatb2 ? -3.14159274 : float(0.0);
    u_xlat0.x = u_xlat2 + u_xlat0.x;
    u_xlat2 = min(vs_TEXCOORD0.x, vs_TEXCOORD0.y);
    u_xlatb2 = u_xlat2<(-u_xlat2);
    u_xlat4 = max(vs_TEXCOORD0.x, vs_TEXCOORD0.y);
    u_xlatb4 = u_xlat4>=(-u_xlat4);
    u_xlatb2 = u_xlatb4 && u_xlatb2;
    u_xlat0.x = (u_xlatb2) ? (-u_xlat0.x) : u_xlat0.x;
    u_xlat0.x = u_xlat0.x + 3.1415925;
    u_xlat2 = u_xlat0.x * _DashFrequency;
    u_xlatb2 = u_xlat2>=(-u_xlat2);
    u_xlat2 = (u_xlatb2) ? _DashFrequency : (-_DashFrequency);
    u_xlat4 = float(1.0) / u_xlat2;
    u_xlat0.x = u_xlat4 * u_xlat0.x;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat4 = _DashFrequency * 0.5;
    u_xlat0.x = u_xlat2 * u_xlat0.x + (-u_xlat4);
    u_xlat2 = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
    u_xlat2 = sqrt(u_xlat2);
    u_xlat16_1 = dFdx(u_xlat2);
    u_xlat16_3 = dFdy(u_xlat2);
    u_xlat16_1 = abs(u_xlat16_3) + abs(u_xlat16_1);
    u_xlat0.z = u_xlat2 + (-_Radius);
    u_xlat0.xz = u_xlat0.xz / vec2(u_xlat16_1);
    u_xlat0.xz = clamp(u_xlat0.xz, 0.0, 1.0);
    u_xlat4 = (-u_xlat0.z) + 1.0;
    u_xlat6 = (-_Thickness) + _Radius;
    u_xlat2 = (-u_xlat6) + u_xlat2;
    u_xlat2 = u_xlat2 / u_xlat16_1;
    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
    u_xlat16_1 = u_xlat2 * u_xlat4;
    u_xlat16_1 = u_xlat16_1 * vs_COLOR0.w;
    u_xlat0.x = u_xlat0.x * u_xlat16_1;
    SV_Target0.w = u_xlat0.x;
    SV_Target0.xyz = vs_COLOR0.xyz;
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
uniform 	mediump vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
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
uniform 	float _Radius;
uniform 	float _Thickness;
uniform 	float _DashFrequency;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_1;
float u_xlat2;
bool u_xlatb2;
mediump float u_xlat16_3;
float u_xlat4;
bool u_xlatb4;
float u_xlat6;
bool u_xlatb6;
void main()
{
    u_xlat0.x = max(abs(vs_TEXCOORD0.x), abs(vs_TEXCOORD0.y));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat2 = min(abs(vs_TEXCOORD0.x), abs(vs_TEXCOORD0.y));
    u_xlat0.x = u_xlat0.x * u_xlat2;
    u_xlat2 = u_xlat0.x * u_xlat0.x;
    u_xlat4 = u_xlat2 * 0.0208350997 + -0.0851330012;
    u_xlat4 = u_xlat2 * u_xlat4 + 0.180141002;
    u_xlat4 = u_xlat2 * u_xlat4 + -0.330299497;
    u_xlat2 = u_xlat2 * u_xlat4 + 0.999866009;
    u_xlat4 = u_xlat2 * u_xlat0.x;
    u_xlat4 = u_xlat4 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(abs(vs_TEXCOORD0.x)<abs(vs_TEXCOORD0.y));
#else
    u_xlatb6 = abs(vs_TEXCOORD0.x)<abs(vs_TEXCOORD0.y);
#endif
    u_xlat4 = u_xlatb6 ? u_xlat4 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat2 + u_xlat4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(vs_TEXCOORD0.x<(-vs_TEXCOORD0.x));
#else
    u_xlatb2 = vs_TEXCOORD0.x<(-vs_TEXCOORD0.x);
#endif
    u_xlat2 = u_xlatb2 ? -3.14159274 : float(0.0);
    u_xlat0.x = u_xlat2 + u_xlat0.x;
    u_xlat2 = min(vs_TEXCOORD0.x, vs_TEXCOORD0.y);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat2<(-u_xlat2));
#else
    u_xlatb2 = u_xlat2<(-u_xlat2);
#endif
    u_xlat4 = max(vs_TEXCOORD0.x, vs_TEXCOORD0.y);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4>=(-u_xlat4));
#else
    u_xlatb4 = u_xlat4>=(-u_xlat4);
#endif
    u_xlatb2 = u_xlatb4 && u_xlatb2;
    u_xlat0.x = (u_xlatb2) ? (-u_xlat0.x) : u_xlat0.x;
    u_xlat0.x = u_xlat0.x + 3.1415925;
    u_xlat2 = u_xlat0.x * _DashFrequency;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat2>=(-u_xlat2));
#else
    u_xlatb2 = u_xlat2>=(-u_xlat2);
#endif
    u_xlat2 = (u_xlatb2) ? _DashFrequency : (-_DashFrequency);
    u_xlat4 = float(1.0) / u_xlat2;
    u_xlat0.x = u_xlat4 * u_xlat0.x;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat4 = _DashFrequency * 0.5;
    u_xlat0.x = u_xlat2 * u_xlat0.x + (-u_xlat4);
    u_xlat2 = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
    u_xlat2 = sqrt(u_xlat2);
    u_xlat16_1 = dFdx(u_xlat2);
    u_xlat16_3 = dFdy(u_xlat2);
    u_xlat16_1 = abs(u_xlat16_3) + abs(u_xlat16_1);
    u_xlat0.z = u_xlat2 + (-_Radius);
    u_xlat0.xz = u_xlat0.xz / vec2(u_xlat16_1);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xz = min(max(u_xlat0.xz, 0.0), 1.0);
#else
    u_xlat0.xz = clamp(u_xlat0.xz, 0.0, 1.0);
#endif
    u_xlat4 = (-u_xlat0.z) + 1.0;
    u_xlat6 = (-_Thickness) + _Radius;
    u_xlat2 = (-u_xlat6) + u_xlat2;
    u_xlat2 = u_xlat2 / u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
#else
    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
#endif
    u_xlat16_1 = u_xlat2 * u_xlat4;
    u_xlat16_1 = u_xlat16_1 * vs_COLOR0.w;
    u_xlat0.x = u_xlat0.x * u_xlat16_1;
    SV_Target0.w = u_xlat0.x;
    SV_Target0.xyz = vs_COLOR0.xyz;
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
uniform 	mediump vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
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
uniform 	float _Radius;
uniform 	float _Thickness;
uniform 	float _DashFrequency;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_1;
float u_xlat2;
bool u_xlatb2;
mediump float u_xlat16_3;
float u_xlat4;
bool u_xlatb4;
float u_xlat6;
bool u_xlatb6;
void main()
{
    u_xlat0.x = max(abs(vs_TEXCOORD0.x), abs(vs_TEXCOORD0.y));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat2 = min(abs(vs_TEXCOORD0.x), abs(vs_TEXCOORD0.y));
    u_xlat0.x = u_xlat0.x * u_xlat2;
    u_xlat2 = u_xlat0.x * u_xlat0.x;
    u_xlat4 = u_xlat2 * 0.0208350997 + -0.0851330012;
    u_xlat4 = u_xlat2 * u_xlat4 + 0.180141002;
    u_xlat4 = u_xlat2 * u_xlat4 + -0.330299497;
    u_xlat2 = u_xlat2 * u_xlat4 + 0.999866009;
    u_xlat4 = u_xlat2 * u_xlat0.x;
    u_xlat4 = u_xlat4 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(abs(vs_TEXCOORD0.x)<abs(vs_TEXCOORD0.y));
#else
    u_xlatb6 = abs(vs_TEXCOORD0.x)<abs(vs_TEXCOORD0.y);
#endif
    u_xlat4 = u_xlatb6 ? u_xlat4 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat2 + u_xlat4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(vs_TEXCOORD0.x<(-vs_TEXCOORD0.x));
#else
    u_xlatb2 = vs_TEXCOORD0.x<(-vs_TEXCOORD0.x);
#endif
    u_xlat2 = u_xlatb2 ? -3.14159274 : float(0.0);
    u_xlat0.x = u_xlat2 + u_xlat0.x;
    u_xlat2 = min(vs_TEXCOORD0.x, vs_TEXCOORD0.y);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat2<(-u_xlat2));
#else
    u_xlatb2 = u_xlat2<(-u_xlat2);
#endif
    u_xlat4 = max(vs_TEXCOORD0.x, vs_TEXCOORD0.y);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4>=(-u_xlat4));
#else
    u_xlatb4 = u_xlat4>=(-u_xlat4);
#endif
    u_xlatb2 = u_xlatb4 && u_xlatb2;
    u_xlat0.x = (u_xlatb2) ? (-u_xlat0.x) : u_xlat0.x;
    u_xlat0.x = u_xlat0.x + 3.1415925;
    u_xlat2 = u_xlat0.x * _DashFrequency;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat2>=(-u_xlat2));
#else
    u_xlatb2 = u_xlat2>=(-u_xlat2);
#endif
    u_xlat2 = (u_xlatb2) ? _DashFrequency : (-_DashFrequency);
    u_xlat4 = float(1.0) / u_xlat2;
    u_xlat0.x = u_xlat4 * u_xlat0.x;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat4 = _DashFrequency * 0.5;
    u_xlat0.x = u_xlat2 * u_xlat0.x + (-u_xlat4);
    u_xlat2 = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
    u_xlat2 = sqrt(u_xlat2);
    u_xlat16_1 = dFdx(u_xlat2);
    u_xlat16_3 = dFdy(u_xlat2);
    u_xlat16_1 = abs(u_xlat16_3) + abs(u_xlat16_1);
    u_xlat0.z = u_xlat2 + (-_Radius);
    u_xlat0.xz = u_xlat0.xz / vec2(u_xlat16_1);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xz = min(max(u_xlat0.xz, 0.0), 1.0);
#else
    u_xlat0.xz = clamp(u_xlat0.xz, 0.0, 1.0);
#endif
    u_xlat4 = (-u_xlat0.z) + 1.0;
    u_xlat6 = (-_Thickness) + _Radius;
    u_xlat2 = (-u_xlat6) + u_xlat2;
    u_xlat2 = u_xlat2 / u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
#else
    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
#endif
    u_xlat16_1 = u_xlat2 * u_xlat4;
    u_xlat16_1 = u_xlat16_1 * vs_COLOR0.w;
    u_xlat0.x = u_xlat0.x * u_xlat16_1;
    SV_Target0.w = u_xlat0.x;
    SV_Target0.xyz = vs_COLOR0.xyz;
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
uniform 	mediump vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
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
uniform 	float _Radius;
uniform 	float _Thickness;
uniform 	float _DashFrequency;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_1;
float u_xlat2;
bool u_xlatb2;
mediump float u_xlat16_3;
float u_xlat4;
bool u_xlatb4;
float u_xlat6;
bool u_xlatb6;
void main()
{
    u_xlat0.x = max(abs(vs_TEXCOORD0.x), abs(vs_TEXCOORD0.y));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat2 = min(abs(vs_TEXCOORD0.x), abs(vs_TEXCOORD0.y));
    u_xlat0.x = u_xlat0.x * u_xlat2;
    u_xlat2 = u_xlat0.x * u_xlat0.x;
    u_xlat4 = u_xlat2 * 0.0208350997 + -0.0851330012;
    u_xlat4 = u_xlat2 * u_xlat4 + 0.180141002;
    u_xlat4 = u_xlat2 * u_xlat4 + -0.330299497;
    u_xlat2 = u_xlat2 * u_xlat4 + 0.999866009;
    u_xlat4 = u_xlat2 * u_xlat0.x;
    u_xlat4 = u_xlat4 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(abs(vs_TEXCOORD0.x)<abs(vs_TEXCOORD0.y));
#else
    u_xlatb6 = abs(vs_TEXCOORD0.x)<abs(vs_TEXCOORD0.y);
#endif
    u_xlat4 = u_xlatb6 ? u_xlat4 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat2 + u_xlat4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(vs_TEXCOORD0.x<(-vs_TEXCOORD0.x));
#else
    u_xlatb2 = vs_TEXCOORD0.x<(-vs_TEXCOORD0.x);
#endif
    u_xlat2 = u_xlatb2 ? -3.14159274 : float(0.0);
    u_xlat0.x = u_xlat2 + u_xlat0.x;
    u_xlat2 = min(vs_TEXCOORD0.x, vs_TEXCOORD0.y);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat2<(-u_xlat2));
#else
    u_xlatb2 = u_xlat2<(-u_xlat2);
#endif
    u_xlat4 = max(vs_TEXCOORD0.x, vs_TEXCOORD0.y);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4>=(-u_xlat4));
#else
    u_xlatb4 = u_xlat4>=(-u_xlat4);
#endif
    u_xlatb2 = u_xlatb4 && u_xlatb2;
    u_xlat0.x = (u_xlatb2) ? (-u_xlat0.x) : u_xlat0.x;
    u_xlat0.x = u_xlat0.x + 3.1415925;
    u_xlat2 = u_xlat0.x * _DashFrequency;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat2>=(-u_xlat2));
#else
    u_xlatb2 = u_xlat2>=(-u_xlat2);
#endif
    u_xlat2 = (u_xlatb2) ? _DashFrequency : (-_DashFrequency);
    u_xlat4 = float(1.0) / u_xlat2;
    u_xlat0.x = u_xlat4 * u_xlat0.x;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat4 = _DashFrequency * 0.5;
    u_xlat0.x = u_xlat2 * u_xlat0.x + (-u_xlat4);
    u_xlat2 = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
    u_xlat2 = sqrt(u_xlat2);
    u_xlat16_1 = dFdx(u_xlat2);
    u_xlat16_3 = dFdy(u_xlat2);
    u_xlat16_1 = abs(u_xlat16_3) + abs(u_xlat16_1);
    u_xlat0.z = u_xlat2 + (-_Radius);
    u_xlat0.xz = u_xlat0.xz / vec2(u_xlat16_1);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xz = min(max(u_xlat0.xz, 0.0), 1.0);
#else
    u_xlat0.xz = clamp(u_xlat0.xz, 0.0, 1.0);
#endif
    u_xlat4 = (-u_xlat0.z) + 1.0;
    u_xlat6 = (-_Thickness) + _Radius;
    u_xlat2 = (-u_xlat6) + u_xlat2;
    u_xlat2 = u_xlat2 / u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
#else
    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
#endif
    u_xlat16_1 = u_xlat2 * u_xlat4;
    u_xlat16_1 = u_xlat16_1 * vs_COLOR0.w;
    u_xlat0.x = u_xlat0.x * u_xlat16_1;
    SV_Target0.w = u_xlat0.x;
    SV_Target0.xyz = vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "UNITY_UI_ALPHACLIP" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    vs_TEXCOORD1 = in_POSITION0;
    return;
}

#endif
#ifdef FRAGMENT
#version 100
#ifdef GL_OES_standard_derivatives
#extension GL_OES_standard_derivatives : enable
#endif

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	float _Radius;
uniform 	float _Thickness;
uniform 	float _DashFrequency;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
bool u_xlatb0;
mediump float u_xlat16_1;
float u_xlat2;
bool u_xlatb2;
mediump float u_xlat16_3;
float u_xlat4;
bool u_xlatb4;
float u_xlat6;
bool u_xlatb6;
void main()
{
    u_xlat0.x = max(abs(vs_TEXCOORD0.x), abs(vs_TEXCOORD0.y));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat2 = min(abs(vs_TEXCOORD0.x), abs(vs_TEXCOORD0.y));
    u_xlat0.x = u_xlat0.x * u_xlat2;
    u_xlat2 = u_xlat0.x * u_xlat0.x;
    u_xlat4 = u_xlat2 * 0.0208350997 + -0.0851330012;
    u_xlat4 = u_xlat2 * u_xlat4 + 0.180141002;
    u_xlat4 = u_xlat2 * u_xlat4 + -0.330299497;
    u_xlat2 = u_xlat2 * u_xlat4 + 0.999866009;
    u_xlat4 = u_xlat2 * u_xlat0.x;
    u_xlat4 = u_xlat4 * -2.0 + 1.57079637;
    u_xlatb6 = abs(vs_TEXCOORD0.x)<abs(vs_TEXCOORD0.y);
    u_xlat4 = u_xlatb6 ? u_xlat4 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat2 + u_xlat4;
    u_xlatb2 = vs_TEXCOORD0.x<(-vs_TEXCOORD0.x);
    u_xlat2 = u_xlatb2 ? -3.14159274 : float(0.0);
    u_xlat0.x = u_xlat2 + u_xlat0.x;
    u_xlat2 = min(vs_TEXCOORD0.x, vs_TEXCOORD0.y);
    u_xlatb2 = u_xlat2<(-u_xlat2);
    u_xlat4 = max(vs_TEXCOORD0.x, vs_TEXCOORD0.y);
    u_xlatb4 = u_xlat4>=(-u_xlat4);
    u_xlatb2 = u_xlatb4 && u_xlatb2;
    u_xlat0.x = (u_xlatb2) ? (-u_xlat0.x) : u_xlat0.x;
    u_xlat0.x = u_xlat0.x + 3.1415925;
    u_xlat2 = u_xlat0.x * _DashFrequency;
    u_xlatb2 = u_xlat2>=(-u_xlat2);
    u_xlat2 = (u_xlatb2) ? _DashFrequency : (-_DashFrequency);
    u_xlat4 = float(1.0) / u_xlat2;
    u_xlat0.x = u_xlat4 * u_xlat0.x;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat4 = _DashFrequency * 0.5;
    u_xlat0.x = u_xlat2 * u_xlat0.x + (-u_xlat4);
    u_xlat2 = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
    u_xlat2 = sqrt(u_xlat2);
    u_xlat16_1 = dFdx(u_xlat2);
    u_xlat16_3 = dFdy(u_xlat2);
    u_xlat16_1 = abs(u_xlat16_3) + abs(u_xlat16_1);
    u_xlat0.z = u_xlat2 + (-_Radius);
    u_xlat0.xz = u_xlat0.xz / vec2(u_xlat16_1);
    u_xlat0.xz = clamp(u_xlat0.xz, 0.0, 1.0);
    u_xlat4 = (-u_xlat0.z) + 1.0;
    u_xlat6 = (-_Thickness) + _Radius;
    u_xlat2 = (-u_xlat6) + u_xlat2;
    u_xlat2 = u_xlat2 / u_xlat16_1;
    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
    u_xlat16_1 = u_xlat2 * u_xlat4;
    u_xlat16_1 = u_xlat16_1 * vs_COLOR0.w;
    u_xlat16_3 = u_xlat16_1 * u_xlat0.x + -0.00100000005;
    u_xlat0.x = u_xlat0.x * u_xlat16_1;
    SV_Target0.w = u_xlat0.x;
    u_xlatb0 = u_xlat16_3<0.0;
    if(u_xlatb0){discard;}
    SV_Target0.xyz = vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "UNITY_UI_ALPHACLIP" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    vs_TEXCOORD1 = in_POSITION0;
    return;
}

#endif
#ifdef FRAGMENT
#version 100
#ifdef GL_OES_standard_derivatives
#extension GL_OES_standard_derivatives : enable
#endif

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	float _Radius;
uniform 	float _Thickness;
uniform 	float _DashFrequency;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
bool u_xlatb0;
mediump float u_xlat16_1;
float u_xlat2;
bool u_xlatb2;
mediump float u_xlat16_3;
float u_xlat4;
bool u_xlatb4;
float u_xlat6;
bool u_xlatb6;
void main()
{
    u_xlat0.x = max(abs(vs_TEXCOORD0.x), abs(vs_TEXCOORD0.y));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat2 = min(abs(vs_TEXCOORD0.x), abs(vs_TEXCOORD0.y));
    u_xlat0.x = u_xlat0.x * u_xlat2;
    u_xlat2 = u_xlat0.x * u_xlat0.x;
    u_xlat4 = u_xlat2 * 0.0208350997 + -0.0851330012;
    u_xlat4 = u_xlat2 * u_xlat4 + 0.180141002;
    u_xlat4 = u_xlat2 * u_xlat4 + -0.330299497;
    u_xlat2 = u_xlat2 * u_xlat4 + 0.999866009;
    u_xlat4 = u_xlat2 * u_xlat0.x;
    u_xlat4 = u_xlat4 * -2.0 + 1.57079637;
    u_xlatb6 = abs(vs_TEXCOORD0.x)<abs(vs_TEXCOORD0.y);
    u_xlat4 = u_xlatb6 ? u_xlat4 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat2 + u_xlat4;
    u_xlatb2 = vs_TEXCOORD0.x<(-vs_TEXCOORD0.x);
    u_xlat2 = u_xlatb2 ? -3.14159274 : float(0.0);
    u_xlat0.x = u_xlat2 + u_xlat0.x;
    u_xlat2 = min(vs_TEXCOORD0.x, vs_TEXCOORD0.y);
    u_xlatb2 = u_xlat2<(-u_xlat2);
    u_xlat4 = max(vs_TEXCOORD0.x, vs_TEXCOORD0.y);
    u_xlatb4 = u_xlat4>=(-u_xlat4);
    u_xlatb2 = u_xlatb4 && u_xlatb2;
    u_xlat0.x = (u_xlatb2) ? (-u_xlat0.x) : u_xlat0.x;
    u_xlat0.x = u_xlat0.x + 3.1415925;
    u_xlat2 = u_xlat0.x * _DashFrequency;
    u_xlatb2 = u_xlat2>=(-u_xlat2);
    u_xlat2 = (u_xlatb2) ? _DashFrequency : (-_DashFrequency);
    u_xlat4 = float(1.0) / u_xlat2;
    u_xlat0.x = u_xlat4 * u_xlat0.x;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat4 = _DashFrequency * 0.5;
    u_xlat0.x = u_xlat2 * u_xlat0.x + (-u_xlat4);
    u_xlat2 = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
    u_xlat2 = sqrt(u_xlat2);
    u_xlat16_1 = dFdx(u_xlat2);
    u_xlat16_3 = dFdy(u_xlat2);
    u_xlat16_1 = abs(u_xlat16_3) + abs(u_xlat16_1);
    u_xlat0.z = u_xlat2 + (-_Radius);
    u_xlat0.xz = u_xlat0.xz / vec2(u_xlat16_1);
    u_xlat0.xz = clamp(u_xlat0.xz, 0.0, 1.0);
    u_xlat4 = (-u_xlat0.z) + 1.0;
    u_xlat6 = (-_Thickness) + _Radius;
    u_xlat2 = (-u_xlat6) + u_xlat2;
    u_xlat2 = u_xlat2 / u_xlat16_1;
    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
    u_xlat16_1 = u_xlat2 * u_xlat4;
    u_xlat16_1 = u_xlat16_1 * vs_COLOR0.w;
    u_xlat16_3 = u_xlat16_1 * u_xlat0.x + -0.00100000005;
    u_xlat0.x = u_xlat0.x * u_xlat16_1;
    SV_Target0.w = u_xlat0.x;
    u_xlatb0 = u_xlat16_3<0.0;
    if(u_xlatb0){discard;}
    SV_Target0.xyz = vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "UNITY_UI_ALPHACLIP" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    vs_TEXCOORD1 = in_POSITION0;
    return;
}

#endif
#ifdef FRAGMENT
#version 100
#ifdef GL_OES_standard_derivatives
#extension GL_OES_standard_derivatives : enable
#endif

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	float _Radius;
uniform 	float _Thickness;
uniform 	float _DashFrequency;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
bool u_xlatb0;
mediump float u_xlat16_1;
float u_xlat2;
bool u_xlatb2;
mediump float u_xlat16_3;
float u_xlat4;
bool u_xlatb4;
float u_xlat6;
bool u_xlatb6;
void main()
{
    u_xlat0.x = max(abs(vs_TEXCOORD0.x), abs(vs_TEXCOORD0.y));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat2 = min(abs(vs_TEXCOORD0.x), abs(vs_TEXCOORD0.y));
    u_xlat0.x = u_xlat0.x * u_xlat2;
    u_xlat2 = u_xlat0.x * u_xlat0.x;
    u_xlat4 = u_xlat2 * 0.0208350997 + -0.0851330012;
    u_xlat4 = u_xlat2 * u_xlat4 + 0.180141002;
    u_xlat4 = u_xlat2 * u_xlat4 + -0.330299497;
    u_xlat2 = u_xlat2 * u_xlat4 + 0.999866009;
    u_xlat4 = u_xlat2 * u_xlat0.x;
    u_xlat4 = u_xlat4 * -2.0 + 1.57079637;
    u_xlatb6 = abs(vs_TEXCOORD0.x)<abs(vs_TEXCOORD0.y);
    u_xlat4 = u_xlatb6 ? u_xlat4 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat2 + u_xlat4;
    u_xlatb2 = vs_TEXCOORD0.x<(-vs_TEXCOORD0.x);
    u_xlat2 = u_xlatb2 ? -3.14159274 : float(0.0);
    u_xlat0.x = u_xlat2 + u_xlat0.x;
    u_xlat2 = min(vs_TEXCOORD0.x, vs_TEXCOORD0.y);
    u_xlatb2 = u_xlat2<(-u_xlat2);
    u_xlat4 = max(vs_TEXCOORD0.x, vs_TEXCOORD0.y);
    u_xlatb4 = u_xlat4>=(-u_xlat4);
    u_xlatb2 = u_xlatb4 && u_xlatb2;
    u_xlat0.x = (u_xlatb2) ? (-u_xlat0.x) : u_xlat0.x;
    u_xlat0.x = u_xlat0.x + 3.1415925;
    u_xlat2 = u_xlat0.x * _DashFrequency;
    u_xlatb2 = u_xlat2>=(-u_xlat2);
    u_xlat2 = (u_xlatb2) ? _DashFrequency : (-_DashFrequency);
    u_xlat4 = float(1.0) / u_xlat2;
    u_xlat0.x = u_xlat4 * u_xlat0.x;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat4 = _DashFrequency * 0.5;
    u_xlat0.x = u_xlat2 * u_xlat0.x + (-u_xlat4);
    u_xlat2 = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
    u_xlat2 = sqrt(u_xlat2);
    u_xlat16_1 = dFdx(u_xlat2);
    u_xlat16_3 = dFdy(u_xlat2);
    u_xlat16_1 = abs(u_xlat16_3) + abs(u_xlat16_1);
    u_xlat0.z = u_xlat2 + (-_Radius);
    u_xlat0.xz = u_xlat0.xz / vec2(u_xlat16_1);
    u_xlat0.xz = clamp(u_xlat0.xz, 0.0, 1.0);
    u_xlat4 = (-u_xlat0.z) + 1.0;
    u_xlat6 = (-_Thickness) + _Radius;
    u_xlat2 = (-u_xlat6) + u_xlat2;
    u_xlat2 = u_xlat2 / u_xlat16_1;
    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
    u_xlat16_1 = u_xlat2 * u_xlat4;
    u_xlat16_1 = u_xlat16_1 * vs_COLOR0.w;
    u_xlat16_3 = u_xlat16_1 * u_xlat0.x + -0.00100000005;
    u_xlat0.x = u_xlat0.x * u_xlat16_1;
    SV_Target0.w = u_xlat0.x;
    u_xlatb0 = u_xlat16_3<0.0;
    if(u_xlatb0){discard;}
    SV_Target0.xyz = vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "UNITY_UI_ALPHACLIP" }
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
uniform 	mediump vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
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
uniform 	float _Radius;
uniform 	float _Thickness;
uniform 	float _DashFrequency;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
bool u_xlatb0;
mediump float u_xlat16_1;
float u_xlat2;
bool u_xlatb2;
mediump float u_xlat16_3;
float u_xlat4;
bool u_xlatb4;
float u_xlat6;
bool u_xlatb6;
void main()
{
    u_xlat0.x = max(abs(vs_TEXCOORD0.x), abs(vs_TEXCOORD0.y));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat2 = min(abs(vs_TEXCOORD0.x), abs(vs_TEXCOORD0.y));
    u_xlat0.x = u_xlat0.x * u_xlat2;
    u_xlat2 = u_xlat0.x * u_xlat0.x;
    u_xlat4 = u_xlat2 * 0.0208350997 + -0.0851330012;
    u_xlat4 = u_xlat2 * u_xlat4 + 0.180141002;
    u_xlat4 = u_xlat2 * u_xlat4 + -0.330299497;
    u_xlat2 = u_xlat2 * u_xlat4 + 0.999866009;
    u_xlat4 = u_xlat2 * u_xlat0.x;
    u_xlat4 = u_xlat4 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(abs(vs_TEXCOORD0.x)<abs(vs_TEXCOORD0.y));
#else
    u_xlatb6 = abs(vs_TEXCOORD0.x)<abs(vs_TEXCOORD0.y);
#endif
    u_xlat4 = u_xlatb6 ? u_xlat4 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat2 + u_xlat4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(vs_TEXCOORD0.x<(-vs_TEXCOORD0.x));
#else
    u_xlatb2 = vs_TEXCOORD0.x<(-vs_TEXCOORD0.x);
#endif
    u_xlat2 = u_xlatb2 ? -3.14159274 : float(0.0);
    u_xlat0.x = u_xlat2 + u_xlat0.x;
    u_xlat2 = min(vs_TEXCOORD0.x, vs_TEXCOORD0.y);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat2<(-u_xlat2));
#else
    u_xlatb2 = u_xlat2<(-u_xlat2);
#endif
    u_xlat4 = max(vs_TEXCOORD0.x, vs_TEXCOORD0.y);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4>=(-u_xlat4));
#else
    u_xlatb4 = u_xlat4>=(-u_xlat4);
#endif
    u_xlatb2 = u_xlatb4 && u_xlatb2;
    u_xlat0.x = (u_xlatb2) ? (-u_xlat0.x) : u_xlat0.x;
    u_xlat0.x = u_xlat0.x + 3.1415925;
    u_xlat2 = u_xlat0.x * _DashFrequency;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat2>=(-u_xlat2));
#else
    u_xlatb2 = u_xlat2>=(-u_xlat2);
#endif
    u_xlat2 = (u_xlatb2) ? _DashFrequency : (-_DashFrequency);
    u_xlat4 = float(1.0) / u_xlat2;
    u_xlat0.x = u_xlat4 * u_xlat0.x;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat4 = _DashFrequency * 0.5;
    u_xlat0.x = u_xlat2 * u_xlat0.x + (-u_xlat4);
    u_xlat2 = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
    u_xlat2 = sqrt(u_xlat2);
    u_xlat16_1 = dFdx(u_xlat2);
    u_xlat16_3 = dFdy(u_xlat2);
    u_xlat16_1 = abs(u_xlat16_3) + abs(u_xlat16_1);
    u_xlat0.z = u_xlat2 + (-_Radius);
    u_xlat0.xz = u_xlat0.xz / vec2(u_xlat16_1);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xz = min(max(u_xlat0.xz, 0.0), 1.0);
#else
    u_xlat0.xz = clamp(u_xlat0.xz, 0.0, 1.0);
#endif
    u_xlat4 = (-u_xlat0.z) + 1.0;
    u_xlat6 = (-_Thickness) + _Radius;
    u_xlat2 = (-u_xlat6) + u_xlat2;
    u_xlat2 = u_xlat2 / u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
#else
    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
#endif
    u_xlat16_1 = u_xlat2 * u_xlat4;
    u_xlat16_1 = u_xlat16_1 * vs_COLOR0.w;
    u_xlat16_3 = u_xlat16_1 * u_xlat0.x + -0.00100000005;
    u_xlat0.x = u_xlat0.x * u_xlat16_1;
    SV_Target0.w = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_3<0.0);
#else
    u_xlatb0 = u_xlat16_3<0.0;
#endif
    if(u_xlatb0){discard;}
    SV_Target0.xyz = vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "UNITY_UI_ALPHACLIP" }
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
uniform 	mediump vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
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
uniform 	float _Radius;
uniform 	float _Thickness;
uniform 	float _DashFrequency;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
bool u_xlatb0;
mediump float u_xlat16_1;
float u_xlat2;
bool u_xlatb2;
mediump float u_xlat16_3;
float u_xlat4;
bool u_xlatb4;
float u_xlat6;
bool u_xlatb6;
void main()
{
    u_xlat0.x = max(abs(vs_TEXCOORD0.x), abs(vs_TEXCOORD0.y));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat2 = min(abs(vs_TEXCOORD0.x), abs(vs_TEXCOORD0.y));
    u_xlat0.x = u_xlat0.x * u_xlat2;
    u_xlat2 = u_xlat0.x * u_xlat0.x;
    u_xlat4 = u_xlat2 * 0.0208350997 + -0.0851330012;
    u_xlat4 = u_xlat2 * u_xlat4 + 0.180141002;
    u_xlat4 = u_xlat2 * u_xlat4 + -0.330299497;
    u_xlat2 = u_xlat2 * u_xlat4 + 0.999866009;
    u_xlat4 = u_xlat2 * u_xlat0.x;
    u_xlat4 = u_xlat4 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(abs(vs_TEXCOORD0.x)<abs(vs_TEXCOORD0.y));
#else
    u_xlatb6 = abs(vs_TEXCOORD0.x)<abs(vs_TEXCOORD0.y);
#endif
    u_xlat4 = u_xlatb6 ? u_xlat4 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat2 + u_xlat4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(vs_TEXCOORD0.x<(-vs_TEXCOORD0.x));
#else
    u_xlatb2 = vs_TEXCOORD0.x<(-vs_TEXCOORD0.x);
#endif
    u_xlat2 = u_xlatb2 ? -3.14159274 : float(0.0);
    u_xlat0.x = u_xlat2 + u_xlat0.x;
    u_xlat2 = min(vs_TEXCOORD0.x, vs_TEXCOORD0.y);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat2<(-u_xlat2));
#else
    u_xlatb2 = u_xlat2<(-u_xlat2);
#endif
    u_xlat4 = max(vs_TEXCOORD0.x, vs_TEXCOORD0.y);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4>=(-u_xlat4));
#else
    u_xlatb4 = u_xlat4>=(-u_xlat4);
#endif
    u_xlatb2 = u_xlatb4 && u_xlatb2;
    u_xlat0.x = (u_xlatb2) ? (-u_xlat0.x) : u_xlat0.x;
    u_xlat0.x = u_xlat0.x + 3.1415925;
    u_xlat2 = u_xlat0.x * _DashFrequency;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat2>=(-u_xlat2));
#else
    u_xlatb2 = u_xlat2>=(-u_xlat2);
#endif
    u_xlat2 = (u_xlatb2) ? _DashFrequency : (-_DashFrequency);
    u_xlat4 = float(1.0) / u_xlat2;
    u_xlat0.x = u_xlat4 * u_xlat0.x;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat4 = _DashFrequency * 0.5;
    u_xlat0.x = u_xlat2 * u_xlat0.x + (-u_xlat4);
    u_xlat2 = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
    u_xlat2 = sqrt(u_xlat2);
    u_xlat16_1 = dFdx(u_xlat2);
    u_xlat16_3 = dFdy(u_xlat2);
    u_xlat16_1 = abs(u_xlat16_3) + abs(u_xlat16_1);
    u_xlat0.z = u_xlat2 + (-_Radius);
    u_xlat0.xz = u_xlat0.xz / vec2(u_xlat16_1);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xz = min(max(u_xlat0.xz, 0.0), 1.0);
#else
    u_xlat0.xz = clamp(u_xlat0.xz, 0.0, 1.0);
#endif
    u_xlat4 = (-u_xlat0.z) + 1.0;
    u_xlat6 = (-_Thickness) + _Radius;
    u_xlat2 = (-u_xlat6) + u_xlat2;
    u_xlat2 = u_xlat2 / u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
#else
    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
#endif
    u_xlat16_1 = u_xlat2 * u_xlat4;
    u_xlat16_1 = u_xlat16_1 * vs_COLOR0.w;
    u_xlat16_3 = u_xlat16_1 * u_xlat0.x + -0.00100000005;
    u_xlat0.x = u_xlat0.x * u_xlat16_1;
    SV_Target0.w = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_3<0.0);
#else
    u_xlatb0 = u_xlat16_3<0.0;
#endif
    if(u_xlatb0){discard;}
    SV_Target0.xyz = vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "UNITY_UI_ALPHACLIP" }
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
uniform 	mediump vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
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
uniform 	float _Radius;
uniform 	float _Thickness;
uniform 	float _DashFrequency;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
bool u_xlatb0;
mediump float u_xlat16_1;
float u_xlat2;
bool u_xlatb2;
mediump float u_xlat16_3;
float u_xlat4;
bool u_xlatb4;
float u_xlat6;
bool u_xlatb6;
void main()
{
    u_xlat0.x = max(abs(vs_TEXCOORD0.x), abs(vs_TEXCOORD0.y));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat2 = min(abs(vs_TEXCOORD0.x), abs(vs_TEXCOORD0.y));
    u_xlat0.x = u_xlat0.x * u_xlat2;
    u_xlat2 = u_xlat0.x * u_xlat0.x;
    u_xlat4 = u_xlat2 * 0.0208350997 + -0.0851330012;
    u_xlat4 = u_xlat2 * u_xlat4 + 0.180141002;
    u_xlat4 = u_xlat2 * u_xlat4 + -0.330299497;
    u_xlat2 = u_xlat2 * u_xlat4 + 0.999866009;
    u_xlat4 = u_xlat2 * u_xlat0.x;
    u_xlat4 = u_xlat4 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(abs(vs_TEXCOORD0.x)<abs(vs_TEXCOORD0.y));
#else
    u_xlatb6 = abs(vs_TEXCOORD0.x)<abs(vs_TEXCOORD0.y);
#endif
    u_xlat4 = u_xlatb6 ? u_xlat4 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat2 + u_xlat4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(vs_TEXCOORD0.x<(-vs_TEXCOORD0.x));
#else
    u_xlatb2 = vs_TEXCOORD0.x<(-vs_TEXCOORD0.x);
#endif
    u_xlat2 = u_xlatb2 ? -3.14159274 : float(0.0);
    u_xlat0.x = u_xlat2 + u_xlat0.x;
    u_xlat2 = min(vs_TEXCOORD0.x, vs_TEXCOORD0.y);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat2<(-u_xlat2));
#else
    u_xlatb2 = u_xlat2<(-u_xlat2);
#endif
    u_xlat4 = max(vs_TEXCOORD0.x, vs_TEXCOORD0.y);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4>=(-u_xlat4));
#else
    u_xlatb4 = u_xlat4>=(-u_xlat4);
#endif
    u_xlatb2 = u_xlatb4 && u_xlatb2;
    u_xlat0.x = (u_xlatb2) ? (-u_xlat0.x) : u_xlat0.x;
    u_xlat0.x = u_xlat0.x + 3.1415925;
    u_xlat2 = u_xlat0.x * _DashFrequency;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat2>=(-u_xlat2));
#else
    u_xlatb2 = u_xlat2>=(-u_xlat2);
#endif
    u_xlat2 = (u_xlatb2) ? _DashFrequency : (-_DashFrequency);
    u_xlat4 = float(1.0) / u_xlat2;
    u_xlat0.x = u_xlat4 * u_xlat0.x;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat4 = _DashFrequency * 0.5;
    u_xlat0.x = u_xlat2 * u_xlat0.x + (-u_xlat4);
    u_xlat2 = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
    u_xlat2 = sqrt(u_xlat2);
    u_xlat16_1 = dFdx(u_xlat2);
    u_xlat16_3 = dFdy(u_xlat2);
    u_xlat16_1 = abs(u_xlat16_3) + abs(u_xlat16_1);
    u_xlat0.z = u_xlat2 + (-_Radius);
    u_xlat0.xz = u_xlat0.xz / vec2(u_xlat16_1);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xz = min(max(u_xlat0.xz, 0.0), 1.0);
#else
    u_xlat0.xz = clamp(u_xlat0.xz, 0.0, 1.0);
#endif
    u_xlat4 = (-u_xlat0.z) + 1.0;
    u_xlat6 = (-_Thickness) + _Radius;
    u_xlat2 = (-u_xlat6) + u_xlat2;
    u_xlat2 = u_xlat2 / u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
#else
    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
#endif
    u_xlat16_1 = u_xlat2 * u_xlat4;
    u_xlat16_1 = u_xlat16_1 * vs_COLOR0.w;
    u_xlat16_3 = u_xlat16_1 * u_xlat0.x + -0.00100000005;
    u_xlat0.x = u_xlat0.x * u_xlat16_1;
    SV_Target0.w = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_3<0.0);
#else
    u_xlatb0 = u_xlat16_3<0.0;
#endif
    if(u_xlatb0){discard;}
    SV_Target0.xyz = vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "UNITY_UI_CLIP_RECT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    vs_TEXCOORD1 = in_POSITION0;
    return;
}

#endif
#ifdef FRAGMENT
#version 100
#ifdef GL_OES_standard_derivatives
#extension GL_OES_standard_derivatives : enable
#endif

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec4 _ClipRect;
uniform 	float _Radius;
uniform 	float _Thickness;
uniform 	float _DashFrequency;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump float u_xlat16_1;
vec2 u_xlat2;
bvec2 u_xlatb2;
vec2 u_xlat3;
bvec2 u_xlatb3;
mediump float u_xlat16_4;
float u_xlat6;
bool u_xlatb6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = max(abs(vs_TEXCOORD0.x), abs(vs_TEXCOORD0.y));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat3.x = min(abs(vs_TEXCOORD0.x), abs(vs_TEXCOORD0.y));
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = u_xlat0.x * u_xlat0.x;
    u_xlat6 = u_xlat3.x * 0.0208350997 + -0.0851330012;
    u_xlat6 = u_xlat3.x * u_xlat6 + 0.180141002;
    u_xlat6 = u_xlat3.x * u_xlat6 + -0.330299497;
    u_xlat3.x = u_xlat3.x * u_xlat6 + 0.999866009;
    u_xlat6 = u_xlat3.x * u_xlat0.x;
    u_xlat6 = u_xlat6 * -2.0 + 1.57079637;
    u_xlatb9 = abs(vs_TEXCOORD0.x)<abs(vs_TEXCOORD0.y);
    u_xlat6 = u_xlatb9 ? u_xlat6 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat3.x + u_xlat6;
    u_xlatb3.x = vs_TEXCOORD0.x<(-vs_TEXCOORD0.x);
    u_xlat3.x = u_xlatb3.x ? -3.14159274 : float(0.0);
    u_xlat0.x = u_xlat3.x + u_xlat0.x;
    u_xlat3.x = min(vs_TEXCOORD0.x, vs_TEXCOORD0.y);
    u_xlatb3.x = u_xlat3.x<(-u_xlat3.x);
    u_xlat6 = max(vs_TEXCOORD0.x, vs_TEXCOORD0.y);
    u_xlatb6 = u_xlat6>=(-u_xlat6);
    u_xlatb3.x = u_xlatb6 && u_xlatb3.x;
    u_xlat0.x = (u_xlatb3.x) ? (-u_xlat0.x) : u_xlat0.x;
    u_xlat0.x = u_xlat0.x + 3.1415925;
    u_xlat3.x = u_xlat0.x * _DashFrequency;
    u_xlatb3.x = u_xlat3.x>=(-u_xlat3.x);
    u_xlat3.x = (u_xlatb3.x) ? _DashFrequency : (-_DashFrequency);
    u_xlat6 = float(1.0) / u_xlat3.x;
    u_xlat0.x = u_xlat6 * u_xlat0.x;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat6 = _DashFrequency * 0.5;
    u_xlat0.x = u_xlat3.x * u_xlat0.x + (-u_xlat6);
    u_xlat3.x = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
    u_xlat3.x = sqrt(u_xlat3.x);
    u_xlat16_1 = dFdx(u_xlat3.x);
    u_xlat16_4 = dFdy(u_xlat3.x);
    u_xlat16_1 = abs(u_xlat16_4) + abs(u_xlat16_1);
    u_xlat0.z = u_xlat3.x + (-_Radius);
    u_xlat0.xz = u_xlat0.xz / vec2(u_xlat16_1);
    u_xlat0.xz = clamp(u_xlat0.xz, 0.0, 1.0);
    u_xlat6 = (-u_xlat0.z) + 1.0;
    u_xlat9 = (-_Thickness) + _Radius;
    u_xlat3.x = (-u_xlat9) + u_xlat3.x;
    u_xlat3.x = u_xlat3.x / u_xlat16_1;
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat16_1 = u_xlat3.x * u_xlat6;
    u_xlat16_1 = u_xlat16_1 * vs_COLOR0.w;
    u_xlat0.x = u_xlat0.x * u_xlat16_1;
    u_xlatb3.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlat3.x = u_xlatb3.x ? float(1.0) : 0.0;
    u_xlat3.y = u_xlatb3.y ? float(1.0) : 0.0;
;
    u_xlatb2.xy = greaterThanEqual(_ClipRect.zwzz, vs_TEXCOORD1.xyxx).xy;
    u_xlat2.x = u_xlatb2.x ? float(1.0) : 0.0;
    u_xlat2.y = u_xlatb2.y ? float(1.0) : 0.0;
;
    u_xlat3.xy = u_xlat3.xy * u_xlat2.xy;
    u_xlat3.x = u_xlat3.y * u_xlat3.x;
    u_xlat0.x = u_xlat3.x * u_xlat0.x;
    SV_Target0.w = u_xlat0.x;
    SV_Target0.xyz = vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "UNITY_UI_CLIP_RECT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    vs_TEXCOORD1 = in_POSITION0;
    return;
}

#endif
#ifdef FRAGMENT
#version 100
#ifdef GL_OES_standard_derivatives
#extension GL_OES_standard_derivatives : enable
#endif

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec4 _ClipRect;
uniform 	float _Radius;
uniform 	float _Thickness;
uniform 	float _DashFrequency;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump float u_xlat16_1;
vec2 u_xlat2;
bvec2 u_xlatb2;
vec2 u_xlat3;
bvec2 u_xlatb3;
mediump float u_xlat16_4;
float u_xlat6;
bool u_xlatb6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = max(abs(vs_TEXCOORD0.x), abs(vs_TEXCOORD0.y));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat3.x = min(abs(vs_TEXCOORD0.x), abs(vs_TEXCOORD0.y));
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = u_xlat0.x * u_xlat0.x;
    u_xlat6 = u_xlat3.x * 0.0208350997 + -0.0851330012;
    u_xlat6 = u_xlat3.x * u_xlat6 + 0.180141002;
    u_xlat6 = u_xlat3.x * u_xlat6 + -0.330299497;
    u_xlat3.x = u_xlat3.x * u_xlat6 + 0.999866009;
    u_xlat6 = u_xlat3.x * u_xlat0.x;
    u_xlat6 = u_xlat6 * -2.0 + 1.57079637;
    u_xlatb9 = abs(vs_TEXCOORD0.x)<abs(vs_TEXCOORD0.y);
    u_xlat6 = u_xlatb9 ? u_xlat6 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat3.x + u_xlat6;
    u_xlatb3.x = vs_TEXCOORD0.x<(-vs_TEXCOORD0.x);
    u_xlat3.x = u_xlatb3.x ? -3.14159274 : float(0.0);
    u_xlat0.x = u_xlat3.x + u_xlat0.x;
    u_xlat3.x = min(vs_TEXCOORD0.x, vs_TEXCOORD0.y);
    u_xlatb3.x = u_xlat3.x<(-u_xlat3.x);
    u_xlat6 = max(vs_TEXCOORD0.x, vs_TEXCOORD0.y);
    u_xlatb6 = u_xlat6>=(-u_xlat6);
    u_xlatb3.x = u_xlatb6 && u_xlatb3.x;
    u_xlat0.x = (u_xlatb3.x) ? (-u_xlat0.x) : u_xlat0.x;
    u_xlat0.x = u_xlat0.x + 3.1415925;
    u_xlat3.x = u_xlat0.x * _DashFrequency;
    u_xlatb3.x = u_xlat3.x>=(-u_xlat3.x);
    u_xlat3.x = (u_xlatb3.x) ? _DashFrequency : (-_DashFrequency);
    u_xlat6 = float(1.0) / u_xlat3.x;
    u_xlat0.x = u_xlat6 * u_xlat0.x;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat6 = _DashFrequency * 0.5;
    u_xlat0.x = u_xlat3.x * u_xlat0.x + (-u_xlat6);
    u_xlat3.x = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
    u_xlat3.x = sqrt(u_xlat3.x);
    u_xlat16_1 = dFdx(u_xlat3.x);
    u_xlat16_4 = dFdy(u_xlat3.x);
    u_xlat16_1 = abs(u_xlat16_4) + abs(u_xlat16_1);
    u_xlat0.z = u_xlat3.x + (-_Radius);
    u_xlat0.xz = u_xlat0.xz / vec2(u_xlat16_1);
    u_xlat0.xz = clamp(u_xlat0.xz, 0.0, 1.0);
    u_xlat6 = (-u_xlat0.z) + 1.0;
    u_xlat9 = (-_Thickness) + _Radius;
    u_xlat3.x = (-u_xlat9) + u_xlat3.x;
    u_xlat3.x = u_xlat3.x / u_xlat16_1;
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat16_1 = u_xlat3.x * u_xlat6;
    u_xlat16_1 = u_xlat16_1 * vs_COLOR0.w;
    u_xlat0.x = u_xlat0.x * u_xlat16_1;
    u_xlatb3.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlat3.x = u_xlatb3.x ? float(1.0) : 0.0;
    u_xlat3.y = u_xlatb3.y ? float(1.0) : 0.0;
;
    u_xlatb2.xy = greaterThanEqual(_ClipRect.zwzz, vs_TEXCOORD1.xyxx).xy;
    u_xlat2.x = u_xlatb2.x ? float(1.0) : 0.0;
    u_xlat2.y = u_xlatb2.y ? float(1.0) : 0.0;
;
    u_xlat3.xy = u_xlat3.xy * u_xlat2.xy;
    u_xlat3.x = u_xlat3.y * u_xlat3.x;
    u_xlat0.x = u_xlat3.x * u_xlat0.x;
    SV_Target0.w = u_xlat0.x;
    SV_Target0.xyz = vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "UNITY_UI_CLIP_RECT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    vs_TEXCOORD1 = in_POSITION0;
    return;
}

#endif
#ifdef FRAGMENT
#version 100
#ifdef GL_OES_standard_derivatives
#extension GL_OES_standard_derivatives : enable
#endif

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec4 _ClipRect;
uniform 	float _Radius;
uniform 	float _Thickness;
uniform 	float _DashFrequency;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
mediump float u_xlat16_1;
vec2 u_xlat2;
bvec2 u_xlatb2;
vec2 u_xlat3;
bvec2 u_xlatb3;
mediump float u_xlat16_4;
float u_xlat6;
bool u_xlatb6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = max(abs(vs_TEXCOORD0.x), abs(vs_TEXCOORD0.y));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat3.x = min(abs(vs_TEXCOORD0.x), abs(vs_TEXCOORD0.y));
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = u_xlat0.x * u_xlat0.x;
    u_xlat6 = u_xlat3.x * 0.0208350997 + -0.0851330012;
    u_xlat6 = u_xlat3.x * u_xlat6 + 0.180141002;
    u_xlat6 = u_xlat3.x * u_xlat6 + -0.330299497;
    u_xlat3.x = u_xlat3.x * u_xlat6 + 0.999866009;
    u_xlat6 = u_xlat3.x * u_xlat0.x;
    u_xlat6 = u_xlat6 * -2.0 + 1.57079637;
    u_xlatb9 = abs(vs_TEXCOORD0.x)<abs(vs_TEXCOORD0.y);
    u_xlat6 = u_xlatb9 ? u_xlat6 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat3.x + u_xlat6;
    u_xlatb3.x = vs_TEXCOORD0.x<(-vs_TEXCOORD0.x);
    u_xlat3.x = u_xlatb3.x ? -3.14159274 : float(0.0);
    u_xlat0.x = u_xlat3.x + u_xlat0.x;
    u_xlat3.x = min(vs_TEXCOORD0.x, vs_TEXCOORD0.y);
    u_xlatb3.x = u_xlat3.x<(-u_xlat3.x);
    u_xlat6 = max(vs_TEXCOORD0.x, vs_TEXCOORD0.y);
    u_xlatb6 = u_xlat6>=(-u_xlat6);
    u_xlatb3.x = u_xlatb6 && u_xlatb3.x;
    u_xlat0.x = (u_xlatb3.x) ? (-u_xlat0.x) : u_xlat0.x;
    u_xlat0.x = u_xlat0.x + 3.1415925;
    u_xlat3.x = u_xlat0.x * _DashFrequency;
    u_xlatb3.x = u_xlat3.x>=(-u_xlat3.x);
    u_xlat3.x = (u_xlatb3.x) ? _DashFrequency : (-_DashFrequency);
    u_xlat6 = float(1.0) / u_xlat3.x;
    u_xlat0.x = u_xlat6 * u_xlat0.x;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat6 = _DashFrequency * 0.5;
    u_xlat0.x = u_xlat3.x * u_xlat0.x + (-u_xlat6);
    u_xlat3.x = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
    u_xlat3.x = sqrt(u_xlat3.x);
    u_xlat16_1 = dFdx(u_xlat3.x);
    u_xlat16_4 = dFdy(u_xlat3.x);
    u_xlat16_1 = abs(u_xlat16_4) + abs(u_xlat16_1);
    u_xlat0.z = u_xlat3.x + (-_Radius);
    u_xlat0.xz = u_xlat0.xz / vec2(u_xlat16_1);
    u_xlat0.xz = clamp(u_xlat0.xz, 0.0, 1.0);
    u_xlat6 = (-u_xlat0.z) + 1.0;
    u_xlat9 = (-_Thickness) + _Radius;
    u_xlat3.x = (-u_xlat9) + u_xlat3.x;
    u_xlat3.x = u_xlat3.x / u_xlat16_1;
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat16_1 = u_xlat3.x * u_xlat6;
    u_xlat16_1 = u_xlat16_1 * vs_COLOR0.w;
    u_xlat0.x = u_xlat0.x * u_xlat16_1;
    u_xlatb3.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlat3.x = u_xlatb3.x ? float(1.0) : 0.0;
    u_xlat3.y = u_xlatb3.y ? float(1.0) : 0.0;
;
    u_xlatb2.xy = greaterThanEqual(_ClipRect.zwzz, vs_TEXCOORD1.xyxx).xy;
    u_xlat2.x = u_xlatb2.x ? float(1.0) : 0.0;
    u_xlat2.y = u_xlatb2.y ? float(1.0) : 0.0;
;
    u_xlat3.xy = u_xlat3.xy * u_xlat2.xy;
    u_xlat3.x = u_xlat3.y * u_xlat3.x;
    u_xlat0.x = u_xlat3.x * u_xlat0.x;
    SV_Target0.w = u_xlat0.x;
    SV_Target0.xyz = vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "UNITY_UI_CLIP_RECT" }
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
uniform 	mediump vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
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
uniform 	vec4 _ClipRect;
uniform 	float _Radius;
uniform 	float _Thickness;
uniform 	float _DashFrequency;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_1;
vec2 u_xlat2;
bvec2 u_xlatb2;
vec2 u_xlat3;
bvec2 u_xlatb3;
mediump float u_xlat16_4;
float u_xlat6;
bool u_xlatb6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = max(abs(vs_TEXCOORD0.x), abs(vs_TEXCOORD0.y));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat3.x = min(abs(vs_TEXCOORD0.x), abs(vs_TEXCOORD0.y));
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = u_xlat0.x * u_xlat0.x;
    u_xlat6 = u_xlat3.x * 0.0208350997 + -0.0851330012;
    u_xlat6 = u_xlat3.x * u_xlat6 + 0.180141002;
    u_xlat6 = u_xlat3.x * u_xlat6 + -0.330299497;
    u_xlat3.x = u_xlat3.x * u_xlat6 + 0.999866009;
    u_xlat6 = u_xlat3.x * u_xlat0.x;
    u_xlat6 = u_xlat6 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(abs(vs_TEXCOORD0.x)<abs(vs_TEXCOORD0.y));
#else
    u_xlatb9 = abs(vs_TEXCOORD0.x)<abs(vs_TEXCOORD0.y);
#endif
    u_xlat6 = u_xlatb9 ? u_xlat6 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat3.x + u_xlat6;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3.x = !!(vs_TEXCOORD0.x<(-vs_TEXCOORD0.x));
#else
    u_xlatb3.x = vs_TEXCOORD0.x<(-vs_TEXCOORD0.x);
#endif
    u_xlat3.x = u_xlatb3.x ? -3.14159274 : float(0.0);
    u_xlat0.x = u_xlat3.x + u_xlat0.x;
    u_xlat3.x = min(vs_TEXCOORD0.x, vs_TEXCOORD0.y);
#ifdef UNITY_ADRENO_ES3
    u_xlatb3.x = !!(u_xlat3.x<(-u_xlat3.x));
#else
    u_xlatb3.x = u_xlat3.x<(-u_xlat3.x);
#endif
    u_xlat6 = max(vs_TEXCOORD0.x, vs_TEXCOORD0.y);
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat6>=(-u_xlat6));
#else
    u_xlatb6 = u_xlat6>=(-u_xlat6);
#endif
    u_xlatb3.x = u_xlatb6 && u_xlatb3.x;
    u_xlat0.x = (u_xlatb3.x) ? (-u_xlat0.x) : u_xlat0.x;
    u_xlat0.x = u_xlat0.x + 3.1415925;
    u_xlat3.x = u_xlat0.x * _DashFrequency;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3.x = !!(u_xlat3.x>=(-u_xlat3.x));
#else
    u_xlatb3.x = u_xlat3.x>=(-u_xlat3.x);
#endif
    u_xlat3.x = (u_xlatb3.x) ? _DashFrequency : (-_DashFrequency);
    u_xlat6 = float(1.0) / u_xlat3.x;
    u_xlat0.x = u_xlat6 * u_xlat0.x;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat6 = _DashFrequency * 0.5;
    u_xlat0.x = u_xlat3.x * u_xlat0.x + (-u_xlat6);
    u_xlat3.x = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
    u_xlat3.x = sqrt(u_xlat3.x);
    u_xlat16_1 = dFdx(u_xlat3.x);
    u_xlat16_4 = dFdy(u_xlat3.x);
    u_xlat16_1 = abs(u_xlat16_4) + abs(u_xlat16_1);
    u_xlat0.z = u_xlat3.x + (-_Radius);
    u_xlat0.xz = u_xlat0.xz / vec2(u_xlat16_1);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xz = min(max(u_xlat0.xz, 0.0), 1.0);
#else
    u_xlat0.xz = clamp(u_xlat0.xz, 0.0, 1.0);
#endif
    u_xlat6 = (-u_xlat0.z) + 1.0;
    u_xlat9 = (-_Thickness) + _Radius;
    u_xlat3.x = (-u_xlat9) + u_xlat3.x;
    u_xlat3.x = u_xlat3.x / u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat16_1 = u_xlat3.x * u_xlat6;
    u_xlat16_1 = u_xlat16_1 * vs_COLOR0.w;
    u_xlat0.x = u_xlat0.x * u_xlat16_1;
    u_xlatb3.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlat3.x = u_xlatb3.x ? float(1.0) : 0.0;
    u_xlat3.y = u_xlatb3.y ? float(1.0) : 0.0;
;
    u_xlatb2.xy = greaterThanEqual(_ClipRect.zwzz, vs_TEXCOORD1.xyxx).xy;
    u_xlat2.x = u_xlatb2.x ? float(1.0) : 0.0;
    u_xlat2.y = u_xlatb2.y ? float(1.0) : 0.0;
;
    u_xlat3.xy = u_xlat3.xy * u_xlat2.xy;
    u_xlat3.x = u_xlat3.y * u_xlat3.x;
    u_xlat0.x = u_xlat3.x * u_xlat0.x;
    SV_Target0.w = u_xlat0.x;
    SV_Target0.xyz = vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "UNITY_UI_CLIP_RECT" }
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
uniform 	mediump vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
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
uniform 	vec4 _ClipRect;
uniform 	float _Radius;
uniform 	float _Thickness;
uniform 	float _DashFrequency;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_1;
vec2 u_xlat2;
bvec2 u_xlatb2;
vec2 u_xlat3;
bvec2 u_xlatb3;
mediump float u_xlat16_4;
float u_xlat6;
bool u_xlatb6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = max(abs(vs_TEXCOORD0.x), abs(vs_TEXCOORD0.y));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat3.x = min(abs(vs_TEXCOORD0.x), abs(vs_TEXCOORD0.y));
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = u_xlat0.x * u_xlat0.x;
    u_xlat6 = u_xlat3.x * 0.0208350997 + -0.0851330012;
    u_xlat6 = u_xlat3.x * u_xlat6 + 0.180141002;
    u_xlat6 = u_xlat3.x * u_xlat6 + -0.330299497;
    u_xlat3.x = u_xlat3.x * u_xlat6 + 0.999866009;
    u_xlat6 = u_xlat3.x * u_xlat0.x;
    u_xlat6 = u_xlat6 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(abs(vs_TEXCOORD0.x)<abs(vs_TEXCOORD0.y));
#else
    u_xlatb9 = abs(vs_TEXCOORD0.x)<abs(vs_TEXCOORD0.y);
#endif
    u_xlat6 = u_xlatb9 ? u_xlat6 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat3.x + u_xlat6;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3.x = !!(vs_TEXCOORD0.x<(-vs_TEXCOORD0.x));
#else
    u_xlatb3.x = vs_TEXCOORD0.x<(-vs_TEXCOORD0.x);
#endif
    u_xlat3.x = u_xlatb3.x ? -3.14159274 : float(0.0);
    u_xlat0.x = u_xlat3.x + u_xlat0.x;
    u_xlat3.x = min(vs_TEXCOORD0.x, vs_TEXCOORD0.y);
#ifdef UNITY_ADRENO_ES3
    u_xlatb3.x = !!(u_xlat3.x<(-u_xlat3.x));
#else
    u_xlatb3.x = u_xlat3.x<(-u_xlat3.x);
#endif
    u_xlat6 = max(vs_TEXCOORD0.x, vs_TEXCOORD0.y);
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat6>=(-u_xlat6));
#else
    u_xlatb6 = u_xlat6>=(-u_xlat6);
#endif
    u_xlatb3.x = u_xlatb6 && u_xlatb3.x;
    u_xlat0.x = (u_xlatb3.x) ? (-u_xlat0.x) : u_xlat0.x;
    u_xlat0.x = u_xlat0.x + 3.1415925;
    u_xlat3.x = u_xlat0.x * _DashFrequency;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3.x = !!(u_xlat3.x>=(-u_xlat3.x));
#else
    u_xlatb3.x = u_xlat3.x>=(-u_xlat3.x);
#endif
    u_xlat3.x = (u_xlatb3.x) ? _DashFrequency : (-_DashFrequency);
    u_xlat6 = float(1.0) / u_xlat3.x;
    u_xlat0.x = u_xlat6 * u_xlat0.x;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat6 = _DashFrequency * 0.5;
    u_xlat0.x = u_xlat3.x * u_xlat0.x + (-u_xlat6);
    u_xlat3.x = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
    u_xlat3.x = sqrt(u_xlat3.x);
    u_xlat16_1 = dFdx(u_xlat3.x);
    u_xlat16_4 = dFdy(u_xlat3.x);
    u_xlat16_1 = abs(u_xlat16_4) + abs(u_xlat16_1);
    u_xlat0.z = u_xlat3.x + (-_Radius);
    u_xlat0.xz = u_xlat0.xz / vec2(u_xlat16_1);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xz = min(max(u_xlat0.xz, 0.0), 1.0);
#else
    u_xlat0.xz = clamp(u_xlat0.xz, 0.0, 1.0);
#endif
    u_xlat6 = (-u_xlat0.z) + 1.0;
    u_xlat9 = (-_Thickness) + _Radius;
    u_xlat3.x = (-u_xlat9) + u_xlat3.x;
    u_xlat3.x = u_xlat3.x / u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat16_1 = u_xlat3.x * u_xlat6;
    u_xlat16_1 = u_xlat16_1 * vs_COLOR0.w;
    u_xlat0.x = u_xlat0.x * u_xlat16_1;
    u_xlatb3.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlat3.x = u_xlatb3.x ? float(1.0) : 0.0;
    u_xlat3.y = u_xlatb3.y ? float(1.0) : 0.0;
;
    u_xlatb2.xy = greaterThanEqual(_ClipRect.zwzz, vs_TEXCOORD1.xyxx).xy;
    u_xlat2.x = u_xlatb2.x ? float(1.0) : 0.0;
    u_xlat2.y = u_xlatb2.y ? float(1.0) : 0.0;
;
    u_xlat3.xy = u_xlat3.xy * u_xlat2.xy;
    u_xlat3.x = u_xlat3.y * u_xlat3.x;
    u_xlat0.x = u_xlat3.x * u_xlat0.x;
    SV_Target0.w = u_xlat0.x;
    SV_Target0.xyz = vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "UNITY_UI_CLIP_RECT" }
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
uniform 	mediump vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
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
uniform 	vec4 _ClipRect;
uniform 	float _Radius;
uniform 	float _Thickness;
uniform 	float _DashFrequency;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_1;
vec2 u_xlat2;
bvec2 u_xlatb2;
vec2 u_xlat3;
bvec2 u_xlatb3;
mediump float u_xlat16_4;
float u_xlat6;
bool u_xlatb6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = max(abs(vs_TEXCOORD0.x), abs(vs_TEXCOORD0.y));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat3.x = min(abs(vs_TEXCOORD0.x), abs(vs_TEXCOORD0.y));
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = u_xlat0.x * u_xlat0.x;
    u_xlat6 = u_xlat3.x * 0.0208350997 + -0.0851330012;
    u_xlat6 = u_xlat3.x * u_xlat6 + 0.180141002;
    u_xlat6 = u_xlat3.x * u_xlat6 + -0.330299497;
    u_xlat3.x = u_xlat3.x * u_xlat6 + 0.999866009;
    u_xlat6 = u_xlat3.x * u_xlat0.x;
    u_xlat6 = u_xlat6 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(abs(vs_TEXCOORD0.x)<abs(vs_TEXCOORD0.y));
#else
    u_xlatb9 = abs(vs_TEXCOORD0.x)<abs(vs_TEXCOORD0.y);
#endif
    u_xlat6 = u_xlatb9 ? u_xlat6 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat3.x + u_xlat6;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3.x = !!(vs_TEXCOORD0.x<(-vs_TEXCOORD0.x));
#else
    u_xlatb3.x = vs_TEXCOORD0.x<(-vs_TEXCOORD0.x);
#endif
    u_xlat3.x = u_xlatb3.x ? -3.14159274 : float(0.0);
    u_xlat0.x = u_xlat3.x + u_xlat0.x;
    u_xlat3.x = min(vs_TEXCOORD0.x, vs_TEXCOORD0.y);
#ifdef UNITY_ADRENO_ES3
    u_xlatb3.x = !!(u_xlat3.x<(-u_xlat3.x));
#else
    u_xlatb3.x = u_xlat3.x<(-u_xlat3.x);
#endif
    u_xlat6 = max(vs_TEXCOORD0.x, vs_TEXCOORD0.y);
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat6>=(-u_xlat6));
#else
    u_xlatb6 = u_xlat6>=(-u_xlat6);
#endif
    u_xlatb3.x = u_xlatb6 && u_xlatb3.x;
    u_xlat0.x = (u_xlatb3.x) ? (-u_xlat0.x) : u_xlat0.x;
    u_xlat0.x = u_xlat0.x + 3.1415925;
    u_xlat3.x = u_xlat0.x * _DashFrequency;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3.x = !!(u_xlat3.x>=(-u_xlat3.x));
#else
    u_xlatb3.x = u_xlat3.x>=(-u_xlat3.x);
#endif
    u_xlat3.x = (u_xlatb3.x) ? _DashFrequency : (-_DashFrequency);
    u_xlat6 = float(1.0) / u_xlat3.x;
    u_xlat0.x = u_xlat6 * u_xlat0.x;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat6 = _DashFrequency * 0.5;
    u_xlat0.x = u_xlat3.x * u_xlat0.x + (-u_xlat6);
    u_xlat3.x = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
    u_xlat3.x = sqrt(u_xlat3.x);
    u_xlat16_1 = dFdx(u_xlat3.x);
    u_xlat16_4 = dFdy(u_xlat3.x);
    u_xlat16_1 = abs(u_xlat16_4) + abs(u_xlat16_1);
    u_xlat0.z = u_xlat3.x + (-_Radius);
    u_xlat0.xz = u_xlat0.xz / vec2(u_xlat16_1);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xz = min(max(u_xlat0.xz, 0.0), 1.0);
#else
    u_xlat0.xz = clamp(u_xlat0.xz, 0.0, 1.0);
#endif
    u_xlat6 = (-u_xlat0.z) + 1.0;
    u_xlat9 = (-_Thickness) + _Radius;
    u_xlat3.x = (-u_xlat9) + u_xlat3.x;
    u_xlat3.x = u_xlat3.x / u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat16_1 = u_xlat3.x * u_xlat6;
    u_xlat16_1 = u_xlat16_1 * vs_COLOR0.w;
    u_xlat0.x = u_xlat0.x * u_xlat16_1;
    u_xlatb3.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlat3.x = u_xlatb3.x ? float(1.0) : 0.0;
    u_xlat3.y = u_xlatb3.y ? float(1.0) : 0.0;
;
    u_xlatb2.xy = greaterThanEqual(_ClipRect.zwzz, vs_TEXCOORD1.xyxx).xy;
    u_xlat2.x = u_xlatb2.x ? float(1.0) : 0.0;
    u_xlat2.y = u_xlatb2.y ? float(1.0) : 0.0;
;
    u_xlat3.xy = u_xlat3.xy * u_xlat2.xy;
    u_xlat3.x = u_xlat3.y * u_xlat3.x;
    u_xlat0.x = u_xlat3.x * u_xlat0.x;
    SV_Target0.w = u_xlat0.x;
    SV_Target0.xyz = vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    vs_TEXCOORD1 = in_POSITION0;
    return;
}

#endif
#ifdef FRAGMENT
#version 100
#ifdef GL_OES_standard_derivatives
#extension GL_OES_standard_derivatives : enable
#endif

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec4 _ClipRect;
uniform 	float _Radius;
uniform 	float _Thickness;
uniform 	float _DashFrequency;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
bool u_xlatb0;
mediump float u_xlat16_1;
vec2 u_xlat2;
bvec2 u_xlatb2;
vec2 u_xlat3;
bvec2 u_xlatb3;
mediump float u_xlat16_4;
float u_xlat6;
bool u_xlatb6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = max(abs(vs_TEXCOORD0.x), abs(vs_TEXCOORD0.y));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat3.x = min(abs(vs_TEXCOORD0.x), abs(vs_TEXCOORD0.y));
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = u_xlat0.x * u_xlat0.x;
    u_xlat6 = u_xlat3.x * 0.0208350997 + -0.0851330012;
    u_xlat6 = u_xlat3.x * u_xlat6 + 0.180141002;
    u_xlat6 = u_xlat3.x * u_xlat6 + -0.330299497;
    u_xlat3.x = u_xlat3.x * u_xlat6 + 0.999866009;
    u_xlat6 = u_xlat3.x * u_xlat0.x;
    u_xlat6 = u_xlat6 * -2.0 + 1.57079637;
    u_xlatb9 = abs(vs_TEXCOORD0.x)<abs(vs_TEXCOORD0.y);
    u_xlat6 = u_xlatb9 ? u_xlat6 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat3.x + u_xlat6;
    u_xlatb3.x = vs_TEXCOORD0.x<(-vs_TEXCOORD0.x);
    u_xlat3.x = u_xlatb3.x ? -3.14159274 : float(0.0);
    u_xlat0.x = u_xlat3.x + u_xlat0.x;
    u_xlat3.x = min(vs_TEXCOORD0.x, vs_TEXCOORD0.y);
    u_xlatb3.x = u_xlat3.x<(-u_xlat3.x);
    u_xlat6 = max(vs_TEXCOORD0.x, vs_TEXCOORD0.y);
    u_xlatb6 = u_xlat6>=(-u_xlat6);
    u_xlatb3.x = u_xlatb6 && u_xlatb3.x;
    u_xlat0.x = (u_xlatb3.x) ? (-u_xlat0.x) : u_xlat0.x;
    u_xlat0.x = u_xlat0.x + 3.1415925;
    u_xlat3.x = u_xlat0.x * _DashFrequency;
    u_xlatb3.x = u_xlat3.x>=(-u_xlat3.x);
    u_xlat3.x = (u_xlatb3.x) ? _DashFrequency : (-_DashFrequency);
    u_xlat6 = float(1.0) / u_xlat3.x;
    u_xlat0.x = u_xlat6 * u_xlat0.x;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat6 = _DashFrequency * 0.5;
    u_xlat0.x = u_xlat3.x * u_xlat0.x + (-u_xlat6);
    u_xlat3.x = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
    u_xlat3.x = sqrt(u_xlat3.x);
    u_xlat16_1 = dFdx(u_xlat3.x);
    u_xlat16_4 = dFdy(u_xlat3.x);
    u_xlat16_1 = abs(u_xlat16_4) + abs(u_xlat16_1);
    u_xlat0.z = u_xlat3.x + (-_Radius);
    u_xlat0.xz = u_xlat0.xz / vec2(u_xlat16_1);
    u_xlat0.xz = clamp(u_xlat0.xz, 0.0, 1.0);
    u_xlat6 = (-u_xlat0.z) + 1.0;
    u_xlat9 = (-_Thickness) + _Radius;
    u_xlat3.x = (-u_xlat9) + u_xlat3.x;
    u_xlat3.x = u_xlat3.x / u_xlat16_1;
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat16_1 = u_xlat3.x * u_xlat6;
    u_xlat16_1 = u_xlat16_1 * vs_COLOR0.w;
    u_xlat0.x = u_xlat0.x * u_xlat16_1;
    u_xlatb3.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlat3.x = u_xlatb3.x ? float(1.0) : 0.0;
    u_xlat3.y = u_xlatb3.y ? float(1.0) : 0.0;
;
    u_xlatb2.xy = greaterThanEqual(_ClipRect.zwzz, vs_TEXCOORD1.xyxx).xy;
    u_xlat2.x = u_xlatb2.x ? float(1.0) : 0.0;
    u_xlat2.y = u_xlatb2.y ? float(1.0) : 0.0;
;
    u_xlat3.xy = u_xlat3.xy * u_xlat2.xy;
    u_xlat3.x = u_xlat3.y * u_xlat3.x;
    u_xlat16_1 = u_xlat0.x * u_xlat3.x + -0.00100000005;
    u_xlat0.x = u_xlat3.x * u_xlat0.x;
    SV_Target0.w = u_xlat0.x;
    u_xlatb0 = u_xlat16_1<0.0;
    if(u_xlatb0){discard;}
    SV_Target0.xyz = vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    vs_TEXCOORD1 = in_POSITION0;
    return;
}

#endif
#ifdef FRAGMENT
#version 100
#ifdef GL_OES_standard_derivatives
#extension GL_OES_standard_derivatives : enable
#endif

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec4 _ClipRect;
uniform 	float _Radius;
uniform 	float _Thickness;
uniform 	float _DashFrequency;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
bool u_xlatb0;
mediump float u_xlat16_1;
vec2 u_xlat2;
bvec2 u_xlatb2;
vec2 u_xlat3;
bvec2 u_xlatb3;
mediump float u_xlat16_4;
float u_xlat6;
bool u_xlatb6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = max(abs(vs_TEXCOORD0.x), abs(vs_TEXCOORD0.y));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat3.x = min(abs(vs_TEXCOORD0.x), abs(vs_TEXCOORD0.y));
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = u_xlat0.x * u_xlat0.x;
    u_xlat6 = u_xlat3.x * 0.0208350997 + -0.0851330012;
    u_xlat6 = u_xlat3.x * u_xlat6 + 0.180141002;
    u_xlat6 = u_xlat3.x * u_xlat6 + -0.330299497;
    u_xlat3.x = u_xlat3.x * u_xlat6 + 0.999866009;
    u_xlat6 = u_xlat3.x * u_xlat0.x;
    u_xlat6 = u_xlat6 * -2.0 + 1.57079637;
    u_xlatb9 = abs(vs_TEXCOORD0.x)<abs(vs_TEXCOORD0.y);
    u_xlat6 = u_xlatb9 ? u_xlat6 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat3.x + u_xlat6;
    u_xlatb3.x = vs_TEXCOORD0.x<(-vs_TEXCOORD0.x);
    u_xlat3.x = u_xlatb3.x ? -3.14159274 : float(0.0);
    u_xlat0.x = u_xlat3.x + u_xlat0.x;
    u_xlat3.x = min(vs_TEXCOORD0.x, vs_TEXCOORD0.y);
    u_xlatb3.x = u_xlat3.x<(-u_xlat3.x);
    u_xlat6 = max(vs_TEXCOORD0.x, vs_TEXCOORD0.y);
    u_xlatb6 = u_xlat6>=(-u_xlat6);
    u_xlatb3.x = u_xlatb6 && u_xlatb3.x;
    u_xlat0.x = (u_xlatb3.x) ? (-u_xlat0.x) : u_xlat0.x;
    u_xlat0.x = u_xlat0.x + 3.1415925;
    u_xlat3.x = u_xlat0.x * _DashFrequency;
    u_xlatb3.x = u_xlat3.x>=(-u_xlat3.x);
    u_xlat3.x = (u_xlatb3.x) ? _DashFrequency : (-_DashFrequency);
    u_xlat6 = float(1.0) / u_xlat3.x;
    u_xlat0.x = u_xlat6 * u_xlat0.x;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat6 = _DashFrequency * 0.5;
    u_xlat0.x = u_xlat3.x * u_xlat0.x + (-u_xlat6);
    u_xlat3.x = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
    u_xlat3.x = sqrt(u_xlat3.x);
    u_xlat16_1 = dFdx(u_xlat3.x);
    u_xlat16_4 = dFdy(u_xlat3.x);
    u_xlat16_1 = abs(u_xlat16_4) + abs(u_xlat16_1);
    u_xlat0.z = u_xlat3.x + (-_Radius);
    u_xlat0.xz = u_xlat0.xz / vec2(u_xlat16_1);
    u_xlat0.xz = clamp(u_xlat0.xz, 0.0, 1.0);
    u_xlat6 = (-u_xlat0.z) + 1.0;
    u_xlat9 = (-_Thickness) + _Radius;
    u_xlat3.x = (-u_xlat9) + u_xlat3.x;
    u_xlat3.x = u_xlat3.x / u_xlat16_1;
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat16_1 = u_xlat3.x * u_xlat6;
    u_xlat16_1 = u_xlat16_1 * vs_COLOR0.w;
    u_xlat0.x = u_xlat0.x * u_xlat16_1;
    u_xlatb3.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlat3.x = u_xlatb3.x ? float(1.0) : 0.0;
    u_xlat3.y = u_xlatb3.y ? float(1.0) : 0.0;
;
    u_xlatb2.xy = greaterThanEqual(_ClipRect.zwzz, vs_TEXCOORD1.xyxx).xy;
    u_xlat2.x = u_xlatb2.x ? float(1.0) : 0.0;
    u_xlat2.y = u_xlatb2.y ? float(1.0) : 0.0;
;
    u_xlat3.xy = u_xlat3.xy * u_xlat2.xy;
    u_xlat3.x = u_xlat3.y * u_xlat3.x;
    u_xlat16_1 = u_xlat0.x * u_xlat3.x + -0.00100000005;
    u_xlat0.x = u_xlat3.x * u_xlat0.x;
    SV_Target0.w = u_xlat0.x;
    u_xlatb0 = u_xlat16_1<0.0;
    if(u_xlatb0){discard;}
    SV_Target0.xyz = vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec2 in_TEXCOORD0;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    vs_TEXCOORD1 = in_POSITION0;
    return;
}

#endif
#ifdef FRAGMENT
#version 100
#ifdef GL_OES_standard_derivatives
#extension GL_OES_standard_derivatives : enable
#endif

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec4 _ClipRect;
uniform 	float _Radius;
uniform 	float _Thickness;
uniform 	float _DashFrequency;
varying mediump vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
bool u_xlatb0;
mediump float u_xlat16_1;
vec2 u_xlat2;
bvec2 u_xlatb2;
vec2 u_xlat3;
bvec2 u_xlatb3;
mediump float u_xlat16_4;
float u_xlat6;
bool u_xlatb6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = max(abs(vs_TEXCOORD0.x), abs(vs_TEXCOORD0.y));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat3.x = min(abs(vs_TEXCOORD0.x), abs(vs_TEXCOORD0.y));
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = u_xlat0.x * u_xlat0.x;
    u_xlat6 = u_xlat3.x * 0.0208350997 + -0.0851330012;
    u_xlat6 = u_xlat3.x * u_xlat6 + 0.180141002;
    u_xlat6 = u_xlat3.x * u_xlat6 + -0.330299497;
    u_xlat3.x = u_xlat3.x * u_xlat6 + 0.999866009;
    u_xlat6 = u_xlat3.x * u_xlat0.x;
    u_xlat6 = u_xlat6 * -2.0 + 1.57079637;
    u_xlatb9 = abs(vs_TEXCOORD0.x)<abs(vs_TEXCOORD0.y);
    u_xlat6 = u_xlatb9 ? u_xlat6 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat3.x + u_xlat6;
    u_xlatb3.x = vs_TEXCOORD0.x<(-vs_TEXCOORD0.x);
    u_xlat3.x = u_xlatb3.x ? -3.14159274 : float(0.0);
    u_xlat0.x = u_xlat3.x + u_xlat0.x;
    u_xlat3.x = min(vs_TEXCOORD0.x, vs_TEXCOORD0.y);
    u_xlatb3.x = u_xlat3.x<(-u_xlat3.x);
    u_xlat6 = max(vs_TEXCOORD0.x, vs_TEXCOORD0.y);
    u_xlatb6 = u_xlat6>=(-u_xlat6);
    u_xlatb3.x = u_xlatb6 && u_xlatb3.x;
    u_xlat0.x = (u_xlatb3.x) ? (-u_xlat0.x) : u_xlat0.x;
    u_xlat0.x = u_xlat0.x + 3.1415925;
    u_xlat3.x = u_xlat0.x * _DashFrequency;
    u_xlatb3.x = u_xlat3.x>=(-u_xlat3.x);
    u_xlat3.x = (u_xlatb3.x) ? _DashFrequency : (-_DashFrequency);
    u_xlat6 = float(1.0) / u_xlat3.x;
    u_xlat0.x = u_xlat6 * u_xlat0.x;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat6 = _DashFrequency * 0.5;
    u_xlat0.x = u_xlat3.x * u_xlat0.x + (-u_xlat6);
    u_xlat3.x = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
    u_xlat3.x = sqrt(u_xlat3.x);
    u_xlat16_1 = dFdx(u_xlat3.x);
    u_xlat16_4 = dFdy(u_xlat3.x);
    u_xlat16_1 = abs(u_xlat16_4) + abs(u_xlat16_1);
    u_xlat0.z = u_xlat3.x + (-_Radius);
    u_xlat0.xz = u_xlat0.xz / vec2(u_xlat16_1);
    u_xlat0.xz = clamp(u_xlat0.xz, 0.0, 1.0);
    u_xlat6 = (-u_xlat0.z) + 1.0;
    u_xlat9 = (-_Thickness) + _Radius;
    u_xlat3.x = (-u_xlat9) + u_xlat3.x;
    u_xlat3.x = u_xlat3.x / u_xlat16_1;
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat16_1 = u_xlat3.x * u_xlat6;
    u_xlat16_1 = u_xlat16_1 * vs_COLOR0.w;
    u_xlat0.x = u_xlat0.x * u_xlat16_1;
    u_xlatb3.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlat3.x = u_xlatb3.x ? float(1.0) : 0.0;
    u_xlat3.y = u_xlatb3.y ? float(1.0) : 0.0;
;
    u_xlatb2.xy = greaterThanEqual(_ClipRect.zwzz, vs_TEXCOORD1.xyxx).xy;
    u_xlat2.x = u_xlatb2.x ? float(1.0) : 0.0;
    u_xlat2.y = u_xlatb2.y ? float(1.0) : 0.0;
;
    u_xlat3.xy = u_xlat3.xy * u_xlat2.xy;
    u_xlat3.x = u_xlat3.y * u_xlat3.x;
    u_xlat16_1 = u_xlat0.x * u_xlat3.x + -0.00100000005;
    u_xlat0.x = u_xlat3.x * u_xlat0.x;
    SV_Target0.w = u_xlat0.x;
    u_xlatb0 = u_xlat16_1<0.0;
    if(u_xlatb0){discard;}
    SV_Target0.xyz = vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" }
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
uniform 	mediump vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
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
uniform 	vec4 _ClipRect;
uniform 	float _Radius;
uniform 	float _Thickness;
uniform 	float _DashFrequency;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
bool u_xlatb0;
mediump float u_xlat16_1;
vec2 u_xlat2;
bvec2 u_xlatb2;
vec2 u_xlat3;
bvec2 u_xlatb3;
mediump float u_xlat16_4;
float u_xlat6;
bool u_xlatb6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = max(abs(vs_TEXCOORD0.x), abs(vs_TEXCOORD0.y));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat3.x = min(abs(vs_TEXCOORD0.x), abs(vs_TEXCOORD0.y));
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = u_xlat0.x * u_xlat0.x;
    u_xlat6 = u_xlat3.x * 0.0208350997 + -0.0851330012;
    u_xlat6 = u_xlat3.x * u_xlat6 + 0.180141002;
    u_xlat6 = u_xlat3.x * u_xlat6 + -0.330299497;
    u_xlat3.x = u_xlat3.x * u_xlat6 + 0.999866009;
    u_xlat6 = u_xlat3.x * u_xlat0.x;
    u_xlat6 = u_xlat6 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(abs(vs_TEXCOORD0.x)<abs(vs_TEXCOORD0.y));
#else
    u_xlatb9 = abs(vs_TEXCOORD0.x)<abs(vs_TEXCOORD0.y);
#endif
    u_xlat6 = u_xlatb9 ? u_xlat6 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat3.x + u_xlat6;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3.x = !!(vs_TEXCOORD0.x<(-vs_TEXCOORD0.x));
#else
    u_xlatb3.x = vs_TEXCOORD0.x<(-vs_TEXCOORD0.x);
#endif
    u_xlat3.x = u_xlatb3.x ? -3.14159274 : float(0.0);
    u_xlat0.x = u_xlat3.x + u_xlat0.x;
    u_xlat3.x = min(vs_TEXCOORD0.x, vs_TEXCOORD0.y);
#ifdef UNITY_ADRENO_ES3
    u_xlatb3.x = !!(u_xlat3.x<(-u_xlat3.x));
#else
    u_xlatb3.x = u_xlat3.x<(-u_xlat3.x);
#endif
    u_xlat6 = max(vs_TEXCOORD0.x, vs_TEXCOORD0.y);
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat6>=(-u_xlat6));
#else
    u_xlatb6 = u_xlat6>=(-u_xlat6);
#endif
    u_xlatb3.x = u_xlatb6 && u_xlatb3.x;
    u_xlat0.x = (u_xlatb3.x) ? (-u_xlat0.x) : u_xlat0.x;
    u_xlat0.x = u_xlat0.x + 3.1415925;
    u_xlat3.x = u_xlat0.x * _DashFrequency;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3.x = !!(u_xlat3.x>=(-u_xlat3.x));
#else
    u_xlatb3.x = u_xlat3.x>=(-u_xlat3.x);
#endif
    u_xlat3.x = (u_xlatb3.x) ? _DashFrequency : (-_DashFrequency);
    u_xlat6 = float(1.0) / u_xlat3.x;
    u_xlat0.x = u_xlat6 * u_xlat0.x;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat6 = _DashFrequency * 0.5;
    u_xlat0.x = u_xlat3.x * u_xlat0.x + (-u_xlat6);
    u_xlat3.x = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
    u_xlat3.x = sqrt(u_xlat3.x);
    u_xlat16_1 = dFdx(u_xlat3.x);
    u_xlat16_4 = dFdy(u_xlat3.x);
    u_xlat16_1 = abs(u_xlat16_4) + abs(u_xlat16_1);
    u_xlat0.z = u_xlat3.x + (-_Radius);
    u_xlat0.xz = u_xlat0.xz / vec2(u_xlat16_1);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xz = min(max(u_xlat0.xz, 0.0), 1.0);
#else
    u_xlat0.xz = clamp(u_xlat0.xz, 0.0, 1.0);
#endif
    u_xlat6 = (-u_xlat0.z) + 1.0;
    u_xlat9 = (-_Thickness) + _Radius;
    u_xlat3.x = (-u_xlat9) + u_xlat3.x;
    u_xlat3.x = u_xlat3.x / u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat16_1 = u_xlat3.x * u_xlat6;
    u_xlat16_1 = u_xlat16_1 * vs_COLOR0.w;
    u_xlat0.x = u_xlat0.x * u_xlat16_1;
    u_xlatb3.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlat3.x = u_xlatb3.x ? float(1.0) : 0.0;
    u_xlat3.y = u_xlatb3.y ? float(1.0) : 0.0;
;
    u_xlatb2.xy = greaterThanEqual(_ClipRect.zwzz, vs_TEXCOORD1.xyxx).xy;
    u_xlat2.x = u_xlatb2.x ? float(1.0) : 0.0;
    u_xlat2.y = u_xlatb2.y ? float(1.0) : 0.0;
;
    u_xlat3.xy = u_xlat3.xy * u_xlat2.xy;
    u_xlat3.x = u_xlat3.y * u_xlat3.x;
    u_xlat16_1 = u_xlat0.x * u_xlat3.x + -0.00100000005;
    u_xlat0.x = u_xlat3.x * u_xlat0.x;
    SV_Target0.w = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1<0.0);
#else
    u_xlatb0 = u_xlat16_1<0.0;
#endif
    if(u_xlatb0){discard;}
    SV_Target0.xyz = vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" }
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
uniform 	mediump vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
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
uniform 	vec4 _ClipRect;
uniform 	float _Radius;
uniform 	float _Thickness;
uniform 	float _DashFrequency;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
bool u_xlatb0;
mediump float u_xlat16_1;
vec2 u_xlat2;
bvec2 u_xlatb2;
vec2 u_xlat3;
bvec2 u_xlatb3;
mediump float u_xlat16_4;
float u_xlat6;
bool u_xlatb6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = max(abs(vs_TEXCOORD0.x), abs(vs_TEXCOORD0.y));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat3.x = min(abs(vs_TEXCOORD0.x), abs(vs_TEXCOORD0.y));
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = u_xlat0.x * u_xlat0.x;
    u_xlat6 = u_xlat3.x * 0.0208350997 + -0.0851330012;
    u_xlat6 = u_xlat3.x * u_xlat6 + 0.180141002;
    u_xlat6 = u_xlat3.x * u_xlat6 + -0.330299497;
    u_xlat3.x = u_xlat3.x * u_xlat6 + 0.999866009;
    u_xlat6 = u_xlat3.x * u_xlat0.x;
    u_xlat6 = u_xlat6 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(abs(vs_TEXCOORD0.x)<abs(vs_TEXCOORD0.y));
#else
    u_xlatb9 = abs(vs_TEXCOORD0.x)<abs(vs_TEXCOORD0.y);
#endif
    u_xlat6 = u_xlatb9 ? u_xlat6 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat3.x + u_xlat6;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3.x = !!(vs_TEXCOORD0.x<(-vs_TEXCOORD0.x));
#else
    u_xlatb3.x = vs_TEXCOORD0.x<(-vs_TEXCOORD0.x);
#endif
    u_xlat3.x = u_xlatb3.x ? -3.14159274 : float(0.0);
    u_xlat0.x = u_xlat3.x + u_xlat0.x;
    u_xlat3.x = min(vs_TEXCOORD0.x, vs_TEXCOORD0.y);
#ifdef UNITY_ADRENO_ES3
    u_xlatb3.x = !!(u_xlat3.x<(-u_xlat3.x));
#else
    u_xlatb3.x = u_xlat3.x<(-u_xlat3.x);
#endif
    u_xlat6 = max(vs_TEXCOORD0.x, vs_TEXCOORD0.y);
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat6>=(-u_xlat6));
#else
    u_xlatb6 = u_xlat6>=(-u_xlat6);
#endif
    u_xlatb3.x = u_xlatb6 && u_xlatb3.x;
    u_xlat0.x = (u_xlatb3.x) ? (-u_xlat0.x) : u_xlat0.x;
    u_xlat0.x = u_xlat0.x + 3.1415925;
    u_xlat3.x = u_xlat0.x * _DashFrequency;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3.x = !!(u_xlat3.x>=(-u_xlat3.x));
#else
    u_xlatb3.x = u_xlat3.x>=(-u_xlat3.x);
#endif
    u_xlat3.x = (u_xlatb3.x) ? _DashFrequency : (-_DashFrequency);
    u_xlat6 = float(1.0) / u_xlat3.x;
    u_xlat0.x = u_xlat6 * u_xlat0.x;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat6 = _DashFrequency * 0.5;
    u_xlat0.x = u_xlat3.x * u_xlat0.x + (-u_xlat6);
    u_xlat3.x = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
    u_xlat3.x = sqrt(u_xlat3.x);
    u_xlat16_1 = dFdx(u_xlat3.x);
    u_xlat16_4 = dFdy(u_xlat3.x);
    u_xlat16_1 = abs(u_xlat16_4) + abs(u_xlat16_1);
    u_xlat0.z = u_xlat3.x + (-_Radius);
    u_xlat0.xz = u_xlat0.xz / vec2(u_xlat16_1);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xz = min(max(u_xlat0.xz, 0.0), 1.0);
#else
    u_xlat0.xz = clamp(u_xlat0.xz, 0.0, 1.0);
#endif
    u_xlat6 = (-u_xlat0.z) + 1.0;
    u_xlat9 = (-_Thickness) + _Radius;
    u_xlat3.x = (-u_xlat9) + u_xlat3.x;
    u_xlat3.x = u_xlat3.x / u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat16_1 = u_xlat3.x * u_xlat6;
    u_xlat16_1 = u_xlat16_1 * vs_COLOR0.w;
    u_xlat0.x = u_xlat0.x * u_xlat16_1;
    u_xlatb3.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlat3.x = u_xlatb3.x ? float(1.0) : 0.0;
    u_xlat3.y = u_xlatb3.y ? float(1.0) : 0.0;
;
    u_xlatb2.xy = greaterThanEqual(_ClipRect.zwzz, vs_TEXCOORD1.xyxx).xy;
    u_xlat2.x = u_xlatb2.x ? float(1.0) : 0.0;
    u_xlat2.y = u_xlatb2.y ? float(1.0) : 0.0;
;
    u_xlat3.xy = u_xlat3.xy * u_xlat2.xy;
    u_xlat3.x = u_xlat3.y * u_xlat3.x;
    u_xlat16_1 = u_xlat0.x * u_xlat3.x + -0.00100000005;
    u_xlat0.x = u_xlat3.x * u_xlat0.x;
    SV_Target0.w = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1<0.0);
#else
    u_xlatb0 = u_xlat16_1<0.0;
#endif
    if(u_xlatb0){discard;}
    SV_Target0.xyz = vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" }
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
uniform 	mediump vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
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
uniform 	vec4 _ClipRect;
uniform 	float _Radius;
uniform 	float _Thickness;
uniform 	float _DashFrequency;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
bool u_xlatb0;
mediump float u_xlat16_1;
vec2 u_xlat2;
bvec2 u_xlatb2;
vec2 u_xlat3;
bvec2 u_xlatb3;
mediump float u_xlat16_4;
float u_xlat6;
bool u_xlatb6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = max(abs(vs_TEXCOORD0.x), abs(vs_TEXCOORD0.y));
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat3.x = min(abs(vs_TEXCOORD0.x), abs(vs_TEXCOORD0.y));
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat3.x = u_xlat0.x * u_xlat0.x;
    u_xlat6 = u_xlat3.x * 0.0208350997 + -0.0851330012;
    u_xlat6 = u_xlat3.x * u_xlat6 + 0.180141002;
    u_xlat6 = u_xlat3.x * u_xlat6 + -0.330299497;
    u_xlat3.x = u_xlat3.x * u_xlat6 + 0.999866009;
    u_xlat6 = u_xlat3.x * u_xlat0.x;
    u_xlat6 = u_xlat6 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(abs(vs_TEXCOORD0.x)<abs(vs_TEXCOORD0.y));
#else
    u_xlatb9 = abs(vs_TEXCOORD0.x)<abs(vs_TEXCOORD0.y);
#endif
    u_xlat6 = u_xlatb9 ? u_xlat6 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat3.x + u_xlat6;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3.x = !!(vs_TEXCOORD0.x<(-vs_TEXCOORD0.x));
#else
    u_xlatb3.x = vs_TEXCOORD0.x<(-vs_TEXCOORD0.x);
#endif
    u_xlat3.x = u_xlatb3.x ? -3.14159274 : float(0.0);
    u_xlat0.x = u_xlat3.x + u_xlat0.x;
    u_xlat3.x = min(vs_TEXCOORD0.x, vs_TEXCOORD0.y);
#ifdef UNITY_ADRENO_ES3
    u_xlatb3.x = !!(u_xlat3.x<(-u_xlat3.x));
#else
    u_xlatb3.x = u_xlat3.x<(-u_xlat3.x);
#endif
    u_xlat6 = max(vs_TEXCOORD0.x, vs_TEXCOORD0.y);
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(u_xlat6>=(-u_xlat6));
#else
    u_xlatb6 = u_xlat6>=(-u_xlat6);
#endif
    u_xlatb3.x = u_xlatb6 && u_xlatb3.x;
    u_xlat0.x = (u_xlatb3.x) ? (-u_xlat0.x) : u_xlat0.x;
    u_xlat0.x = u_xlat0.x + 3.1415925;
    u_xlat3.x = u_xlat0.x * _DashFrequency;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3.x = !!(u_xlat3.x>=(-u_xlat3.x));
#else
    u_xlatb3.x = u_xlat3.x>=(-u_xlat3.x);
#endif
    u_xlat3.x = (u_xlatb3.x) ? _DashFrequency : (-_DashFrequency);
    u_xlat6 = float(1.0) / u_xlat3.x;
    u_xlat0.x = u_xlat6 * u_xlat0.x;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat6 = _DashFrequency * 0.5;
    u_xlat0.x = u_xlat3.x * u_xlat0.x + (-u_xlat6);
    u_xlat3.x = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
    u_xlat3.x = sqrt(u_xlat3.x);
    u_xlat16_1 = dFdx(u_xlat3.x);
    u_xlat16_4 = dFdy(u_xlat3.x);
    u_xlat16_1 = abs(u_xlat16_4) + abs(u_xlat16_1);
    u_xlat0.z = u_xlat3.x + (-_Radius);
    u_xlat0.xz = u_xlat0.xz / vec2(u_xlat16_1);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xz = min(max(u_xlat0.xz, 0.0), 1.0);
#else
    u_xlat0.xz = clamp(u_xlat0.xz, 0.0, 1.0);
#endif
    u_xlat6 = (-u_xlat0.z) + 1.0;
    u_xlat9 = (-_Thickness) + _Radius;
    u_xlat3.x = (-u_xlat9) + u_xlat3.x;
    u_xlat3.x = u_xlat3.x / u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat16_1 = u_xlat3.x * u_xlat6;
    u_xlat16_1 = u_xlat16_1 * vs_COLOR0.w;
    u_xlat0.x = u_xlat0.x * u_xlat16_1;
    u_xlatb3.xy = greaterThanEqual(vs_TEXCOORD1.xyxx, _ClipRect.xyxx).xy;
    u_xlat3.x = u_xlatb3.x ? float(1.0) : 0.0;
    u_xlat3.y = u_xlatb3.y ? float(1.0) : 0.0;
;
    u_xlatb2.xy = greaterThanEqual(_ClipRect.zwzz, vs_TEXCOORD1.xyxx).xy;
    u_xlat2.x = u_xlatb2.x ? float(1.0) : 0.0;
    u_xlat2.y = u_xlatb2.y ? float(1.0) : 0.0;
;
    u_xlat3.xy = u_xlat3.xy * u_xlat2.xy;
    u_xlat3.x = u_xlat3.y * u_xlat3.x;
    u_xlat16_1 = u_xlat0.x * u_xlat3.x + -0.00100000005;
    u_xlat0.x = u_xlat3.x * u_xlat0.x;
    SV_Target0.w = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat16_1<0.0);
#else
    u_xlatb0 = u_xlat16_1<0.0;
#endif
    if(u_xlatb0){discard;}
    SV_Target0.xyz = vs_COLOR0.xyz;
    return;
}

#endif
"
}
}
}
}
}